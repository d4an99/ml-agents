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
set "ASCII=0"
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
echo   A CFW de referência hoje é a ARK-4; ela roda por cima do firmware oficial 6.61 da Sony.
echo.
echo   Existem DOIS níveis, e este guia faz os dois na ordem certa:
echo     1. TEMPORÁRIA (ARK Loader) - risco zero, sai ao desligar. Serve para testar tudo antes.
echo     2. PERMANENTE (cIPL)       - grava na NAND, liga já com CFW. Risco baixo, mas real.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: você parou no passo %PASSO% de %TOTAL%.
if not "%PASSO%"=="0" echo.
echo   [1] Começar do início (passo 1)
echo   [2] Continuar de onde parei
echo   [3] Ir para um passo específico
echo   [4] Requisitos e downloads
echo   [5] Erros comuns e como corrigir
echo   [6] Como desfazer (voltar ao firmware oficial)
echo   [7] Abrir links oficiais no navegador
echo   [8] Ferramentas de PC (detectar cartão, backup, pastas, conferir arquivos)
echo   [9] Apagar o progresso salvo
echo   [A] Modo sem acentos (use se o texto aparecer com caracteres estranhos)
echo   [0] Sair
echo.
choice /c 1234567890A /n /m "   Escolha uma opção: "
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
echo    1  O que é e o que não é este desbloqueio     13  Copiar o ARK-4 para o cartão (PC)
echo    2  Virar o PSP e identificar o modelo         14  Conferir se os arquivos chegaram (PC)
echo    3  Risco de brick do SEU modelo               15  Ejetar com segurança e sair do modo USB
echo    4  Ver a versão do firmware no console        16  Rodar o ARK Loader no PSP (temporária)
echo    5  Bateria, carregador e cartão de memória    17  Confirmar "ARK-4 Live" nas Informações
echo    6  Conectar o PSP ao PC em modo USB           18  Decidir: ficar temporária ou ir de cIPL
echo    7  Detectar a unidade do cartão (PC)          19  Instalar o cIPL (CFW permanente)
echo    8  Backup completo do cartão (PC)             20  Confirmar "ARK 4.20.XX cIPL"
echo    9  Conferir FAT32 e espaço livre (PC)         21  Configurar o ARK (menu VSH / SELECT)
echo   10  Criar a estrutura de pastas (PC)           22  Colocar jogos, homebrew e PS1
echo   11  Atualizar para o firmware oficial 6.61     23  Backup dos saves e do cartão
echo   12  Baixar o ARK-4 (ou ARK-5) no PC            24  Verificação final e boas práticas
echo.
set "N="
set /p "N=   Digite o número do passo (1-%TOTAL%) ou ENTER para voltar: "
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
call :CABECALHO 1 "O que é (e o que não é) este desbloqueio"
echo   O QUE VOCÊ VAI CONSEGUIR:
echo     - Rodar homebrew: emuladores (SNES, Mega Drive, GBA, Master System, MAME), players, utilitários.
echo     - Rodar backups dos SEUS jogos de UMD em ISO/CSO direto do cartão, sem o disco.
echo     - Rodar jogos de PS1 convertidos em EBOOT.PBP.
echo     - Plugins (cheats, filtros de tela, adhoc online), temas, overclock da CPU.
echo     - Tirar o UMD da jogada: menos consumo de bateria e menos desgaste do leitor.
echo.
echo   O QUE ESTE GUIA NÃO FAZ:
echo     - Não ensina a baixar jogos. Faça o dump dos SEUS UMDs (o próprio ARK tem dumper de UMD).
echo     - Não conserta PSP com defeito de hardware (tela, analógico, leitor, dock do Go).
echo     - Não "destrava" região: o PSP já é livre de região para jogos.
echo.
echo   COMO FUNCIONA (resumo honesto):
echo     - O firmware oficial (OFW) mais recente e último da Sony é o 6.61, de janeiro de 2015.
echo     - A CFW ARK-4 roda POR CIMA do 6.61. Última versão estável: v4.20.69 r206 (maio/2026).
echo     - O projeto ARK-4 foi encerrado e arquivado em agosto/2026; o sucessor é o ARK-5,
echo       em desenvolvimento ativo, mas com lançamentos marcados como pré-release.
echo     - Por isso o MÉTODO RECOMENDADO aqui é ARK-4 v4.20.69 r206 + cIPL: é o mais testado.
echo       Quem quiser o mais novo pode usar o ARK-5 - o passo 12 mostra as duas opções.
echo.
echo   REVERSIBILIDADE:
echo     - A etapa temporária não grava nada: basta desligar o console.
echo     - O cIPL grava na NAND, mas é removível por software (opção 6 do menu).
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 1
goto %DESTINO%

:PASSO_2
cls
call :CABECALHO 2 "VIRE O PSP: identificar o modelo exato (ação física)"
echo   AÇÃO FÍSICA: pegue o console e VIRE-O de costas, com a tela para baixo.
echo   Na traseira, perto do meio ou embaixo, existe uma etiqueta impressa com o número do modelo.
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
echo   No PSP Go a etiqueta fica atrás, perto da trava da tampa deslizante.
echo   Se a etiqueta estiver apagada, dá para identificar pelo formato:
echo     - PSP-1000 "Fat"    : mais grosso e pesado; tampa da bateria removível por trava.
echo     - PSP-2000 "Slim"   : bem mais fino que o 1000; saída de vídeo por cabo componente.
echo     - PSP-3000          : igual ao 2000 por fora, mas a tela tem um padrão de linhas visível de perto.
echo     - PSP Go (N1000)    : pequeno, tela deslizante, SEM leitor de UMD, 16 GB internos.
echo     - PSP Street (E1000): fosco, SEM Wi-Fi, SEM alto-falantes estéreo, botão liga na frente.
echo.
echo   Escolha o seu modelo:
echo     [1] PSP-1000 (Fat)          [2] PSP-2000 (Slim)        [3] PSP-3000
echo     [4] PSP Go (N1000)          [5] PSP Street (E1000)     [6] Não consegui identificar
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
echo     1. Tem leitor de UMD (a tampa redonda que abre atrás)? NÃO = PSP Go.
echo     2. Tem Wi-Fi? Olhe se existe o interruptor/antena e se aparece "Configurações de rede"
echo        nas Configurações. Sem Wi-Fi = PSP Street (E1000).
echo     3. É grosso, com a bateria saindo por uma tampa grande com trava? = PSP-1000.
echo     4. É fino e a tela tem um leve padrão de linhas quando você olha de perto? = PSP-3000.
echo        Fino e sem esse padrão = PSP-2000.
echo   Não importa tanto para a instalação: o ARK-4 e o cIPL funcionam nos cinco modelos.
echo   O que muda é o risco de recuperação em caso de brick, explicado no passo 3.
echo.
call :AGUARDAR "Pressione qualquer tecla para escolher o modelo"
goto PASSO_2

