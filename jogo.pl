comecar :- como_jogar, inicializar([' ',' ',' ',' ',' ',' ',' ',' ',' ']).
assistir:- inicializarT([' ',' ',' ',' ',' ',' ',' ',' ',' ']).
comBusca:- inicializarTT([' ',' ',' ',' ',' ',' ',' ',' ',' ']).

inicializar(Tab) :- ganhar(Tab,x), write('X ganhou!'), abort().
inicializar(Tab) :- ganhar(Tab,o), write('o ganhou!'), abort().
inicializar(Tab) :- 
	read(N),
	mover_x(Tab,N,NovoTab),
	imprimir_tabuleiro(NovoTab),
	jogar_o(NovoTab,MaisNovoTab),
	imprimir_tabuleiro(MaisNovoTab),
	inicializar(MaisNovoTab).

inicializarT(Tab) :- ganhar(Tab,x), write('x ganhou!'),!.
inicializarT(Tab) :- ganhar(Tab,o), write('o ganhou!'),!.
inicializarT(Tab) :- 
    jogar_x(Tab,NovoTab),
	imprimir_tabuleiro(NovoTab),
	jogar_o(NovoTab,MaisNovoTab),
    !,
	imprimir_tabuleiro(MaisNovoTab),
	inicializarT(MaisNovoTab).

outro(x, o).
outro(o, x).

inicializarTT(Tab) :- ganhar(Tab,x), write('x ganhou!'),!.
inicializarTT(Tab) :- ganhar(Tab,o), write('o ganhou!'),!.
inicializarTT(Tab) :- 
    write('Proxima Jogada'),
    jogar_x(Tab,NovoTab),
	imprimir_tabuleiro(NovoTab),
	%jogar_o(NovoTab,MaisNovoTab),
    melhor_jogada(NovoTab,MaisNovoTab),
    write('saiu de melhor jogada'),
    !,
	imprimir_tabuleiro(MaisNovoTab),
	inicializarTT(MaisNovoTab).

melhor_jogada(NovoTab,MaisNovoTab) :-
    minmax(NovoTab,MaisNovoTab,_,o);

membro(X,[X|_]).
membro(X,[_|C]):-
membro(X,C).

minmax(Tab, MelhorNovoTab, Val, Jogador1):-
    outro(Jogador1, Jogador2),
	member(' ',Tab),
    bagof(NovoTab, jogar_v(Tab, Jogador1, NovoTab), NovoTabList),
    nl,
    write(NovoTabList),
    melhor(NovoTabList, MelhorNovoTab, Val, Jogador2),!.
minmax(Tab, _, Val, _):-
    utilidade(Tab, Val),!.

jogar_v(Tab, x, NovoTab) :- jogar_x(Tab, NovoTab).
jogar_v(Tab, o, NovoTab) :- jogar_o(Tab, NovoTab).

melhor([Tab], Tab, Val, Jogador) :-
    minmax(Tab, _, Val, Jogador).
melhor([Tab | TabLista], MelhorTab, MelhorVal, Jogador) :-
    minmax(Tab, _, Val1, Jogador),
    melhor(TabLista, Tab2, Val2, Jogador),
    melhor_de(Val1, Val2),
    write('e agora jose').

melhor_de(Val, Val1) :-                         
    Val > Val1.

utilidade(Tab, 1) :- ganhar(Tab, o).      
utilidade(Tab, -1) :- ganhar(Tab, x).      
utilidade(_, 0).      

ganhar(Tab,Jogador) :-
	ganhar_linha(Tab,Jogador);
	ganhar_coluna(Tab,Jogador);
	ganhar_diagonal(Tab,Jogador).

ganhar_linha(Tab,Jogador) :-
	Tab = [Jogador,Jogador,Jogador,_,_,_,_,_,_];
	Tab = [_,_,_,Jogador,Jogador,Jogador,_,_,_];
	Tab = [_,_,_,_,_,_,Jogador,Jogador,Jogador].

ganhar_coluna(Tab,Jogador) :-
	Tab = [Jogador,_,_,Jogador,_,_,Jogador,_,_];
	Tab = [_,Jogador,_,_,Jogador,_,_,Jogador,_];
	Tab = [_,_,Jogador,_,_,Jogador,_,_,Jogador].


ganhar_diagonal(Tab,Jogador) :-
	Tab = [Jogador,_,_,_,Jogador,_,_,_,Jogador];
	Tab = [_,_,Jogador,_,Jogador,_,Jogador,_,_].

