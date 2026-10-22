## Lectures through markdown: .txt → .md (lect.py) → .md.tex (pandoc) → .md.pdf (texj)
## linear.draft.md.pdf: linear.txt mdtalk/lect.py mdtalk/draft.md.fmt

mdtalk ?= mdtalk

Ignore += *.draft.md *.md.tex *.md.pdf

.PRECIOUS: %.draft.md
%.draft.md: %.txt $(mdtalk)/draft.md.fmt $(mdtalk)/lect.py
	python3 $(mdtalk)/lect.py $< $(mdtalk)/draft.md.fmt > $@

.PRECIOUS: %.draft.md.tex
%.draft.md.tex: %.draft.md $(mdtalk)/beamer.pandoc $(mdtalk)/spans.lua
	pandoc $< -t beamer --slide-level=3 --template=$(mdtalk)/beamer.pandoc --lua-filter=$(mdtalk)/spans.lua -o $@
