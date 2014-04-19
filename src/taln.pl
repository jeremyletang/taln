
% Le predicat lire/2 lit une chaine de caracteres Chaine entre apostrophes % et terminee par un point.
% Resultat correspond a la liste des mots contenus dans la phrase.
% Les signes de ponctuation ne sont pas geres.
lire(Chaine,Resultat):-
    write('Entrer la phrase '),
    read(Chaine),
    name(Chaine, Temp),
    chaine_liste(Temp, Resultat),
    !.

% Predicat de transformation de chaine en liste
chaine_liste([],[]).

chaine_liste(Liste,[Mot|Reste]):-
    separer(Liste,32,A,B),
    name(Mot,A),
    chaine_liste(B,Reste).

% Separe une liste par rapport à un élément

separer([],X,[],[]):- !.

separer([X|R],X,[],R):- !.

separer([A|R],X,[A|Av],Ap):-
    X\==A,
    !,
    separer(R,X,Av,Ap).