mover_o([A,' ',C,D,E,F,G,H,I], Jogador, [A,Jogador,C,D,E,F,G,H,I]).
mover_o([A,B,C,D,E,F,G,' ',I], Jogador, [A,B,C,D,E,F,G,Jogador,I]).
mover_o([A,B,C,D,' ',F,G,H,I], Jogador, [A,B,C,D,Jogador,F,G,H,I]).
mover_o([A,B,' ',D,E,F,G,H,I], Jogador, [A,B,Jogador,D,E,F,G,H,I]).
mover_o([A,B,C,' ',E,F,G,H,I], Jogador, [A,B,C,Jogador,E,F,G,H,I]).
mover_o([A,B,C,D,E,F,G,H,' '], Jogador, [A,B,C,D,E,F,G,H,Jogador]).
mover_o([' ',B,C,D,E,F,G,H,I], Jogador, [Jogador,B,C,D,E,F,G,H,I]).
mover_o([A,B,C,D,E,' ',G,H,I], Jogador, [A,B,C,D,E,Jogador,G,H,I]).
mover_o([A,B,C,D,E,F,' ',H,I], Jogador, [A,B,C,D,E,F,Jogador,H,I]).

mover_x([' ',B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
mover_x([A,' ',C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
mover_x([A,B,' ',D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
mover_x([A,B,C,' ',E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
mover_x([A,B,C,D,' ',F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
mover_x([A,B,C,D,E,' ',G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
mover_x([A,B,C,D,E,F,' ',H,I], 7, [A,B,C,D,E,F,x,H,I]).
mover_x([A,B,C,D,E,F,G,' ',I], 8, [A,B,C,D,E,F,G,x,I]).
mover_x([A,B,C,D,E,F,G,H,' '], 9, [A,B,C,D,E,F,G,H,x]).
mover_x(Tab,_,Tab) :- write('Jogada proibida. Tente uma posição válida.'), inicializar(Tab).

imprimir_tabuleiro([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,
	write('|'),
	write([G,H,I]),write('|'),nl,nl.


como_jogar :-
	write('Voce e o jogador x.'),nl,
	write('Para jogar, escreva o numero da posicao desejada e um ponto final.'),nl,
	write('Ex: ?-5.'),nl,nl,
	imprimir_tabuleiro([1,2,3,4,5,6,7,8,9]).

%X tenta achar uma posicao se ganha
jogar_x(Tab, NovoTab) :-
	mover_o(Tab,x,NovoTab),
	ganhar(NovoTab,x).
    %write('X ganha com essa:'),
    %imprimir_tabuleiro(NovoTab).


%X tenta achar uma posicao se não perde
jogar_x(Tab, NovoTab) :- 
	mover_o(Tab,x,NovoTab),
	not(o_pode_ganhar(NovoTab)).
    %write('X não perde com essa:'),
    %imprimir_tabuleiro(NovoTab).

jogar_x(Tab, NovoTab) :- 
	mover_o(Tab,x,NovoTab).

jogar_x(Tab, _) :-
    not(member(' ',Tab)),!,
    write('Empate').%,
    %abort().

o_pode_ganhar(Tab) :-
    mover_o(Tab,o,NovoTab),
	ganhar(NovoTab,o).
    %write('o pode ganhar com: '),nl,
	%imprimir_tabuleiro(NovoTab).	

x_pode_ganhar(Tab) :-
	mover_o(Tab,x,NovoTab),
    ganhar(NovoTab,x).
	%write('X pode ganhar com:'),nl,
    %imprimir_tabuleiro(NovoTab).	
	
%jogar com essa se ganha
jogar_o(Tab, NovoTab) :-
    %write('Tentou ganhar'),nl,
	mover_o(Tab,o,NovoTab),
	ganhar(NovoTab,o),!.

%%jogar com essa se nao perde
jogar_o(Tab, NovoTab) :- 
    %write('Tentou nao perder'),nl,
	mover_o(Tab,o,NovoTab),
	not(x_pode_ganhar(NovoTab)).

jogar_o(Tab, NovoTab) :- 
    %write('Tentou nada'),nl,
	mover_o(Tab,o,NovoTab).

jogar_o(Tab, _) :- 
	not(member(' ',Tab)),!,
    write('Empate').
%,
 %   abort().



