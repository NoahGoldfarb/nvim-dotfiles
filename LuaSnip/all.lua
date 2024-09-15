-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep



local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end



return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".

  s({trig=";a", snippetType="autosnippet"},
  {
    t("\\alpha"),
  }
  ),
  s({trig=";b", snippetType="autosnippet"},
  {
    t("\\beta"),
  }),

  s({trig=";g", snippetType="autosnippet"},
  {
    t("\\gamma"),
  }),

s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
  {
    t("\\texttt{"), -- remember: backslashes need to be escaped
    i(1),
    t("}"),
  }
),
-- Yes, these jumbles of text nodes and insert nodes get messy fast, and yes,
-- there is a much better, human-readable solution: ls.fmt, described shortly.
s({trig="/", dscr="Expands 'ff' into '\frac{}{}'"},
  fmt(
    "\\frac{<>}{<>}",
    {d(1, get_visual), i(2)},
    {delimiters = "<>"})),

s({trig="mm", dscr="triggers basic equation mode"},
  fmt(
    "$<>$",
    {i(1)},
    {delimiters = "<>"})),

s({trig="dm", dscr="Expands 'dm' into an equation environment"},
  fmta(
     [[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
     {i(1)})),

s({trig = "td", dscr="Expands td into ^{}"},
  fmta(
  "<>^{<>}<>",
  {i(1),i(2), i(0)},
  {delimiters= "<>"})),





s({trig = "lim", dscr="lim",},
  fmta(

  "\\lim_{n\\to\\infty} <>",
  {i(1)},
  {delimiters = "<>"}


  )),


  s({trig="beg", snippetType="autosnippet"},
  fmta(
    [[
      \begin{<>}
          <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      rep(1),  -- this node repeats insert node i(1)
    }
  )
),


s({trig = "texdoc", snippetType="autosnippet"},
  fmta(

    [[
      \documentclass{article}
      \usepackage{graphicx}
      \usepackage{assymb}
      \begin{document}
      <>
      \end{document}  
          
    ]],

    {i(1)}


  )

),

s({trig = ".aufgabe", snippetType="autosnippet"},
      fmta(
   
        [[
          \documentclass[12pt]{article}

          \usepackage{graphicx}
          \usepackage{amsmath}
          \usepackage[margin=1in]{geometry}
          \usepackage{fancyhdr}
          \usepackage{enumerate}
          \usepackage[shortlabels]{enumitem}



          \pagestyle{fancy}
          \fancyhead[l]{Noah Goldfarb}
          \fancyhead[c]{Math 100 Homework \#1}
          \fancyhead[r]{\today}
          \fancyfoot[c]{\thepage}
          \renewcommand{\headrulewidth}{0.2pt}
          \setlength{\headheight}{15pt}



          \begin{document}
          <>

          \end{document}


       ]],
        {i(1)})),

s({trig="=>"}, t("\\Rightarrow")),

s({trig="<="}, t("\\Leftarrow")),

s({trig="<=>"}, t("\\Leftrightarrow"))
}


