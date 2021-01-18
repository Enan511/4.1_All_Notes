couple(grandfather,grandmother).
couple(mizan,rawshan).
couple(kashem,salma).

father(grandfather,mizan).
father(grandfather,kashem).
father(mizan,rashik).
father(mizan,nakiba).
father(kashem,shohan).
father(kashem,maliha).

mother(grandmother,mizan).
mother(grandmother,kashem).
mother(rawshan,rashik).
mother(rawshan,nakiba).
mother(salma,shohan).
mother(salma,maliha).

/*query : sibling(rashik,nakiba).*/
sibling(X,Y) :- father(W,X),
                father(T,Y),
                W==T,
                format('~w and ~w are siblings. ~n',[X,Y]).

/*query : cousin(rashik,shohan).*/
cousin(X,Y) :- father(W,X),
               father(T,Y),
               sibling(W,T),
               format('~w is cousin of ~w. ~n',[X,Y]).

/*query : grandchild(grandfather,rashik).*/
grandchild(X,Y) :- father(Who,Y),
                   father(X,Who),
                   format('~w is grandchild of ~w. ~n',[Y,X]).

/*query : daughter_in_law(rawshan,grandfather).*/
daughter_in_law(F,M) :- couple(Who,F),
                        father(M,Who),
                        format('~w is daughter in law of ~w. ~n',[F,M]).