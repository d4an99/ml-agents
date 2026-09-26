@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul 2>&1
title Guia interativo - Desbloqueio PSP (CFW ARK-4 + cIPL permanente)
color 0A
mode con: cols=110 lines=50 >nul 2>&1

rem ============================================================================
rem  GUIA INTERATIVO - PSP: CUSTOM FIRMWARE ARK-4 + cIPL PERMANENTE
rem  Serve para PSP-1000, PSP-2000, PSP-3000, PSP Go (N1000) e PSP Street (E1000).
rem  Baseado na wiki oficial do ARK-4 (PSP-Archive/ARK-4), consultada em set/2026.
rem  Salve este arquivo como UTF-8 SEM BOM com finais de linha CRLF.
rem ============================================================================

set "PASTA=%~dp0"
set "PROG=%PASTA%progresso_psp.txt"
set "REG=%PASTA%log_psp.txt"
set "TOTAL=24"
set "ASCII=1"
set "PSB64=CgAkAHMAcgBjAD0AJABlAG4AdgA6AFMAQQBfAFMAUgBDADsAIAAkAGQAcwB0AD0AJABlAG4AdgA6AFMAQQBfAEQAUwBUAAoAJAB0AD0AWwBJAE8ALgBGAGkAbABlAF0AOgA6AFIAZQBhAGQAQQBsAGwAVABlAHgAdAAoACQAcwByAGMALABbAFQAZQB4AHQALgBFAG4AYwBvAGQAaQBuAGcAXQA6ADoAVQBUAEYAOAApAAoAJABtAGEAcAA9AEAAewAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADQAKQA9ACcAIABvAHUAIAAnADsACgAgACgAWwBzAHQAcgBpAG4AZwBdAFsAYwBoAGEAcgBdADAAeAAyADYAMwAwACkAPQAnAFsAbQBlAG4AdQBdACcAOwAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIANwAxADMAKQA9ACcATwBLACcAOwAKACAAKAAnAOVlLGcnACkAPQAnAE4AaQBoAG8AbgAgACgASgBhAHAAYQBvACkAJwA7AAoAIAAoACcALYqaW1cwajBEMCcAKQA9ACcAbgBhAG8AIABkAGUAZgBpAG4AaQByACcAOwAKACAAKAAnAACzXNX8u22tJwApAD0AJwBEAGEAZQBoAGEAbgAgAE0AaQBuAGcAdQBrACAAKABDAG8AcgBlAGkAYQApACcAOwAKACAAKAAnACTBFchY1cDJIABKxUzHJwApAD0AJwBuAGEAbwAgAGQAZQBmAGkAbgBpAHIAJwAKAH0ACgBmAG8AcgBlAGEAYwBoACgAJABrACAAaQBuACAAJABtAGEAcAAuAEsAZQB5AHMAKQB7ACAAJAB0AD0AJAB0AC4AUgBlAHAAbABhAGMAZQAoACQAawAsACQAbQBhAHAAWwAkAGsAXQApACAAfQAKACQAYQByAHIAbwB3AD0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADIACgAkAHMAYgAyAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFQAZQB4AHQALgBTAHQAcgBpAG4AZwBCAHUAaQBsAGQAZQByAAoAZgBvAHIAZQBhAGMAaAAoACQAbABpAG4AZQAgAGkAbgAgACQAdAAgAC0AcwBwAGwAaQB0ACAAIgBgAHIAYABuACIAKQB7AAoAIAAgAGkAZgAoACQAbABpAG4AZQAuAEkAbgBkAGUAeABPAGYAKAAkAGEAcgByAG8AdwApACAALQBnAGUAIAAwACkAewAKACAAIAAgACAAJABxAD0AJABmAGEAbABzAGUAOwAgACQAbgBsAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFQAZQB4AHQALgBTAHQAcgBpAG4AZwBCAHUAaQBsAGQAZQByAAoAIAAgACAAIABmAG8AcgBlAGEAYwBoACgAJABjACAAaQBuACAAJABsAGkAbgBlAC4AVABvAEMAaABhAHIAQQByAHIAYQB5ACgAKQApAHsACgAgACAAIAAgACAAIABpAGYAKAAkAGMAIAAtAGUAcQAgACcAIgAnACkAewAgACQAcQA9AC0AbgBvAHQAIAAkAHEAOwAgAFsAdgBvAGkAZABdACQAbgBsAC4AQQBwAHAAZQBuAGQAKAAkAGMAKQAgAH0ACgAgACAAIAAgACAAIABlAGwAcwBlAGkAZgAoACQAYwAgAC0AZQBxACAAJABhAHIAcgBvAHcAKQB7ACAAaQBmACgAJABxACkAewBbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJwAtAD4AJwApAH0AIABlAGwAcwBlACAAewBbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJwAtAF4APgAnACkAfQAgAH0ACgAgACAAIAAgACAAIABlAGwAcwBlAHsAIABbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJABjACkAIAB9AAoAIAAgACAAIAB9AAoAIAAgACAAIAAkAGwAaQBuAGUAPQAkAG4AbAAuAFQAbwBTAHQAcgBpAG4AZwAoACkACgAgACAAfQAKACAAIABbAHYAbwBpAGQAXQAkAHMAYgAyAC4AQQBwAHAAZQBuAGQAKAAkAGwAaQBuAGUAKQA7ACAAWwB2AG8AaQBkAF0AJABzAGIAMgAuAEEAcABwAGUAbgBkACgAIgBgAHIAYABuACIAKQAKAH0ACgAkAHQAPQAkAHMAYgAyAC4AVABvAFMAdAByAGkAbgBnACgAKQA7ACAAaQBmACgAJAB0AC4ATABlAG4AZwB0AGgAIAAtAGcAZQAgADIAKQB7ACAAJAB0AD0AJAB0AC4AUwB1AGIAcwB0AHIAaQBuAGcAKAAwACwAJAB0AC4ATABlAG4AZwB0AGgALQAyACkAIAB9AAoAJABuAD0AJAB0AC4ATgBvAHIAbQBhAGwAaQB6AGUAKABbAFQAZQB4AHQALgBOAG8AcgBtAGEAbABpAHoAYQB0AGkAbwBuAEYAbwByAG0AXQA6ADoARgBvAHIAbQBEACkACgAkAHMAYgA9AE4AZQB3AC0ATwBiAGoAZQBjAHQAIABUAGUAeAB0AC4AUwB0AHIAaQBuAGcAQgB1AGkAbABkAGUAcgAKAGYAbwByAGUAYQBjAGgAKAAkAGMAIABpAG4AIAAkAG4ALgBUAG8AQwBoAGEAcgBBAHIAcgBhAHkAKAApACkAewAKACAAIABpAGYAKABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBDAGgAYQByAFUAbgBpAGMAbwBkAGUASQBuAGYAbwBdADoAOgBHAGUAdABVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQAoACQAYwApACAALQBuAGUAIABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQBdADoAOgBOAG8AbgBTAHAAYQBjAGkAbgBnAE0AYQByAGsAKQB7ACAAWwB2AG8AaQBkAF0AJABzAGIALgBBAHAAcABlAG4AZAAoACQAYwApACAAfQAKAH0ACgAkAG8AdQB0AD0AJABzAGIALgBUAG8AUwB0AHIAaQBuAGcAKAApAAoAJABvAHUAdAA9AFsAcgBlAGcAZQB4AF0AOgA6AFIAZQBwAGwAYQBjAGUAKAAkAG8AdQB0ACwAJwBbAF4AXAB4ADAAMAAtAFwAeAA3AEYAXQAnACwAJwA/ACcAKQAKACQAbwB1AHQAPQAkAG8AdQB0AC4AUgBlAHAAbABhAGMAZQAoACcAcwBlAHQAIAAiAEEAUwBDAEkASQA9ADAAIgAnACwAJwBzAGUAdAAgACIAQQBTAEMASQBJAD0AMQAiACcAKQAKAFsASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABzAHQALAAkAG8AdQB0ACwAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAVABlAHgAdAAuAFUAVABGADgARQBuAGMAbwBkAGkAbgBnACgAJABmAGEAbABzAGUAKQApACkACgA="
set "DESTINO=MENU"
set "VOLTAR=MENU"
set "PASSO=0"
set "SDL="
set "MODELO="
set "RAIZ="
call :CARREGAR

