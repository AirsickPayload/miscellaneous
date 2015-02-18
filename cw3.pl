/* zad 3 */
min(X,Y,X):- X<=Y,!.
min(X,Y,Y).

gcd(X, 0, X):- !.
gcd(0, X, X):- !.
gcd(X, Y, D):- X > Y, !, Z is X mod Y, gcd(Y, Z, D).
gcd(X, Y, D):- Z is Y mod X, gcd(X, Z, D).

/* zad 4 */
zad4_zapisz :- write('Podaj dane studenta'), nl,
                 write('Imie'),
                 read(Imie),
                 write('Nazwisko'),
                 read(Nazwisko),
                 write('Indeks'),
                 read(Indeks),
                 append('studenci.txt'),
                 write('student('),
                 write(Imie),
                 write(', '),
                 write(Nazwisko),
                 write(', '),
                 write(Indeks),
                 write(')'),
                 write(.),
                 nl,
                 told.
