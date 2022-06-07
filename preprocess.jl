function split_line(line::String)
    # Separa cada linha em colunas de acordo com o cabeçalho.
    cols = split(line, ";")
    # Processamento para pegar o sobrenome dos jogadores.
    s = split(cols[2], "-Match Odds ")[1]
    s = split(s, " v ")
    # Sbrenome do primeiro jogador.
    p1 = split(s[1], " ")
    player1 = p1[end]
    # println(cols)
    # Sobrenome do segundo jogador.
    # println(s[2])
    s = split(s[2], " ")
    player2 = s[end - 2]
    
    # O sobrenome do campeão sempre aparecem no sinal da string.
    winner = s[end]
    
    odd = replace(cols[4], "," => ".")
    stake = replace(cols[5], "," => ".")
    profit_loss = replace(cols[7], "," => ".")
    status = cols[8]
    
    return player1, player2, winner, odd, stake, profit_loss, status
end

function gerar_jogos()
    f = readlines("bets.csv")

    open("jogos.pl", "w") do io
        # write(io, "% Dados de apostas em jogos de tênis dos últimos 3 meses no mercado Exchange da Betfair.\n")
        write(io, "% jogo(jogador1, jogador2, vencedor, odd, aposta, lucro/prejuizo, status).\n\n")
        # A primeira linha é o cabeçalho da tabela.
        for l in f[2:end]
            p1, p2, winner, odd, stake, prof_loss, stat = split_line(l)
            
            write(io, "jogo('$p1', '$p2', '$winner', $odd, $stake, $prof_loss, '$stat').\n")
        end
    end
end

function filtrar_jogos(threashold::Int64)
    f = readlines("bets.csv")

    duelos = Dict{String, Int64}()
    # Conta a quantidade de vezes que cada jogador aparece.
    for l in f[2:end]
        p1, p2, _, _, _, _, _ = split_line(l)

        if haskey(duelos, p1)
            duelos[p1] += 1
        else 
            duelos[p1] = 1
        end

        if haskey(duelos, p2)
            duelos[p2] += 1
        else 
            duelos[p2] = 1
        end
    end

    open("habilidades.pl", "w") do io
        write(io, "% habilidade(jogador, habilidade).\n\n")
        for k in keys(duelos)
            # Verifica apenas jogadores com quantidade de jogos maior ou igual ao threashold.
            if duelos[k] >= threashold
                win = 0
                # Calcula a quantidade de estralas do jogador.
                for l in f[2:end]
                    _, _, winner, _, _, _, _ = split_line(l)
                    if k == winner
                        win += 1
                    end
                end
                # A quantidade de estrelas, que determina a habilidade, varia de 0 a 5.
                # Regra de 3 simples: 
                # duelos[k] ==     5
                #    win    == habilidade.
                skill = round(5 * win / duelos[k], digits=2)
                write(io, "habilidade('$k', $skill).\n")
            end
        end
    end
end

gerar_jogos()
filtrar_jogos(4)