:MENU
cls
echo.
echo  ==========================================================================================
echo   GUIA INTERATIVO DE DESBLOQUEIO  -  PSP  (CFW ARK-4 + cIPL permanente)
echo  ==========================================================================================
echo.
echo   "Desbloquear" o PSP = instalar uma CUSTOM FIRMWARE (CFW). Com ela o console roda homebrew,
echo   emuladores, backups dos SEUS jogos em ISO/CSO, plugins, temas e jogos de PS1 em EBOOT.
echo   A CFW de referencia hoje e a ARK-4; ela roda por cima do firmware oficial 6.61 da Sony.
echo.
echo   Existem DOIS niveis, e este guia faz os dois na ordem certa:
echo     1. TEMPORARIA (ARK Loader) - risco zero, sai ao desligar. Serve para testar tudo antes.
echo     2. PERMANENTE (cIPL)       - grava na NAND, liga ja com CFW. Risco baixo, mas real.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: voce parou no passo %PASSO% de %TOTAL%.
if not "%PASSO%"=="0" echo.
echo   [1] Comecar do inicio (passo 1)
echo   [2] Continuar de onde parei
echo   [3] Ir para um passo especifico
echo   [4] Requisitos e downloads
echo   [5] Erros comuns e como corrigir
echo   [6] Como desfazer (voltar ao firmware oficial)
echo   [7] Abrir links oficiais no navegador
echo   [8] Ferramentas de PC (detectar cartao, backup, pastas, conferir arquivos)
echo   [9] Apagar o progresso salvo
echo   [A] Modo sem acentos (use se o texto aparecer com caracteres estranhos)
echo   [0] Sair
echo.
choice /c 1234567890A /n /m "   Escolha uma opcao: "
if errorlevel 11 goto SEM_ACENTOS
if errorlevel 10 goto SAIR
if errorlevel 9 goto APAGAR_PROGRESSO
if errorlevel 8 (set "VOLTAR=MENU" & goto FERRAMENTAS)
if errorlevel 7 goto LINKS
if errorlevel 6 goto DESFAZER
if errorlevel 5 (set "VOLTAR=MENU" & goto ERROS)
if errorlevel 4 goto REQUISITOS
if errorlevel 3 goto IR_PARA
if errorlevel 2 goto CONTINUAR
goto PASSO_1

:CONTINUAR
if "%PASSO%"=="0" goto PASSO_1
set /a PROXIMO=%PASSO%+1
if %PROXIMO% GTR %TOTAL% goto CONCLUIDO
goto PASSO_%PROXIMO%

:IR_PARA
cls
echo.
echo   LISTA DE PASSOS
echo   ---------------
echo    1  O que e e o que nao e este desbloqueio     13  Copiar o ARK-4 para o cartao (PC)
echo    2  Virar o PSP e identificar o modelo         14  Conferir se os arquivos chegaram (PC)
echo    3  Risco de brick do SEU modelo               15  Ejetar com seguranca e sair do modo USB
echo    4  Ver a versao do firmware no console        16  Rodar o ARK Loader no PSP (temporaria)
echo    5  Bateria, carregador e cartao de memoria    17  Confirmar "ARK-4 Live" nas Informacoes
echo    6  Conectar o PSP ao PC em modo USB           18  Decidir: ficar temporaria ou ir de cIPL
echo    7  Detectar a unidade do cartao (PC)          19  Instalar o cIPL (CFW permanente)
echo    8  Backup completo do cartao (PC)             20  Confirmar "ARK 4.20.XX cIPL"
echo    9  Conferir FAT32 e espaco livre (PC)         21  Configurar o ARK (menu VSH / SELECT)
echo   10  Criar a estrutura de pastas (PC)           22  Colocar jogos, homebrew e PS1
echo   11  Atualizar para o firmware oficial 6.61     23  Backup dos saves e do cartao
echo   12  Baixar o ARK-4 (ou ARK-5) no PC            24  Verificacao final e boas praticas
echo.
set "N="
set /p "N=   Digite o numero do passo (1-%TOTAL%) ou ENTER para voltar: "
if "%N%"=="" goto MENU
:STRIP_ZERO
if "%N:~0,1%"=="0" (set "N=%N:~1%" & goto STRIP_ZERO)
if "%N%"=="" goto MENU
set /a N=%N% 2>nul
if %N% LSS 1 goto MENU
if %N% GTR %TOTAL% goto MENU
goto PASSO_%N%

rem ============================================================================
rem  PASSOS
rem ============================================================================

:PASSO_1
cls
call :CABECALHO 1 "O que e (e o que nao e) este desbloqueio"
echo   O QUE VOCE VAI CONSEGUIR:
echo     - Rodar homebrew: emuladores (SNES, Mega Drive, GBA, Master System, MAME), players, utilitarios.
echo     - Rodar backups dos SEUS jogos de UMD em ISO/CSO direto do cartao, sem o disco.
echo     - Rodar jogos de PS1 convertidos em EBOOT.PBP.
echo     - Plugins (cheats, filtros de tela, adhoc online), temas, overclock da CPU.
echo     - Tirar o UMD da jogada: menos consumo de bateria e menos desgaste do leitor.
echo.
echo   O QUE ESTE GUIA NAO FAZ:
echo     - Nao ensina a baixar jogos. Faca o dump dos SEUS UMDs (o proprio ARK tem dumper de UMD).
echo     - Nao conserta PSP com defeito de hardware (tela, analogico, leitor, dock do Go).
echo     - Nao "destrava" regiao: o PSP ja e livre de regiao para jogos.
echo.
echo   COMO FUNCIONA (resumo honesto):
echo     - O firmware oficial (OFW) mais recente e ultimo da Sony e o 6.61, de janeiro de 2015.
echo     - A CFW ARK-4 roda POR CIMA do 6.61. Ultima versao estavel: v4.20.69 r206 (maio/2026).
echo     - O projeto ARK-4 foi encerrado e arquivado em agosto/2026; o sucessor e o ARK-5,
echo       em desenvolvimento ativo, mas com lancamentos marcados como pre-release.
echo     - Por isso o METODO RECOMENDADO aqui e ARK-4 v4.20.69 r206 + cIPL: e o mais testado.
echo       Quem quiser o mais novo pode usar o ARK-5 - o passo 12 mostra as duas opcoes.
echo.
echo   REVERSIBILIDADE:
echo     - A etapa temporaria nao grava nada: basta desligar o console.
echo     - O cIPL grava na NAND, mas e removivel por software (opcao 6 do menu).
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 1
goto %DESTINO%

:PASSO_2
cls
call :CABECALHO 2 "VIRE O PSP: identificar o modelo exato (acao fisica)"
echo   ACAO FISICA: pegue o console e VIRE-O de costas, com a tela para baixo.
echo   Na traseira, perto do meio ou embaixo, existe uma etiqueta impressa com o numero do modelo.
echo.
echo        TRASEIRA DO PSP (tela virada para baixo)
echo.
echo        +-------------------------------------------------------------+
echo        :                                                             :
echo        :                  [ tampa da bateria ]                       :
echo        :                                                             :
echo        :        etiqueta:  PSP-XXXX   /   Model No.                  :   ^<-- leia AQUI
echo        :        (letras pequenas, junto do "MADE IN ...")            :
echo        :                                                             :
echo        +-------------------------------------------------------------+
echo.
echo   No PSP Go a etiqueta fica atras, perto da trava da tampa deslizante.
echo   Se a etiqueta estiver apagada, da para identificar pelo formato:
echo     - PSP-1000 "Fat"    : mais grosso e pesado; tampa da bateria removivel por trava.
echo     - PSP-2000 "Slim"   : bem mais fino que o 1000; saida de video por cabo componente.
echo     - PSP-3000          : igual ao 2000 por fora, mas a tela tem um padrao de linhas visivel de perto.
echo     - PSP Go (N1000)    : pequeno, tela deslizante, SEM leitor de UMD, 16 GB internos.
echo     - PSP Street (E1000): fosco, SEM Wi-Fi, SEM alto-falantes estereo, botao liga na frente.
echo.
echo   Escolha o seu modelo:
echo     [1] PSP-1000 (Fat)          [2] PSP-2000 (Slim)        [3] PSP-3000
echo     [4] PSP Go (N1000)          [5] PSP Street (E1000)     [6] Nao consegui identificar
echo.
choice /c 123456 /n /m "   Modelo: "
if errorlevel 6 goto PASSO_2_AJUDA
if errorlevel 5 (set "MODELO=E1000" & goto PASSO_2_OK)
if errorlevel 4 (set "MODELO=GO" & goto PASSO_2_OK)
if errorlevel 3 (set "MODELO=3000" & goto PASSO_2_OK)
if errorlevel 2 (set "MODELO=2000" & goto PASSO_2_OK)
set "MODELO=1000"

:PASSO_2_OK
echo.
echo   Modelo registrado: %MODELO%
if "%MODELO%"=="GO" set "RAIZ=ef0"
if not "%MODELO%"=="GO" set "RAIZ=ms0"
echo   Raiz de armazenamento usada nos comandos deste guia: %RAIZ%:
call :ANOTAR "Modelo informado: %MODELO% (raiz %RAIZ%:)"
call :FIM_PASSO 2
goto %DESTINO%

:PASSO_2_AJUDA
echo.
echo   Como confirmar sem a etiqueta:
echo     1. Tem leitor de UMD (a tampa redonda que abre atras)? NAO = PSP Go.
echo     2. Tem Wi-Fi? Olhe se existe o interruptor/antena e se aparece "Configuracoes de rede"
echo        nas Configuracoes. Sem Wi-Fi = PSP Street (E1000).
echo     3. E grosso, com a bateria saindo por uma tampa grande com trava? = PSP-1000.
echo     4. E fino e a tela tem um leve padrao de linhas quando voce olha de perto? = PSP-3000.
echo        Fino e sem esse padrao = PSP-2000.
echo   Nao importa tanto para a instalacao: o ARK-4 e o cIPL funcionam nos cinco modelos.
echo   O que muda e o risco de recuperacao em caso de brick, explicado no passo 3.
echo.
call :AGUARDAR "Pressione qualquer tecla para escolher o modelo"
goto PASSO_2