:PASSO_3
cls
call :CABECALHO 3 "Risco de brick do SEU modelo - leia antes de continuar"
if "%MODELO%"=="" (echo   Você ainda não informou o modelo. Voltando ao passo 2... & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_2)
echo   O que é brick: o console para de ligar porque a área de boot (IPL, dentro da NAND) ficou inválida.
echo   Só a etapa PERMANENTE (cIPL, passo 19) mexe nessa área. A etapa temporária NÃO tem esse risco.
echo.
echo   RECUPERAÇÃO POR "BATERIA PANDORA" (hardware, sem abrir o console):
echo     - PSP-1000                          : recuperável. A Pandora funciona.
echo     - PSP-2000 com placa TA-085 ou antes : recuperável.
echo     - PSP-2000 TA-088v3, 3000, Go, E1000: NÃO recuperável por Pandora. Um brick nesses
echo       modelos exige solda/programador externo - na prática, console perdido.
echo.
if "%MODELO%"=="1000" echo   SEU CASO ^(PSP-1000^): risco BAIXO e com rede de segurança ^(Pandora^).
if "%MODELO%"=="2000" echo   SEU CASO ^(PSP-2000^): risco BAIXO; só é recuperável se a placa for TA-085 ou anterior.
if "%MODELO%"=="3000" echo   SEU CASO ^(PSP-3000^): risco BAIXO, mas SEM rede de segurança. Siga o passo 5 à risca.
if "%MODELO%"=="GO" echo   SEU CASO ^(PSP Go^): risco BAIXO, mas SEM rede de segurança. Siga o passo 5 à risca.
if "%MODELO%"=="E1000" echo   SEU CASO ^(PSP Street^): risco BAIXO, mas SEM rede de segurança. Siga o passo 5 à risca.
echo.
echo   COMO O RISCO VIRA QUASE ZERO (as três regras de ouro):
echo     1. Bateria com carga alta E carregador ligado na tomada durante a gravação.
echo     2. Não apertar nada, não desligar, não tirar a bateria enquanto estiver gravando.
echo     3. Só gravar depois que a CFW temporária já funcionou (passos 16 e 17).
echo.
echo   Você PODE parar na CFW temporária e nunca fazer o cIPL. Funciona igual; só exige rodar
echo   o ARK Loader cada vez que ligar o console. O passo 18 pergunta isso.
echo.
call :PERGUNTA "   Você entendeu o risco e quer seguir?"
if errorlevel 2 goto MENU
call :FIM_PASSO 3
goto %DESTINO%

:PASSO_4
cls
call :CABECALHO 4 "Ver a versão do firmware no console (ação física)"
echo   AÇÃO FÍSICA no PSP:
echo     1. Ligue o console (interruptor POWER para cima no 1000/2000/3000; botão na frente no E1000;
echo        no Go, deslize a tela para cima ou use o botão POWER na lateral).
echo     2. No menu XMB, vá com o analógico/direcional até a coluna "Configurações" (o ícone de chave).
echo     3. Desça até "Configurações do Sistema" e aperte X.
echo     4. Desça até "Informações do Sistema" e aperte X.
echo     5. Leia a linha "Software do sistema". Vai aparecer algo como "6.61" ou "6.60" ou "6.20".
echo.
echo   ANOTE esse número. Ele decide o próximo caminho:
echo     - 6.61 : perfeito, é o alvo. Pule o passo 11.
echo     - 6.60 : também serve para o cIPL, mas o recomendado é subir para 6.61 no passo 11.
echo     - menor que 6.60 : você vai atualizar no passo 11 (é seguro e oficial).
echo     - já aparece "ARK", "PRO", "ME", "LME" ou "Infinity" : o console JÁ tem CFW. Veja abaixo.
echo.
set "FW="
set /p "FW=   Digite a versão que apareceu (ex.: 6.61) ou ENTER para continuar sem anotar: "
if not "%FW%"=="" call :ANOTAR "Firmware informado: %FW%"
echo.
echo   Se apareceu PRO / ME / LME / Infinity (CFW antiga):
echo     - Antes do cIPL é obrigatório instalar o DC-ARK, que remove o Infinity antigo.
echo     - Rode o DC-ARK (vem no mesmo pacote do ARK-4) e só depois siga para o passo 19.
echo     - Isso está detalhado na opção [5] do menu (erros comuns).
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Bateria, carregador e cartão de memória (ação física)"
echo   1. BATERIA: coloque para carregar até o LED laranja apagar (carga cheia).
if "%MODELO%"=="GO" echo      No PSP Go a bateria é interna: deixe no carregador até o LED apagar.
if not "%MODELO%"=="GO" echo      AÇÃO: confirme que a bateria está ENCAIXADA e a tampa fechada. Nunca grave com a tampa aberta.
echo      Bateria "inchada" (tampa estufando) deve ser trocada ANTES de qualquer coisa.
echo   2. CARREGADOR: mantenha o carregador ligado na tomada e no console durante todo o processo.
echo   3. CARTÃO DE MEMÓRIA:
if "%MODELO%"=="GO" echo      - PSP Go: usa memória interna de 16 GB ^(raiz ef0:^) e, opcionalmente, um cartão M2 ^(Memory Stick Micro^).
if not "%MODELO%"=="GO" echo      - Este modelo usa Memory Stick PRO Duo. Um adaptador "microSD para Memory Stick Duo" com
if not "%MODELO%"=="GO" echo        microSD de 32 GB Classe 10 funciona bem e é mais barato que o cartão original.
echo      - O cartão precisa estar em FAT32. O passo 9 confere isso.
echo      - Espaço livre: 100 MB já bastam para a CFW; separe mais para jogos.
echo.
if not "%MODELO%"=="GO" echo   AÇÃO FÍSICA - onde fica o slot do cartão:
if "%MODELO%"=="1000" echo      PSP-1000: na lateral ESQUERDA, atrás de uma portinha de plástico. Empurre o cartão até ouvir o clique.
if "%MODELO%"=="2000" echo      PSP-2000/3000: na lateral ESQUERDA, atrás de uma tampinha, acima do botão de volume.
if "%MODELO%"=="3000" echo      PSP-2000/3000: na lateral ESQUERDA, atrás de uma tampinha, acima do botão de volume.
if "%MODELO%"=="E1000" echo      PSP Street: na lateral ESQUERDA, atrás de uma tampinha.
echo.
echo   Para tirar o cartão: empurre-o levemente para DENTRO; ele destrava e salta (slot com mola).
echo   NUNCA puxe o cartão à força e nunca tire com o console gravando.
echo.
call :PERGUNTA "   Bateria cheia, carregador ligado e cartão no lugar?"
if errorlevel 2 (echo   Resolva isso primeiro - é a principal causa de brick. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_5)
call :FIM_PASSO 5
goto %DESTINO%

