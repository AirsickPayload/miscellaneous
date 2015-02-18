
 
/* zadanie 5 */
max([X],X) :- !.
max([X|Xs],X):- max(Xs,Y), X >=Y.
max([X|Xs],N):- max(Xs, N), N > X.
 
/* zadanie 6 */
znajdz([X|_], 1, X) :- !.
znajdz([_|Xs], N, M) :- N1 is N-1, znajdz(Xs,N1,M). 
 
/* zadanie 7 */
poczatek([X], [X|Ys]) :- !.
poczatek([X|Xs], [X|Ys]) :- poczatek(Xs,Ys).
 
/* zadanie 8 */
ostatni([X], X).
ostatni([I|Xs],X) :- ostatni(Xs,X).
 
/* zadanie 9 */
nty(A, [A], 0).
nty(A, [B|Tail], C, X) :- B = A, X is C, !; Z is C+1, nty(A, Tail, Z, X).
nty(A, B, X) :- nty(A, B, 0, X).

nty2(E, [E|L], 1) :- !.
nty2(E, [I|L], X) :- nty2(E, L , X1), X is X1 + 1.
 
/* zadanie 10 */
rosnacy([_]):- !.
rosnacy([X|[Xs|Xss]]) :- X =< Xs, rosnacy([Xs|Xss]).

silnia(0,1) :- !.
silnia(X,Y):- X1 is X-1, silnia(X1,B), Y is B*X.

nalezy_do_l(X, [X|_]).
nalezy_do_l(X, [_|R]) :- nalezy_do_l(X,R).

pozbior([],Y).
podzbior([X|R], Y) :- nalezy_do_l(X,Y), podzbior(R,Y).

intersectt([],Y,[]).
intersectt([X|R],Y,[X|Z]) :- nalezy_do_l(X,Y), !, intersectt(R,Y,Z).
intersectt([X|R],Y,Z) : - intersectt(R,Y,Z).

union([],Y,Y).
union([X|R], Y, Z) :- nalezy_do_l(X,Y), !, union(R,Y,Z).
union([X|R], Y, [X|Z]) :- union(R,Y,Z).

diff([],Y,[]).
diff([X|R], Y, [X|Z]) :- not(nalezy_do_l(X,Y)), !, diff(R,Y,Z).
diff([X|R], Y , Z) :- diff(R,Y,Z).

ostatni([X],X).
ostatni([X|R],Y) :- ostatni(R,Y).

max2([X],X) :- !.
max2([X|Xs], X) :- max2(Xs, Y), X >= Y.
max2([X|Xs], Y) :- max2(Xs, Y), Y > X.


find2([X|_], 1, X) :- !.
find2([_|Xs], N, X) :- N1 is N-1, find2(Xs,N1,X).

sumlst([],0).
sumlst([G|O], S) :- sumlst(O,S1), S is G + S1. 


mm(X,Y,X) :- X>=Y, !.
mm(X,Y,Y).



len([],0).
len([X|Xs], S) :- len(Xs, S1), S is S1+1.