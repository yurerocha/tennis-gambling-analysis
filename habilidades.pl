% habilidade(jogador, habilidade).

habilidade('Tiafoe', 5.0).
habilidade('Serdarusic', 1.25).
habilidade('Schwartzman', 5.0).
habilidade('Fritz', 3.75).
habilidade('Blanch', 0.0).
habilidade('Paul', 1.25).
habilidade('Gaio', 5.0).
habilidade('Lehecka', 5.0).
habilidade('Etcheverry', 1.25).
habilidade('Bouzkova', 0.0).
habilidade('Bonzi', 1.0).
habilidade('Watson', 0.0).
habilidade('Arnaldi', 0.0).
habilidade('Zverev', 5.0).
habilidade('Moraing', 5.0).
habilidade('Vavassori', 5.0).
habilidade('Krueger', 1.67).
habilidade('Verdasco', 3.75).
habilidade('Medjedovic', 0.0).
habilidade('Johnson', 2.5).

% Previsão, baseada em jogos passados, de quem ganharia um novo jogo.
% novo_jogo(jogador 1, jogador 2)
novo_jogo(J1, J2) :- habilidade(J1, H1), habilidade(J2, H2), H1 > H2, atom_concat('Campeão: ', J1, S), write(S), nl.
novo_jogo(J1, J2) :- habilidade(J1, H1), habilidade(J2, H2), H2 > H1, atom_concat('Campeão: ', J2, S), write(S), nl.
novo_jogo(J1, J2) :- habilidade(J1, H1), habilidade(J2, H2), H1 == H2, write('Empate'), nl.