:PASSO_6
cls
call :CABECALHO 6 "Conectar o PSP ao PC em modo USB (ação física)"
echo   AÇÃO FÍSICA:
echo     1. Ligue o console.
echo     2. Pegue um cabo USB de DADOS.
if "%MODELO%"=="GO" echo        PSP Go: o conector é o proprietário multiuso ^(o mesmo do carregador^), não é mini-USB.
if not "%MODELO%"=="GO" echo        PSP-1000/2000/3000/E1000: o conector do console é MINI-USB ^(tipo B^), na parte de CIMA,
if not "%MODELO%"=="GO" echo        ao lado do botão de WLAN. Não confunda com micro-USB: mini-USB é maior e trapezoidal.
echo     3. Encaixe a ponta pequena no PSP e a ponta grande em uma porta USB do PC.
echo     4. No XMB do PSP, vá em "Configurações" e desça até "Conexão USB". Aperte X.
echo        A tela do PSP vai mostrar "Conexão USB" e o PC vai montar o cartão como uma unidade.
echo.
echo   Dica: se o cartão nem aparecer no PC, o cabo pode ser "só carga". Troque o cabo antes de
echo   mexer em driver: no PSP em modo USB não existe driver especial a instalar no Windows 10/11.
echo.
call :AGUARDAR "Pressione qualquer tecla quando a unidade do PSP aparecer no PC"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "Detectar a unidade do cartão no PC"
echo   Com o PSP em modo USB, o cartão aparece no PC como um pen drive.
echo   Vou tentar descobrir a letra automaticamente procurando a pasta PSP na raiz das unidades.
echo.
call :DETECTAR_PSP
if not "%SDL%"=="" goto PASSO_7_OK
echo   Não achei automaticamente. Abra "Este Computador" e veja a letra da unidade removível.
echo   Em um cartão novo pode não existir pasta nenhuma ainda - isso é normal, o passo 10 cria.
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
call :CABECALHO 8 "Backup completo do cartão (automático, não altera nada)"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_8
set "BKP=%USERPROFILE%\Desktop\Backup_PSP_%DATE:/=-%"
set "BKP=%BKP: =_%"
echo   Vou copiar TUDO de %SDL%:\ para:
echo      %BKP%
echo   robocopy só LÊ o cartão; nada é apagado nem modificado nele.
echo.
call :PERGUNTA "   Iniciar a cópia agora?"
if errorlevel 2 goto PASSO_8_MANUAL
robocopy %SDL%:\ "%BKP%" /E /R:2 /W:2 /NP /NFL /NDL /XJ
if errorlevel 8 goto PASSO_8_FALHA
echo.
echo   Backup concluído em: %BKP%
echo   Guarde essa pasta: com ela você devolve o cartão ao estado exato de hoje.
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
echo   robocopy falhou (código %ERRORLEVEL%). Causas em ordem de probabilidade:
echo     1. Cabo ruim ou porta USB instável  -^> troque de cabo e de porta (evite hub).
echo     2. Cartão com setores ruins         -^> rode  chkdsk %SDL%: /f  num Prompt como administrador.
echo     3. Letra errada                     -^> confira em "Este Computador".
call :AGUARDAR "Pressione qualquer tecla para repetir o passo"
goto PASSO_8

:PASSO_9
cls
call :CABECALHO 9 "Conferir FAT32 e espaço livre"
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
echo     Espaço livre        : %LIVRE% GB
echo.
echo   Requisitos do PSP:
echo     - FAT32 obrigatório. exFAT e NTFS NÃO funcionam (cartões acima de 32 GB vêm em exFAT de fábrica).
echo     - Espaço livre: 100 MB bastam para a CFW. Jogos de UMD ocupam de 300 MB a 1,8 GB cada.
echo.
if /i "%FS%"=="FAT32" echo   OK: já está em FAT32. Nada a fazer.
if /i not "%FS%"=="FAT32" echo   ATENÇÃO: não está em FAT32. Veja abaixo como resolver.
if /i not "%FS%"=="FAT32" echo     - Formatar APAGA o cartão. Você já fez o backup no passo 8, então dá para formatar com segurança.
if /i not "%FS%"=="FAT32" echo     - Jeito melhor: formate pelo PRÓPRIO PSP ^(Configurações -^> Configurações do Sistema -^>
if /i not "%FS%"=="FAT32" echo       Formatar Memory Stick^). O console formata do jeito certo sozinho.
if /i not "%FS%"=="FAT32" echo     - Pelo PC, até 32 GB:  format %SDL%: /FS:FAT32 /Q     ^(num Prompt como administrador^)
if /i not "%FS%"=="FAT32" echo     - Acima de 32 GB o Windows não oferece FAT32 na janela de formatação; use o comando acima
if /i not "%FS%"=="FAT32" echo       ou o próprio PSP. Depois devolva os arquivos do backup.
echo.
call :ANOTAR "Cartao: FS=%FS% total=%TAM%GB livre=%LIVRE%GB"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 9
goto %DESTINO%

:PASSO_10
cls
call :CABECALHO 10 "Criar a estrutura de pastas no cartão"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_10
echo   O PSP procura cada tipo de arquivo numa pasta fixa. Esta é a estrutura correta:
echo.
echo     %SDL%:\
echo       ISO\                 jogos de UMD em .iso ou .cso
echo       PSP\
echo         GAME\              homebrew, emuladores e jogos de PS1 em EBOOT.PBP
echo         SAVEDATA\          saves dos jogos (e a pasta ARK_01234 da CFW)
echo         CHEATS\            arquivos de cheat do plugin CheatMaster
echo         SYSTEM\            configuração do sistema (criada pelo console)
echo       MUSIC\               músicas em MP3
echo       PICTURE\             fotos em JPG/PNG
echo       VIDEO\               vídeos em MP4
echo       SEPLUGINS\           plugins (padrão antigo; o ARK usa PSP\PLUGINS)
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
echo   Se algo falhou, o cartão pode estar protegido contra gravação ou cheio.
call :ANOTAR "Estrutura de pastas criada em %SDL%:"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 10
goto %DESTINO%

