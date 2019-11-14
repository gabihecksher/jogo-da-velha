vencerLinha(Simbolo, Tabuleiro) :-
	Tabuleiro = [Simbolo,Simbolo,Simbolo,_,_,_,_,_,_];
	Tabuleiro = [_,_,_,Simbolo,Simbolo,Simbolo,_,_,_];
	Tabuleiro = [_,_,_,_,_,_,Simbolo,Simbolo,Simbolo].

vencerColuna(Simbolo, Tabuleiro) :-
	Tabuleiro = [Simbolo,_,_,Simbolo,_,_,Simbolo,_,_];
	Tabuleiro = [_,Simbolo,_,_,Simbolo,_,_,Simbolo,_];
	Tabuleiro = [_,_,Simbolo,_,_,Simbolo,_,_,Simbolo].

vencerDiagonal(Simbolo, Tabuleiro) :-
	Tabuleiro = [Simbolo,_,_,_,Simbolo,_,_,_,Simbolo];
	Tabuleiro = [_,_,Simbolo,_,Simbolo,_,Simbolo,_,_].

vencer(Simbolo, Tabuleiro) :-
	vencerLinha(Simbolo, Tabuleiro);
	vencerColuna(Simbolo, Tabuleiro);
	vencerDiagonal(Simbolo, Tabuleiro).

# retorna verdadeiro apenas se o elemento na lista Tabuleiro na 
# posicao Posicao (comecando com 1, se quiser comecar a contar as
# posicoes com zero tem que trocar pra nth0) for "vazio"

jogadaValida(Posicao, Tabuleiro) :-
	nth1(Posicao, Tabuleiro, vazio). 

# Acha a primeira posicao de Tabuleiro que contem o elemento "vazio" e substitui 
# "vazio" pelo Simbolo e então coloca tabuleiro resultante em TabuleiroNovo
# com ";" vai achando as proximas posicoes vazias
mover(Simbolo, Posicao, Tabuleiro, TabuleiroNovo) :-
	select(vazio, Tabuleiro, Simbolo, TabuleiroNovo).


iniciar(Tabuleiro, Simbolo, TabuleiroNovo) :-
	Tabuleiro = [vazio,vazio,vazio,vazio,vazio,vazio],
	mover(Simbolo, 3, Tabuleiro, TabuleiroNovo).