spouse(motaleb,moriom).
spouse(mizan,rawshan).
spouse(kashem,salma).
spouse(rashik,mariam).
spouse(shohan,nawring).
spouse(mahin,mow).
spouse(shamim,sharmin).



father(motaleb,mizan).
father(motaleb,kashem).
father(mizan,rashik).
father(mizan,nakiba).
father(kashem,shohan).
father(rashik,mahin).
father(shohan,shamim).
father(mahin,mugdho).
father(shamim,athoi).



/*grandfather(X,Y).*/
grandfather(X,Z):- father(X,Y), father(Y,Z), format('~w is grandfather of ~w. ~n',[X,Z]).

/*sibling(X,Y).*/
sibling(X,Y) :- father(Z,X), father(Z,Y),X\=Y, format('~w and ~w are siblings. ~n',[X,Y]).

/*first_cousin(X,Y).*/
first_cousin(X,Y) :- father(Z,X), father(W,Y),X\=Y,Z\=W,sibling(Z,W), format('~w and ~w are first cousins. ~n',[X,Y]).

/*second_cousin(X,Y).*/
second_cousin(X,Y) :- father(Z,X), father(W,Y),X\=Y,Z\=W,first_cousin(Z,W), format('~w and ~w are second cousins. ~n',[X,Y]).

/*third_cousin(X,Y).*/
third_cousin(X,Y) :- grandfather(Z,X), grandfather(W,Y),X\=Y,Z\=W,first_cousin(Z,W), format('~w and ~w are second cousins. ~n',[X,Y]).

/*first_cousin_once_removed(X,Y).*/
first_cousin_once_removed(X,Y):- father(Z,Y), first_cousin(X,Z), X\=Y, format('Afther removing 1st cousin once').

/*first_cousin_twice_removed(X,Y).*/
first_cousin_twice_removed(X,Y):- grandfather(Z,Y), first_cousin(X,Z), X\=Y, format('Afther removing 1st cousin twice').