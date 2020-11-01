.utl.require"ut"

\d .gr                                             / graphs

/ follow directed graph x from node y until it reaches self or a terminal node. Output list of visited nodes
follow:{{distinct raze y,x@y}[x]/[y]}
dependson:follow .z.b

filter:{y where x y,:()}                           / subset of list y with elements meeting predicate x
flatten:distinct raze over

/ represent the expression list as dictionary
egraph:{                                           / x: list of parsable expressions given as strings -> (dependents!dependees) syms
 d:{x[;1]!x[;2]} parse each x;                     / (d)ict of (var preceding ":")!(parsed expression following ":"
 d:filter[(-11h=type@/:)] each d;                  / (d)ict without non-symbols
 d,\:0#`}                                          / enforce symbol lists; (d)ict of (vars!referenced vars) used in the expressions

refs:{                                           / x: list of parsable expressions given as strings -> (dependents!dependees) syms
 if[not type x; x:{x[;1]!x[;2]} x];                                / (d)ict of (var preceding ":")!(parsed expression following ":"
 ref:{flatten $[-11=t:type x;x;t;();.z.s each x]};
 ref each x}                                      / (d)ict without non-symbols
/ (d)ict of (vars!referenced vars) used in the expressions

ascg:{                                             / order (g)raph dictionary in (a)scending (dep)endency order
 o:flatten reverse (flatten x@)scan k:key x;       / follow nodes until terminus; reverse (o)rder so that deeper ones are first
 (o inter k)#x}                                    / graph ordered by dependency

adep:ascg refs parse each::                        / input: expression list; output: directed graph in ascending dependency order

willbe:{[t;f;g]                                    / table willbe definition
 p:parse each f;                                   / parse of expression
 o:key ascg refs p;                                / dependencies ordered by reference
 col:![;();;];
 col/[t;g o;o .ut.map'p o]}                        / create view

loop:{                                             / list of all loops; loop: a list of nodes forming a cycle
 x:(t:where 0=count each x)_x;                     / graph without (t)erminal nodes
 x:x except\: t;                                   / graph without edges leading to (t)erminal nodes
 x:(where 1=count each x)#x;                       / graph without forking nodes
 p:follow[x] each key x;                           / (p)aths from each node
 where 1<count each group asc each p}              / loop: where paths duplicate
