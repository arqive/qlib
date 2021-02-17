.tst.desc["Directed graph"]{
 should["be dictionary mapping from list of direct predecessors to list of lists: their direct successors"]{
  `g mock `a`b`c!(1#`e;();1#`f`g);                 / usually symbols dict
  `h mock 1 2 3!(4 5;();1#6);                      / but nodes can be denoted with non-symbols too
  11b mustmatch .is.dir each (g;h);
  };
 should["detect any circular dependencies - cycles"]{
  /    a -> b -> c
  /    |    |
  /    |    +--> d <-+
  /    v         |   |
  /    e <-------+   |
  /   / \            |
  /  v   v           |
  /  f   g ----------+
  `g.a mock `b`e;                                  / (g)raph with loop
  `g.b mock `c`d;
  `g.c mock 0#`;
  `g.d mock 1#`e;
  `g.e mock `f`g;
  `g.f mock 0#`;
  `g.g mock 1#`d;
  enlist[`s#`d`e`g] mustmatch .gr.cyc 1 _ g;
  };
 should["reverse the direction of all arrows"]{
  `g mock `a`b`c!(`b`c;1#`e;1#`d);
  (`b`c`e`d!(1#`a;1#`a;1#`b;1#`c)) mustmatch .gr.rev g;
  };
 };

.tst.desc["Dependency graph is a directed graph, which"]{
 before{
  `l mock ("d:c+b";"c:neg b";"e:d*a";"b:10";"a:20");        / given the list of parsable expressions
  `d mock `h`j`k`l!("j+k";"f+g";"j*100";"k%sum k");         / dictionary of variables defined as parsable expressions
  };
 should["be definable from list/dict of expressions as a dictionary mapping from dependents -> dependees"]{
  (`d`c`e`b`a!(`c`b;1#`b;`d`a;0#`;0#`)) mustmatch .gr.dep l;        / given the list of parsable expressions
  (`h`j`k`l!(`j`k;`f`g;1#`j;1#`k)) mustmatch .gr.dep d;
  };
 should["be sortable by the order of evaluation, so that each variable is computed before it is referenced"]{
  `b`c`d`a`e mustmatch .gr.ord .gr.dep l;
  `j`k`h`l mustmatch .gr.ord .gr.dep d;
  (`b`c`d`a`e!(0#`;1#`b;`c`b;0#`;`d`a)) mustmatch .gr.depo l;
  (`j`k`h`l!(`f`g;1#`j;`j`k;1#`k)) mustmatch .gr.depo d;
  };
 should["reverse the direction of dependency"]{
  `g mock .gr.dep ("a::10";"b::a+1";"c::a+2";"d:20";"e::b+d";"f::e+4";"g::f+5");
  `a`b`c`e`f`g mustmatch .gr.follow[.gr.rev g] `a; / depends on `a; also, .z.b~.gr.rev g
  };
 };

.tst.desc["Willbe is a promise of calculated columns with yet undetermined order of evaluation, which"]{
 should["allow specifying all definitions in advance"]{
  `t mock ([]e:1 1 2;f:10 20 30;g:40 50 60);        / initial table
  `f mock `h`j`k`l!("j+k";"f+g";"j*100";"k%sum k"); / definitions of calculated fields/columns
  `g mock `h`j`k`l!(0b;0b;0b;enlist[`e]!enlist`e);  / group clauses for each calculated columns
  `v mock .gr.willbe[t;f;g];                        / v can be also a view; i.e. v::.gr.willbe[t;f;g]
  ([]e:1 1 2;f:10 20 30;g:40 50 60;j:50 70 90;k:50 70 90*100;h:50 70 90*(100+1);l:(5000 7000%12000),1f) mustmatch v;
  / e f  g  j  k    h    l
  / ------------------------------
  / 1 10 40 50 5000 5050 0.4166667
  / 1 20 50 70 7000 7070 0.5833333
  / 2 30 60 90 9000 9090 1
  `t mock update g:g+1 from t where f<50;          / one of inputs has changed
  `v mock .gr.willbe[t;f;g];                       / if v was a view; then just `show v` would trigger the recalc
  ([]e:1 1 2;f:10 20 30;g:41 51 61;j:51 71 91;k:5100 7100 9100;h:5151 7171 9191;l:(5151 7171%12322),1f) mustmatch v;
  / e f  g  j  k    h    l
  / ------------------------------
  / 1 10 41 51 5100 5151 0.4180328
  / 1 20 51 71 7100 7171 0.5819672
  / 2 30 61 91 9100 9191 1
  };
 };