:PASSO_11
cls
call :CABECALHO 11 "Atualizar para o firmware oficial 6.61 (só se estiver abaixo disso)"
echo   Se o passo 4 já mostrou 6.61, PULE este passo (aperte M e escolha o passo 12).
echo.
echo   Por que 6.61: é o último firmware oficial da Sony (janeiro/2015) e é o que o ARK-4 e o cIPL
echo   esperam encontrar. O 6.60 também serve, mas o 6.61 é o alvo recomendado.
echo.
echo   ONDE BAIXAR: o arquivo é o atualizador oficial da Sony, um EBOOT.PBP de cerca de 30 MB.
echo   A Sony encerrou as páginas de download do PSP; hoje o arquivo é obtido em acervos de
echo   preservação. Confira sempre o tamanho e, se o acervo publicar, o hash do arquivo.
echo   A opção [7] do menu abre os links que este guia usa.
echo.
echo   COMO INSTALAR:
echo     1. No PC, crie a pasta:  %SDL%:\PSP\GAME\UPDATE\
echo     2. Coloque o atualizador dentro dela com o nome EXATO: EBOOT.PBP
echo        Caminho final:  %SDL%:\PSP\GAME\UPDATE\EBOOT.PBP
echo     3. Ejete o cartão no PC e saia do modo USB no PSP (aperte O).
echo     4. AÇÃO FÍSICA: confirme bateria cheia E carregador na tomada. Isto é obrigatório aqui:
echo        desligar o console durante a atualização oficial BRICKA o PSP.
echo     5. No XMB: coluna "Jogo" -^> "Memory Stick" -^> aparece "Atualização de Versão X.XX" -^> X.
echo     6. Leia e aceite os termos. A barra vai até 100%%. O console reinicia sozinho.
echo     7. Ao voltar, confira em Informações do Sistema: deve mostrar 6.61.
echo.
call :PERGUNTA "   Quer que eu crie agora a pasta PSP\GAME\UPDATE no cartão?"
if errorlevel 2 goto PASSO_11_FIM
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_11_FIM
if not exist "%SDL%:\PSP\GAME\UPDATE\" md "%SDL%:\PSP\GAME\UPDATE" 2>nul
if exist "%SDL%:\PSP\GAME\UPDATE\" echo   Pasta criada: %SDL%:\PSP\GAME\UPDATE\
if exist "%SDL%:\PSP\GAME\UPDATE\EBOOT.PBP" echo   Já existe um EBOOT.PBP nela ^(OK^).
if not exist "%SDL%:\PSP\GAME\UPDATE\EBOOT.PBP" echo   Falta copiar o EBOOT.PBP para dentro dela.
if exist "%SDL%:\PSP\GAME\UPDATE\" start "" "%SDL%:\PSP\GAME\UPDATE"

:PASSO_11_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver em 6.61 (ou se você pulou este passo)"
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Baixar a CFW no PC: ARK-4 (recomendado) ou ARK-5"
echo   MÉTODO RECOMENDADO: ARK-4 v4.20.69 r206 - última versão estável, de maio/2026.
echo     Por que: é a versão mais testada e a que toda a documentação atual descreve. O repositório
echo     foi arquivado em agosto/2026, ou seja, não muda mais: o que funciona hoje continua igual.
echo     Baixe o arquivo ARK4.zip na página de releases:
echo       https://github.com/PSP-Archive/ARK-4/releases
echo.
echo   ALTERNATIVA: ARK-5 - sucessor, em desenvolvimento ativo.
echo     Ganhos: SDK novo, overclock embutido, gerenciamento de plugins melhor.
echo     Contra: os lançamentos são marcados como pré-release (rolling), então pode mudar de
echo     comportamento entre versões. Bom para quem topa atualizar e testar.
echo       https://github.com/PSP-Arkfive/ARK-5
echo       https://github.com/PSP-Arkfive/FasterARK
echo.
echo   O QUE VEM DENTRO DO ARK4.zip (o que importa para nós):
echo     ARK_01234    -^> vai para  PSP\SAVEDATA\      (o núcleo da CFW)
echo     ARK_Loader   -^> vai para  PSP\GAME\          (o atalho que liga a CFW temporária)
echo     ARK_cIPL     -^> vai para  PSP\GAME\          (o gravador da CFW permanente)
echo     DC-ARK       -^> vai para  PSP\GAME\          (só se o console já tiver Infinity antigo)
echo.
echo   Extraia com 7-Zip, PeaZip ou o próprio Windows. Não renomeie as pastas.
echo.
call :PERGUNTA "   Quer que eu abra a página de releases do ARK-4 no navegador?"
if errorlevel 2 goto PASSO_12_FIM
start "" "https://github.com/PSP-Archive/ARK-4/releases"

:PASSO_12_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando o ARK4.zip estiver baixado e extraído"
call :FIM_PASSO 12
goto %DESTINO%

:PASSO_13
cls
call :CABECALHO 13 "Copiar o ARK-4 para o cartão"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_13
echo   Agora vamos colocar as três pastas nos lugares certos.
echo   Destinos (no cartão %SDL%:):
echo     %SDL%:\PSP\SAVEDATA\ARK_01234
echo     %SDL%:\PSP\GAME\ARK_Loader
echo     %SDL%:\PSP\GAME\ARK_cIPL
echo.
echo   Você pode fazer isso arrastando no Explorer, ou me dizer onde extraiu o ZIP que eu copio.
echo.
set "ORIG="
set /p "ORIG=   Cole o caminho da pasta extraída do ARK4.zip (ou ENTER para copiar à mão): "
if "%ORIG%"=="" goto PASSO_13_MANUAL
if not exist "%ORIG%\" (echo   Caminho não encontrado. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_13)
set "SRC=%ORIG%"
if exist "%ORIG%\PSP\ARK_01234\" set "SRC=%ORIG%\PSP"
echo.
echo   Origem usada: %SRC%
if not exist "%SRC%\ARK_01234\" (echo   Não achei ARK_01234 dentro dela. Confira se extraiu o ZIP inteiro. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_13)
if not exist "%SDL%:\PSP\SAVEDATA\" md "%SDL%:\PSP\SAVEDATA" 2>nul
if not exist "%SDL%:\PSP\GAME\" md "%SDL%:\PSP\GAME" 2>nul
echo   Copiando ARK_01234 ...
robocopy "%SRC%\ARK_01234" "%SDL%:\PSP\SAVEDATA\ARK_01234" /E /R:2 /W:2 /NP /NFL /NDL
if exist "%SRC%\ARK_Loader\" (echo   Copiando ARK_Loader ... & robocopy "%SRC%\ARK_Loader" "%SDL%:\PSP\GAME\ARK_Loader" /E /R:2 /W:2 /NP /NFL /NDL)
if exist "%SRC%\ARK_cIPL\" (echo   Copiando ARK_cIPL ... & robocopy "%SRC%\ARK_cIPL" "%SDL%:\PSP\GAME\ARK_cIPL" /E /R:2 /W:2 /NP /NFL /NDL)
if exist "%SRC%\DC-ARK\" (echo   Copiando DC-ARK ... & robocopy "%SRC%\DC-ARK" "%SDL%:\PSP\GAME\DC-ARK" /E /R:2 /W:2 /NP /NFL /NDL)
echo.
echo   Cópia terminada. O passo 14 confere.
call :ANOTAR "ARK copiado de %SRC% para %SDL%:"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 13
goto %DESTINO%