:PASSO_3
cls
call :CABECALHO 3 "Risco de brick do SEU modelo - leia antes de continuar"
if "%MODELO%"=="" (echo   Voce ainda nao informou o modelo. Voltando ao passo 2... & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_2)
echo   O que e brick: o console para de ligar porque a area de boot (IPL, dentro da NAND) ficou invalida.
echo   So a etapa PERMANENTE (cIPL, passo 19) mexe nessa area. A etapa temporaria NAO tem esse risco.
echo.
echo   RECUPERACAO POR "BATERIA PANDORA" (hardware, sem abrir o console):
echo     - PSP-1000                          : recuperavel. A Pandora funciona.
echo     - PSP-2000 com placa TA-085 ou antes : recuperavel.
echo     - PSP-2000 TA-088v3, 3000, Go, E1000: NAO recuperavel por Pandora. Um brick nesses
echo       modelos exige solda/programador externo - na pratica, console perdido.
echo.
if "%MODELO%"=="1000" echo   SEU CASO ^(PSP-1000^): risco BAIXO e com rede de seguranca ^(Pandora^).
if "%MODELO%"=="2000" echo   SEU CASO ^(PSP-2000^): risco BAIXO; so e recuperavel se a placa for TA-085 ou anterior.
if "%MODELO%"=="3000" echo   SEU CASO ^(PSP-3000^): risco BAIXO, mas SEM rede de seguranca. Siga o passo 5 a risca.
if "%MODELO%"=="GO" echo   SEU CASO ^(PSP Go^): risco BAIXO, mas SEM rede de seguranca. Siga o passo 5 a risca.
if "%MODELO%"=="E1000" echo   SEU CASO ^(PSP Street^): risco BAIXO, mas SEM rede de seguranca. Siga o passo 5 a risca.
echo.
echo   COMO O RISCO VIRA QUASE ZERO (as tres regras de ouro):
echo     1. Bateria com carga alta E carregador ligado na tomada durante a gravacao.
echo     2. Nao apertar nada, nao desligar, nao tirar a bateria enquanto estiver gravando.
echo     3. So gravar depois que a CFW temporaria ja funcionou (passos 16 e 17).
echo.
echo   Voce PODE parar na CFW temporaria e nunca fazer o cIPL. Funciona igual; so exige rodar
echo   o ARK Loader cada vez que ligar o console. O passo 18 pergunta isso.
echo.
call :PERGUNTA "   Voce entendeu o risco e quer seguir?"
if errorlevel 2 goto MENU
call :FIM_PASSO 3
goto %DESTINO%

:PASSO_4
cls
call :CABECALHO 4 "Ver a versao do firmware no console (acao fisica)"
echo   ACAO FISICA no PSP:
echo     1. Ligue o console (interruptor POWER para cima no 1000/2000/3000; botao na frente no E1000;
echo        no Go, deslize a tela para cima ou use o botao POWER na lateral).
echo     2. No menu XMB, va com o analogico/direcional ate a coluna "Configuracoes" (o icone de chave).
echo     3. Desca ate "Configuracoes do Sistema" e aperte X.
echo     4. Desca ate "Informacoes do Sistema" e aperte X.
echo     5. Leia a linha "Software do sistema". Vai aparecer algo como "6.61" ou "6.60" ou "6.20".
echo.
echo   ANOTE esse numero. Ele decide o proximo caminho:
echo     - 6.61 : perfeito, e o alvo. Pule o passo 11.
echo     - 6.60 : tambem serve para o cIPL, mas o recomendado e subir para 6.61 no passo 11.
echo     - menor que 6.60 : voce vai atualizar no passo 11 (e seguro e oficial).
echo     - ja aparece "ARK", "PRO", "ME", "LME" ou "Infinity" : o console JA tem CFW. Veja abaixo.
echo.
set "FW="
set /p "FW=   Digite a versao que apareceu (ex.: 6.61) ou ENTER para continuar sem anotar: "
if not "%FW%"=="" call :ANOTAR "Firmware informado: %FW%"
echo.
echo   Se apareceu PRO / ME / LME / Infinity (CFW antiga):
echo     - Antes do cIPL e obrigatorio instalar o DC-ARK, que remove o Infinity antigo.
echo     - Rode o DC-ARK (vem no mesmo pacote do ARK-4) e so depois siga para o passo 19.
echo     - Isso esta detalhado na opcao [5] do menu (erros comuns).
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Bateria, carregador e cartao de memoria (acao fisica)"
echo   1. BATERIA: coloque para carregar ate o LED laranja apagar (carga cheia).
if "%MODELO%"=="GO" echo      No PSP Go a bateria e interna: deixe no carregador ate o LED apagar.
if not "%MODELO%"=="GO" echo      ACAO: confirme que a bateria esta ENCAIXADA e a tampa fechada. Nunca grave com a tampa aberta.
echo      Bateria "inchada" (tampa estufando) deve ser trocada ANTES de qualquer coisa.
echo   2. CARREGADOR: mantenha o carregador ligado na tomada e no console durante todo o processo.
echo   3. CARTAO DE MEMORIA:
if "%MODELO%"=="GO" echo      - PSP Go: usa memoria interna de 16 GB ^(raiz ef0:^) e, opcionalmente, um cartao M2 ^(Memory Stick Micro^).
if not "%MODELO%"=="GO" echo      - Este modelo usa Memory Stick PRO Duo. Um adaptador "microSD para Memory Stick Duo" com
if not "%MODELO%"=="GO" echo        microSD de 32 GB Classe 10 funciona bem e e mais barato que o cartao original.
echo      - O cartao precisa estar em FAT32. O passo 9 confere isso.
echo      - Espaco livre: 100 MB ja bastam para a CFW; separe mais para jogos.
echo.
if not "%MODELO%"=="GO" echo   ACAO FISICA - onde fica o slot do cartao:
if "%MODELO%"=="1000" echo      PSP-1000: na lateral ESQUERDA, atras de uma portinha de plastico. Empurre o cartao ate ouvir o clique.
if "%MODELO%"=="2000" echo      PSP-2000/3000: na lateral ESQUERDA, atras de uma tampinha, acima do botao de volume.
if "%MODELO%"=="3000" echo      PSP-2000/3000: na lateral ESQUERDA, atras de uma tampinha, acima do botao de volume.
if "%MODELO%"=="E1000" echo      PSP Street: na lateral ESQUERDA, atras de uma tampinha.
echo.
echo   Para tirar o cartao: empurre-o levemente para DENTRO; ele destrava e salta (slot com mola).
echo   NUNCA puxe o cartao a forca e nunca tire com o console gravando.
echo.
call :PERGUNTA "   Bateria cheia, carregador ligado e cartao no lugar?"
if errorlevel 2 (echo   Resolva isso primeiro - e a principal causa de brick. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_5)
call :FIM_PASSO 5
goto %DESTINO%

:PASSO_6
cls
call :CABECALHO 6 "Conectar o PSP ao PC em modo USB (acao fisica)"
echo   ACAO FISICA:
echo     1. Ligue o console.
echo     2. Pegue um cabo USB de DADOS.
if "%MODELO%"=="GO" echo        PSP Go: o conector e o proprietario multiuso ^(o mesmo do carregador^), nao e mini-USB.
if not "%MODELO%"=="GO" echo        PSP-1000/2000/3000/E1000: o conector do console e MINI-USB ^(tipo B^), na parte de CIMA,
if not "%MODELO%"=="GO" echo        ao lado do botao de WLAN. Nao confunda com micro-USB: mini-USB e maior e trapezoidal.
echo     3. Encaixe a ponta pequena no PSP e a ponta grande em uma porta USB do PC.
echo     4. No XMB do PSP, va em "Configuracoes" e desca ate "Conexao USB". Aperte X.
echo        A tela do PSP vai mostrar "Conexao USB" e o PC vai montar o cartao como uma unidade.
echo.
echo   Dica: se o cartao nem aparecer no PC, o cabo pode ser "so carga". Troque o cabo antes de
echo   mexer em driver: no PSP em modo USB nao existe driver especial a instalar no Windows 10/11.
echo.
call :AGUARDAR "Pressione qualquer tecla quando a unidade do PSP aparecer no PC"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "Detectar a unidade do cartao no PC"
echo   Com o PSP em modo USB, o cartao aparece no PC como um pen drive.
echo   Vou tentar descobrir a letra automaticamente procurando a pasta PSP na raiz das unidades.
echo.
call :DETECTAR_PSP
if not "%SDL%"=="" goto PASSO_7_OK
echo   Nao achei automaticamente. Abra "Este Computador" e veja a letra da unidade removivel.
echo   Em um cartao novo pode nao existir pasta nenhuma ainda - isso e normal, o passo 10 cria.
echo.
call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_7

:PASSO_7_OK
echo.
echo   Unidade do PSP: %SDL%:
call :ANOTAR "Unidade do cartao: %SDL%:"
call :FIM_PASSO 7
goto %DESTINO%

:PASSO_8
cls
call :CABECALHO 8 "Backup completo do cartao (automatico, nao altera nada)"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_8
set "BKP=%USERPROFILE%\Desktop\Backup_PSP_%DATE:/=-%"
set "BKP=%BKP: =_%"
echo   Vou copiar TUDO de %SDL%:\ para:
echo      %BKP%
echo   robocopy so LE o cartao; nada e apagado nem modificado nele.
echo.
call :PERGUNTA "   Iniciar a copia agora?"
if errorlevel 2 goto PASSO_8_MANUAL
robocopy %SDL%:\ "%BKP%" /E /R:2 /W:2 /NP /NFL /NDL /XJ
if errorlevel 8 goto PASSO_8_FALHA
echo.
echo   Backup concluido em: %BKP%
echo   Guarde essa pasta: com ela voce devolve o cartao ao estado exato de hoje.
call :ANOTAR "Backup do cartao em: %BKP%"
call :FIM_PASSO 8
goto %DESTINO%

