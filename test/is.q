.tst.desc[".is.* functions "]{
 should["identify correctly keyed table"]{
  `t mock ([]`a`b;1 2);
  (not .is.kt t) must "expect other than keyed table";
  `t mock ([`a`b];1 2);
  (.is.kt t) must "expect keyed table";
  };
  should["test if symbol/path/file is defined"]{
   `env.e mock ();
   0011111b mustmatch .is.def each `a`b`.q`.`env.e`:/home/dk/.bashrc`:/home/dk;
   };
 };