:PASSO_13_MANUAL
echo.
echo   À mão, no Explorer:
echo     1. Abra a pasta extraída do ARK4.zip. Se existir uma pasta "PSP" dentro dela, entre nela.
echo     2. Arraste ARK_01234  para  %SDL%:\PSP\SAVEDATA\
echo     3. Arraste ARK_Loader para  %SDL%:\PSP\GAME\
echo     4. Arraste ARK_cIPL   para  %SDL%:\PSP\GAME\
echo   Vou abrir as duas pastas de destino para facilitar.
if exist "%SDL%:\PSP\SAVEDATA\" start "" "%SDL%:\PSP\SAVEDATA"
if exist "%SDL%:\PSP\GAME\" start "" "%SDL%:\PSP\GAME"
call :AGUARDAR "Pressione qualquer tecla quando tiver copiado as três pastas"
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
if exist "%SDL%:\PSP\GAME\ARK_cIPL\" (echo     OK      PSP\GAME\ARK_cIPL) else (echo     AVISO   PSP\GAME\ARK_cIPL ^(só é necessário no passo 19^))
if exist "%SDL%:\PSP\GAME\ARK_Loader\EBOOT.PBP" (echo     OK      ARK_Loader\EBOOT.PBP) else (echo     FALTA   ARK_Loader\EBOOT.PBP & set "FALTA=1")
echo.
if "%FALTA%"=="1" echo   Está faltando coisa. Volte ao passo 13 ^(aperte R^) e confira se extraiu o ZIP inteiro.
if "%FALTA%"=="0" echo   Tudo no lugar. Pode seguir.
echo.
echo   Erro clássico: criar PSP\GAME\ARK_Loader\ARK_Loader (pasta dentro de pasta do mesmo nome).
echo   O EBOOT.PBP tem que estar DIRETO dentro de ARK_Loader.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 14
goto %DESTINO%

:PASSO_15
cls
call :CABECALHO 15 "Ejetar com segurança e sair do modo USB (ação física)"
echo   1. No PC: clique no ícone "Remover hardware com segurança" (bandeja, perto do relógio)
echo      e escolha ejetar a unidade %SDL%:. Espere a mensagem de que é seguro remover.
echo      Isso garante que a cópia foi realmente gravada no cartão, e não só no cache do Windows.
echo   2. AÇÃO FÍSICA no PSP: aperte o botão O (círculo) para sair da tela "Conexão USB".
echo   3. Desconecte o cabo USB do console.
echo   4. Deixe o carregador ligado.
echo.
echo   Se o Windows recusar a ejeção, feche as janelas do Explorer que estão abertas no cartão
echo   e tente de novo. Não arranque o cabo com gravação em andamento.
echo.
call :AGUARDAR "Pressione qualquer tecla quando tiver ejetado e saído do modo USB"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "Rodar o ARK Loader no PSP - CFW temporária (ação física)"
echo   Esta é a hora da verdade, e é a parte SEM RISCO: nada é gravado na NAND.
echo.
echo   AÇÃO FÍSICA no PSP:
echo     1. Com o console ligado e fora do modo USB, vá no XMB até a coluna "Jogo".
echo     2. Desça até "Memory Stick" e aperte X.
if "%MODELO%"=="GO" echo        No PSP Go, se você usou a memória interna, o item aparece como "Memória interna".
echo     3. Na lista deve aparecer o item "ARK Loader" (ícone do ARK). Selecione e aperte X.
echo     4. A tela vai ficar preta por 1 a 3 segundos e o console REINICIA sozinho, voltando ao XMB.
echo        Esse reinício rápido é o esperado: significa que a CFW subiu.
echo.
echo   SE "ARK Loader" NÃO APARECER NA LISTA:
echo     - Confira o caminho: PSP\GAME\ARK_Loader\EBOOT.PBP (passo 14).
echo     - Se apareceu "Dados corrompidos", o arquivo não terminou de copiar ou o cartão não foi
echo       ejetado com segurança. Copie de novo (passo 13) e ejete direito (passo 15).
echo     - Confira que o firmware é 6.60 ou 6.61 (passo 4).
echo.
echo   SE A TELA FICAR PRETA E NÃO VOLTAR:
echo     - Segure POWER por 10 segundos para desligar à força e ligue de novo. Nada foi gravado;
echo       o console volta normal no firmware oficial.
echo.
call :AGUARDAR "Pressione qualquer tecla depois que o console reiniciar e voltar ao XMB"
call :FIM_PASSO 16
goto %DESTINO%

:PASSO_17
cls
call :CABECALHO 17 "Confirmar que a CFW temporária está ativa"
echo   AÇÃO FÍSICA no PSP:
echo     1. XMB -^> "Configurações" -^> "Configurações do Sistema" -^> "Informações do Sistema".
echo     2. Olhe a linha "Software do sistema".
echo.
echo   RESULTADO ESPERADO: aparece algo como
echo.
echo        Software do sistema:  6.61 ARK-4 Live
echo.
echo   Se aparecer "ARK-4 Live" (ou "ARK-4"), a CFW temporária ESTÁ funcionando. 
echo   Se aparecer só "6.61" sem menção ao ARK, a CFW não subiu: volte ao passo 16.
echo.
echo   TESTE RÁPIDO (opcional, mas recomendado):
echo     - Aperte SELECT no XMB: deve abrir o menu VSH do ARK (menu de configurações da CFW).
echo       Se o menu abrir, está tudo certo. Aperte SELECT de novo para fechar.
echo.
echo   IMPORTANTE: nesta fase, ao DESLIGAR o console a CFW sai. Para voltar, roda o ARK Loader
echo   outra vez. Isso é normal e é exatamente o que o cIPL do passo 19 resolve.
echo.
call :PERGUNTA "   Apareceu ARK-4 nas Informações do Sistema?"
if errorlevel 2 (echo   Então a CFW não subiu. Volte ao passo 16 e siga as dicas de erro. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_16)
call :ANOTAR "CFW temporaria confirmada (ARK-4 Live)"
call :FIM_PASSO 17
goto %DESTINO%

