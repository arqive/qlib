\d .os                                             / operational system

file:{x~key x}
dir:{11h~type key x}

tree:{                                             / list files within the dir x and its subdirs. x: filesystem dir or q dir
 $[x~k:key x;x;                                    / q function is ~10% faster than system "tree -ifF . | grep '[[:alnum:]]$\\|\\*'"
  11h=type k;raze (.z.s ` sv x,) each k;
  ()]}                                             / https://unix.stackexchange.com/questions/232564/how-to-make-tree-output-only-files
