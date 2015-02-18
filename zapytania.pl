/* 2.b */

starszy(X,Y):-wiek(X,X1), wiek(Y,Y1), X1>Y1.
mlodszy(X,Y):-wiek(X,X1), wiek(Y,Y1), X1<Y1.
tylesamolat(X,Y):-wiek(X,X1), wiek(Y,Y1), X1=:=Y1.

/* 3.a */

student(X,Y,Z,ZZ,poznan,ZZZ).

/* 3.b */
student(X,Y,informatyka,Z,poznan, ZZ), ZZ<1994.

/* 3.c */
student(X,Y,informatyka,Z,poznan,ZZ), Z=pp.

/* 3.d */
student(_,_,matematyka,X,Y,_).