:PASSO_18
cls
call :CABECALHO 18 "Decidir: ficar na temporária ou instalar o cIPL permanente"
echo   Agora você escolhe. As duas opções são válidas.
echo.
echo   OPÇÃO A - FICAR NA TEMPORÁRIA (ARK Loader)
echo     + Risco zero: nada é gravado na NAND, brick impossível por software.
echo     + Reverter é desligar o console.
echo     - Toda vez que ligar, precisa entrar em Jogo -^> Memory Stick -^> ARK Loader.
echo     - Alguns jogos e homebrew que reiniciam o console fazem a CFW cair.
echo.
echo   OPÇÃO B - cIPL PERMANENTE (recomendado depois que a temporária já funcionou)
echo     + Liga já com CFW, sem passo extra. Comporta-se como firmware do console.
echo     + Funciona em todos os modelos: 1000, 2000, 3000, Go e Street.
echo     + Removível por software (opção 6 do menu deste guia).
echo     - Grava na área de boot da NAND. Se faltar energia no meio, pode brickar.
if "%MODELO%"=="3000" echo     - No seu PSP-3000 um brick NÃO é recuperável por bateria Pandora.
if "%MODELO%"=="GO" echo     - No seu PSP Go um brick NÃO é recuperável por bateria Pandora.
if "%MODELO%"=="E1000" echo     - No seu PSP Street um brick NÃO é recuperável por bateria Pandora.
if "%MODELO%"=="1000" echo     - No seu PSP-1000 um brick é recuperável com bateria Pandora.
if "%MODELO%"=="2000" echo     - No seu PSP-2000 um brick é recuperável com Pandora se a placa for TA-085 ou anterior.
echo.
echo   CHECKLIST OBRIGATÓRIO ANTES DA OPÇÃO B:
echo     [ ] A CFW temporária já funcionou (passo 17 confirmado).
echo     [ ] Bateria com carga alta E encaixada.
echo     [ ] Carregador ligado na tomada e no console.
echo     [ ] Você não vai apertar nada durante a gravação (leva poucos segundos).
echo.
choice /c AB /n /m "   [A] Ficar na temporária e ir para as configurações    [B] Instalar o cIPL agora : "
if errorlevel 2 (call :FIM_PASSO 18 19 & goto %DESTINO%)
echo.
echo   Escolha registrada: ficar na CFW temporária. Vou pular para o passo 21 (configuração).
echo   Você pode voltar e fazer o cIPL depois: menu -^> [3] -^> passo 19.
call :ANOTAR "Usuario optou por ficar na CFW temporaria"
call :FIM_PASSO 18 21
goto %DESTINO%

:PASSO_19
cls
call :CABECALHO 19 "Instalar o cIPL - CFW permanente (ação física, ponto de atenção)"
echo   LEIA ANTES DE APERTAR QUALQUER COISA:
echo     - Isto grava na NAND. São poucos segundos, mas NÃO interrompa.
echo     - Requisitos: firmware 6.60 ou 6.61 e a CFW temporária ativa AGORA (passo 17).
echo     - Se este console já teve Infinity instalado antes, rode PRIMEIRO o DC-ARK e só depois o cIPL.
echo.
echo   AÇÃO FÍSICA no PSP:
echo     1. Confirme na tela que a CFW está ativa (SELECT abre o menu VSH).
echo     2. Confirme que o carregador está na tomada e o cabo no console.
echo     3. XMB -^> "Jogo" -^> "Memory Stick" -^> selecione "ARK cIPL Flasher" -^> X.
if "%MODELO%"=="GO" echo        No PSP Go o item vem da memória interna ^(ef0:^) se você copiou para lá.
echo     4. Leia o aviso na tela e aperte o botão de CONFIRMAR indicado (normalmente X).
echo     5. Espere a mensagem de sucesso. NÃO aperte nada, NÃO desligue, NÃO tire o cabo.
echo     6. Quando pedir, reinicie o console (ou desligue e ligue normalmente).
echo.
echo   O QUE VOCÊ DEVE VER: uma tela de texto simples com o resultado da gravação e a instrução
echo   para reiniciar. Se aparecer erro, ANOTE a mensagem e veja a opção [5] do menu.
echo.
call :PERGUNTA "   Carregador na tomada, bateria encaixada e CFW temporária ativa?"
if errorlevel 2 (echo   Resolva isso antes. Este é o único passo com risco real. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_19)
echo.
call :AGUARDAR "Pressione qualquer tecla DEPOIS que o console reiniciar"
call :ANOTAR "cIPL: usuario informou que a gravacao terminou"
call :FIM_PASSO 19
goto %DESTINO%

:PASSO_20
cls
call :CABECALHO 20 "Confirmar a CFW permanente"
echo   AÇÃO FÍSICA no PSP (com o console recém-reiniciado, SEM rodar o ARK Loader):
echo     1. XMB -^> "Configurações" -^> "Configurações do Sistema" -^> "Informações do Sistema".
echo     2. Olhe a linha "Software do sistema".
echo.
echo   RESULTADO ESPERADO:
echo.
echo        Software do sistema:  ARK 4.20.XX cIPL
echo.
echo   Se aparecer "cIPL", pronto: o console liga com CFW para sempre, sem passo extra.
echo   Se aparecer só "6.61", a gravação não pegou. O console continua funcionando normalmente;
echo   você pode usar a CFW temporária e tentar o cIPL de novo depois (passo 19).
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
echo   Não pegou. Causas em ordem de probabilidade:
echo     1. A CFW temporária não estava ativa no momento da gravação -^> refaça 16, 17 e 19 na ordem.
echo     2. Firmware diferente de 6.60/6.61 -^> confira no passo 4 e atualize no passo 11.
echo     3. Infinity antigo no console -^> rode o DC-ARK e depois o cIPL.
echo     4. Cartão com problema -^> refaça a cópia (passo 13) e ejete com segurança (passo 15).
echo   Nada disso brickou o console: você continua podendo usar a CFW temporária.
call :AGUARDAR "Pressione qualquer tecla para voltar ao passo 19"
goto PASSO_19

:PASSO_21
cls
call :CABECALHO 21 "Configurar o ARK: menu VSH (SELECT), clock e plugins"
echo   O menu de configuração da CFW abre apertando SELECT dentro do XMB (ou dentro de um jogo).
echo.
echo   AJUSTES QUE VALEM A PENA:
echo     - CPU Clock (XMB): deixe em padrão. Clock alto no XMB só gasta bateria.
echo     - CPU Clock (jogo): 333/166 MHz ajuda em jogos que engasgam (God of War, GTA, Tekken).
echo       Custo: mais consumo de bateria e mais calor. Se travar, volte para o padrão.
echo     - UMD ISO Mode: deixe em "Inferno" (driver padrão do ARK, melhor compatibilidade).
echo     - Region Free: útil para UMD-Video de outra região.
echo     - Plugins: ficam em PSP\PLUGINS e são ligados/desligados nesse mesmo menu.
echo       Regra prática: só um plugin novo por vez. Se o console travar ao ligar, foi o último.
echo.
echo   SE UM PLUGIN QUEBRAR O CONSOLE (trava no XMB):
echo     - Desligue, coloque o cartão no PC e renomeie a pasta do plugin (ex.: PLUGINS para PLUGINS_off).
echo     - O console volta a ligar normal.
echo.
echo   RECOVERY MENU: com a CFW ativa, desligue e ligue segurando R. Abre um menu de emergência
echo   onde dá para desativar todos os plugins e reverter configurações.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 21
goto %DESTINO%

