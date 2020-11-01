.utl.require"gr"
/ represent the expression list as an appropriate dictionary of dependencies, ordered so that each variable is computed before it is used
l:("d:c+b";"c:neg b";"e:d*a";"b:10";"a:20")        / given the list of parsable expressions
(`b`c`d`a`e!(();(),`b;`c`b;();`d`a))~.gr.adep l
`c`b`d`a~.gr.flatten .gr.refs parse each l

f:`h`j`k`l!("j+k";"f+g";"j*100";"k%sum k")
`j`k`f`g~.gr.flatten .gr.refs parse each f
(`j`k`h`l!(`f`g;1#`j;`j`k;1#`k))~.gr.adep f

/    a -> b -> c
/    |    |
/    |    +--> d <-+
/    v         |   |
/    e <-------+   |
/   / \            |
/  v   v           |
/  f   g ----------+
d.a:`b`e
d.b:`c`d
d.c:0#`
d.d:enlist`e
d.e:`f`g
d.f:0#`
d.g:enlist`d
.gr.loop 1 _ d                                     / cycles (loops) in a graph

a:10
b::a+1
c::a+2
d:c+20
e::b+d
f::e+4
g::f+5
`a`b`c`e`f`g~.gr.dependson`a


t:([]e:1 1 2;f:10 20 30;g:40 50 60)
f:`h`j`k`l!("j+k";"f+g";"j*100";"k%sum k")
g:`h`j`k`l!(0b;0b;0b;enlist[`e]!enlist`e)
v::.gr.willbe[t;f;g]
show t
show v
t:update g:g+1 from t where f<50
show t
show v


