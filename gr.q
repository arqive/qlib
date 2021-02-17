.utl.require"ut"

.is.dir:{if[not 99h=type x;:0b];0<=type first value x} / is directed graph

\d .gr                                             / graph theory

rev:{(where count each x) group raze value x}      / reverse the direction of all edges of a directed graph

follow:{{distinct raze y,x@y}[x]/[y]}              / follow directed graph x from node y until it reaches self or a terminal node; output list of visited nodes

cyc:{                                              / list of lists of nodes forming cycle(s); x: directed graph dict
 x:(t:where 0=count each x)_x;                     / graph without (t)erminal nodes
 x:x except\: t;                                   / graph without edges leading to (t)erminal nodes
 x:(where 1=count each x)#x;                       / graph without forking nodes
 p:follow[x] each key x;                           / (p)aths from each node
 where 1<count each group asc each p}              / loop/cycle: where paths duplicate

flatten:distinct raze over

dep:{                                              / x: list of parsable expressions; output (dependents!dependees) dict
 if[10h=type first x;:dep parse each x];           / if string expressions provided, parse them to get tree
 if[not type x; x:{x[;1]!x[;2]} x];                / (d)ict of (var preceding ":")!(parsed expression following ":"
 ref:{flatten $[-11=t:type x;x;t;0#`;.z.s each x]};
 ref each x}                                       / (d)ict of (vars!referenced vars) used in the expressions

ord:{inter[flatten reverse (flatten x@)scan k] k:key x} / find evaluation (ord)er of the dependency graph by following the references until terminus, reverse so that deeper are first

depo:{ord[g]#g:dep x}                              / (dep)endency graph sorted in evaluation (ord)er; x: expression list/dict

willbe:{[t;f;g]                                    / table willbe definition
 p:parse each f;                                   / parse of expression
 o:key depo p;                                     / dependencies ordered by reference
 col:![;();;];
 col/[t;g o;o .ut.map'p o]}                        / create view