:PASSO_22
cls
call :CABECALHO 22 "Colocar jogos, homebrew e jogos de PS1"
if "%SDL%"=="" call :PEDIR_UNIDADE
echo   ONDE CADA COISA VAI (no cartão):
echo.
echo     Jogos de UMD (backup dos SEUS discos)   -^>  %SDL%:\ISO\      arquivos .iso ou .cso
echo     Homebrew e emuladores                    -^>  %SDL%:\PSP\GAME\  uma pasta por programa
echo     Jogos de PS1 (EBOOT.PBP)                 -^>  %SDL%:\PSP\GAME\  uma pasta por jogo
echo     Cheats                                   -^>  %SDL%:\PSP\CHEATS\
echo.
echo   COMO FAZER O DUMP DOS SEUS UMDs (legal e sem PC):
echo     1. Coloque o UMD no console.
echo     2. Abra o menu VSH (SELECT) e procure a opção de dump de UMD do ARK, ou use o homebrew
echo        "UMD Dumper" colocado em PSP\GAME.
echo     3. O arquivo .iso sai direto na pasta ISO do cartão.
echo     4. .cso é o mesmo jogo comprimido: ocupa menos espaço, carrega igual. Dá para converter
echo        no PC com o UMDGen ou com o CISO.
echo.
echo   EMULADORES QUE VALEM NO PSP (todos homebrew livre, cada um em PSP\GAME):
echo     - SNES9x TYL / Snes9x Euphoria  : Super Nintendo
echo     - PicoDrive                     : Mega Drive / Master System / Game Gear
echo     - gpSP / TempGBA                : Game Boy Advance
echo     - NesterJ                       : NES
echo     - MAME4ALL / FBA               : arcade
echo     - RetroArch PSP                : vários núcleos em um só (mais pesado)
echo.
echo   Regra de ouro: baixe homebrew só do GitHub oficial do projeto ou de acervos conhecidos.
echo   Arquivo de homebrew não precisa de instalador; é só copiar a pasta.
echo.
call :PERGUNTA "   Quer que eu abra a pasta ISO do cartão para você jogar os arquivos lá?"
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
call :CABECALHO 23 "Backup dos saves e do cartão (rotina que salva sua vida)"
if "%SDL%"=="" call :PEDIR_UNIDADE
if "%SDL%"=="" goto PASSO_23
echo   Os saves do PSP ficam em PSP\SAVEDATA, uma pasta por jogo. Se o cartão corromper, eles vão junto.
echo   Recomendação: copie PSP\SAVEDATA para o PC de vez em quando (leva segundos).
echo.
set "SVB=%USERPROFILE%\Desktop\Saves_PSP_%DATE:/=-%"
set "SVB=%SVB: =_%"
echo   Destino: %SVB%
echo.
call :PERGUNTA "   Copiar os saves agora?"
if errorlevel 2 goto PASSO_23_FIM
if not exist "%SDL%:\PSP\SAVEDATA\" (echo   Não achei %SDL%:\PSP\SAVEDATA - o cartão está conectado e em modo USB? & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_23)
robocopy "%SDL%:\PSP\SAVEDATA" "%SVB%" /E /R:2 /W:2 /NP /NFL /NDL
if errorlevel 8 (echo   Falha na cópia. Confira o cabo e a letra da unidade. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_23)
echo.
echo   Saves copiados para: %SVB%
call :ANOTAR "Saves copiados para %SVB%"

:PASSO_23_FIM
echo.
echo   Dica: a pasta ARK_01234 também vive em PSP\SAVEDATA. Ao restaurar saves, não sobrescreva
echo   ARK_01234 com uma versão antiga - copie de volta só as pastas dos jogos.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 23
goto %DESTINO%

:PASSO_24
cls
call :CABECALHO 24 "Verificação final e boas práticas"
echo   CHECKLIST FINAL - marque mentalmente cada item:
echo     [ ] Informações do Sistema mostra ARK (Live ou cIPL).
echo     [ ] O console desliga e liga mantendo a CFW (se você fez o cIPL).
echo     [ ] Um homebrew abre a partir de Jogo -^> Memory Stick.
echo     [ ] Um jogo em ISO/CSO abre a partir da pasta ISO.
echo     [ ] Backup do cartão e dos saves guardado no PC.
echo.
echo   BOAS PRÁTICAS PARA NÃO QUEBRAR NADA:
echo     1. Nunca instale "atualização de firmware oficial" depois do cIPL sem ler antes: o 6.61
echo        já é o último, então qualquer "update" que aparecer de fonte estranha é suspeito.
echo     2. Um plugin novo por vez. Se travar, Recovery Menu (ligar segurando R) e desative tudo.
echo     3. Não tire o cartão com o console ligado.
echo     4. Evite formatar o cartão pelo PC quando der problema: formate pelo próprio PSP.
echo     5. Bateria inchada: troque. É risco de fogo e de empenar a carcaça.
echo     6. Guarde uma cópia do ARK4.zip usado. O repositório foi arquivado; ter o arquivo
echo        local evita depender de link no futuro.
echo.
echo   ONDE PEDIR AJUDA: wiki oficial do ARK-4 no GitHub (PSP-Archive/ARK-4) e a página de releases.
echo   A opção [7] do menu abre esses links.
echo.
call :ANOTAR "Guia concluido"
call :AGUARDAR "Pressione qualquer tecla para ver a tela de conclusão"
call :FIM_PASSO 24
goto %DESTINO%

rem ============================================================================
rem  TELAS AUXILIARES
rem ============================================================================

