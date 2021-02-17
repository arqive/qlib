\d .st                                          / statistics

winsor:{w:_[0,b:"j"$count[x]*y,1-y;] i:iasc x;  / cut three windows at boundaries from sorted vector of indices
 @[x;w 0 2;:;x i b-0 1]}                        / amend lower and upper window values with middle window boundary values

wmed:{[w;x]$[.5=sw first ii:2#where .5<=sw:sums w%sum w@:i:iasc x; avg x i ii;x i ii 0]} / weighted median
