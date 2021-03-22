.tst.desc["is *something* functions"]{
 should["identify correctly keyed table"]{
  `t mock ([]`a`b;1 2);
  (not .ut.qkt t) must "expect other than keyed table";
  `t mock ([`a`b];1 2);
  (.ut.qkt t) must "expect keyed table";
  };
 should["test if symbol/path/file is defined"]{
  `env.e mock ();
  0011111b mustmatch .ut.qd each `a`b`.q`.`env.e`:/home/dk/.bashrc`:/home/dk;
  };
 };

.tst.desc[".ut.ind"]{
 should["extract keys or indices of a nested dictionary, directory or list"]{
  `nestDict mock ("aa";"bb";"cc")!(
   ("bb";"cc";"dd")!(1;2 3;4);
   42;
   (("ee";"ff")!(5 6)));

  / (("aa";"b";"b");("aa";"c";"c");("aa";"d";"d");"bb";("cc";"e";"e");("cc";"f";"f")) mustmatch .ut.ind nestDict;

  `nestDir mock `a`b`c!(
   `d`e`f!1 2 3;
   `g`h!(`i`j!4 5;6);
   7);
  (`a`d;`a`e;`a`f;`b`g`i;`b`g`j;`b`h;1#`c) mustmatch .ut.ind nestDir;

  `nestList mock (1 2 3;(4;5 6));
  (1#0;1 0; 1 1) mustmatch .ut.ind nestList;
  };
 };