:CONCLUIDO
cls
echo.
echo  ==========================================================================================
echo   CONCLUÍDO  -  seu PSP está com Custom Firmware
echo  ==========================================================================================
echo.
echo   O que você tem agora:
echo     - CFW ARK-4 ativa (temporária via ARK Loader ou permanente via cIPL).
echo     - Homebrew, emuladores, ISO/CSO, PS1, plugins e temas liberados.
echo     - Backup do cartão e dos saves guardados no PC.
echo.
echo   Guarde estes arquivos, na mesma pasta deste guia:
echo     %PROG%   (progresso)
echo     %REG%   (registro do que foi feito)
echo.
echo   Próximos passos sugeridos:
echo     1. Fazer o dump dos seus UMDs para a pasta ISO (passo 22).
echo     2. Instalar 2 ou 3 emuladores e testar um jogo em cada.
echo     3. Se ainda está na CFW temporária e quer permanente, volte ao passo 19.
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
echo     - Firmware oficial 6.60 ou 6.61 (o alvo é 6.61, último oficial da Sony, de jan/2015).
echo     - Bateria que segura carga + carregador original ou equivalente.
echo     - Memory Stick PRO Duo (ou microSD com adaptador) em FAT32. No Go, a memória interna serve.
echo.
echo   NO PC:
echo     - Windows 10 ou 11, uma porta USB e um cabo USB de DADOS.
echo       PSP-1000/2000/3000/E1000: mini-USB tipo B.  PSP Go: conector multiuso proprietário.
echo     - 7-Zip, PeaZip ou o extrator do Windows.
echo     - Nenhum driver especial: o PSP em modo USB monta como pen drive.
echo.
echo   DOWNLOADS:
echo     ARK-4 (recomendado, v4.20.69 r206, última estável):
echo       https://github.com/PSP-Archive/ARK-4/releases
echo     Wiki oficial do ARK-4 (instalação, cIPL, Full Flash):
echo       https://github.com/PSP-Archive/ARK-4/wiki
echo     ARK-5 (sucessor, em desenvolvimento ativo, releases pré-release):
echo       https://github.com/PSP-Arkfive/ARK-5
echo       https://github.com/PSP-Arkfive/FasterARK
echo.
echo   SOBRE O FIRMWARE 6.61: a Sony encerrou as páginas de download do PSP. O atualizador oficial
echo   (EBOOT.PBP, cerca de 30 MB) hoje é obtido em acervos de preservação. Confira o tamanho e o
echo   hash quando o acervo publicar. Este guia não hospeda nem indica cópia de jogos.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:ERROS
cls
echo.
echo   ERROS COMUNS E COMO CORRIGIR
echo   ----------------------------
echo   1. "ARK Loader" não aparece em Jogo -^> Memory Stick
echo      causa: caminho errado, cópia incompleta ou cartão fora de FAT32.
echo      correção: confira PSP\GAME\ARK_Loader\EBOOT.PBP (passo 14); refaça a cópia; ejete direito.
echo.
echo   2. "Dados corrompidos" no ícone
echo      causa: arquivo truncado (cabo ruim, cartão retirado sem ejetar) ou EBOOT incompatível.
echo      correção: apague a pasta, copie de novo do ZIP e ejete com segurança antes de tirar o cabo.
echo.
echo   3. Tela preta ao abrir o ARK Loader
echo      causa: firmware fora de 6.60/6.61, ou pasta ARK_01234 ausente.
echo      correção: confira o firmware (passo 4) e a pasta PSP\SAVEDATA\ARK_01234 (passo 14).
echo      Segure POWER 10 s para desligar. Nada foi gravado.
echo.
echo   4. O cIPL não pega (Informações do Sistema não mostra cIPL)
echo      causa: CFW temporária não estava ativa na hora, ou Infinity antigo no console.
echo      correção: rode o ARK Loader, confirme "ARK-4 Live", e só então o cIPL. Se já teve Infinity,
echo      rode o DC-ARK primeiro.
echo.
echo   5. Console já tinha PRO / ME / LME / Infinity
echo      correção: instale o DC-ARK (vem no pacote do ARK-4) para limpar o Infinity e depois o cIPL.
echo.
echo   6. Trava no XMB depois de instalar plugin
echo      correção: ligue segurando R para abrir o Recovery Menu e desative todos os plugins.
echo      Ou coloque o cartão no PC e renomeie a pasta PSP\PLUGINS.
echo.
echo   7. O PC não vê o cartão no modo USB
echo      causa mais comum: cabo "só carga". Troque o cabo. Depois teste outra porta USB (sem hub).
echo.
echo   8. Cartão acima de 32 GB que o Windows não formata em FAT32
echo      correção: num Prompt como administrador rode  format X: /FS:FAT32 /Q  onde X é a letra do
echo      cartão. Ou, mais simples, formate pelo próprio PSP.
echo.
echo   9. Console não liga depois do cIPL (brick)
echo      PSP-1000 ou 2000 TA-085 ou anterior: recuperável com bateria Pandora + Magic Memory Stick.
echo      PSP-2000 TA-088v3, 3000, Go, E1000: não há recuperação por Pandora.
echo      Em qualquer caso: NÃO insista ligando várias vezes; procure ajuda na comunidade antes.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DESFAZER
cls
echo.
echo   COMO DESFAZER (voltar ao firmware oficial)
echo   ------------------------------------------
echo   CASO 1 - você só usou a CFW TEMPORÁRIA (ARK Loader)
echo     Nada a desfazer: desligue o console. Se quiser limpar o cartão, apague as pastas
echo     PSP\GAME\ARK_Loader, PSP\GAME\ARK_cIPL e PSP\SAVEDATA\ARK_01234.
echo.
echo   CASO 2 - você instalou o cIPL (permanente)
echo     1. Ligue o console (ele sobe com CFW).
echo     2. Rode o DC-ARK, que está em PSP\GAME\DC-ARK (vem no pacote do ARK-4).
echo        Ele remove o cIPL e devolve o boot original.
echo     3. Reinicie e confira em Informações do Sistema: deve mostrar apenas 6.61.
echo     4. Depois disso, apague as pastas do ARK do cartão, se quiser.
echo.
echo   CASO 3 - restaurar o cartão exatamente como estava
echo     Copie de volta o conteúdo da pasta de backup criada no passo 8.
echo.
echo   OBSERVAÇÕES HONESTAS:
echo     - Remover o cIPL não "zera" o console como sair de fábrica; ele volta a bootar o firmware
echo       oficial, que é o que importa para levar em assistência ou vender.
echo     - Se quiser zerar configurações e saves: Configurações -^> Configurações do Sistema -^>
echo       Restaurar Configurações Padrão (isso não remove CFW).
echo     - Formatar o Memory Stick não remove o cIPL: o cIPL está na NAND, não no cartão.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   ABRIR LINKS OFICIAIS
echo   --------------------
echo   [1] ARK-4 - página de releases (baixar ARK4.zip)
echo   [2] ARK-4 - wiki (instalação, cIPL, Full Flash)
echo   [3] ARK-5 - repositório do sucessor
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
echo   [2] Informações do cartão (FAT32, tamanho, espaço livre)
echo   [3] Backup completo do cartão
echo   [4] Criar a estrutura de pastas
echo   [5] Conferir se o ARK está no lugar certo
echo   [6] Copiar apenas os saves (PSP\SAVEDATA) para o PC
echo   [7] Abrir o cartão no Explorer
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
if "%SDL%"=="" echo   Não encontrei automaticamente. Use a opção 7 para olhar no Explorer.
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
if not exist "%REG%" echo   Ainda não há registro.
echo   ------------------------------------------------------------------------------------------
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:SEM_ACENTOS
cls
echo.
echo   MODO SEM ACENTOS
echo   Gera uma cópia deste guia só com caracteres ASCII (sem acentos; setas viram -^>) e abre a cópia.
if "%ASCII%"=="1" (echo   Esta já é a versão sem acentos. & call :AGUARDAR "Pressione qualquer tecla" & goto MENU)
set "SA_SRC=%~f0"
set "SA_DST=%~dpn0_sem_acentos.bat"
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand %PSB64%
if not exist "%SA_DST%" (echo   Falha ao gerar a cópia. & call :AGUARDAR "Pressione qualquer tecla" & goto MENU)
echo   Gerado: %SA_DST%
echo   Abrindo a versão sem acentos e fechando esta...
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
choice /c SN /n /m "%~1  [S] Sim   [N] Não : "
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
if not exist %SDL%:\ (echo   Unidade %SDL%: não encontrada. & set "SDL=" & exit /b)
if /i "%SDL%"=="C" (echo   C: é o disco do Windows, não o PSP! & set "SDL=" & exit /b)
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
choice /c SRME /n /m "   [S] Próximo passo    [R] Repetir este passo    [M] Menu    [E] Erros e correções : "
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
