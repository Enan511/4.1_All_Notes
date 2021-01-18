spouse(grandfather,grandmother).
spouse(mizan,rawshan).
spouse(kashem,salma).

parent(grandfather,mizan).
parent(grandfather,kashem).
parent(mizan,rashik).
parent(mizan,nakiba).
parent(kashem,shohan).
parent(kashem,maliha).

/*parent(grandmother,mizan).
parent(grandmother,kashem).
parent(rawshan,rashik).
parent(rawshan,nakiba).
parent(salma,shohan).
parent(salma,maliha). */




grandparent(X,Z):- parent(X,Y), parent(Y,Z), format('~w is grandparent of ~w. ~n',[X,Z]).

sibling(X,Y) :- parent(Z,X), parent(Z,Y),X\=Y, format('~w and ~w are siblings. ~n',[X,Y]).

cousin(X,Y) :- parent(Z,X), parent(W,Y),X\=Y,Z\=W,sibling(Z,W), format('~w and ~w are cousins. ~n',[X,Y]).