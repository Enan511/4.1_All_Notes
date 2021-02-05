partner(adam,agatha).
partner(betty,ben).
partner(charles,corinda).
partner(david,dawn).
partner(emma,edwardg).
partner(frank,felicity).
partner(george,gwen).



parent(adam,betty).
parent(adam,charles).
parent(betty,david).
parent(charles,emma).
parent(david,frank).
parent(emma,george).
parent(frank,harry).
parent(george,imogen).



/*grandparent(X,Y).*/
grandparent(X,Z):- parent(X,Y), parent(Y,Z).

/*sibling(X,Y).*/
sibling(X,Y) :- parent(Z,X), parent(Z,Y),X\=Y.

/*first_cousin(X,Y).*/
first_cousin(X,Y) :- parent(Z,X), parent(W,Y),X\=Y,Z\=W,sibling(Z,W).

/*third_cousin(X,Y).*/
third_cousin(X,Y) :- grandparent(Z,X), grandparent(W,Y),X\=Y,Z\=W,first_cousin(Z,W).

/*second_cousin_once_removed(X,Y).*/
second_cousin_once_removed(X,Y):- parent(Z,X), grandparent(T,Y),first_cousin(Z,T),X\=Y.