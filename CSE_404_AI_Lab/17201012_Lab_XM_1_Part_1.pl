/*Part A*/
tall(shafa,rashik).
tall(rashik,prince).
tall(prince,iqbal).

/*Part B*/

rule_tall(X,Y):-tall(X,Y).
rule_tall(X,Y):-tall(Z,Y),rule_tall(X,Z).
