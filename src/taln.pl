%% Projet TALN
%%  Francois Portalis
%%  Jeremy Letang

% list des questions:
%   Quel est ton nom?
%   Ou vis tu?
%   As tu un animal?
%   Ton animal est il bleu?
%   Combien as tu de bras?


% creation des predication permettant de repondre aux differentes phrases
quel(est, ton, nom):- write_ln('Mon nom est nono').
ou(vis, tu):- write_ln('Je vis sur Mars').
as(tu, animal):- write_ln('oui j\'ai un chien!').
ton(animal, est, bleu):- write_ln('non il est vert').
combien(as, bras):- write_ln('j\'ai 42 bras').

% message d'erreur en cas de phrase inconnue
error:- write_ln('Desole je ne connais pas la reponse').

% definition du mot clef interrogatif
interrogation(I) --> inter(I).

% definition d'un groupe nominal
g_nominal(D, O) -->
    deter(D),
    nom(O).

% $definition d'un groupe nominal
g_nominal(O) --> nom(O).

% definition d'un groupe verbal
g_verbal(V) --> verb(V).

% definition d'un groupe verbal
g_verbal(V, P) -->
    verb(V),
    pronom(P).


%% phrase(sem) -->
%%     g_nominal(act),
%%     g_verbal(verb, obj).


% verbes
verb(est) --> ['Est'].
verb(est) --> ['est'].
verb(vis) --> ['vis'].
verb(as) --> ['As'].
verb(as) --> ['as'].

% determinants
deter(un) --> ['un'].
deter(ton) --> ['ton'].
deter(ton) --> ['Ton'].
deter(de) --> ['de'].

% mots interrogatifs
inter(quel) --> ['quel'].
inter(combien) --> ['Combien'].
inter(combien) --> ['combien'].
inter(quel) --> ['Quel'].
inter(ou) --> ['Ou'].
inter(ou) --> ['ou'].

% noms
nom(nom) --> ['nom'].
nom(animal) --> ['animal'].
nom(bleu) --> ['bleu'].
nom(bras) --> ['bras'].

% pronoms
pronom(tu) --> ['tu'].
pronom(il) --> ['il'].


% traitement de la question 'quel est ton nom'
phrase(Question) -->
    interrogation(I),
    g_verbal(V),
    g_nominal(D, O),
    {Question =..[I, V, D, O]}.

% traitement de la question 'ou vis tu'
phrase(Question) -->
    interrogation(I),
    g_verbal(D, O),
    {Question =..[I, D, O]}.

% traitement de la question 'as tu un animal'
phrase(Question) -->
    g_verbal(V, P),
    g_nominal(_, N),
    {Question =..[V, P, N]}.

% traitement de la question 'ton animal est il bleu'
phrase(Question) -->
    g_nominal(D, N),
    g_verbal(V, _),
    g_nominal(N2),
    {Question =..[D, N, V, N2]}.

% traitement de la question 'Combien as tu de bras'
phrase(Question) -->
    interrogation(I),
    g_verbal(V, _),
    g_nominal(_, N),
    {Question =..[I, V, N]}.

question(Question, WordList, Buf):-
    phrase(Question, WordList, Buf);
    Question = call(error).

reponse(Question, Reponse):-
    Reponse = call(Question).

lancer:-
    lire(_, ListWord),
    question(Question, ListWord, []),
    write('La reponse est: '),
    reponse(Question, Reponse),
    Reponse.

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
