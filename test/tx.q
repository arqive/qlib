.tst.desc["Nested structure"]{
 should["be expressed as flat file"]{
  l:enlist"[host1]";
  l,:enlist"HostName=pbgw";
  l,:enlist"RequestTTY=force";
  l,:enlist"[host2]";
  l,:enlist"HostName=pbgw";
  l,:enlist"RequestTTY=force";
  cfg:([Host:`host1`host2]HostName:2 1#enlist"pbgw";RequestTTY:2 1#enlist "force");
  l mustmatch .tx.ini cfg;

  l,:enlist"LocalCommand=pbrun -u user -h host bash";
  cfg:@[()!(); `host1`host2;:;(`HostName`RequestTTY!("pbgw";"force");`HostName`RequestTTY`LocalCommand!("pbgw";"force";"pbrun -u user -h host bash"))];
  l mustmatch .tx.ini cfg;

  cfg:@[()!(); ("host1";"host2");:;(`HostName`RequestTTY!("pbgw";"force");`HostName`RequestTTY`LocalCommand!("pbgw";"force";"pbrun -u user -h host bash"))];
  l mustmatch .tx.ini cfg;

  l:enlist"Host host1";
  l,:enlist"  HostName pbgw";
  l,:enlist"  RequestTTY force";
  l,:enlist"Host host2";
  l,:enlist"  HostName pbgw";
  l,:enlist"  RequestTTY force";
  l,:enlist"  LocalCommand pbrun -u user -h host bash";
  l mustmatch .tx.ssh cfg;
  };
 };

.tst.desc["String search & replace"]{
 before{
  `text mock "quick {color} {animal} {jumps} over lazy {animal2}";
  `pattern mock ("{color}";"{animal}";"{animal2}");
  `replacements mock string(`brown`white`black;`fox`squirrel;1#`dog);
  };
 should["locate positions of all pattern occurences"]{
  (6 14 41;("{color}";"{animal}";"{animal2}")) mustmatch .tx.search[text;pattern];
  };
 should["replace all pattern occurences with alternative substitutes"]{
  read0[`:test/tx/fox.txt] mustmatch .tx.replace[text;pattern;replacements];
  };
 };