:PASSO_8_MANUAL
echo.
echo   Manual: abra %SDL%:\ , selecione tudo (Ctrl+A), copie (Ctrl+C) e cole numa pasta nova no PC.
call :AGUARDAR "Pressione qualquer tecla quando o backup manual terminar"
call :FIM_PASSO 8
goto %DESTINO%

:PASSO_8_FALHA
echo.
echo   robocopy falhou (codigo %ERRORLEVEL%). Causas em ordem de probabilidade:
echo     1. Cabo ruim ou porta USB instavel  -^> troque de cabo e de porta (evite hub).
echo     2. Cartao com setores ruins         -^> rode  chkdsk %SDL%: /f  num Prompt como administrador.
echo     3. Letra errada                     -^> confira em "Este Computador".
call :AGUARDAR "Pressione qualquer tecla para repetir o passo"
goto PASSO_8

:PASSO_9
cls
call :CABECALHO 9 "Conferir FAT32 e espaco livre"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_9
echo   Verificando a unidade %SDL%: ...
echo.
set "FS="
set "LIVRE="
set "TAM="
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "try{$v=Get-Volume -DriveLetter '%SDL%' -ErrorAction Stop; '{0};{1};{2}' -f $v.FileSystemType,[math]::Round($v.SizeRemaining/1GB,2),[math]::Round($v.Size/1GB,2)}catch{'?;?;?'}"`) do set "INFO=%%A"
for /f "tokens=1-3 delims=;" %%A in ("%INFO%") do (set "FS=%%A" & set "LIVRE=%%B" & set "TAM=%%C")
echo     Sistema de arquivos : %FS%
echo     Tamanho total       : %TAM% GB
echo     Espaco livre        : %LIVRE% GB
echo.
echo   Requisitos do PSP:
echo     - FAT32 obrigatorio. exFAT e NTFS NAO funcionam (cartoes acima de 32 GB vem em exFAT de fabrica).
echo     - Espaco livre: 100 MB bastam para a CFW. Jogos de UMD ocupam de 300 MB a 1,8 GB cada.
echo.
if /i "%FS%"=="FAT32" echo   OK: ja esta em FAT32. Nada a fazer.
if /i not "%FS%"=="FAT32" echo   ATENCAO: nao esta em FAT32. Veja abaixo como resolver.
if /i not "%FS%"=="FAT32" echo     - Formatar APAGA o cartao. Voce ja fez o backup no passo 8, entao da para formatar com seguranca.
if /i not "%FS%"=="FAT32" echo     - Jeito melhor: formate pelo PROPRIO PSP ^(Configuracoes -^> Configuracoes do Sistema -^>
if /i not "%FS%"=="FAT32" echo       Formatar Memory Stick^). O console formata do jeito certo sozinho.
if /i not "%FS%"=="FAT32" echo     - Pelo PC, ate 32 GB:  format %SDL%: /FS:FAT32 /Q     ^(num Prompt como administrador^)
if /i not "%FS%"=="FAT32" echo     - Acima de 32 GB o Windows nao oferece FAT32 na janela de formatacao; use o comando acima
if /i not "%FS%"=="FAT32" echo       ou o proprio PSP. Depois devolva os arquivos do backup.
echo.
call :ANOTAR "Cartao: FS=%FS% total=%TAM%GB livre=%LIVRE%GB"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 9
goto %DESTINO%

:PASSO_10
cls
call :CABECALHO 10 "Criar a estrutura de pastas no cartao"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_10
echo   O PSP procura cada tipo de arquivo numa pasta fixa. Esta e a estrutura correta:
echo.
echo     %SDL%:\
echo       ISO\                 jogos de UMD em .iso ou .cso
echo       PSP\
echo         GAME\              homebrew, emuladores e jogos de PS1 em EBOOT.PBP
echo         SAVEDATA\          saves dos jogos (e a pasta ARK_01234 da CFW)
echo         CHEATS\            arquivos de cheat do plugin CheatMaster
echo         SYSTEM\            configuracao do sistema (criada pelo console)
echo       MUSIC\               musicas em MP3
echo       PICTURE\             fotos em JPG/PNG
echo       VIDEO\               videos em MP4
echo       SEPLUGINS\           plugins (padrao antigo; o ARK usa PSP\PLUGINS)
echo.
call :PERGUNTA "   Criar essas pastas agora em %SDL%:\ ?"
if errorlevel 2 (call :FIM_PASSO 10 & goto %DESTINO%)
for %%D in ("ISO" "PSP" "PSP\GAME" "PSP\SAVEDATA" "PSP\CHEATS" "MUSIC" "PICTURE" "VIDEO" "SEPLUGINS") do (
  if not exist "%SDL%:\%%~D\" md "%SDL%:\%%~D" 2>nul
)
echo.
echo   Resultado:
for %%D in ("ISO" "PSP\GAME" "PSP\SAVEDATA" "MUSIC" "PICTURE" "VIDEO") do (
  if exist "%SDL%:\%%~D\" echo     OK      %%~D
  if not exist "%SDL%:\%%~D\" echo     FALHOU  %%~D
)
echo.
echo   Se algo falhou, o cartao pode estar protegido contra gravacao ou cheio.
call :ANOTAR "Estrutura de pastas criada em %SDL%:"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 10
goto %DESTINO%

:PASSO_11
cls
call :CABECALHO 11 "Atualizar para o firmware oficial 6.61 (so se estiver abaixo disso)"
echo   Se o passo 4 ja mostrou 6.61, PULE este passo (aperte M e escolha o passo 12).
echo.
echo   Por que 6.61: e o ultimo firmware oficial da Sony (janeiro/2015) e e o que o ARK-4 e o cIPL
echo   esperam encontrar. O 6.60 tambem serve, mas o 6.61 e o alvo recomendado.
echo.
echo   ONDE BAIXAR: o arquivo e o atualizador oficial da Sony, um EBOOT.PBP de cerca de 30 MB.
echo   A Sony encerrou as paginas de download do PSP; hoje o arquivo e obtido em acervos de
echo   preservacao. Confira sempre o tamanho e, se o acervo publicar, o hash do arquivo.
echo   A opcao [7] do menu abre os links que este guia usa.
echo.
echo   COMO INSTALAR:
echo     1. No PC, crie a pasta:  %SDL%:\PSP\GAME\UPDATE\
echo     2. Coloque o atualizador dentro dela com o nome EXATO: EBOOT.PBP
echo        Caminho final:  %SDL%:\PSP\GAME\UPDATE\EBOOT.PBP
echo     3. Ejete o cartao no PC e saia do modo USB no PSP (aperte O).
echo     4. ACAO FISICA: confirme bateria cheia E carregador na tomada. Isto e obrigatorio aqui:
echo        desligar o console durante a atualizacao oficial BRICKA o PSP.
echo     5. No XMB: coluna "Jogo" -^> "Memory Stick" -^> aparece "Atualizacao de Versao X.XX" -^> X.
echo     6. Leia e aceite os termos. A barra vai ate 100%%. O console reinicia sozinho.
echo     7. Ao voltar, confira em Informacoes do Sistema: deve mostrar 6.61.
echo.
call :PERGUNTA "   Quer que eu crie agora a pasta PSP\GAME\UPDATE no cartao?"
if errorlevel 2 goto PASSO_11_FIM
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_11_FIM
if not exist "%SDL%:\PSP\GAME\UPDATE\" md "%SDL%:\PSP\GAME\UPDATE" 2>nul
if exist "%SDL%:\PSP\GAME\UPDATE\" echo   Pasta criada: %SDL%:\PSP\GAME\UPDATE\
if exist "%SDL%:\PSP\GAME\UPDATE\EBOOT.PBP" echo   Ja existe um EBOOT.PBP nela ^(OK^).
if not exist "%SDL%:\PSP\GAME\UPDATE\EBOOT.PBP" echo   Falta copiar o EBOOT.PBP para dentro dela.
if exist "%SDL%:\PSP\GAME\UPDATE\" start "" "%SDL%:\PSP\GAME\UPDATE"

:PASSO_11_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver em 6.61 (ou se voce pulou este passo)"
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Baixar a CFW no PC: ARK-4 (recomendado) ou ARK-5"
echo   METODO RECOMENDADO: ARK-4 v4.20.69 r206 - ultima versao estavel, de maio/2026.
echo     Por que: e a versao mais testada e a que toda a documentacao atual descreve. O repositorio
echo     foi arquivado em agosto/2026, ou seja, nao muda mais: o que funciona hoje continua igual.
echo     Baixe o arquivo ARK4.zip na pagina de releases:
echo       https://github.com/PSP-Archive/ARK-4/releases
echo.
echo   ALTERNATIVA: ARK-5 - sucessor, em desenvolvimento ativo.
echo     Ganhos: SDK novo, overclock embutido, gerenciamento de plugins melhor.
echo     Contra: os lancamentos sao marcados como pre-release (rolling), entao pode mudar de
echo     comportamento entre versoes. Bom para quem topa atualizar e testar.
echo       https://github.com/PSP-Arkfive/ARK-5
echo       https://github.com/PSP-Arkfive/FasterARK
echo.
echo   O QUE VEM DENTRO DO ARK4.zip (o que importa para nos):
echo     ARK_01234    -^> vai para  PSP\SAVEDATA\      (o nucleo da CFW)
echo     ARK_Loader   -^> vai para  PSP\GAME\          (o atalho que liga a CFW temporaria)
echo     ARK_cIPL     -^> vai para  PSP\GAME\          (o gravador da CFW permanente)
echo     DC-ARK       -^> vai para  PSP\GAME\          (so se o console ja tiver Infinity antigo)
echo.
echo   Extraia com 7-Zip, PeaZip ou o proprio Windows. Nao renomeie as pastas.
echo.
call :PERGUNTA "   Quer que eu abra a pagina de releases do ARK-4 no navegador?"
if errorlevel 2 goto PASSO_12_FIM
start "" "https://github.com/PSP-Archive/ARK-4/releases"

:PASSO_12_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando o ARK4.zip estiver baixado e extraido"
call :FIM_PASSO 12
goto %DESTINO%

:PASSO_13
cls
call :CABECALHO 13 "Copiar o ARK-4 para o cartao"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_13
echo   Agora vamos colocar as tres pastas nos lugares certos.
echo   Destinos (no cartao %SDL%:):
echo     %SDL%:\PSP\SAVEDATA\ARK_01234
echo     %SDL%:\PSP\GAME\ARK_Loader
echo     %SDL%:\PSP\GAME\ARK_cIPL
echo.
echo   Voce pode fazer isso arrastando no Explorer, ou me dizer onde extraiu o ZIP que eu copio.
echo.
set "ORIG="
set /p "ORIG=   Cole o caminho da pasta extraida do ARK4.zip (ou ENTER para copiar a mao): "
if "%ORIG%"=="" goto PASSO_13_MANUAL
if not exist "%ORIG%\" (echo   Caminho nao encontrado. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_13)
set "SRC=%ORIG%"
if exist "%ORIG%\PSP\ARK_01234\" set "SRC=%ORIG%\PSP"
echo.
echo   Origem usada: %SRC%
if not exist "%SRC%\ARK_01234\" (echo   Nao achei ARK_01234 dentro dela. Confira se extraiu o ZIP inteiro. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_13)
if not exist "%SDL%:\PSP\SAVEDATA\" md "%SDL%:\PSP\SAVEDATA" 2>nul
if not exist "%SDL%:\PSP\GAME\" md "%SDL%:\PSP\GAME" 2>nul
echo   Copiando ARK_01234 ...
robocopy "%SRC%\ARK_01234" "%SDL%:\PSP\SAVEDATA\ARK_01234" /E /R:2 /W:2 /NP /NFL /NDL
if exist "%SRC%\ARK_Loader\" (echo   Copiando ARK_Loader ... & robocopy "%SRC%\ARK_Loader" "%SDL%:\PSP\GAME\ARK_Loader" /E /R:2 /W:2 /NP /NFL /NDL)
if exist "%SRC%\ARK_cIPL\" (echo   Copiando ARK_cIPL ... & robocopy "%SRC%\ARK_cIPL" "%SDL%:\PSP\GAME\ARK_cIPL" /E /R:2 /W:2 /NP /NFL /NDL)
if exist "%SRC%\DC-ARK\" (echo   Copiando DC-ARK ... & robocopy "%SRC%\DC-ARK" "%SDL%:\PSP\GAME\DC-ARK" /E /R:2 /W:2 /NP /NFL /NDL)
echo.
echo   Copia terminada. O passo 14 confere.
call :ANOTAR "ARK copiado de %SRC% para %SDL%:"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 13
goto %DESTINO%

:PASSO_13_MANUAL
echo.
echo   A mao, no Explorer:
echo     1. Abra a pasta extraida do ARK4.zip. Se existir uma pasta "PSP" dentro dela, entre nela.
echo     2. Arraste ARK_01234  para  %SDL%:\PSP\SAVEDATA\
echo     3. Arraste ARK_Loader para  %SDL%:\PSP\GAME\
echo     4. Arraste ARK_cIPL   para  %SDL%:\PSP\GAME\
echo   Vou abrir as duas pastas de destino para facilitar.
if exist "%SDL%:\PSP\SAVEDATA\" start "" "%SDL%:\PSP\SAVEDATA"
if exist "%SDL%:\PSP\GAME\" start "" "%SDL%:\PSP\GAME"
call :AGUARDAR "Pressione qualquer tecla quando tiver copiado as tres pastas"
call :FIM_PASSO 13
goto %DESTINO%

:PASSO_14
cls
call :CABECALHO 14 "Conferir se os arquivos chegaram no lugar certo"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_14
echo   Conferindo em %SDL%: ...
echo.
set "FALTA=0"
if exist "%SDL%:\PSP\SAVEDATA\ARK_01234\" (echo     OK      PSP\SAVEDATA\ARK_01234) else (echo     FALTA   PSP\SAVEDATA\ARK_01234 & set "FALTA=1")
if exist "%SDL%:\PSP\GAME\ARK_Loader\" (echo     OK      PSP\GAME\ARK_Loader) else (echo     FALTA   PSP\GAME\ARK_Loader & set "FALTA=1")
if exist "%SDL%:\PSP\GAME\ARK_cIPL\" (echo     OK      PSP\GAME\ARK_cIPL) else (echo     AVISO   PSP\GAME\ARK_cIPL ^(so e necessario no passo 19^))
if exist "%SDL%:\PSP\GAME\ARK_Loader\EBOOT.PBP" (echo     OK      ARK_Loader\EBOOT.PBP) else (echo     FALTA   ARK_Loader\EBOOT.PBP & set "FALTA=1")
echo.
if "%FALTA%"=="1" echo   Esta faltando coisa. Volte ao passo 13 ^(aperte R^) e confira se extraiu o ZIP inteiro.
if "%FALTA%"=="0" echo   Tudo no lugar. Pode seguir.
echo.
echo   Erro classico: criar PSP\GAME\ARK_Loader\ARK_Loader (pasta dentro de pasta do mesmo nome).
echo   O EBOOT.PBP tem que estar DIRETO dentro de ARK_Loader.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 14
goto %DESTINO%

:PASSO_15
cls
call :CABECALHO 15 "Ejetar com seguranca e sair do modo USB (acao fisica)"
echo   1. No PC: clique no icone "Remover hardware com seguranca" (bandeja, perto do relogio)
echo      e escolha ejetar a unidade %SDL%:. Espere a mensagem de que e seguro remover.
echo      Isso garante que a copia foi realmente gravada no cartao, e nao so no cache do Windows.
echo   2. ACAO FISICA no PSP: aperte o botao O (circulo) para sair da tela "Conexao USB".
echo   3. Desconecte o cabo USB do console.
echo   4. Deixe o carregador ligado.
echo.
echo   Se o Windows recusar a ejecao, feche as janelas do Explorer que estao abertas no cartao
echo   e tente de novo. Nao arranque o cabo com gravacao em andamento.
echo.
call :AGUARDAR "Pressione qualquer tecla quando tiver ejetado e saido do modo USB"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "Rodar o ARK Loader no PSP - CFW temporaria (acao fisica)"
echo   Esta e a hora da verdade, e e a parte SEM RISCO: nada e gravado na NAND.
echo.
echo   ACAO FISICA no PSP:
echo     1. Com o console ligado e fora do modo USB, va no XMB ate a coluna "Jogo".
echo     2. Desca ate "Memory Stick" e aperte X.
if "%MODELO%"=="GO" echo        No PSP Go, se voce usou a memoria interna, o item aparece como "Memoria interna".
echo     3. Na lista deve aparecer o item "ARK Loader" (icone do ARK). Selecione e aperte X.
echo     4. A tela vai ficar preta por 1 a 3 segundos e o console REINICIA sozinho, voltando ao XMB.
echo        Esse reinicio rapido e o esperado: significa que a CFW subiu.
echo.
echo   SE "ARK Loader" NAO APARECER NA LISTA:
echo     - Confira o caminho: PSP\GAME\ARK_Loader\EBOOT.PBP (passo 14).
echo     - Se apareceu "Dados corrompidos", o arquivo nao terminou de copiar ou o cartao nao foi
echo       ejetado com seguranca. Copie de novo (passo 13) e ejete direito (passo 15).
echo     - Confira que o firmware e 6.60 ou 6.61 (passo 4).
echo.
echo   SE A TELA FICAR PRETA E NAO VOLTAR:
echo     - Segure POWER por 10 segundos para desligar a forca e ligue de novo. Nada foi gravado;
echo       o console volta normal no firmware oficial.
echo.
call :AGUARDAR "Pressione qualquer tecla depois que o console reiniciar e voltar ao XMB"
call :FIM_PASSO 16
goto %DESTINO%

:PASSO_17
cls
call :CABECALHO 17 "Confirmar que a CFW temporaria esta ativa"
echo   ACAO FISICA no PSP:
echo     1. XMB -^> "Configuracoes" -^> "Configuracoes do Sistema" -^> "Informacoes do Sistema".
echo     2. Olhe a linha "Software do sistema".
echo.
echo   RESULTADO ESPERADO: aparece algo como
echo.
echo        Software do sistema:  6.61 ARK-4 Live
echo.
echo   Se aparecer "ARK-4 Live" (ou "ARK-4"), a CFW temporaria ESTA funcionando. 
echo   Se aparecer so "6.61" sem mencao ao ARK, a CFW nao subiu: volte ao passo 16.
echo.
echo   TESTE RAPIDO (opcional, mas recomendado):
echo     - Aperte SELECT no XMB: deve abrir o menu VSH do ARK (menu de configuracoes da CFW).
echo       Se o menu abrir, esta tudo certo. Aperte SELECT de novo para fechar.
echo.
echo   IMPORTANTE: nesta fase, ao DESLIGAR o console a CFW sai. Para voltar, roda o ARK Loader
echo   outra vez. Isso e normal e e exatamente o que o cIPL do passo 19 resolve.
echo.
call :PERGUNTA "   Apareceu ARK-4 nas Informacoes do Sistema?"
if errorlevel 2 (echo   Entao a CFW nao subiu. Volte ao passo 16 e siga as dicas de erro. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_16)
call :ANOTAR "CFW temporaria confirmada (ARK-4 Live)"
call :FIM_PASSO 17
goto %DESTINO%

:PASSO_18
cls
call :CABECALHO 18 "Decidir: ficar na temporaria ou instalar o cIPL permanente"
echo   Agora voce escolhe. As duas opcoes sao validas.
echo.
echo   OPCAO A - FICAR NA TEMPORARIA (ARK Loader)
echo     + Risco zero: nada e gravado na NAND, brick impossivel por software.
echo     + Reverter e desligar o console.
echo     - Toda vez que ligar, precisa entrar em Jogo -^> Memory Stick -^> ARK Loader.
echo     - Alguns jogos e homebrew que reiniciam o console fazem a CFW cair.
echo.
echo   OPCAO B - cIPL PERMANENTE (recomendado depois que a temporaria ja funcionou)
echo     + Liga ja com CFW, sem passo extra. Comporta-se como firmware do console.
echo     + Funciona em todos os modelos: 1000, 2000, 3000, Go e Street.
echo     + Removivel por software (opcao 6 do menu deste guia).
echo     - Grava na area de boot da NAND. Se faltar energia no meio, pode brickar.
if "%MODELO%"=="3000" echo     - No seu PSP-3000 um brick NAO e recuperavel por bateria Pandora.
if "%MODELO%"=="GO" echo     - No seu PSP Go um brick NAO e recuperavel por bateria Pandora.
if "%MODELO%"=="E1000" echo     - No seu PSP Street um brick NAO e recuperavel por bateria Pandora.
if "%MODELO%"=="1000" echo     - No seu PSP-1000 um brick e recuperavel com bateria Pandora.
if "%MODELO%"=="2000" echo     - No seu PSP-2000 um brick e recuperavel com Pandora se a placa for TA-085 ou anterior.
echo.
echo   CHECKLIST OBRIGATORIO ANTES DA OPCAO B:
echo     [ ] A CFW temporaria ja funcionou (passo 17 confirmado).
echo     [ ] Bateria com carga alta E encaixada.
echo     [ ] Carregador ligado na tomada e no console.
echo     [ ] Voce nao vai apertar nada durante a gravacao (leva poucos segundos).
echo.
choice /c AB /n /m "   [A] Ficar na temporaria e ir para as configuracoes    [B] Instalar o cIPL agora : "
if errorlevel 2 (call :FIM_PASSO 18 19 & goto %DESTINO%)
echo.
echo   Escolha registrada: ficar na CFW temporaria. Vou pular para o passo 21 (configuracao).
echo   Voce pode voltar e fazer o cIPL depois: menu -^> [3] -^> passo 19.
call :ANOTAR "Usuario optou por ficar na CFW temporaria"
call :FIM_PASSO 18 21
goto %DESTINO%

:PASSO_19
cls
call :CABECALHO 19 "Instalar o cIPL - CFW permanente (acao fisica, ponto de atencao)"
echo   LEIA ANTES DE APERTAR QUALQUER COISA:
echo     - Isto grava na NAND. Sao poucos segundos, mas NAO interrompa.
echo     - Requisitos: firmware 6.60 ou 6.61 e a CFW temporaria ativa AGORA (passo 17).
echo     - Se este console ja teve Infinity instalado antes, rode PRIMEIRO o DC-ARK e so depois o cIPL.
echo.
echo   ACAO FISICA no PSP:
echo     1. Confirme na tela que a CFW esta ativa (SELECT abre o menu VSH).
echo     2. Confirme que o carregador esta na tomada e o cabo no console.
echo     3. XMB -^> "Jogo" -^> "Memory Stick" -^> selecione "ARK cIPL Flasher" -^> X.
if "%MODELO%"=="GO" echo        No PSP Go o item vem da memoria interna ^(ef0:^) se voce copiou para la.
echo     4. Leia o aviso na tela e aperte o botao de CONFIRMAR indicado (normalmente X).
echo     5. Espere a mensagem de sucesso. NAO aperte nada, NAO desligue, NAO tire o cabo.
echo     6. Quando pedir, reinicie o console (ou desligue e ligue normalmente).
echo.
echo   O QUE VOCE DEVE VER: uma tela de texto simples com o resultado da gravacao e a instrucao
echo   para reiniciar. Se aparecer erro, ANOTE a mensagem e veja a opcao [5] do menu.
echo.
call :PERGUNTA "   Carregador na tomada, bateria encaixada e CFW temporaria ativa?"
if errorlevel 2 (echo   Resolva isso antes. Este e o unico passo com risco real. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_19)
echo.
call :AGUARDAR "Pressione qualquer tecla DEPOIS que o console reiniciar"
call :ANOTAR "cIPL: usuario informou que a gravacao terminou"
call :FIM_PASSO 19
goto %DESTINO%

:PASSO_20
cls
call :CABECALHO 20 "Confirmar a CFW permanente"
echo   ACAO FISICA no PSP (com o console recem-reiniciado, SEM rodar o ARK Loader):
echo     1. XMB -^> "Configuracoes" -^> "Configuracoes do Sistema" -^> "Informacoes do Sistema".
echo     2. Olhe a linha "Software do sistema".
echo.
echo   RESULTADO ESPERADO:
echo.
echo        Software do sistema:  ARK 4.20.XX cIPL
echo.
echo   Se aparecer "cIPL", pronto: o console liga com CFW para sempre, sem passo extra.
echo   Se aparecer so "6.61", a gravacao nao pegou. O console continua funcionando normalmente;
echo   voce pode usar a CFW temporaria e tentar o cIPL de novo depois (passo 19).
echo.
call :PERGUNTA "   Apareceu cIPL na linha do software do sistema?"
if errorlevel 2 goto PASSO_20_FALHOU
echo.
echo   TESTE FINAL: desligue o console por completo, ligue de novo e confira que continua com CFW.
call :ANOTAR "cIPL confirmado nas Informacoes do Sistema"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 20
goto %DESTINO%

:PASSO_20_FALHOU
echo.
echo   Nao pegou. Causas em ordem de probabilidade:
echo     1. A CFW temporaria nao estava ativa no momento da gravacao -^> refaca 16, 17 e 19 na ordem.
echo     2. Firmware diferente de 6.60/6.61 -^> confira no passo 4 e atualize no passo 11.
echo     3. Infinity antigo no console -^> rode o DC-ARK e depois o cIPL.
echo     4. Cartao com problema -^> refaca a copia (passo 13) e ejete com seguranca (passo 15).
echo   Nada disso brickou o console: voce continua podendo usar a CFW temporaria.
call :AGUARDAR "Pressione qualquer tecla para voltar ao passo 19"
goto PASSO_19

:PASSO_21
cls
call :CABECALHO 21 "Configurar o ARK: menu VSH (SELECT), clock e plugins"
echo   O menu de configuracao da CFW abre apertando SELECT dentro do XMB (ou dentro de um jogo).
echo.
echo   AJUSTES QUE VALEM A PENA:
echo     - CPU Clock (XMB): deixe em padrao. Clock alto no XMB so gasta bateria.
echo     - CPU Clock (jogo): 333/166 MHz ajuda em jogos que engasgam (God of War, GTA, Tekken).
echo       Custo: mais consumo de bateria e mais calor. Se travar, volte para o padrao.
echo     - UMD ISO Mode: deixe em "Inferno" (driver padrao do ARK, melhor compatibilidade).
echo     - Region Free: util para UMD-Video de outra regiao.
echo     - Plugins: ficam em PSP\PLUGINS e sao ligados/desligados nesse mesmo menu.
echo       Regra pratica: so um plugin novo por vez. Se o console travar ao ligar, foi o ultimo.
echo.
echo   SE UM PLUGIN QUEBRAR O CONSOLE (trava no XMB):
echo     - Desligue, coloque o cartao no PC e renomeie a pasta do plugin (ex.: PLUGINS para PLUGINS_off).
echo     - O console volta a ligar normal.
echo.
echo   RECOVERY MENU: com a CFW ativa, desligue e ligue segurando R. Abre um menu de emergencia
echo   onde da para desativar todos os plugins e reverter configuracoes.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 21
goto %DESTINO%

:PASSO_22
cls
call :CABECALHO 22 "Colocar jogos, homebrew e jogos de PS1"
if "%SDL%"=="" call :PEDIR_UNIDADE
echo   ONDE CADA COISA VAI (no cartao):
echo.
echo     Jogos de UMD (backup dos SEUS discos)   -^>  %SDL%:\ISO\      arquivos .iso ou .cso
echo     Homebrew e emuladores                    -^>  %SDL%:\PSP\GAME\  uma pasta por programa
echo     Jogos de PS1 (EBOOT.PBP)                 -^>  %SDL%:\PSP\GAME\  uma pasta por jogo
echo     Cheats                                   -^>  %SDL%:\PSP\CHEATS\
echo.
echo   COMO FAZER O DUMP DOS SEUS UMDs (legal e sem PC):
echo     1. Coloque o UMD no console.
echo     2. Abra o menu VSH (SELECT) e procure a opcao de dump de UMD do ARK, ou use o homebrew
echo        "UMD Dumper" colocado em PSP\GAME.
echo     3. O arquivo .iso sai direto na pasta ISO do cartao.
echo     4. .cso e o mesmo jogo comprimido: ocupa menos espaco, carrega igual. Da para converter
echo        no PC com o UMDGen ou com o CISO.
echo.
echo   EMULADORES QUE VALEM NO PSP (todos homebrew livre, cada um em PSP\GAME):
echo     - SNES9x TYL / Snes9x Euphoria  : Super Nintendo
echo     - PicoDrive                     : Mega Drive / Master System / Game Gear
echo     - gpSP / TempGBA                : Game Boy Advance
echo     - NesterJ                       : NES
echo     - MAME4ALL / FBA               : arcade
echo     - RetroArch PSP                : varios nucleos em um so (mais pesado)
echo.
echo   Regra de ouro: baixe homebrew so do GitHub oficial do projeto ou de acervos conhecidos.
echo   Arquivo de homebrew nao precisa de instalador; e so copiar a pasta.
echo.
call :PERGUNTA "   Quer que eu abra a pasta ISO do cartao para voce jogar os arquivos la?"
if errorlevel 2 goto PASSO_22_FIM
if not "%SDL%"=="" if not exist "%SDL%:\ISO\" md "%SDL%:\ISO" 2>nul
if not "%SDL%"=="" if exist "%SDL%:\ISO\" start "" "%SDL%:\ISO"

:PASSO_22_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 22
goto %DESTINO%

:PASSO_23
cls
call :CABECALHO 23 "Backup dos saves e do cartao (rotina que salva sua vida)"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_23
echo   Os saves do PSP ficam em PSP\SAVEDATA, uma pasta por jogo. Se o cartao corromper, eles vao junto.
echo   Recomendacao: copie PSP\SAVEDATA para o PC de vez em quando (leva segundos).
echo.
set "SVB=%USERPROFILE%\Desktop\Saves_PSP_%DATE:/=-%"
set "SVB=%SVB: =_%"
echo   Destino: %SVB%
echo.
call :PERGUNTA "   Copiar os saves agora?"
if errorlevel 2 goto PASSO_23_FIM
if not exist "%SDL%:\PSP\SAVEDATA\" (echo   Nao achei %SDL%:\PSP\SAVEDATA - o cartao esta conectado e em modo USB? & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_23)
robocopy "%SDL%:\PSP\SAVEDATA" "%SVB%" /E /R:2 /W:2 /NP /NFL /NDL
if errorlevel 8 (echo   Falha na copia. Confira o cabo e a letra da unidade. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_23)
echo.
echo   Saves copiados para: %SVB%
call :ANOTAR "Saves copiados para %SVB%"

:PASSO_23_FIM
echo.
echo   Dica: a pasta ARK_01234 tambem vive em PSP\SAVEDATA. Ao restaurar saves, nao sobrescreva
echo   ARK_01234 com uma versao antiga - copie de volta so as pastas dos jogos.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 23
goto %DESTINO%

:PASSO_24
cls
call :CABECALHO 24 "Verificacao final e boas praticas"
echo   CHECKLIST FINAL - marque mentalmente cada item:
echo     [ ] Informacoes do Sistema mostra ARK (Live ou cIPL).
echo     [ ] O console desliga e liga mantendo a CFW (se voce fez o cIPL).
echo     [ ] Um homebrew abre a partir de Jogo -^> Memory Stick.
echo     [ ] Um jogo em ISO/CSO abre a partir da pasta ISO.
echo     [ ] Backup do cartao e dos saves guardado no PC.
echo.
echo   BOAS PRATICAS PARA NAO QUEBRAR NADA:
echo     1. Nunca instale "atualizacao de firmware oficial" depois do cIPL sem ler antes: o 6.61
echo        ja e o ultimo, entao qualquer "update" que aparecer de fonte estranha e suspeito.
echo     2. Um plugin novo por vez. Se travar, Recovery Menu (ligar segurando R) e desative tudo.
echo     3. Nao tire o cartao com o console ligado.
echo     4. Evite formatar o cartao pelo PC quando der problema: formate pelo proprio PSP.
echo     5. Bateria inchada: troque. E risco de fogo e de empenar a carcaca.
echo     6. Guarde uma copia do ARK4.zip usado. O repositorio foi arquivado; ter o arquivo
echo        local evita depender de link no futuro.
echo.
echo   ONDE PEDIR AJUDA: wiki oficial do ARK-4 no GitHub (PSP-Archive/ARK-4) e a pagina de releases.
echo   A opcao [7] do menu abre esses links.
echo.
call :ANOTAR "Guia concluido"
call :AGUARDAR "Pressione qualquer tecla para ver a tela de conclusao"
call :FIM_PASSO 24
goto %DESTINO%

rem ============================================================================
rem  TELAS AUXILIARES
rem ============================================================================

:CONCLUIDO
cls
echo.
echo  ==========================================================================================
echo   CONCLUIDO  -  seu PSP esta com Custom Firmware
echo  ==========================================================================================
echo.
echo   O que voce tem agora:
echo     - CFW ARK-4 ativa (temporaria via ARK Loader ou permanente via cIPL).
echo     - Homebrew, emuladores, ISO/CSO, PS1, plugins e temas liberados.
echo     - Backup do cartao e dos saves guardados no PC.
echo.
echo   Guarde estes arquivos, na mesma pasta deste guia:
echo     %PROG%   (progresso)
echo     %REG%   (registro do que foi feito)
echo.
echo   Proximos passos sugeridos:
echo     1. Fazer o dump dos seus UMDs para a pasta ISO (passo 22).
echo     2. Instalar 2 ou 3 emuladores e testar um jogo em cada.
echo     3. Se ainda esta na CFW temporaria e quer permanente, volte ao passo 19.
echo.
choice /c MS /n /m "   [M] Voltar ao menu    [S] Sair : "
if errorlevel 2 goto SAIR
goto MENU

:REQUISITOS
cls
echo.
echo   REQUISITOS E DOWNLOADS
echo   ----------------------
echo   NO CONSOLE:
echo     - PSP-1000, 2000, 3000, Go (N1000) ou Street (E1000).
echo     - Firmware oficial 6.60 ou 6.61 (o alvo e 6.61, ultimo oficial da Sony, de jan/2015).
echo     - Bateria que segura carga + carregador original ou equivalente.
echo     - Memory Stick PRO Duo (ou microSD com adaptador) em FAT32. No Go, a memoria interna serve.
echo.
echo   NO PC:
echo     - Windows 10 ou 11, uma porta USB e um cabo USB de DADOS.
echo       PSP-1000/2000/3000/E1000: mini-USB tipo B.  PSP Go: conector multiuso proprietario.
echo     - 7-Zip, PeaZip ou o extrator do Windows.
echo     - Nenhum driver especial: o PSP em modo USB monta como pen drive.
echo.
echo   DOWNLOADS:
echo     ARK-4 (recomendado, v4.20.69 r206, ultima estavel):
echo       https://github.com/PSP-Archive/ARK-4/releases
echo     Wiki oficial do ARK-4 (instalacao, cIPL, Full Flash):
echo       https://github.com/PSP-Archive/ARK-4/wiki
echo     ARK-5 (sucessor, em desenvolvimento ativo, releases pre-release):
echo       https://github.com/PSP-Arkfive/ARK-5
echo       https://github.com/PSP-Arkfive/FasterARK
echo.
echo   SOBRE O FIRMWARE 6.61: a Sony encerrou as paginas de download do PSP. O atualizador oficial
echo   (EBOOT.PBP, cerca de 30 MB) hoje e obtido em acervos de preservacao. Confira o tamanho e o
echo   hash quando o acervo publicar. Este guia nao hospeda nem indica copia de jogos.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:ERROS
cls
echo.
echo   ERROS COMUNS E COMO CORRIGIR
echo   ----------------------------
echo   1. "ARK Loader" nao aparece em Jogo -^> Memory Stick
echo      causa: caminho errado, copia incompleta ou cartao fora de FAT32.
echo      correcao: confira PSP\GAME\ARK_Loader\EBOOT.PBP (passo 14); refaca a copia; ejete direito.
echo.
echo   2. "Dados corrompidos" no icone
echo      causa: arquivo truncado (cabo ruim, cartao retirado sem ejetar) ou EBOOT incompativel.
echo      correcao: apague a pasta, copie de novo do ZIP e ejete com seguranca antes de tirar o cabo.
echo.
echo   3. Tela preta ao abrir o ARK Loader
echo      causa: firmware fora de 6.60/6.61, ou pasta ARK_01234 ausente.
echo      correcao: confira o firmware (passo 4) e a pasta PSP\SAVEDATA\ARK_01234 (passo 14).
echo      Segure POWER 10 s para desligar. Nada foi gravado.
echo.
echo   4. O cIPL nao pega (Informacoes do Sistema nao mostra cIPL)
echo      causa: CFW temporaria nao estava ativa na hora, ou Infinity antigo no console.
echo      correcao: rode o ARK Loader, confirme "ARK-4 Live", e so entao o cIPL. Se ja teve Infinity,
echo      rode o DC-ARK primeiro.
echo.
echo   5. Console ja tinha PRO / ME / LME / Infinity
echo      correcao: instale o DC-ARK (vem no pacote do ARK-4) para limpar o Infinity e depois o cIPL.
echo.
echo   6. Trava no XMB depois de instalar plugin
echo      correcao: ligue segurando R para abrir o Recovery Menu e desative todos os plugins.
echo      Ou coloque o cartao no PC e renomeie a pasta PSP\PLUGINS.
echo.
echo   7. O PC nao ve o cartao no modo USB
echo      causa mais comum: cabo "so carga". Troque o cabo. Depois teste outra porta USB (sem hub).
echo.
echo   8. Cartao acima de 32 GB que o Windows nao formata em FAT32
echo      correcao: num Prompt como administrador rode  format X: /FS:FAT32 /Q  onde X e a letra do
echo      cartao. Ou, mais simples, formate pelo proprio PSP.
echo.
echo   9. Console nao liga depois do cIPL (brick)
echo      PSP-1000 ou 2000 TA-085 ou anterior: recuperavel com bateria Pandora + Magic Memory Stick.
echo      PSP-2000 TA-088v3, 3000, Go, E1000: nao ha recuperacao por Pandora.
echo      Em qualquer caso: NAO insista ligando varias vezes; procure ajuda na comunidade antes.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DESFAZER
cls
echo.
echo   COMO DESFAZER (voltar ao firmware oficial)
echo   ------------------------------------------
echo   CASO 1 - voce so usou a CFW TEMPORARIA (ARK Loader)
echo     Nada a desfazer: desligue o console. Se quiser limpar o cartao, apague as pastas
echo     PSP\GAME\ARK_Loader, PSP\GAME\ARK_cIPL e PSP\SAVEDATA\ARK_01234.
echo.
echo   CASO 2 - voce instalou o cIPL (permanente)
echo     1. Ligue o console (ele sobe com CFW).
echo     2. Rode o DC-ARK, que esta em PSP\GAME\DC-ARK (vem no pacote do ARK-4).
echo        Ele remove o cIPL e devolve o boot original.
echo     3. Reinicie e confira em Informacoes do Sistema: deve mostrar apenas 6.61.
echo     4. Depois disso, apague as pastas do ARK do cartao, se quiser.
echo.
echo   CASO 3 - restaurar o cartao exatamente como estava
echo     Copie de volta o conteudo da pasta de backup criada no passo 8.
echo.
echo   OBSERVACOES HONESTAS:
echo     - Remover o cIPL nao "zera" o console como sair de fabrica; ele volta a bootar o firmware
echo       oficial, que e o que importa para levar em assistencia ou vender.
echo     - Se quiser zerar configuracoes e saves: Configuracoes -^> Configuracoes do Sistema -^>
echo       Restaurar Configuracoes Padrao (isso nao remove CFW).
echo     - Formatar o Memory Stick nao remove o cIPL: o cIPL esta na NAND, nao no cartao.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   ABRIR LINKS OFICIAIS
echo   --------------------
echo   [1] ARK-4 - pagina de releases (baixar ARK4.zip)
echo   [2] ARK-4 - wiki (instalacao, cIPL, Full Flash)
echo   [3] ARK-5 - repositorio do sucessor
echo   [4] FasterARK - downloads do ARK-5
echo   [0] Voltar
echo.
choice /c 12340 /n /m "   Escolha: "
if errorlevel 5 goto MENU
if errorlevel 4 (start "" "https://github.com/PSP-Arkfive/FasterARK" & goto LINKS)
if errorlevel 3 (start "" "https://github.com/PSP-Arkfive/ARK-5" & goto LINKS)
if errorlevel 2 (start "" "https://github.com/PSP-Archive/ARK-4/wiki" & goto LINKS)
start "" "https://github.com/PSP-Archive/ARK-4/releases"
goto LINKS

:FERRAMENTAS
cls
echo.
echo   FERRAMENTAS DE PC
echo   -----------------
echo   [1] Detectar a unidade do PSP automaticamente
echo   [2] Informacoes do cartao (FAT32, tamanho, espaco livre)
echo   [3] Backup completo do cartao
echo   [4] Criar a estrutura de pastas
echo   [5] Conferir se o ARK esta no lugar certo
echo   [6] Copiar apenas os saves (PSP\SAVEDATA) para o PC
echo   [7] Abrir o cartao no Explorer
echo   [8] Ver o registro (log) deste guia
echo   [0] Voltar
echo.
choice /c 123456780 /n /m "   Escolha: "
if errorlevel 9 goto %VOLTAR%
if errorlevel 8 goto FER_LOG
if errorlevel 7 goto FER_ABRIR
if errorlevel 6 goto PASSO_23
if errorlevel 5 goto PASSO_14
if errorlevel 4 goto PASSO_10
if errorlevel 3 goto PASSO_8
if errorlevel 2 goto PASSO_9
call :DETECTAR_PSP
if "%SDL%"=="" echo   Nao encontrei automaticamente. Use a opcao 7 para olhar no Explorer.
if not "%SDL%"=="" echo   Encontrado: %SDL%:
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FER_ABRIR
if "%SDL%"=="" call :PEDIR_UNIDADE
if not "%SDL%"=="" start "" "%SDL%:\"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FER_LOG
cls
echo.
echo   REGISTRO DESTE GUIA (%REG%)
echo   ------------------------------------------------------------------------------------------
if exist "%REG%" type "%REG%"
if not exist "%REG%" echo   Ainda nao ha registro.
echo   ------------------------------------------------------------------------------------------
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:SEM_ACENTOS
cls
echo.
echo   MODO SEM ACENTOS
echo   Gera uma copia deste guia so com caracteres ASCII (sem acentos; setas viram -^>) e abre a copia.
if "%ASCII%"=="1" (echo   Esta ja e a versao sem acentos. & call :AGUARDAR "Pressione qualquer tecla" & goto MENU)
set "SA_SRC=%~f0"
set "SA_DST=%~dpn0_sem_acentos.bat"
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand %PSB64%
if not exist "%SA_DST%" (echo   Falha ao gerar a copia. & call :AGUARDAR "Pressione qualquer tecla" & goto MENU)
echo   Gerado: %SA_DST%
echo   Abrindo a versao sem acentos e fechando esta...
start "" cmd /c "%SA_DST%"
goto SAIR

:APAGAR_PROGRESSO
if exist "%PROG%" del /q "%PROG%"
set "PASSO=0"
echo   Progresso apagado.
call :AGUARDAR "Pressione qualquer tecla"
goto MENU

:SAIR
endlocal
exit /b 0

rem ============================================================================
rem  SUB-ROTINAS
rem ============================================================================

:CABECALHO
echo.
echo  ==========================================================================================
echo   PASSO %~1 de %TOTAL%  -  %~2
echo  ==========================================================================================
echo.
exit /b

:AGUARDAR
echo.
echo   ^>^> %~1 ...
pause >nul
exit /b

:PERGUNTA
echo.
choice /c SN /n /m "%~1  [S] Sim   [N] Nao : "
if errorlevel 2 exit /b 2
exit /b 1

:ANOTAR
>>"%REG%" echo [%DATE% %TIME%] %~1
exit /b

:PEDIR_UNIDADE
set "SDL="
set /p "SDL=   Digite a LETRA da unidade do PSP (ex.: E) ou ENTER para cancelar: "
if "%SDL%"=="" exit /b
set "SDL=%SDL:~0,1%"
if not exist %SDL%:\ (echo   Unidade %SDL%: nao encontrada. & set "SDL=" & exit /b)
if /i "%SDL%"=="C" (echo   C: e o disco do Windows, nao o PSP! & set "SDL=" & exit /b)
echo   Unidade selecionada: %SDL%:
exit /b

:DETECTAR_PSP
set "SDL="
for %%L in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if not defined SDL if exist "%%L:\PSP\" set "SDL=%%L"
)
if not defined SDL for %%L in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if not defined SDL if exist "%%L:\ISO\" set "SDL=%%L"
)
exit /b

:FIM_PASSO
set "PASSO=%~1"
set "PROXIMO=%~2"
if "%PROXIMO%"=="" set /a PROXIMO=%PASSO%+1
call :SALVAR
echo.
echo  ------------------------------------------------------------------------------------------
echo   Passo %PASSO% de %TOTAL% registrado. Progresso salvo em: %PROG%
choice /c SRME /n /m "   [S] Proximo passo    [R] Repetir este passo    [M] Menu    [E] Erros e correcoes : "
if errorlevel 4 (set "VOLTAR=PASSO_%PASSO%" & set "DESTINO=ERROS" & exit /b)
if errorlevel 3 (set "DESTINO=MENU" & exit /b)
if errorlevel 2 (set "DESTINO=PASSO_%PASSO%" & exit /b)
set "DESTINO=PASSO_%PROXIMO%"
if %PROXIMO% GTR %TOTAL% set "DESTINO=CONCLUIDO"
exit /b

:SALVAR
>"%PROG%" echo PASSO=%PASSO%
>>"%PROG%" echo MODELO=%MODELO%
>>"%PROG%" echo SDL=%SDL%
exit /b

:CARREGAR
if not exist "%PROG%" exit /b
for /f "usebackq tokens=1,* delims==" %%A in ("%PROG%") do set "%%A=%%B"
if "%MODELO%"=="GO" set "RAIZ=ef0"
if not "%MODELO%"=="GO" set "RAIZ=ms0"
exit /b
