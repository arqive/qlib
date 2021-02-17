.utl.require"ut"

\d .tx                                             / text manipulation. configuration file generation
u.safe:{$[type[x] in 0 10h;x;99h=type x;string first x;string x]} / safely ensure string
u.head:{x[0],u.safe[y],x 1}

out:{[s;h;d;x]                                     / output lines from nested 0h or 99h; indent. (s)pace; (h)eader markup; (d)elim. char
 v:x ./: k:.ut.ind x;                              / keys at depth; values at terminal nodes
 i:(s*-1+count each k)#\:"";                       / indentation based on depth
 l:i,'d 0:(k[;1];v);                               / lines with indented and delimited key-value pairs
 w:where differ k0:k[;0];                          / positions where headers change
 h:u.head[h] each k0 w;                            / headers as text
 .ut.inj[l;w;h]}                                   / inject headers into positions between lines

ssh:out[2;("Host ";"");" "]                        / https://www.ssh.com/ssh/config/
ini:out[0;"[]";"="]                                / https://en.wikipedia.org/wiki/INI_file

load.ini:{                                                          / q ini.q [initfile] [section]
 .utl.require"qutil/opts.q";
 .utl.require"qutil/config_parse.q";
 .utl.addArg["S";`.ini;0;](`x;{.utl.parseConfig hsym x});           / [initfile] cmdline arg
 .utl.addArg["*";"";0;]{.[`x;();@;] $[count x;x;first key get `x]}; / [section] cmdline arg: selects section of file or first section
 .utl.parseArgs[];                                                  / parse declarations above
 x::{`cast _x!$[99h=type z;"*"^z x;"*"]$y}[`$key x;value x;eval parse x"cast"]; / cast: keys as symbols, values according to "cast" key
 if[count l:get[`x]`load;{system"l ",x}each " " vs l];              / load files, if provided via "load" key
 }                                                                  / global var x holding a dictionary of typed program parameters

sgrep:{
 p:"\\|" sv x;
 c:"/bin/bash -c \"grep -b -o '",p,"' <<< '",y,"'\"";
 ("J*";":") 0:system c}

fssr:{[mf;x;y;z]
 m:mf[y;x]; n:count m 0; ym:y?m 1;                  / (m)atched (position;string); (n)umber of matches
 s:cut[;x]0,raze m[0]+flip (n#0;)(count each y) ym; / cut string at matched positions
 f:raze @[s;1+2*til n;:;]::;
 g:(cross/;enlist) 2>count mm:distinct m 1;
 c:string flip g `$z y?mm;
 (m;cm;) .ut.f2nd[f] cm:c[ym;til count first c] }   / (match offsets; substitutions; generated combinations)

replace:last fssr[sgrep;;]::
search:{sgrep[y;x]}

/
p:0N 0 0 0 0 0 0 0 1 1 1 7 7 7 12 12               / parent vector
child:group                                        / (parentid!childrenids) from parent vector
parent:{@[raze x;value x;:;key x]}                 / parent vector from (parentid!childrenids)
.tr.is:{@[`p`k`v~cols@;x;{0b}]}
pv:(();();)
pd:(value;key;){()!()}
pl:(::;til count@;){()}
pf:(pl;pd;pv)0 99h?type@

.tr.flatten:{[pf;x]
 f:{(x y)@\:y} pf;
 g:{x each raze y[;0]} f;
 r:raze (g\) enlist f x;
 ([]p:0N,where count each 0N!r[;0];                  / parent vector: think 0 0 0 1 1 3 3 3 3~where 3 2 0 4
  k:$[neg abs type n;" "],n:raze r[;1];         / names of nodes (branches or leaves); root name is typed " "
  v:r[;2])}
.tr.flat:tr.flatten pf
