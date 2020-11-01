\d .ut

exists:{0<count key x}                                     / x:symbol/directory/sympath; return (0b)1b if x is (not)defined

map:{enlist[x]!enlist y}

/ returns boolean indicating preference not to flip matrices
noflip:{system"g"}              / redefine to customize behavior

/ apply (f)unction (in parallel) to the 2nd dimension of (X)
f2nd:{[f;X]$[noflip[];(f value::) peach flip (count[X]#`)!X;f peach flip X]}
