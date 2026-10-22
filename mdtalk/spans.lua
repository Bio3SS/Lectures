-- Turn span classes from the .md.fmt files into LaTeX wrappers
-- Colours are defined in talkdir/colors.tex

local wrap = {
	answer = {"{\\color{blue} ", "}"},
	poll = {"{\\color{pollcolor} ", "}"},
	short = {"{\\color{shortcolor}\\sl ", "}"},
	change = {"{\\color{red}", "}"},
	uline = {"\\underline{", "}"},
}

function Span(el)
	for _, c in ipairs(el.classes) do
		local w = wrap[c]
		if w then
			local out = pandoc.Inlines{pandoc.RawInline("latex", w[1])}
			out:extend(el.content)
			out:insert(pandoc.RawInline("latex", w[2]))
			return out
		end
	end
end

-- Old format set every column in \small
function Div(el)
	if el.classes:includes("column") then
		el.content:insert(1, pandoc.RawBlock("latex", "\\small"))
		return el
	end
end
