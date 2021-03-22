\d .ut                                             / utilities (mostly data structure helpers)

guid:{0x0 sv `byte$#[16-count x;" "],x}            / guid from string (max 16 chars)

qkt:{$[not 99h=type x;0b;not (f:98h=type@) key x;0b;f value x]} / is x a keyed table ?
qd:{0<count key x}                                 / is defined? x:`sym|`:path/to/dir/|`:path/to/file.ext

map:{enlist[x]!enlist y}
filter:{y where x y,:()}                           / subset of list y with elements meeting predicate x

inj:{[x;i;y]2 raze/ flip ((count y;1)#y;) i cut x} / inject list y items into i positions of list x

ind:{                                              / indices of nested tree x at depth, all leaves are then x ./: ind x
 f:{$[type[y] in x;enlist y;y]};                   / enlist any strings (10h) or dicts (99h) so they are not inserted into with (,)
 i:@[;y](til count@;til count@;key;{()})0 98 99h?type y; / indices at this level: (k)ey of dict or til count list/table; () otherwise
 $[count i;f[10 99h;x],/:raze i .z.s' y i;         / recurse deeper into the dict or list and build the index path
  f[10h;x]]                                        / until leaf reached (not a dict nor list); enlist strings so not joined by raze
 }()                                               / execute the recursive function starting at the top with the empty index list ()

lea:{x ./: ind x}                                  / extract list of leaves (end nodes whose type not in 0 99h)

nullempty:{if[type x;:x]; @[x;where i;:;] first $[;()] type x first where not i:()~/:x} / empty list elements to null

noflip:{system"g"}                                 / boolean indicating preference not to flip matrices

f2nd:{[f;X]$[noflip[];(f value::) peach flip (count[X]#`)!X;f peach flip X]} / apply (f)unction in parallel to the 2nd dimension of (X)

sseq:{y[0]+x*til 1+floor 1e-14+((-). y 1 0)%x} / (s)tepped (seq)uence: x-sized steps within y
