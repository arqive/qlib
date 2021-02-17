.tst.desc["Assorted statistical functions"]{
 should["winsorize"]{
  `v mock 92 19 101 58 1053 91 26 78 10 13 -40 101 86 85 15 89 89 28 -5 41;     / vector to winsorize
  `l mock .05;                                                                  / winsorization level
  92 19 101 58 101 91 26 78 10 13 -5 101 86 85 15 89 89 28 -5 41 mustmatch .st.winsor[v;l];
  };
 should["calculate weighted median"]{
  `v mock (7 1 2 4 10;
   7 1 2 4 10;
   7 1 2 4 10 15;
   1 2 4 7 10 15;
   0 10 20 30;
   1 2 3 4 5;
   1 2 3 4 5;
   30 40 50 60 35;
   2 0.6 1.3 0.3 0.3 1.7 0.7 1.7 0.4;
   3.7 3.3 3.5 2.8;
   100 125 123 60 45 56 66;
   2 2 2 2 2 2;
   (),2.3;
   -2 -3 1 2 -10;
   1 2 3 4 5);

  `w mock (1.,(1%3),(1%3),(1%3),1.;
   1 1 1 1 1f;
   1f,(1%3),(1%3),(1%3),1 1f;
   (1%3),(1%3),(1%3),1 1 1f;
   30 191 9 0;
   10 1 1 1 9;
   10 1 1 1 900;
   1 3 5 4 2;
   2 2 0 1 2 2 1 6 0;
   5 5 4 1;
   30 56 144 24 55 43 67;
   0.1 0.2 0.3 0.4 0.5 0.6;
   (),12;
   7 1 1 1 6;
   1 0 0 0 2);
  must[;"calculate correctly"]all 7 4 8.5 8.5 10 2.5 5 50 1.7 3.5 100 2 2.3 -2 5="f"$.st.wmed'[w;v];
  };
 };




