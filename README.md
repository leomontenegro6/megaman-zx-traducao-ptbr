# [NDS] Mega Man ZX - Tradução PT-BR

Este é um projeto de tradução do jogo Mega Man ZX, de Nintendo DS, para português do Brasil. O projeto foi baseado na versão americana do jogo.

Mega Man ZX é o primeiro jogo da sexta saga da franquia Mega Man. Lançado em 2006, é a continuação direta de Mega Man Zero 4, com a história passando-se dois séculos depois. Pela primeira vez na franquia, o jogo oferece a opção de selecionar um protagonista masculino (Vent) ou feminino (Aile), antes de começar a jogar. Alguns diálogos variam em função do personagem escolhido, dando uma certa variedade no jogo.

# Como surgiu?

Havia conhecido a nova saga ZX da franquia Mega Man alguns anos atrás, mas por falta de tempo (e torcer um pouco o nariz com os novos protagonistas e novo rumo da história), não havia jogado nenhum dos dois jogos por muito tempo.

No entanto, levando em consideração que no passado eu também havia traduzido os quatro jogos da saga Mega Man Zero de Gameboy Advance, alguns anos atrás eu havia tentato iniciar um projeto para traduzir os jogos da saga Mega Man ZX para português, começando pelo desenvolvimento de uma ferramenta para extrair e reinserir textos dinamicamente. Mas a falta de tempo, misturado com a falta de paciência para terminar a ferramenta e corrigir seus bugs, acabou mantendo o projeto parado.

Mas uns 2 meses atrás, após eu ter zerado pela primeira vez ambos os jogos da franquia alguns meses atrás, decidi tocar o projeto pra frente, terminando o desenvolvimento e teste da ferramenta, e iniciando a tradução em seguida.

# O que há neste repositório?

Por ora, estão todos os scripts extraídos do jogo, juntamente com a ferramenta para extração / reinserção de textos desenvolvida em PHP. Inicialmente, enviei todos os scripts em inglês, e estou atualizando a pasta trocando-os pelos traduzidos.

# Como os scripts estão organizados?

O conteúdo dos scripts varia em função do nome do arquivo, especificamente de seus prefixos e sufixos.

O prefixo "m_" referem-se a textos de menus, enquanto que os de prefixo "talk_" referem-se a diálogos de personagens e NPCs no jogo.

O sufixo "_en" significa que os textos são do idioma inglês, enquanto que "_jp" referem-se ao japonês. Na versão européia, que há tradução para até 5 idiomas, há os prefixos "_es" (espanhol), "_fr" (francês), "_gr" (alemão), etc.

Adicionalmente, nomes de sufixo "_en1" referem-se a textos do personagem masculino (Vent), enquanto que os de sufixo "_en2" referem-se ao personagem feminino (Aile). Se não especificar número, então são textos genéricos para ambos os personagens.

A listagem abaixo explica com mais detalhes o conteúdo de cada script:

1. Menus
 - m_back_en.txt : Textos dos menus de salvar, carregar ou apagar jogo salvo;
 - m_rep_en.txt : Textos da funcionalidade de reparar Biometais, com o personagem Fleuve, no QG dos Guardiões;
 - m_sdisk_en.txt : Textos contendo descrições dos discos secretos (Secret Disks), detalhando informações sobre cada inimigo, boss, personagem ou NPC do jogo. São exibidos ao falar com o personagem Fleuve, no QG dos Guardiões;
 - m_sub_en.txt : Textos de menu exibidos ao pausar o jogo, contendo nomes de armas, itens, mapa de áreas e configurações de botões;
 - m_sys_en.txt : Textos de menu exibidos ao acessar a listagem de missões / pedidos em um transervidor. Também contém textos complementares aos menus de salvar, carregar ou apagar jogo salvo;
2. Diálogos
 - Prefixo "talk_gd1" : Falas dos NPCs masculinos situados no QG dos Guardiões. Acessível depois de realizar as três primeiras missões do jogo;
 - Prefixo "talk_gd2" : Falas dos NPCs femininos situados no QG dos Guardiões. Acessível depois de realizar as três primeiras missões do jogo;
 - Prefixo "talk_m" : Textos das missões principais do jogo. Contém 16 missões ao todo;
 - Prefixo "talk_q" : Textos das missões secundárias do jogo (quests). Traduzido como "Pedidos". Contém 24 quests ao todo;
 - Prefixo "talk_tw1" : Falas dos NPCs masculinos situados na cidade de Innerpeace (Área C). Acessível a partir da missão "Passe no Teste". Alguns NPCs aparecem apenas mais tarde no jogo;
 - Prefixo "talk_tw2" : Falas dos NPCs femininos situados na cidade de Innerpeace (Área C). Acessível a partir da missão "Passe no Teste". Alguns NPCs aparecem apenas mais tarde no jogo;
3. Conteúdos diversos
 - talk_sys_en.txt : Textos diversos, comum para ambos os personagens. Contém textos complementares aos: menus dos transervidores, itens obtidos / entregues, mini-games na loja de Morgan, etc.

No entanto, há algumas exceções e considerações quanto às regras acima:

- Os script referentes ao pedido (quest) de número 7 está disponível apenas para a personagem Aile. Em outras palavras, há apenas o script "talk_q07_en2.txt", pois o que seria o script equivalente para Vent, o personagem masculino, é um arquivo nulo;
- Alguns trechos dos scripts "talk_tw1_en1" e "talk_tw2_en1", referente às falas dos NPCs da cidade para o personagem Vent estão incompletos. Faltam nestes um ou dois blocos de texto no final do script, e acredito que, nesses casos, o jogo faça referência ao trecho equivalente nos scripts "talk_tw1_en2" e "talk_tw2_en2", da personagem Aile.
