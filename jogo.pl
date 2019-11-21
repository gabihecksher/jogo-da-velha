comecar :- como_jogar, inicializar([' ',' ',' ',' ',' ',' ',' ',' ',' ']).

inicializar(Tab) :- ganhar(Tab,x), write('Voce ganhou!').
inicializar(Tab) :- ganhar(Tab,o), write('Computador ganhou').
inicializar(Tab) :- 
	read(N),
	mover_x(Tab,N,NovoTab),
	imprimir_tabuleiro(NovoTab),
	jogar_o(NovoTab,MaisNovoTab),
	imprimir_tabuleiro(MaisNovoTab),
	inicializar(MaisNovoTab).

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


x_pode_ganhar(Tab) :-
	mover_o(Tab,x,NovoTab),
	ganhar(NovoTab,x),
	write('X pode ganhar'),nl,
	imprimir_tabuleiro(NovoTab),nl.

jogar_o(Tab, NovoTab) :- 
	mover_o(Tab,o,NovoTab),
	ganhar(NovoTab,o),!.

jogar_o(Tab, NovoTab) :- 
	mover_o(Tab,o,NovoTab),
	not(x_pode_ganhar(NovoTab)).

jogar_o(Tab, NovoTab) :- 
	mover_o(Tab,o,NovoTab).

jogar_o(Tab, NovoTab) :- 
	not(member(' ',Tab)),!,
	write('Empate'),nl.
