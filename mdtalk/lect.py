## Translate a lecture .txt file into pandoc markdown, using a .fmt file
## Usage: python3 lect.py <file.txt> <file.fmt> (any order)
## Rewrite of talkdir/lect.pl, on the scaffold of usTests/tests/lect.py

## Input is slides separated by !SEP; slides are paragraphs separated by blank lines
## The first word of a paragraph is its command, if the .fmt knows it
## The first paragraph of a slide, if it has no command, is formatted with DEFHEAD
## Anything else is formatted with DEFCOMM
## Leading tabs make list items: depth n → 4(n-1) spaces + "- "
## A slide whose formatted text includes NULLSLIDE is dropped; ENDTALK ends the talk

## Patterns (same meanings as lect.pl):
## %%     the rest of the paragraph (every %% gets the same text)
## %+     the rest of the paragraph, without using it up
## %!     discard the rest of the paragraph (a pattern of just %! drops the paragraph)
## %|     the next sentence (up to . ! ? or |; the | is dropped)
## %      the next word
## ^      (at the start of a result) format the result again, as a new paragraph
## \n     newline (write "\n " before a letter, to avoid \newpage-style collisions)
## A % right after a digit is a literal percent (width=54%)

import re
import sys

files = {f.rsplit(".", 1)[-1]: f for f in sys.argv[1:]}
txtfile = files.get("txt") or files["TXT"]
fmtfile = files["fmt"]

com, spec = {}, {}
with open(fmtfile) as f:
	for line in f:
		parts = line.rstrip("\n").split(None, 1)
		if not parts or parts[0].startswith("#") or parts[0].endswith(":"):
			continue
		pat = parts[1] if len(parts) > 1 else ""
		if parts[0].startswith("!"):
			spec[parts[0][1:]] = pat
		else:
			com[parts[0]] = pat

sep = spec.get("SEP", r"-{30,}")
reserved = ("NULLSLIDE", "ENDTALK")

def warn(msg):
	print(txtfile + ": " + msg, file=sys.stderr)

## Old-style LaTeX that pandoc mangles; this belongs in a conversion script eventually
def legacy(text):
	text = re.sub(r"``(.*?)''", r'"\1"', text, flags=re.S)
	## Pandoc needs $ next to the math it encloses
	text = re.sub(r"(?<![$\\])\$(?!\$)\s*([^$]+?)\s*\$", r"$\1$", text)
	cmds = {"bf": "textbf", "em": "emph", "it": "textit", "sl": "textsl"}
	return re.sub(r"\{\\(bf|em|it|sl)\s+([^{}]*)\}",
		lambda m: "\\" + cmds[m.group(1)] + "{" + m.group(2) + "}", text)

## Fill a pattern from text, consuming text as the pattern asks
def substitute(pat, text):
	pat = re.sub(r"\\n( |(?![A-Za-z]))", "\n", pat)
	out = []
	rest = None
	for tok in re.split(r"(?<!\d)(%%|%!|%\+|%\||%)", pat):
		if tok == "%%":
			if rest is None:
				rest, text = text, ""
			out.append(rest)
		elif tok == "%+":
			out.append(text)
		elif tok == "%!":
			text = ""
		elif tok == "%|":
			m = re.match(r"\s*([^|.!?]*[|.!?]?)\s*", text, re.S)
			out.append(m.group(1).rstrip("|").strip())
			text = text[m.end():]
		elif tok == "%":
			m = re.match(r"\s*([^\s|]+)\s*", text)
			if not m:
				sys.exit(txtfile + ": % doesn't match \"" + text + "\" in " + pat)
			out.append(m.group(1))
			text = text[m.end():]
		else:
			out.append(tok)
	res = "".join(out)
	if text.strip() and not res.startswith(reserved):
		warn("orphan text " + text)
	return res

## Return (depth, formatted text) for one paragraph
def paragraph(par, first):
	lines = par.split("\n")
	depth = len(lines[0]) - len(lines[0].lstrip("\t"))
	text = legacy("\n".join(l.strip() for l in lines))
	while True:
		word, rest = (text.split(None, 1) + [""])[:2]
		if word in com:
			pat, arg = com[word], rest
		elif first and depth == 0 and "DEFHEAD" in com:
			pat, arg = com["DEFHEAD"], text
		else:
			pat, arg = com.get("DEFCOMM", "%%"), text
		first = False
		text = substitute(pat, arg)
		if not text.startswith("^"):
			return depth, text.strip()
		text = text[1:].strip()

## Put paragraphs together, turning depths into markdown lists
## Items stay separated by blank lines (loose lists), so bulletspace.tex sets the spacing
def assemble(pars):
	out = ""
	level = 0
	for depth, text in pars:
		if not text:
			continue
		if depth == 0:
			level = 0
			out += "\n\n" + text
			continue
		d = min(depth, level + 1)
		indent = "    " * (d - 1)
		item = indent + "- " + text.replace("\n", "\n" + indent + "  ")
		out += "\n\n" + item
		level = d
	return out.strip("\n")

with open(txtfile) as f:
	body = f.read()

## Comment lines (as in lect.pl)
body = re.sub(r"^#+[ #][^\n]*\n?", "", body, flags=re.M)

slides = []
for slide in re.split(r"^" + sep + r"[ \t]*$", body, flags=re.M):
	pars = [p.strip("\n") for p in re.split(r"\n[ \t]*\n", slide) if p.strip()]
	done = [paragraph(p, k == 0) for k, p in enumerate(pars)]
	words = {w for _, t in done for w in t.split()[:1]}
	if "ENDTALK" in words:
		break
	if "NULLSLIDE" in words:
		continue
	md = assemble(done)
	if md:
		slides.append(md)

print("\n\n".join(slides))
