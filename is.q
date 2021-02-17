
\d .is                                             / is x something ?
kt:{$[not 99h=type x;0b;not (f:98h=type@) key x;0b;f value x]} / is x a keyed table ?

def:{0<count key x}                                / is defined? x:`sym|`:path/to/dir/|`:path/to/file.ext
