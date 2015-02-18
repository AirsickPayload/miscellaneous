kobieta(ewa).
kobieta(elzbieta).
kobieta(iwona).
kobieta(ilona).
kobieta(anna).
kobieta(marta).
kobieta(iza).
kobieta(ola).
kobieta(magda).

mezczyzna(piotr).
mezczyzna(adam).
mezczyzna(pawel).
mezczyzna(dariusz).
mezczyzna(jan).
mezczyzna(norbert).
mezczyzna(marek).
mezczyzna(krzysztof).
mezczyzna(maciej).

rodzic(ewa,marek).
rodzic(ewa,marta).
rodzic(piotr,marek).
rodzic(piotr,marta).
rodzic(elzbieta,magda).
rodzic(norbert,magda).
rodzic(maciej,anna).
rodzic(ola,anna).
rodzic(marek,ola).
rodzic(magda,ola).
rodzic(pawel,krzysztof).
rodzic(pawel,iza).
rodzic(krzysztof,adam).
rodzic(marta,adam).
rodzic(iwona,iza).
rodzic(iwona,krzysztof).
rodzic(ilona,dariusz).
rodzic(adam,dariusz).

wiek(elzbieta,78).
wiek(norbert,80).
wiek(ewa,84).
wiek(piotr,85).
wiek(iwona,85).
wiek(pawel,86).
wiek(krzysztof,65).
wiek(iza,60).
wiek(marta,55).
wiek(marek,58).
wiek(magda,55).
wiek(maciej,32).
wiek(ola,30).
wiek(adam,37).
wiek(ilona,33).
wiek(darek,13).
wiek(anna,10).

student(anna, kowalska, informatyka, uam, poznan, 1994).
student(anna, nowak, informatyka, pp, poznan, 1994).
student(danuta, kolska, matematyka, uam, poznan, 1993).
student(zbigniew, sobkowiak, informatyka, uam, poznan, 1993).
student(marek, kowal, informatyka, pp, poznan, 1993).
student(adam, kwiatkowski, matematyka, ug, gdansk, 1994).
student(roman, laskowski, informatyka, pg, gdansk, 1994).
student(anna, bielicka, matematyka, uam, poznan, 1994).

ojciec(X,Y):-mezczyzna(X),rodzic(X,Y), X\=Y.
matka(X,Y):-kobieta(X),rodzic(X,Y), X\=Y.
rodzenstwo(X,Y):-rodzic(R,X),rodzic(R,Y), X\=Y.
brat(X,Y):-mezczyzna(X), mezczyzna(T), rodzic(T,X), rodzic(T,Y), kobieta(M), rodzic(M,X), rodzic(M,Y), X\=Y.
siostra(X,Y):-kobieta(X), mezczyzna(T), rodzic(T,X), rodzic(T,Y), kobieta(M), rodzic(M,X), rodzic(M,Y), X\=Y.
dziadek(X,Y):-rodzic(X,T), rodzic(T,Y), mezczyzna(X).
babcia(X,Y):-rodzic(X,T), rodzic(T,Y), kobieta(X).
dziadkowie(X,Y,Z):-rodzic(X,T), rodzic(T,Z),rodzic(Y,M), rodzic(M,Z), X\=Y.
wuj(X,Y):-mezczyzna(X), rodzic(R,Y),rodzic(RR,R), rodzic(RR,X), brat(X,R).
kuzyn(X,Y):-mezczyzna(X),rodzic(R,Y), rodzenstwo(R,W), rodzic(W,X).

potomek(X,Y):-rodzic(Y,X).
potomek(X,Y):-rodzic(R,X), rodzic(R,Y).
przodek(X,Y):-potomek(Y,X).


/* 4 */

wiekszy(X,Y,Y):- X =< Y.
wiekszy(X,Y,X):- X > Y.

/* 5 */

suma(X,Y,Z):- Z is X+Y.

/* 6 */
nwd(X,0,X).
nwd(X,Y,Z):-Y>0, R is X mod Y, nwd(Y,R,Z).

/* 7.a */

jarosz(ola).
jarosz(ewa).
jarosz(jan).
jarosz(pawel).
kawa(piotr).
kawa(pawel).
kawa(iza).
ksiazki(ola).
ksiazki(iza).
ksiazki(pawel).
sport(iza).
sport(ola).
sport(piotr).
sport(pawel).

lubi(ola,X):- jarosz(X),sport(X).
lubi(ewa,X):- not(kawa(X)),jarosz(X).
lubi(iza,X):- ksiazki(X).
lubi(iza,X):- sport(X),not(kawa(X)).
lubi(jan,X):- sport(X).
lubi(piotr,X):- sport(X),jarosz(X).
lubi(piotr,X):- ksiazki(X).
lubi(pawel,X):- jarosz(X),sport(X),ksiazki(X).

przyjaciele(X,Y):-lubi(X,Y),lubi(Y,X),X\=Y.