@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul 2>&1
title Guia interativo - Desbloqueio New 3DS XL (Luma3DS + boot9strap)
color 0B
mode con: cols=110 lines=50 >nul 2>&1

rem ============================================================================
rem  GUIA INTERATIVO DE DESBLOQUEIO - NEW NINTENDO 3DS XL
rem  Baseado no guia oficial 3ds.hacks.guide (consultado em set/2026)
rem  Metodos cobertos: super-skaterhax (New 3DS 11.15-11.17, USA/EUR/KOR)
rem                    MSET9 CLI      (New 3DS 11.4-11.17, todas as regioes)
rem  Salve este arquivo como UTF-8 SEM BOM com finais de linha CRLF.
rem ============================================================================

set "PASTA=%~dp0"
set "PROG=%PASTA%progresso_new3dsxl.txt"
set "TOTAL=30"
set "ASCII=1"
set "LOG=%PASTA%log_new3dsxl.txt"
set "PSB64=CgAkAHMAcgBjAD0AJABlAG4AdgA6AFMAQQBfAFMAUgBDADsAIAAkAGQAcwB0AD0AJABlAG4AdgA6AFMAQQBfAEQAUwBUAAoAJAB0AD0AWwBJAE8ALgBGAGkAbABlAF0AOgA6AFIAZQBhAGQAQQBsAGwAVABlAHgAdAAoACQAcwByAGMALABbAFQAZQB4AHQALgBFAG4AYwBvAGQAaQBuAGcAXQA6ADoAVQBUAEYAOAApAAoAJABtAGEAcAA9AEAAewAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADQAKQA9ACcAIABvAHUAIAAnADsACgAgACgAWwBzAHQAcgBpAG4AZwBdAFsAYwBoAGEAcgBdADAAeAAyADYAMwAwACkAPQAnAFsAbQBlAG4AdQBdACcAOwAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIANwAxADMAKQA9ACcATwBLACcAOwAKACAAKAAnAOVlLGcnACkAPQAnAE4AaQBoAG8AbgAgACgASgBhAHAAYQBvACkAJwA7AAoAIAAoACcALYqaW1cwajBEMCcAKQA9ACcAbgBhAG8AIABkAGUAZgBpAG4AaQByACcAOwAKACAAKAAnAACzXNX8u22tJwApAD0AJwBEAGEAZQBoAGEAbgAgAE0AaQBuAGcAdQBrACAAKABDAG8AcgBlAGkAYQApACcAOwAKACAAKAAnACTBFchY1cDJIABKxUzHJwApAD0AJwBuAGEAbwAgAGQAZQBmAGkAbgBpAHIAJwAKAH0ACgBmAG8AcgBlAGEAYwBoACgAJABrACAAaQBuACAAJABtAGEAcAAuAEsAZQB5AHMAKQB7ACAAJAB0AD0AJAB0AC4AUgBlAHAAbABhAGMAZQAoACQAawAsACQAbQBhAHAAWwAkAGsAXQApACAAfQAKACQAYQByAHIAbwB3AD0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADIACgAkAHMAYgAyAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFQAZQB4AHQALgBTAHQAcgBpAG4AZwBCAHUAaQBsAGQAZQByAAoAZgBvAHIAZQBhAGMAaAAoACQAbABpAG4AZQAgAGkAbgAgACQAdAAgAC0AcwBwAGwAaQB0ACAAIgBgAHIAYABuACIAKQB7AAoAIAAgAGkAZgAoACQAbABpAG4AZQAuAEkAbgBkAGUAeABPAGYAKAAkAGEAcgByAG8AdwApACAALQBnAGUAIAAwACkAewAKACAAIAAgACAAJABxAD0AJABmAGEAbABzAGUAOwAgACQAbgBsAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFQAZQB4AHQALgBTAHQAcgBpAG4AZwBCAHUAaQBsAGQAZQByAAoAIAAgACAAIABmAG8AcgBlAGEAYwBoACgAJABjACAAaQBuACAAJABsAGkAbgBlAC4AVABvAEMAaABhAHIAQQByAHIAYQB5ACgAKQApAHsACgAgACAAIAAgACAAIABpAGYAKAAkAGMAIAAtAGUAcQAgACcAIgAnACkAewAgACQAcQA9AC0AbgBvAHQAIAAkAHEAOwAgAFsAdgBvAGkAZABdACQAbgBsAC4AQQBwAHAAZQBuAGQAKAAkAGMAKQAgAH0ACgAgACAAIAAgACAAIABlAGwAcwBlAGkAZgAoACQAYwAgAC0AZQBxACAAJABhAHIAcgBvAHcAKQB7ACAAaQBmACgAJABxACkAewBbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJwAtAD4AJwApAH0AIABlAGwAcwBlACAAewBbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJwAtAF4APgAnACkAfQAgAH0ACgAgACAAIAAgACAAIABlAGwAcwBlAHsAIABbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJABjACkAIAB9AAoAIAAgACAAIAB9AAoAIAAgACAAIAAkAGwAaQBuAGUAPQAkAG4AbAAuAFQAbwBTAHQAcgBpAG4AZwAoACkACgAgACAAfQAKACAAIABbAHYAbwBpAGQAXQAkAHMAYgAyAC4AQQBwAHAAZQBuAGQAKAAkAGwAaQBuAGUAKQA7ACAAWwB2AG8AaQBkAF0AJABzAGIAMgAuAEEAcABwAGUAbgBkACgAIgBgAHIAYABuACIAKQAKAH0ACgAkAHQAPQAkAHMAYgAyAC4AVABvAFMAdAByAGkAbgBnACgAKQA7ACAAaQBmACgAJAB0AC4ATABlAG4AZwB0AGgAIAAtAGcAZQAgADIAKQB7ACAAJAB0AD0AJAB0AC4AUwB1AGIAcwB0AHIAaQBuAGcAKAAwACwAJAB0AC4ATABlAG4AZwB0AGgALQAyACkAIAB9AAoAJABuAD0AJAB0AC4ATgBvAHIAbQBhAGwAaQB6AGUAKABbAFQAZQB4AHQALgBOAG8AcgBtAGEAbABpAHoAYQB0AGkAbwBuAEYAbwByAG0AXQA6ADoARgBvAHIAbQBEACkACgAkAHMAYgA9AE4AZQB3AC0ATwBiAGoAZQBjAHQAIABUAGUAeAB0AC4AUwB0AHIAaQBuAGcAQgB1AGkAbABkAGUAcgAKAGYAbwByAGUAYQBjAGgAKAAkAGMAIABpAG4AIAAkAG4ALgBUAG8AQwBoAGEAcgBBAHIAcgBhAHkAKAApACkAewAKACAAIABpAGYAKABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBDAGgAYQByAFUAbgBpAGMAbwBkAGUASQBuAGYAbwBdADoAOgBHAGUAdABVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQAoACQAYwApACAALQBuAGUAIABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQBdADoAOgBOAG8AbgBTAHAAYQBjAGkAbgBnAE0AYQByAGsAKQB7ACAAWwB2AG8AaQBkAF0AJABzAGIALgBBAHAAcABlAG4AZAAoACQAYwApACAAfQAKAH0ACgAkAG8AdQB0AD0AJABzAGIALgBUAG8AUwB0AHIAaQBuAGcAKAApAAoAJABvAHUAdAA9AFsAcgBlAGcAZQB4AF0AOgA6AFIAZQBwAGwAYQBjAGUAKAAkAG8AdQB0ACwAJwBbAF4AXAB4ADAAMAAtAFwAeAA3AEYAXQAnACwAJwA/ACcAKQAKACQAbwB1AHQAPQAkAG8AdQB0AC4AUgBlAHAAbABhAGMAZQAoACcAcwBlAHQAIAAiAEEAUwBDAEkASQA9ADAAIgAnACwAJwBzAGUAdAAgACIAQQBTAEMASQBJAD0AMQAiACcAKQAKAFsASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABzAHQALAAkAG8AdQB0ACwAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAVABlAHgAdAAuAFUAVABGADgARQBuAGMAbwBkAGkAbgBnACgAJABmAGEAbABzAGUAKQApACkACgA="
set "PSSPEED=CgAkAGQAPQAkAGUAbgB2ADoAUwBEAEwAKwAnADoAXAAnAAoAJABmAD0ASgBvAGkAbgAtAFAAYQB0AGgAIAAkAGQAIAAnAHQAZQBzAHQAZQBfAHYAZQBsAG8AYwBpAGQAYQBkAGUALgB0AG0AcAAnAAoAJABtAGIAPQAyADAAMAAKACQAYgB1AGYAPQBOAGUAdwAtAE8AYgBqAGUAYwB0ACAAYgB5AHQAZQBbAF0AIAAoADEATQBCACkAOwAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAFIAYQBuAGQAbwBtACkALgBOAGUAeAB0AEIAeQB0AGUAcwAoACQAYgB1AGYAKQAKACQAcwB3AD0AWwBEAGkAYQBnAG4AbwBzAHQAaQBjAHMALgBTAHQAbwBwAHcAYQB0AGMAaABdADoAOgBTAHQAYQByAHQATgBlAHcAKAApAAoAJABmAHMAPQBbAEkATwAuAEYAaQBsAGUAXQA6ADoATwBwAGUAbgAoACQAZgAsACcAQwByAGUAYQB0AGUAJwAsACcAVwByAGkAdABlACcALAAnAE4AbwBuAGUAJwApAAoAZgBvAHIAKAAkAGkAPQAwADsAJABpACAALQBsAHQAIAAkAG0AYgA7ACQAaQArACsAKQB7ACAAJABmAHMALgBXAHIAaQB0AGUAKAAkAGIAdQBmACwAMAAsACQAYgB1AGYALgBMAGUAbgBnAHQAaAApACAAfQAKACQAZgBzAC4ARgBsAHUAcwBoACgAJAB0AHIAdQBlACkAOwAgACQAZgBzAC4AQwBsAG8AcwBlACgAKQA7ACAAJABzAHcALgBTAHQAbwBwACgAKQAKACQAdwA9AFsAbQBhAHQAaABdADoAOgBSAG8AdQBuAGQAKAAkAG0AYgAvACQAcwB3AC4ARQBsAGEAcABzAGUAZAAuAFQAbwB0AGEAbABTAGUAYwBvAG4AZABzACwAMQApAAoAJABzAHcAPQBbAEQAaQBhAGcAbgBvAHMAdABpAGMAcwAuAFMAdABvAHAAdwBhAHQAYwBoAF0AOgA6AFMAdABhAHIAdABOAGUAdwAoACkACgAkAGYAcwA9AFsASQBPAC4ARgBpAGwAZQBdADoAOgBPAHAAZQBuACgAJABmACwAJwBPAHAAZQBuACcALAAnAFIAZQBhAGQAJwAsACcATgBvAG4AZQAnACkAOwAgACQAcgA9AE4AZQB3AC0ATwBiAGoAZQBjAHQAIABiAHkAdABlAFsAXQAgACgAMQBNAEIAKQA7ACAAJAB0AG8AdAA9ADAACgB3AGgAaQBsAGUAKAAoACQAbgA9ACQAZgBzAC4AUgBlAGEAZAAoACQAcgAsADAALAAkAHIALgBMAGUAbgBnAHQAaAApACkAIAAtAGcAdAAgADAAKQB7ACAAJAB0AG8AdAArAD0AJABuACAAfQAKACQAZgBzAC4AQwBsAG8AcwBlACgAKQA7ACAAJABzAHcALgBTAHQAbwBwACgAKQAKACQAcgBkAD0AWwBtAGEAdABoAF0AOgA6AFIAbwB1AG4AZAAoACgAJAB0AG8AdAAvADEATQBCACkALwAkAHMAdwAuAEUAbABhAHAAcwBlAGQALgBUAG8AdABhAGwAUwBlAGMAbwBuAGQAcwAsADEAKQAKAFIAZQBtAG8AdgBlAC0ASQB0AGUAbQAgACQAZgAgAC0ARgBvAHIAYwBlAAoAIgAgACAAIABFAHMAYwByAGkAdABhACAAcwBlAHEAdQBlAG4AYwBpAGEAbAA6ACAAJAB3ACAATQBCAC8AcwAgACAAIABMAGUAaQB0AHUAcgBhACAAcwBlAHEAdQBlAG4AYwBpAGEAbAA6ACAAJAByAGQAIABNAEIALwBzACAAIAAgACgAYQByAHEAdQBpAHYAbwAgAGQAZQAgACQAbQBiACAATQBCACkAIgAKAGkAZgAoACQAdwAgAC0AbAB0ACAANQApAHsAIAAiACAAIAAgAEEAVgBJAFMATwA6ACAAZQBzAGMAcgBpAHQAYQAgAG0AdQBpAHQAbwAgAGwAZQBuAHQAYQAgAG8AdQAgAGMAYQByAHQAYQBvACAAZgBhAGwAcwBvAC8AZABlAGYAZQBpAHQAdQBvAHMAbwAuACAAUgBvAGQAZQAgAG8AIABIADIAdABlAHMAdAB3AC4AIgAgAH0AIABlAGwAcwBlAGkAZgAoACQAdwAgAC0AbAB0ACAAMQAwACkAewAgACIAIAAgACAATABlAG4AdABvACwAIABtAGEAcwAgAGYAdQBuAGMAaQBvAG4AYQAuACAAVQBtACAAYwBhAHIAdABhAG8AIABDAGwAYQBzAHMAZQAgADEAMAAvAEEAMQAgAHIAZQBhAGwAIABlAHMAYwByAGUAdgBlACAAMQA1AC0ANAAwACAATQBCAC8AcwAuACIAIAB9ACAAZQBsAHMAZQAgAHsAIAAiACAAIAAgAE8ASwAgAHAAYQByAGEAIABvACAAMwBEAFMALgAiACAAfQAKAA=="
set "DESTINO=MENU"
set "VOLTAR=MENU"
set "PASSO=0"
set "METODO="
set "REGIAO="
set "FAIXA="
set "SDL="
set "BKP="
call :CARREGAR

:MENU
cls
echo.
echo  ==========================================================================================
echo   GUIA INTERATIVO DE DESBLOQUEIO  -  NEW NINTENDO 3DS XL  (CFW Luma3DS via boot9strap)
echo  ==========================================================================================
echo.
echo   Este guia segue o 3ds.hacks.guide, passo a passo, e pede confirmacao a cada acao fisica
echo   (virar o console, tirar o cartao, apertar botoes). Nada e feito no console pelo PC.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: voce parou no passo %PASSO% de %TOTAL%   ^(metodo: %METODO%  regiao: %REGIAO%^)
if not "%PASSO%"=="0" echo.
echo   [1] Comecar do inicio (passo 1)
echo   [2] Continuar de onde parei
echo   [3] Ir para um passo especifico
echo   [4] Requisitos, downloads e estrutura do cartao SD
echo   [5] Erros comuns e como corrigir
echo   [6] Como desfazer (remover o CFW / restaurar NAND)
echo   [7] Abrir links oficiais no navegador
echo   [8] Apagar o progresso salvo
echo   [9] Ferramentas do cartao SD (teste de velocidade, H2testw, migracao para cartao maior)
echo   [A] Modo sem acentos (use se o texto aparecer com caracteres estranhos)
echo   [0] Sair
echo.
choice /c 1234567890A /n /m "   Escolha uma opcao: "
if errorlevel 11 goto SEM_ACENTOS
if errorlevel 10 goto SAIR
if errorlevel 9 goto FERR_SD
if errorlevel 8 goto APAGAR_PROGRESSO
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
echo    1  Regras de ouro e avisos                     14  [skaterhax] Ajustar regiao, data e hora
echo    2  Confirmar o modelo (New 3DS XL)             15  [skaterhax] Rodar o exploit no navegador
echo    3  Ver versao do firmware e regiao             16  [skaterhax] SafeB9SInstaller e Luma3DS
echo    4  Teste: ja tem CFW? (Select ao ligar)        17  [MSET9] Instalar Python 3
echo    5  Escolher o metodo                           18  [MSET9] Preparacao - criar ID1 hackeado
echo    6  Bateria e carregador                        19  [MSET9] Mii Maker, Reset do banco de titulos
echo    7  Desligar e REMOVER o microSD (fisico)       20  [MSET9] Disparar o exploit (SD com console ligado)
echo    8  Backup completo do cartao no PC             21  [MSET9] SafeB9SInstaller e Luma3DS
echo    9  Verificar formato FAT32 e espaco            22  [MSET9] Remover o MSET9 (obrigatorio)
echo   10  Baixar os arquivos                          23  Finalizar: atualizacao do sistema
echo   11  Copiar arquivos para o SD e conferir        24  Finalizar: Rosalina (DSP e relogio)
echo   12  Colocar o SD no console (fisico)            25  Finalizar: script "finalize" no GodMode9
echo   13  Ligar e conectar ao Wi-Fi                   26  Backup da NAND no PC e verificacao final
echo   POS-INSTALACAO:  27  Universal-Updater e game patching   28  Pretendo Network (online)
echo                    29  Backup de saves com Checkpoint     30  Migrar para um cartao SD maior
echo.
set "N="
set /p "N=   Digite o numero do passo (1-%TOTAL%) ou ENTER para voltar: "
if "%N%"=="" goto MENU
:STRIP_ZERO
if "%N:~0,1%"=="0" if not "%N%"=="0" (set "N=%N:~1%" & goto STRIP_ZERO)
echo %N%| findstr /r "^[0-9][0-9]*$" >nul || goto IR_PARA
if %N% LSS 1 goto IR_PARA
if %N% GTR %TOTAL% goto IR_PARA
goto PASSO_%N%

rem ============================================================================
rem  BLOCO A - PREPARACAO
rem ============================================================================

:PASSO_1
cls
call :CABECALHO 1 "Regras de ouro e avisos (leia com calma)"
echo   O que voce vai instalar:
echo     - boot9strap  : carregador que roda antes do sistema (a "chave" do desbloqueio).
echo     - Luma3DS     : o custom firmware (CFW). Permite homebrew, backups e mais.
echo     - GodMode9    : ferramenta de manutencao usada no final para backup da NAND.
echo.
echo   Regras de ouro:
echo     1. NAO desligue o console durante a instalacao do boot9strap (tela do SafeB9SInstaller).
echo     2. Carregador conectado e bateria acima de 50%% durante todo o processo.
echo     3. Use SOMENTE os arquivos das releases oficiais indicadas neste guia.
echo     4. Nao misture tutoriais antigos (videos de 2019-2022 usam metodos que ja mudaram).
echo     5. Faca backup do cartao SD antes de mexer (o guia faz isso no passo 8).
echo     6. Se algo der errado, NAO tente "adivinhar": use a opcao [E] Erros deste guia
echo        ou o Discord Nintendo Homebrew (link na opcao 7 do menu).
echo.
echo   Risco real: com os metodos atuais (super-skaterhax / MSET9) o risco de brick e muito baixo
echo   desde que voce siga a ordem exata. O unico momento critico e o SafeB9SInstaller.
echo.
echo   Reversivel? Sim. No final voce tera um backup da NAND e existe um script oficial de
echo   remocao do CFW (opcao 6 do menu).
echo.
call :AGUARDAR "Li e entendi as regras. Pressione qualquer tecla para continuar"
call :FIM_PASSO 1
goto %DESTINO%

:PASSO_2
cls
call :CABECALHO 2 "Confirmar o modelo: New Nintendo 3DS XL"
echo   ACAO FISICA: pegue o console, feche a tampa e VIRE-O DE CABECA PARA BAIXO.
echo.
echo   Na parte de baixo ha uma etiqueta branca/prateada. Procure o codigo do modelo:
echo.
echo       +----------------------------------------------+
echo       :  New Nintendo 3DS XL                         :
echo       :  MODEL NO. / MODELO:  RED-001                :   ^<-- New 3DS XL (todas as regioes)
echo       :  SERIAL NO.  ....                            :
echo       +----------------------------------------------+
echo.
echo   Outras formas de confirmar:
echo     - Existe um "C-Stick" (bolinha cinza) acima dos botoes ABXY.
echo     - Existem os gatilhos ZL e ZR (alem de L e R).
echo     - Abaixo da tela inferior esta escrito "NEW" antes de "Nintendo 3DS XL".
echo.
echo   Tabela de modelos (so para referencia):
echo     RED-001 = New 3DS XL     KTR-001 = New 3DS      JAN-001 = New 2DS XL
echo     SPR-001 = 3DS XL antigo  CTR-001 = 3DS antigo   FTR-001 = 2DS antigo
echo.
call :PERGUNTA "   A etiqueta mostra RED-001 (New 3DS XL)?"
if errorlevel 2 goto MODELO_ERRADO
echo.
echo   OK: New 3DS XL confirmado. Pode virar o console de volta.
call :FIM_PASSO 2
goto %DESTINO%

:MODELO_ERRADO
echo.
echo   ATENCAO: este guia foi escrito para o New 3DS XL (RED-001).
echo     - KTR-001 (New 3DS) e JAN-001 (New 2DS XL): os MESMOS metodos funcionam. Pode continuar,
echo       apenas o local do slot SD/microSD muda (New 2DS XL: slot atras da tampa da esquerda).
echo     - CTR/SPR/FTR (modelos antigos): use OUTRO metodo (safecerthax). Va em 3ds.hacks.guide/get-started
echo       e selecione "Old 3DS/2DS". Este guia NAO serve para eles.
echo.
choice /c 123 /n /m "   [1] Continuar (New 3DS / New 2DS XL)   [2] Ver o roteiro safecerthax para Old 3DS/2DS   [3] Menu : "
if errorlevel 3 goto MENU
if errorlevel 2 goto SAFECERTHAX
call :FIM_PASSO 2
goto %DESTINO%

:PASSO_3
cls
call :CABECALHO 3 "Ver a versao do firmware e a regiao"
echo   ACAO: ligue o console (botao POWER, canto inferior direito da tela de baixo).
echo   Se pedir usuario/PIN de controle parental, entre normalmente.
echo.
echo   1. No menu HOME, toque no icone de chave inglesa "Configuracoes do Console" / "System Settings".
echo   2. No canto SUPERIOR DIREITO da tela de cima aparece a versao, por exemplo:
echo.
echo          Ver. 11.17.0-50U
echo               ^^      ^^  ^^
echo               :      :  +-- LETRA DA REGIAO:  U = USA   E = Europa   J = Japao   K = Coreia
echo               :      +----- versao do NVer (50)
echo               +------------ versao do sistema (11.17.0)
echo.
call :AGUARDAR "Pressione qualquer tecla quando estiver vendo a versao na tela"
echo.
echo   O texto comeca com "Ver." ?  (Se comecar com "Luma", "GM9", "B9S" ou outra coisa, o console JA tem CFW.)
choice /c SN /n /m "   [S] Comeca com Ver.   [N] Comeca com outra coisa : "
if errorlevel 2 goto JA_TEM_CFW
echo.
echo   Qual e a LETRA no final da versao?
choice /c UEJKO /n /m "   [U] USA   [E] Europa   [J] Japao   [K] Coreia   [O] outra (C/T) : "
if errorlevel 5 set "REGIAO=OUTRA"
if errorlevel 5 goto REGIAO_OUTRA
if errorlevel 4 set "REGIAO=KOR"
if errorlevel 3 if not errorlevel 4 set "REGIAO=JPN"
if errorlevel 2 if not errorlevel 3 set "REGIAO=EUR"
if not errorlevel 2 set "REGIAO=USA"
echo.
echo   Em qual faixa esta a versao do sistema?
choice /c 123 /n /m "   [1] 11.15 ate 11.17    [2] 11.4 ate 11.14    [3] abaixo de 11.4 : "
if errorlevel 3 set "FAIXA=3"
if errorlevel 2 if not errorlevel 3 set "FAIXA=2"
if not errorlevel 2 set "FAIXA=1"
echo.
echo   Anotado: regiao %REGIAO%, faixa de versao %FAIXA%.
call :FIM_PASSO 3
goto %DESTINO%

:REGIAO_OUTRA
echo.
echo   Regioes C (China) e T (Taiwan) nao existem em New 3DS XL de varejo comum.
echo   Confira a letra novamente. Se for mesmo C ou T, use 3ds.hacks.guide/get-started
echo   para o metodo especifico. Este guia continua so para U / E / J / K.
call :AGUARDAR "Pressione qualquer tecla para repetir o passo"
goto PASSO_3

:JA_TEM_CFW
cls
echo.
echo   ESTE CONSOLE JA TEM CUSTOM FIRMWARE.
echo   Nao siga este guia (instalar de novo por cima pode causar erros).
echo.
echo   O que fazer:
echo     - Para atualizar o Luma3DS / restaurar homebrew: 3ds.hacks.guide/restoring-updating-cfw
echo     - Para checar qual versao de Luma tem: desligue, segure SELECT e ligue (abre o menu do Luma).
echo     - Para remover tudo: opcao 6 do menu deste guia.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:PASSO_4
cls
call :CABECALHO 4 "Teste: o console ja tem CFW? (SELECT ao ligar)"
echo   Mesmo que o passo 3 tenha mostrado "Ver.", faca este teste (consoles usados podem ter CFW oculto).
echo.
echo   ACAO FISICA:
echo     1. Desligue o console COMPLETAMENTE: segure POWER por 1 segundo e toque em "Desligar" / "Power Off".
echo        (Fechar a tampa NAO desliga, so suspende.)
echo     2. Com o console desligado, SEGURE o botao SELECT (o pequeno, a esquerda abaixo da tela inferior).
echo     3. Sem soltar SELECT, aperte POWER e continue segurando SELECT por uns 3 segundos.
echo     4. Observe a tela.
echo.
call :AGUARDAR "Pressione qualquer tecla depois de fazer o teste"
echo.
echo   O que apareceu?
choice /c 12 /n /m "   [1] Menu HOME normal (sem CFW)    [2] Menu de configuracao do Luma3DS ou outra tela preta com texto : "
if errorlevel 2 goto JA_TEM_CFW
echo.
echo   OK: console sem CFW. Pode desligar ou deixar ligado no menu HOME.
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Escolher o metodo (recomendacao automatica)"
if "%FAIXA%"=="" (echo   Voce ainda nao informou a versao. Volte ao passo 3. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_3)
if "%FAIXA%"=="3" goto PRECISA_ATUALIZAR
set "REC=MSET9"
if "%FAIXA%"=="1" if "%REGIAO%"=="USA" set "REC=SKATER"
if "%FAIXA%"=="1" if "%REGIAO%"=="EUR" set "REC=SKATER"
if "%FAIXA%"=="1" if "%REGIAO%"=="KOR" set "REC=SKATER"
echo   Seus dados: New 3DS XL, regiao %REGIAO%, faixa de versao %FAIXA%.
echo.
echo   Metodos disponiveis para este console:
echo.
echo     super-skaterhax  - Exploit pelo NAVEGADOR do 3DS. Precisa de Wi-Fi. Nao precisa de Python.
echo                        New 3DS 11.15 a 11.17, regioes USA/EUR/KOR (JPN nao: erro 032-0420 no navegador).
echo                        Pode falhar algumas vezes (e normal repetir ate 10x).
echo.
echo     MSET9            - Exploit pelo cartao SD + script no PC (Python). Funciona SEM internet.
echo                        New 3DS 11.4 a 11.17, TODAS as regioes. Exige remover o cartao com o console LIGADO
echo                        (no New 3DS XL isso significa abrir a tampa traseira com ele ligado - da para fazer
echo                        com cuidado, o guia explica).
echo.
if "%REC%"=="SKATER" echo   METODO RECOMENDADO: super-skaterhax  ^(e o que o seletor oficial do 3ds.hacks.guide indica para o seu caso^)
if "%REC%"=="MSET9"  echo   METODO RECOMENDADO: MSET9  ^(e o que o seletor oficial do 3ds.hacks.guide indica para o seu caso^)
echo.
choice /c 12 /n /m "   [1] super-skaterhax    [2] MSET9    : "
if errorlevel 2 set "METODO=MSET9"
if not errorlevel 2 set "METODO=SKATER"
if "%METODO%"=="SKATER" if "%REGIAO%"=="JPN" echo   AVISO: skaterhax em console japones costuma falhar ^(erro 032-0420^). Prefira MSET9.
if "%METODO%"=="SKATER" if "%FAIXA%"=="2" echo   AVISO: skaterhax exige 11.15 ou superior. Na sua versao use MSET9.
echo.
echo   Metodo escolhido: %METODO%
call :FIM_PASSO 5
goto %DESTINO%

:PRECISA_ATUALIZAR
echo   Seu console esta abaixo de 11.4. Os metodos deste guia exigem 11.4 ou superior.
echo.
echo   METODO RECOMENDADO: atualizar o console para a versao mais recente (e seguro em console SEM CFW)
echo   e depois usar super-skaterhax ou MSET9.
echo.
echo     1. Conecte o console ao Wi-Fi (Configuracoes -^> Configuracoes da Internet).
echo     2. Configuracoes do Console -^> Outras Configuracoes -^> ultima aba -^> Atualizacao do Sistema.
echo     3. Aceite e aguarde. O console reinicia sozinho.
echo     4. Volte ao passo 3 deste guia e informe a nova versao.
echo.
echo   Se a atualizacao der erro: Configuracoes da Internet -^> sua rede -^> DNS = Automatico, Proxy = Nao.
echo   Se nao quiser atualizar, veja outras opcoes em 3ds.hacks.guide/get-started.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao passo 3"
goto PASSO_3

:PASSO_6
cls
call :CABECALHO 6 "Bateria e carregador"
echo   ACAO FISICA:
echo     1. Conecte o carregador original (ou compativel 4.6V) na porta do lado de tras do console.
echo     2. Confira que o LED laranja de carga (canto do console, perto da dobradica) esta aceso.
echo     3. Espere ate a bateria estar com pelo menos 50%% (icone de bateria no canto superior direito
echo        da tela de baixo no menu HOME, ou o LED laranja apagar = 100%%).
echo.
echo   Mantenha o carregador conectado durante TODO o restante do guia.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o carregador estiver conectado e a bateria acima de 50%%"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "Desligar e REMOVER o cartao microSD (acao fisica)"
echo   1. Desligue o console COMPLETAMENTE (segure POWER -^> "Desligar"). Espere a luz azul apagar.
echo   2. Feche a tampa. Desconecte o carregador so durante este passo.
echo   3. VIRE O CONSOLE DE CABECA PARA BAIXO sobre um pano ou superficie macia.
echo.
echo        PARTE DE BAIXO DO NEW 3DS XL (tampa traseira):
echo.
echo        +--------------------------------------------------------+
echo        :                                                        :
echo        :        [ etiqueta RED-001 ]                            :
echo        :                                                        :
echo        :   (o)                                            (o)   :   ^<-- 2 parafusos Phillips
echo        +---^^----------------------------------------------^^-----+       (cativos: afrouxam
echo            :        entalhe para levantar a tampa           :             mas NAO saem)
echo.
echo   4. Com uma chave Phillips #0 (ou #00), AFROUXE os dois parafusos da tampa (uns 10-15 giros).
echo      Eles ficam presos na tampa - nao force para tira-los.
echo   5. Coloque a unha ou uma palheta de plastico no ENTALHE da borda e levante a tampa a partir
echo      do lado dos parafusos. Ela sai inteira.
echo   6. Voce vera a bateria (bloco grande) e, ao lado dela, o slot do microSD.
echo   7. ANOTE a orientacao do cartao (lado da etiqueta / contatos dourados) antes de tirar.
echo   8. Empurre o microSD levemente para DENTRO: ele destrava e salta (slot com mola). Puxe-o.
echo.
echo   Dica: se o cartao original for de 4 GB, considere trocar por um microSD de 32-64 GB Classe 10
echo   de marca conhecida (SanDisk, Samsung, Kingston). Se trocar, copie TODO o conteudo do antigo para o novo.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o microSD estiver fora do console"
call :FIM_PASSO 7
goto %DESTINO%

:PASSO_8
cls
call :CABECALHO 8 "Backup completo do cartao no PC (automatico)"
echo   1. Coloque o microSD em um adaptador SD ou leitor USB e conecte ao PC.
echo   2. Abra "Este Computador" e veja qual LETRA o cartao recebeu (ex.: E:, F:).
echo      Dentro dele deve existir a pasta "Nintendo 3DS".
echo.
call :PEDIR_SD
if "%SDL%"=="" goto PASSO_8
set "BKP=%USERPROFILE%\Desktop\Backup_3DS_%DATE:/=-%"
set "BKP=%BKP: =_%"
echo.
echo   Vou copiar TUDO de %SDL%:\ para:
echo      %BKP%
echo   (robocopy, nao altera nada no cartao; pode demorar alguns minutos)
echo.
call :PERGUNTA "   Iniciar a copia agora?"
if errorlevel 2 goto PASSO_8_MANUAL
robocopy %SDL%:\ "%BKP%" /E /R:2 /W:2 /NP /NFL /NDL /XJ
if errorlevel 8 goto PASSO_8_FALHA
echo.
echo   Backup concluido em: %BKP%
echo   Guarde essa pasta. Ela permite restaurar o cartao exatamente como estava.
call :FIM_PASSO 8
goto %DESTINO%

:PASSO_8_MANUAL
echo.
echo   Manual: abra %SDL%:\ , selecione tudo (Ctrl+A), copie (Ctrl+C) e cole em uma pasta nova no PC.
call :AGUARDAR "Pressione qualquer tecla quando o backup manual terminar"
call :FIM_PASSO 8
goto %DESTINO%

:PASSO_8_FALHA
echo.
echo   robocopy relatou falha (codigo %ERRORLEVEL%). Causas provaveis:
echo     1. Cartao com setores ruins -^> rode: chkdsk %SDL%: /f   (em um Prompt como administrador)
echo     2. Leitor/adaptador ruim -^> troque o adaptador ou a porta USB.
echo     3. Letra errada -^> confira em "Este Computador".
call :AGUARDAR "Pressione qualquer tecla para repetir o passo"
goto PASSO_8

:PASSO_9
cls
call :CABECALHO 9 "Verificar formato FAT32, tamanho de cluster e espaco livre"
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_9
echo   Verificando a unidade %SDL%: ...
echo.
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "try{$v=Get-Volume -DriveLetter '%SDL%' -ErrorAction Stop; '{0};{1};{2}' -f $v.FileSystemType,[math]::Round($v.SizeRemaining/1GB,2),[math]::Round($v.Size/1GB,2)}catch{'?;?;?'}"`) do set "INFO=%%A"
for /f "tokens=1-3 delims=;" %%A in ("%INFO%") do (set "FS=%%A" & set "LIVRE=%%B" & set "TAM=%%C")
echo     Sistema de arquivos : %FS%
echo     Tamanho total       : %TAM% GB
echo     Espaco livre        : %LIVRE% GB
if exist "%SDL%:\Nintendo 3DS\" echo     Pasta "Nintendo 3DS" : encontrada ^(OK^)
if not exist "%SDL%:\Nintendo 3DS\" echo     Pasta "Nintendo 3DS" : NAO encontrada ^(o console cria ao ligar com o cartao; para MSET9 ela e obrigatoria^)
echo.
echo   Requisitos do 3DS:
echo     - Sistema de arquivos: FAT32 (exFAT e NTFS NAO funcionam; cartoes acima de 32 GB vem em exFAT).
echo     - Cluster de 32 KB e o ideal (formatacao padrao do Windows ate 32 GB ja usa 32 KB).
echo     - Espaco livre: minimo 1,3 GB para o backup da NAND no final (recomendado 2 GB ou mais).
echo.
if /i "%FS%"=="FAT32" echo   RESULTADO: formato OK.
if /i not "%FS%"=="FAT32" echo   RESULTADO: PRECISA FORMATAR EM FAT32. Veja abaixo.
echo.
echo   Como formatar em FAT32 (APAGA TUDO no cartao - voce ja fez o backup no passo 8):
echo     - Ate 32 GB : Este Computador -^> botao direito no cartao -^> Formatar -^> FAT32, "Tamanho da unidade de alocacao: 32 KB".
echo     - Acima de 32 GB: use a ferramenta "guiformat" (FAT32 Format, de Ridgecrop) com Allocation unit size = 32768.
echo       Depois copie de volta o conteudo do backup (passo 8) para o cartao.
echo.
choice /c SN /n /m "   [S] Testar a velocidade do cartao agora (200 MB, 1 min)    [N] Pular : "
if not errorlevel 2 call :TESTE_VELOCIDADE
echo.
echo   Para detectar cartao FALSO (capacidade mentirosa) use o H2testw: https://www.heise.de/download/product/h2testw-50539
echo   (grave o cartao inteiro; "Test finished without errors" = cartao real). Demora 1 h por 64 GB.
call :AGUARDAR "Pressione qualquer tecla quando o cartao estiver em FAT32 com espaco suficiente"
call :FIM_PASSO 9
goto %DESTINO%

:PASSO_10
cls
call :CABECALHO 10 "Baixar os arquivos"
if "%METODO%"=="" (echo   Metodo nao definido. Volte ao passo 5. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_5)
echo   Crie uma pasta no PC, por exemplo:  %USERPROFILE%\Desktop\3DS_Downloads
echo   e baixe para la. NAO extraia ainda; o passo 11 explica onde cada coisa vai.
echo.
echo   COMUNS A TODOS OS METODOS:
echo     [A] Luma3DS (release mais recente, arquivo Luma3DSvXX.X.zip)
echo         https://github.com/LumaTeam/Luma3DS/releases/latest
echo     [B] finalize.romfs
echo         https://github.com/hacks-guide/finalize/releases/latest/download/finalize.romfs
echo     [C] x_finalize_helper.firm
echo         https://github.com/hacks-guide/finalize/releases/latest/download/x_finalize_helper.firm
echo.
if "%METODO%"=="SKATER" echo   ESPECIFICO DO super-skaterhax:
if "%METODO%"=="SKATER" echo     [D] Super-skaterhax .zip para a SUA regiao ^(%REGIAO%^) e SUA versao ^(ex.: 11.17.0-50^)
if "%METODO%"=="SKATER" echo         https://skater.nintendohomebrew.com
if "%METODO%"=="MSET9"  echo   ESPECIFICO DO MSET9:
if "%METODO%"=="MSET9"  echo     [D] MSET9 ^(arquivo MSET9-vX.X.zip da release mais recente^)
if "%METODO%"=="MSET9"  echo         https://github.com/hacks-guide/MSET9/releases/latest
if "%METODO%"=="MSET9"  echo     [E] Python 3 ^(instalador do site oficial; NAO use a versao da Microsoft Store^)
if "%METODO%"=="MSET9"  echo         https://www.python.org/downloads/windows/
echo.
choice /c SN /n /m "   [S] Abrir todos esses links no navegador agora    [N] Ja baixei / vou baixar manualmente : "
if errorlevel 2 goto PASSO_10_CHECK
start "" "https://github.com/LumaTeam/Luma3DS/releases/latest"
if "%METODO%"=="SKATER" start "" "https://skater.nintendohomebrew.com"
if "%METODO%"=="MSET9"  start "" "https://github.com/hacks-guide/MSET9/releases/latest"
if "%METODO%"=="MSET9"  start "" "https://www.python.org/downloads/windows/"
echo.
echo   Tentando baixar finalize.romfs e x_finalize_helper.firm direto para a area de trabalho...
set "DL=%USERPROFILE%\Desktop\3DS_Downloads"
if not exist "%DL%" mkdir "%DL%"
curl.exe -L --fail -o "%DL%\finalize.romfs" "https://github.com/hacks-guide/finalize/releases/latest/download/finalize.romfs" && echo     OK: %DL%\finalize.romfs
curl.exe -L --fail -o "%DL%\x_finalize_helper.firm" "https://github.com/hacks-guide/finalize/releases/latest/download/x_finalize_helper.firm" && echo     OK: %DL%\x_finalize_helper.firm
echo   (Se apareceu erro do curl, baixe os dois pelo navegador com os links [B] e [C].)
:PASSO_10_CHECK
echo.
call :AGUARDAR "Pressione qualquer tecla quando todos os arquivos estiverem baixados"
call :FIM_PASSO 10
goto %DESTINO%

:PASSO_11
cls
call :CABECALHO 11 "Copiar os arquivos para o cartao SD e conferir a estrutura"
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_11
echo   ESTRUTURA FINAL ESPERADA na RAIZ do cartao (%SDL%:\):
echo.
echo     %SDL%:\
echo     :-- boot.firm                      (de dentro do Luma3DS .zip)
echo     :-- boot.3dsx                      (de dentro do Luma3DS .zip)
echo     :-- finalize.romfs                 (download [B])
echo     :-- luma\
echo     :     +-- payloads\
echo     :           +-- x_finalize_helper.firm   (download [C])
echo     :-- Nintendo 3DS\                  (ja existe; NAO mexa)
if "%METODO%"=="SKATER" echo     :-- ^(TODO o conteudo do Super-skaterhax .zip, na raiz, sobrescrevendo se perguntar^)
if "%METODO%"=="MSET9"  echo     :-- ^(TODO o conteudo do MSET9 .zip, na raiz, sobrescrevendo se perguntar^)
if "%METODO%"=="MSET9"  echo     :-- MSET9-Windows.bat, mset9.py, boot9strap\, SafeB9S.bin ...  ^(vem do MSET9 .zip^)
echo.
echo   Como fazer:
echo     1. Abra o Luma3DS .zip -^> copie boot.firm e boot.3dsx para a raiz do cartao.
echo        Use o Explorador do Windows ou 7-Zip. Evite WinRAR (ja corrompeu boot.firm em alguns casos).
echo     2. Copie finalize.romfs para a raiz do cartao.
echo     3. Crie a pasta luma e dentro dela a pasta payloads (este script cria para voce).
echo     4. Copie x_finalize_helper.firm para dentro de %SDL%:\luma\payloads\
if "%METODO%"=="SKATER" echo     5. Abra o Super-skaterhax .zip e copie TODO o conteudo para a raiz. Se perguntar, SUBSTITUA.
if "%METODO%"=="MSET9"  echo     5. Abra o MSET9 .zip e copie TODO o conteudo para a raiz. Se perguntar, SUBSTITUA.
echo.
if not exist "%SDL%:\luma\payloads\" (mkdir "%SDL%:\luma\payloads" && echo   Criei a pasta %SDL%:\luma\payloads\ )
choice /c SA /n /m "   [S] Abrir o cartao no Explorador e a pasta de downloads    [A] Ja copiei, so conferir : "
if errorlevel 2 goto PASSO_11_VERIFICA
start "" "%SDL%:\"
if exist "%USERPROFILE%\Desktop\3DS_Downloads" start "" "%USERPROFILE%\Desktop\3DS_Downloads"
call :AGUARDAR "Pressione qualquer tecla quando terminar de copiar"
:PASSO_11_VERIFICA
echo.
echo   CONFERENCIA AUTOMATICA:
set "FALTA=0"
call :CHECA "%SDL%:\boot.firm"
call :CHECA "%SDL%:\boot.3dsx"
call :CHECA "%SDL%:\finalize.romfs"
call :CHECA "%SDL%:\luma\payloads\x_finalize_helper.firm"
if "%METODO%"=="MSET9" call :CHECA "%SDL%:\MSET9-Windows.bat"
if "%METODO%"=="MSET9" call :CHECA "%SDL%:\mset9.py"
if "%METODO%"=="MSET9" call :CHECA "%SDL%:\SafeB9S.bin"
if "%METODO%"=="MSET9" call :CHECA "%SDL%:\boot9strap\boot9strap.firm"
if "%METODO%"=="MSET9" call :CHECA "%SDL%:\boot9strap\boot9strap.firm.sha"
if "%METODO%"=="SKATER" call :CHECA "%SDL%:\boot9strap\boot9strap.firm"
if "%METODO%"=="SKATER" call :CHECA "%SDL%:\SafeB9S.bin"
if "%METODO%"=="SKATER" call :CHECA "%SDL%:\arm11code.bin"
echo.
if "%FALTA%"=="0" echo   RESULTADO: todos os arquivos esperados estao no lugar.
if not "%FALTA%"=="0" echo   RESULTADO: faltam %FALTA% arquivo^(s^). Copie os que estao marcados como FALTA e repita este passo.
if not "%FALTA%"=="0" echo   ^(Se o nome do arquivo do exploit mudou em uma release nova, confira dentro do .zip; o essencial e
if not "%FALTA%"=="0" echo    ter TUDO do .zip na raiz do cartao.^)
echo.
echo   Por ultimo: no Windows, clique em "Remover hardware com seguranca" antes de tirar o cartao.
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Colocar o microSD de volta no console (acao fisica)"
echo   1. No PC: "Remover hardware com seguranca" -^> tire o cartao do adaptador.
echo   2. Console ainda DESLIGADO e de cabeca para baixo, tampa traseira aberta.
echo   3. Encaixe o microSD no slot NA MESMA ORIENTACAO anotada no passo 7 (normalmente etiqueta para cima,
echo      contatos dourados para baixo, voltados para a placa). Empurre ate ouvir o "clique" da trava.
echo      Nunca force: se nao entrar suave, a orientacao esta errada.
echo   4. Recoloque a tampa traseira: encaixe primeiro o lado da dobradica, depois pressione o lado dos parafusos.
echo   5. Aperte os dois parafusos sem exagerar (so ate parar de girar).
echo   6. Vire o console de volta e reconecte o carregador.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o cartao estiver no console, tampa fechada e carregador conectado"
call :FIM_PASSO 12
goto %DESTINO%

:PASSO_13
cls
call :CABECALHO 13 "Ligar o console e (se necessario) conectar ao Wi-Fi"
echo   1. Ligue o console. Espere o menu HOME.
echo   2. Se aparecer aviso de "cartao SD nao reconhecido": desligue, refaca o passo 12 (cartao mal encaixado
echo      ou formato errado - veja passo 9).
if "%METODO%"=="SKATER" echo   3. O super-skaterhax PRECISA de internet. Configuracoes do Console -^> Configuracoes da Internet -^>
if "%METODO%"=="SKATER" echo      Configuracoes de Conexao -^> escolha uma conexao -^> conecte a sua rede Wi-Fi ^(2,4 GHz; o 3DS nao usa 5 GHz^).
if "%METODO%"=="SKATER" echo      Teste a conexao ate aparecer "Conexao bem-sucedida".
if "%METODO%"=="MSET9"  echo   3. O MSET9 NAO precisa de internet. Se o console pedir para conectar, pode ignorar por enquanto.
echo   4. Confirme que o icone do cartao SD aparece no menu HOME (canto superior esquerdo mostra os blocos livres).
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver ligado no menu HOME"
if "%METODO%"=="MSET9" call :FIM_PASSO 13 17
if "%METODO%"=="SKATER" call :FIM_PASSO 13 14
goto %DESTINO%

rem ============================================================================
rem  BLOCO B1 - SUPER-SKATERHAX
rem ============================================================================

:PASSO_14
cls
call :CABECALHO 14 "[super-skaterhax] Ajustar regiao do perfil, data e hora"
echo   No console, ligado no menu HOME:
echo.
echo   1. Configuracoes do Console -^> "Outras Configuracoes" / "Other Settings".
echo   2. Aba "Perfil" / "Profile" -^> "Configuracoes de Regiao" / "Region Settings".
echo   3. Escolha EXATAMENTE conforme a regiao do seu console:
echo        USA : pais "United States"  -^> estado: "Do Not Set" / "Nao definir"
echo        EUR : pais "United Kingdom" -^> regiao: "Do Not Set" / "Nao definir"
echo        KOR : pais "Daehan Minguk (Coreia)"        -^> "nao definir"
echo      (Isso e temporario; depois do desbloqueio voce pode voltar para Brasil.)
echo   4. Ainda em Outras Configuracoes -^> "Data e Hora" / "Date and Time":
echo        "Data de Hoje" e "Hora Atual" = data e hora REAIS de agora.
echo   5. Saia das Configuracoes (botao HOME ou "Fechar").
echo.
call :AGUARDAR "Pressione qualquer tecla quando regiao, data e hora estiverem ajustadas"
call :FIM_PASSO 14
goto %DESTINO%

:PASSO_15
cls
call :CABECALHO 15 "[super-skaterhax] Rodar o exploit no Navegador da Internet"
if "%REGIAO%"=="KOR" set "URLSK=https://skater.686178.xyz/go/korea"
if not "%REGIAO%"=="KOR" set "URLSK=https://skater.686178.xyz/go/super"
echo   Siga EXATAMENTE nesta ordem (e o procedimento oficial atual):
echo.
echo    1. Abra o "Navegador da Internet" (icone do globo no menu HOME).
echo    2. Toque no icone de 3 linhas ([menu]) no canto INFERIOR DIREITO da tela de baixo.
echo    3. Toque em Configuracoes -^> role ate o fim -^> "Redefinir Dados Salvos" / "Reset Save Data"
echo       -^> "Apagar Tudo" / "Clear All" -^> "Apagar" -^> OK.  (O navegador fecha.)
echo    4. Abra o Navegador de novo.
echo    5. Toque em "Avancar"/"Next" -^> escolha "Google" -^> OK -^> OK.
echo    6. Toque na barra de endereco no topo da tela de baixo e digite, sem errar:
echo.
echo            %URLSK%
echo.
echo    7. Toque em "Abrir"/"Open" e espere a pagina carregar.
echo    8. Toque no icone [menu] -^> "Adicionar aos Favoritos" / "Add to Bookmarks".
echo    9. Toque no icone [menu] -^> Configuracoes -^> "Apagar Cookies" / "Delete Cookies" -^> Sim.
echo   10. Aperte HOME para voltar ao menu HOME e IMEDIATAMENTE abra o Navegador de novo.
echo   11. Espere a pagina carregar por completo e toque no botao "GO GO!".
echo   12. Espere carregar e aperte (A) para fechar o pop-up.
echo   13. Deve aparecer a tela do "Homebrew Launcher" com uma lista de apps.
echo.
echo   Se der erro, veja a tabela abaixo (e NORMAL precisar repetir varias vezes):
echo     - Mensagem de erro BRANCA  : repita a partir do item 10 (ate 10 tentativas). Entre uma e outra,
echo                                  troque o idioma do console (Configuracoes -^> Outras -^> Idioma) e tente de novo.
echo     - Tela PRETA com erro      : algum arquivo do .zip nao esta na raiz do cartao -^> refaca o passo 11.
echo     - Tela AMARELA             : desligue o console e repita a partir do item 1.
echo     - Aparece so a palavra "Text": o console e um 3DS antigo, nao New. Use MSET9/safecerthax.
echo     - Console TRAVOU           : segure POWER ate desligar e repita a partir do item 1.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o Homebrew Launcher aparecer na tela"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "[super-skaterhax] nimdsphax -> SafeB9SInstaller -> Luma3DS"
echo   A PARTE CRITICA. Console no carregador. NAO desligue, NAO tire o cartao ate o passo terminar.
echo.
echo   1. No Homebrew Launcher, toque em "nimdsphax" na lista e aperte (A).
echo   2. A tela deve trocar para o SafeB9SInstaller (fundo preto, texto "SafeB9SInstaller").
echo      Se em vez disso o console travar/desligar: espere 10 s, ligue e refaca o passo 15.
echo   3. A tela de CIMA mostra "Input the key combo" seguida de uma sequencia de botoes.
echo      Aperte EXATAMENTE os botoes mostrados, na ordem (ex.: ? ? -^> ? A).
echo      Caso a tela de cima esteja em branco e a de baixo mostre "Crypto Status - all checks passed",
echo      aperte as cegas: Esquerda, Baixo, Direita, Cima, A  (no D-Pad).
echo   4. Espere as 7 etapas na tela de baixo ficarem VERDES ("Installing boot9strap ... done").
echo   5. Aperte (A) para reiniciar.
echo   6. O console reinicia no "Luma3DS configuration" (tela preta com opcoes).
echo      NAO mude nada. Aperte START para salvar e reiniciar.
echo   7. O console volta ao menu HOME normal. Pronto: o CFW esta instalado.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver de volta no menu HOME"
call :FIM_PASSO 16 23
goto %DESTINO%

rem ============================================================================
rem  BLOCO B2 - MSET9 (CLI, Windows)
rem ============================================================================

:PASSO_17
cls
call :CABECALHO 17 "[MSET9] Instalar o Python 3 no PC"
echo   1. Rode o instalador baixado de python.org (passo 10).
echo   2. Na PRIMEIRA tela marque "Add python.exe to PATH" (embaixo) e clique em "Install Now".
echo   3. Feche e reabra este guia depois de instalar (para o PATH atualizar), se o teste abaixo falhar.
echo.
echo   Testando se o Python esta acessivel...
for /f "delims=" %%P in ('where python 2^>nul') do call :CHECA_STORE "%%P"
python --version 2>nul && goto PASSO_17_OK
py -3 --version 2>nul && goto PASSO_17_OK
echo   Python NAO encontrado (ou e o atalho da Microsoft Store, que nao serve).
echo   Instale pelo python.org marcando "Add python.exe to PATH" e depois FECHE e REABRA este .bat.
call :AGUARDAR "Pressione qualquer tecla"
call :FIM_PASSO 17
goto %DESTINO%
:PASSO_17_OK
echo   OK: Python encontrado.
call :FIM_PASSO 17
goto %DESTINO%

:PASSO_18
cls
call :CABECALHO 18 "[MSET9] Secao I - Preparacao: criar o ID1 hackeado"
echo   O cartao precisa estar no PC (se esta no console: desligue o console e repita o passo 7).
echo   O conteudo do MSET9 .zip precisa estar na RAIZ do cartao (passo 11).
echo.
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_18
echo   1. Abra a raiz do cartao (%SDL%:\) e de DUPLO CLIQUE em "MSET9-Windows" (MSET9-Windows.bat).
echo      Se o Windows avisar sobre seguranca, "Mais informacoes" -^> "Executar assim mesmo".
echo   2. O script pergunta o MODELO e a VERSAO: escolha New 3DS e a sua versao (ex.: 11.17).
echo   3. Digite 1 -^> "Create MSET9 ID1" e depois 1 de novo para aceitar o aviso.
echo   4. Deve aparecer:  "Created hacked ID1"
echo   5. Feche o script (0).
echo.
choice /c SN /n /m "   [S] Abrir a raiz do cartao agora    [N] Ja abri : "
if not errorlevel 2 start "" "%SDL%:\"
call :AGUARDAR "Pressione qualquer tecla quando aparecer 'Created hacked ID1'"
echo.
echo   6. "Remover hardware com seguranca" e tire o cartao do PC.
call :FIM_PASSO 18
goto %DESTINO%

:PASSO_19
cls
call :CABECALHO 19 "[MSET9] Mii Maker + Reset do banco de titulos + conferir 'Ready'"
echo   ACAO FISICA: coloque o cartao no console (passo 12: vire, abra tampa, encaixe, feche).
echo.
echo   No console:
echo    1. Ligue o console.
echo    2. Abra o "Mii Maker" (icone com o Mii). Espere a tela de boas-vindas aparecer e volte ao HOME.
echo    3. Configuracoes do Console -^> "Gerenciamento de Dados" / "Data Management" -^> "Nintendo 3DS"
echo       -^> "Programas" / "Software" -^> "Reiniciar" / "Reset" -^> confirme.
echo       (Se NAO aparecer o botao Reset, tudo bem: continue.)
echo    4. DESLIGUE o console completamente.
echo.
echo   ACAO FISICA: tire o cartao de novo (passo 7) e coloque no PC.
echo.
echo   No PC:
echo    5. Rode MSET9-Windows.bat de novo, escolha modelo e versao.
echo    6. A tela de status deve mostrar "Ready" (e NAO "Not ready"). Se estiver "Not ready", o script diz o que
echo       falta (HOME Menu extdata / Mii Maker extdata / Title database) -^> repita o item correspondente.
echo    7. Digite 0 para fechar. "Remover hardware com seguranca".
echo.
echo   ACAO FISICA: coloque o cartao de volta no console (passo 12). Deixe o console DESLIGADO.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o status for 'Ready' e o cartao estiver no console desligado"
call :FIM_PASSO 19
goto %DESTINO%

:PASSO_20
cls
call :CABECALHO 20 "[MSET9] Secao II - Disparar o exploit (remover o SD com o console LIGADO)"
echo   Siga EXATAMENTE. Nao aperte nada alem do indicado. Nao toque na tela de baixo fora do indicado.
echo.
echo   PREPARE ANTES: chave Phillips na mao, console no carregador, tampa traseira com os parafusos
echo   ja AFROUXADOS (pode deixar a tampa so encostada durante este passo).
echo.
echo    1. Ligue o console. Na tela do menu HOME, use o D-Pad para deixar o cursor em cima de
echo       "Configuracoes do Console" (System Settings). Nao abra nada mais.
echo    2. Aperte (A) para abrir as Configuracoes do Console.
echo    3. Toque em "Gerenciamento de Dados" -^> "Nintendo 3DS" -^> "Dados Extras" / "Extra Data".
echo    4. Pare. Nao aperte botoes, nao toque na tela.
echo    5. ACAO FISICA (com o console LIGADO): vire o console de lado com cuidado, levante a tampa traseira,
echo       empurre o microSD para destravar e RETIRE-O. A tela do console vai piscar e mostrar que nao ha cartao.
echo       Isso e esperado. Deixe o console ligado e apoiado.
echo    6. Coloque o cartao no PC. Rode MSET9-Windows.bat, escolha modelo e versao.
echo    7. Digite 3 -^> "Inject MSET9". Deve aparecer: "MSET9 successfully injected!"
echo    8. Feche o script (0), "Remover hardware com seguranca", tire o cartao do PC.
echo    9. ACAO FISICA: coloque o cartao de volta no console (ainda ligado, na tela de Dados Extras),
echo       sem apertar botoes nem tocar na tela.
echo   10. O console deve carregar sozinho a tela do SafeB9SInstaller em ate 10 segundos.
echo.
echo   Se apareceu tela VERMELHA, ou ficou carregando por mais de 10 s: FALHOU. Segure POWER ate desligar,
echo   coloque o SD no PC, rode o MSET9 e use a opcao 4 (remover trigger). Verifique modelo/versao e
echo   repita o passo. (Ver tambem [E] Erros -^> MSET9.)
echo.
call :AGUARDAR "Pressione qualquer tecla quando o SafeB9SInstaller aparecer"
call :FIM_PASSO 20
goto %DESTINO%

:PASSO_21
cls
call :CABECALHO 21 "[MSET9] Secao III - SafeB9SInstaller -> Luma3DS"
echo   A PARTE CRITICA. Console no carregador. NAO desligue, NAO tire o cartao ate o passo terminar.
echo.
echo   1. A tela de CIMA mostra "Input the key combo" e uma sequencia de botoes. Aperte EXATAMENTE
echo      os botoes mostrados, na ordem.
echo      Se a tela de cima estiver em BRANCO e a de baixo mostrar "Crypto Status - all checks passed",
echo      aperte as cegas no D-Pad: Esquerda, Baixo, Direita, Cima, A.
echo   2. Espere as 7 etapas na tela de baixo ficarem VERDES.
echo   3. Aperte (A) para reiniciar.
echo   4. O console reinicia no "Luma3DS configuration". NAO mude nada. Aperte START.
echo   5. O console volta ao menu HOME. O CFW esta instalado - mas AINDA FALTA remover o MSET9.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver de volta no menu HOME"
call :FIM_PASSO 21
goto %DESTINO%

:PASSO_22
cls
call :CABECALHO 22 "[MSET9] Secao IV - Remover o MSET9 (OBRIGATORIO)"
echo   Se pular isso, apps vao travar e o script 'finalize' vai dar erro #18.
echo.
echo   1. DESLIGUE o console completamente.
echo   2. ACAO FISICA: tire o cartao (passo 7) e coloque no PC.
echo   3. Rode MSET9-Windows.bat, escolha modelo e versao.
echo   4. Se o status mostrar "Injected": digite 4 (remove o arquivo de trigger). Se ja mostrar "Ready", pule.
echo   5. Digite 5 -^> "Remove MSET9". Deve aparecer: "Successfully removed MSET9!"
echo   6. Feche o script (0). "Remover hardware com seguranca".
echo   7. ACAO FISICA: coloque o cartao de volta no console e feche a tampa com os parafusos (passo 12).
echo.
call :AGUARDAR "Pressione qualquer tecla quando aparecer 'Successfully removed MSET9!' e o cartao estiver no console"
call :FIM_PASSO 22
goto %DESTINO%

rem ============================================================================
rem  BLOCO C - FINALIZACAO (comum)
rem ============================================================================

:PASSO_23
cls
call :CABECALHO 23 "Finalizar (1/4): atualizacao do sistema (segura com Luma3DS)"
echo   Com boot9strap + Luma3DS instalados, atualizar o sistema e SEGURO e recomendado.
echo.
echo   1. Ligue o console. Conecte ao Wi-Fi se ainda nao estiver (Configuracoes -^> Configuracoes da Internet).
echo   2. Configuracoes do Console -^> "Outras Configuracoes" -^> ultima aba -^> "Atualizacao do Sistema".
echo   3. Aceite. Se disser que ja esta atualizado, otimo.
echo   4. Se der erro: Configuracoes da Internet -^> sua rede -^> alterar -^> DNS "Automatico" e Proxy "Nao";
echo      tente de novo. Se persistir, veja [E] Erros -^> "Nao consigo atualizar".
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver atualizado (ou ja estava)"
call :FIM_PASSO 23
goto %DESTINO%

:PASSO_24
cls
call :CABECALHO 24 "Finalizar (2/4): Rosalina - dump do DSP e ajuste do relogio"
echo   O Rosalina e o menu do Luma3DS que abre por cima de qualquer tela.
echo.
echo   1. No menu HOME, segure ao mesmo tempo:   L  +  D-Pad BAIXO  +  SELECT
echo      (L e o gatilho superior esquerdo; SELECT e o botao pequeno da esquerda abaixo da tela.)
echo   2. Abre um menu preto "Rosalina menu". Use o D-Pad e (A):
echo   3. "Miscellaneous options" -^> "Dump DSP firmware" -^> espere "DSP firmware dumped" -^> aperte (B).
echo   4. "Nullify user time offset" -^> aperte (B) para confirmar.
echo   5. Aperte (B) duas vezes para fechar o Rosalina.
echo.
echo   Se o Rosalina NAO abrir: o Luma nao esta rodando -^> desligue, segure SELECT ao ligar; se nao aparecer o
echo   menu do Luma, o boot.firm nao esta na raiz do cartao -^> refaca o passo 11.
echo.
call :AGUARDAR "Pressione qualquer tecla quando os dois itens estiverem feitos"
call :FIM_PASSO 24
goto %DESTINO%

:PASSO_25
cls
call :CABECALHO 25 "Finalizar (3/4): script 'finalize' no GodMode9 (instala apps e faz backup da NAND)"
echo   Requer: finalize.romfs na raiz e luma\payloads\x_finalize_helper.firm (passo 11), e no minimo
echo   1,3 GB livres no cartao (passo 9).
echo.
echo   1. DESLIGUE o console completamente.
echo   2. SEGURE o botao (X) e, sem soltar, aperte POWER. Continue segurando X ate aparecer uma tela preta
echo      com texto (e o GodMode9 sendo carregado pelo helper).
echo   3. Se perguntar sobre idioma/teclado, escolha e confirme. Se perguntar "backup essential files?"
echo      responda (A) Yes. Se perguntar sobre ajustar o relogio (RTC), pode confirmar.
echo   4. Aperte o botao HOME -^> abre o menu de acoes -^> "Scripts..." -^> "finalize".
echo   5. Siga o que o script pede na tela. Ele vai:
echo        - pedir para "unlock SysNAND writing": digite a combinacao de botoes que ele mostra;
echo        - copiar os apps (FBI, Anemone3DS, Checkpoint, Universal-Updater, Homebrew Launcher...);
echo        - fazer o BACKUP DA NAND (demora alguns minutos; barra de progresso);
echo        - limpar os arquivos do exploit do cartao.
echo   6. No final aparece "Setup complete!". Aperte (A): o console desliga.
echo.
echo   Erros do script (o numero aparece na tela):
echo     #02 falta essential.exefs -^> reinicie no GodMode9 (segure START ao ligar) e aceite o backup dos essenciais.
echo     #04 / #06 sem espaco -^> libere 1,3 GB (mova temporariamente a pasta Nintendo 3DS para o PC... e devolva depois).
echo     #18a/#18b MSET9 detectado -^> aceite: o script remove; ou refaca o passo 22.
echo     #22 finalize.romfs invalido -^> baixe de novo (passo 10) e substitua.
echo.
call :AGUARDAR "Pressione qualquer tecla quando aparecer 'Setup complete!' e o console desligar"
call :FIM_PASSO 25
goto %DESTINO%

:PASSO_26
cls
call :CABECALHO 26 "Finalizar (4/4): guardar o backup da NAND no PC e verificar tudo"
echo   ACAO FISICA: com o console desligado, tire o cartao (passo 7) e coloque no PC.
echo.
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_26
set "NANDBKP=%USERPROFILE%\Desktop\Backup_NAND_New3DSXL"
echo   Vou copiar %SDL%:\gm9\backups\ para %NANDBKP%
echo   (contem a NAND completa ~1,3 GB + essential.exefs: e o seu "seguro de vida" contra brick)
echo.
if not exist "%SDL%:\gm9\backups\" echo   AVISO: a pasta gm9\backups nao existe no cartao. O backup nao foi feito - refaca o passo 25.
if exist "%SDL%:\gm9\backups\" (robocopy "%SDL%:\gm9\backups" "%NANDBKP%" /E /R:2 /W:2 /NP /NFL /NDL & echo   Copiado. & dir /b "%NANDBKP%")
echo.
echo   Guarde essa pasta em 2 lugares (PC + nuvem/HD externo). Depois de copiar, voce PODE apagar do cartao
echo   os dois arquivos grandes *_sysnand_*.bin e .bin.sha para liberar espaco. MANTENHA o essential.exefs.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o backup estiver salvo no PC"
echo.
echo   ACAO FISICA: devolva o cartao ao console, feche a tampa, aperte os parafusos, vire o console.
echo.
echo   VERIFICACAO FINAL (faca as 4):
echo     1. Ligue normalmente -^> menu HOME aparece; novos icones: FBI, Anemone3DS, Checkpoint, Universal-Updater,
echo        Homebrew Launcher.  (Se nao aparecerem, o cartao nao foi lido: reencaixe.)
echo     2. Desligue; segure SELECT e ligue -^> aparece o "Luma3DS configuration" (aperte START para sair).
echo     3. Desligue; segure START e ligue -^> aparece o GodMode9 (aperte R + START para desligar... ou POWER).
echo     4. No HOME, L + Baixo + SELECT -^> abre o Rosalina (B para fechar).
echo.
echo   Se quiser, volte a regiao do perfil para Brasil (Configuracoes -^> Outras -^> Perfil -^> Regiao).
echo.
call :AGUARDAR "Pressione qualquer tecla quando as 4 verificacoes passarem"
call :FIM_PASSO 26
goto %DESTINO%

rem ============================================================================
rem  BLOCO D - POS-INSTALACAO
rem ============================================================================

:PASSO_27
cls
call :CABECALHO 27 "Pos-instalacao (1/4): Universal-Updater e game patching do Luma"
echo   UNIVERSAL-UPDATER (loja de homebrew, ja instalada pelo finalize)
echo     1. No menu HOME abra "Universal-Updater". Precisa de Wi-Fi.
echo     2. Aba de busca (lupa) -^> instale o que quiser. Recomendados:
echo          Nimbus         (troca entre Nintendo Network e Pretendo - passo 28)
echo          ftpd           (transferir arquivos pelo Wi-Fi sem tirar o cartao)
echo          TWiLight Menu++ (roda jogos de DS/GBA/NES/SNES pelo cartao SD)
echo          GodMode9 e Luma3DS (para atualizar depois: "Update" na propria loja)
echo     3. Apps instalados aparecem no HOME apos reiniciar ou como .3dsx no Homebrew Launcher.
echo.
echo   GAME PATCHING (traducoes, mods, patches de widescreen/60fps)
echo     4. Desligue; segure SELECT e ligue -^> menu do Luma3DS -^> marque com (A) "Enable game patching" -^> START.
echo     5. Patches ficam em  SD:\luma\titles\^<TitleID^>\   com os arquivos code.ips (ou .bps) e/ou pasta romfs\.
echo        O TitleID de cada jogo aparece no FBI -^> Titles -^> jogo (16 caracteres, ex.: 00040000000EDF00).
echo     6. Traducoes PT-BR: procure o patch do jogo no site do grupo tradutor; a maioria ja vem na estrutura luma\titles.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o Universal-Updater tiver instalado pelo menos o Nimbus"
call :FIM_PASSO 27
goto %DESTINO%

:PASSO_28
cls
call :CABECALHO 28 "Pos-instalacao (2/4): Pretendo Network (online de volta)"
echo   A Nintendo Network desligou em 2024. A Pretendo Network e o servidor alternativo da comunidade
echo   (Miiverse, online de alguns jogos, lista de amigos). Documentacao: https://pretendo.network/docs/install/3ds
echo.
echo   Requisitos: Luma3DS atualizado (13.0 ou superior; o Universal-Updater atualiza) e Nimbus instalado.
echo.
echo   1. Abra o Nimbus no HOME -^> escolha "Pretendo" -^> confirme. O console reinicia.
echo   2. Crie a conta PNID no proprio console: Configuracoes do Console -^> Configuracoes de Nintendo Network ID
echo      -^> "Criar" -^> siga (o Nimbus redireciona para os servidores da Pretendo). Se ja tinha NNID, crie uma PNID nova.
echo   3. Confirme em https://pretendo.network/account (login com a PNID) que o console apareceu.
echo   4. Para voltar a Nintendo Network (por exemplo, para atualizar o sistema): Nimbus -^> "Nintendo".
echo.
echo   Erros comuns: 002-0102 (banido/nao-oficial) = esta no servidor errado, troque no Nimbus; 022-2634 = NNID
echo   nao vinculada, use a PNID; erro ao criar conta = data/hora do console erradas.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver na Pretendo com a PNID criada (ou se for pular)"
call :FIM_PASSO 28
goto %DESTINO%

:PASSO_29
cls
call :CABECALHO 29 "Pos-instalacao (3/4): backup de saves com o Checkpoint (e copia para o PC)"
echo   NO CONSOLE
echo     1. Abra "Checkpoint" no HOME (instalado pelo finalize). Ele lista cartuchos e jogos instalados.
echo     2. Selecione o jogo com o D-Pad, aperte (A) -^> "Backup" -^> digite um nome -^> (A). Repita para cada jogo.
echo        Aba superior (L/R) alterna entre saves normais e "extdata".
echo     3. Restaurar depois: selecione o jogo -^> escolha o backup na lista -^> "Restore".
echo   Os backups ficam em  SD:\3ds\Checkpoint\saves\^<jogo^>\^<nome^>\  (e extdata em ...\extdata\).
echo.
echo   NO PC (opcional, recomendado): copiar a pasta do Checkpoint para a area de trabalho.
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_29_FIM
if not exist "%SDL%:\3ds\Checkpoint\" goto PASSO_29_SEM
set "SAVEBKP=%USERPROFILE%\Desktop\Backup_Saves_3DS"
robocopy "%SDL%:\3ds\Checkpoint" "%SAVEBKP%" /E /R:2 /W:2 /NP /NFL /NDL
echo   Copiado para %SAVEBKP%
:PASSO_29_SEM
if not exist "%SDL%:\3ds\Checkpoint\" echo   Pasta %SDL%:\3ds\Checkpoint nao existe ainda ^(faca pelo menos um backup no console^).
:PASSO_29_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 29
goto %DESTINO%

:PASSO_30
cls
call :CABECALHO 30 "Pos-instalacao (4/4): migrar para um cartao SD maior (sem perder nada)"
echo   Regra de ouro: o 3DS aceita trocar de cartao desde que TODO o conteudo (inclusive a pasta "Nintendo 3DS")
echo   seja copiado igual. Jogos instalados ficam presos ao console, nao ao cartao, entao a copia funciona.
echo.
echo   1. Console DESLIGADO. Tire o cartao antigo (passo 7) e coloque no PC.
set "SDL="
call :PEDIR_SD
if "%SDL%"=="" goto PASSO_30_FIM
set "MIG=%USERPROFILE%\Desktop\Migracao_3DS"
echo   2. Copiando TUDO do cartao antigo para %MIG% ...
robocopy %SDL%:\ "%MIG%" /E /R:2 /W:2 /NP /NFL /NDL /XJ
if errorlevel 8 (echo   Falha na copia. Verifique o cartao com chkdsk %SDL%: /f e repita. & goto PASSO_30_FIM)
echo   Copia concluida.
echo.
echo   3. Tire o cartao antigo do PC ("Remover hardware com seguranca"). Coloque o cartao NOVO no PC.
echo   4. O cartao novo precisa estar em FAT32 com cluster de 32 KB e VAZIO (se veio de outro 3DS, apague a pasta
echo      Nintendo 3DS dele).
echo        - ate 32 GB: o script pode formatar (abaixo).   - acima de 32 GB: use o guiformat (FAT32 Format), 32768.
set "SDL="
call :PEDIR_SD
if "%SDL%"=="" goto PASSO_30_FIM
echo.
echo   ATENCAO: formatar APAGA TUDO no cartao %SDL%: . So aceite se %SDL%: for o cartao NOVO.
choice /c SN /n /m "   Formatar %SDL%: agora em FAT32 32 KB? (so ate 32 GB)  [S] Sim   [N] Nao, ja esta formatado : "
if errorlevel 2 goto PASSO_30_COPIA
set "CONF="
set /p "CONF=   Para confirmar, digite a letra %SDL% de novo: "
if /i not "%CONF%"=="%SDL%" (echo   Nao confirmado. Pulando a formatacao. & goto PASSO_30_COPIA)
format %SDL%: /FS:FAT32 /A:32K /Q /V:3DS /Y
:PASSO_30_COPIA
echo.
echo   5. Copiando tudo de %MIG% para o cartao novo %SDL%: ...
robocopy "%MIG%" %SDL%:\ /E /R:2 /W:2 /NP /NFL /NDL
if errorlevel 8 (echo   Falha ao copiar para o cartao novo. & goto PASSO_30_FIM)
echo   Concluido. Conferindo pastas essenciais:
set "FALTA=0"
call :CHECA "%SDL%:\boot.firm"
call :CHECA "%SDL%:\Nintendo 3DS"
call :CHECA "%SDL%:\luma"
echo.
echo   6. Recomendado: rode o H2testw no cartao novo ANTES de confiar nele (cartoes falsos sao comuns).
echo   7. "Remover hardware com seguranca", coloque o cartao novo no console (passo 12) e ligue.
echo      Todos os jogos, saves e temas devem aparecer. Se aparecer "cartao SD nao reconhecido": formato errado.
echo   8. Guarde o cartao antigo intacto por alguns dias como seguranca.
:PASSO_30_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 30
goto %DESTINO%

:CONCLUIDO
cls
echo.
echo  ==========================================================================================
echo   PARABENS: New 3DS XL desbloqueado com boot9strap + Luma3DS.
echo  ==========================================================================================
echo.
echo   Proximos passos recomendados (opcional):
echo     - Universal-Updater : loja de homebrew (temas, emuladores, ferramentas).
echo     - FBI               : instala arquivos .cia (seus backups/homebrew).
echo     - Checkpoint        : backup e restauracao de saves (faca agora um backup dos seus saves).
echo     - Anemone3DS        : temas do menu HOME.
echo     - Manter atualizado : de tempos em tempos veja 3ds.hacks.guide/restoring-updating-cfw
echo     - Online            : Nintendo Network desligou; Pretendo Network e o servidor alternativo (pretendo.network).
echo.
echo   Onde estao seus backups:
echo     - Cartao SD original : %BKP%
echo     - NAND               : %USERPROFILE%\Desktop\Backup_NAND_New3DSXL
echo.
echo   Para desfazer tudo: opcao 6 do menu.  Log de tudo que voce respondeu: %LOG%
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

rem ============================================================================
rem  SECOES AUXILIARES
rem ============================================================================

:REQUISITOS
cls
echo.
echo   REQUISITOS
echo   ----------
echo   Hardware : New Nintendo 3DS XL (RED-001) sem CFW; carregador; chave Phillips #0/#00;
echo              microSD (FAT32, 32 KB, min. 2 GB livres; ideal 32-64 GB Classe 10); adaptador/leitor SD para o PC.
echo   PC       : Windows 10/11. Para MSET9: Python 3 do python.org. Internet para baixar arquivos.
echo   Console  : versao 11.4 a 11.17 (abaixo disso: atualize antes). Wi-Fi 2,4 GHz so para super-skaterhax
echo              e para a atualizacao do sistema.
echo.
echo   DOWNLOADS (todos oficiais)
echo   --------------------------
echo   Luma3DS ............ https://github.com/LumaTeam/Luma3DS/releases/latest
echo   finalize.romfs ..... https://github.com/hacks-guide/finalize/releases/latest/download/finalize.romfs
echo   x_finalize_helper .. https://github.com/hacks-guide/finalize/releases/latest/download/x_finalize_helper.firm
echo   super-skaterhax .... https://skater.nintendohomebrew.com
echo   MSET9 .............. https://github.com/hacks-guide/MSET9/releases/latest
echo   Python 3 ........... https://www.python.org/downloads/windows/
echo.
echo   ESTRUTURA DO CARTAO (raiz)
echo   --------------------------
echo   \boot.firm   \boot.3dsx   \finalize.romfs   \luma\payloads\x_finalize_helper.firm   \Nintendo 3DS\
echo   + todo o conteudo do .zip do exploit escolhido (skaterhax ou MSET9) na raiz.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:ERROS
cls
echo.
echo   ERROS COMUNS E CORRECOES  (causa -^> correcao -^> teste)
echo   ---------------------------------------------------
echo.
echo   [SD / arquivos]
echo   - Console nao le o cartao / "SD card not recognized": formato exFAT/NTFS -^> formatar FAT32 32 KB (passo 9) -^> religar.
echo   - "Failed to apply 1 FIRM patch(es)" ou excecao no processo pm: boot.firm antigo/corrompido -^> baixe Luma de novo,
echo     extraia com Explorador/7-Zip (nao WinRAR) -^> religar.
echo   - Tela preta com luz azul ao ligar: SD mal encaixado -^> reencaixe; espere ate 10 min; renomeie "Nintendo 3DS"
echo     para "Nintendo 3DS_bak" para testar; se persistir, 3ds.hacks.guide/ctrtransfer.
echo.
echo   [super-skaterhax]
echo   - Erro branco: repita (ate 10x) trocando o idioma do console entre tentativas.
echo   - Tela preta com erro: arquivos do .zip fora da raiz -^> passo 11.   - Tela amarela: desligue e repita.
echo   - "Text": e um 3DS antigo -^> use safecerthax (3ds.hacks.guide).       - Travou: segure POWER e repita.
echo   - Erro 032-0420 ao abrir o site: console JPN ou navegador bloqueado -^> use MSET9.
echo.
echo   [MSET9 - script]
echo   - "Python 3 is not installed": instale do python.org com "Add to PATH".
echo   - "HOME Menu extdata: Missing!": ligue o console com o cartao dentro (e volte ao PC).
echo   - "Mii Maker extdata: Missing!": abra o Mii Maker no console ate a tela inicial.
echo   - "Title database: Not initialized!": Configuracoes -^> Gerenciamento de Dados -^> Nintendo 3DS -^> Programas -^> Reiniciar.
echo   - Error 01 (pasta Nintendo 3DS nao encontrada): rode o script a partir da RAIZ do cartao.
echo   - Error 02 (write protected): trava lateral do adaptador SD; reencaixe.
echo   - Error 04 (mais de 1 ID0) / 05 (mais de 1 ID1): siga 3ds.hacks.guide/troubleshooting-mset9 (identificar a pasta certa).
echo   - Error 06: libere 16 MB.   Error 07: baixe o MSET9 de novo e extraia na raiz.
echo   - Error 18 (Windows Locale): Painel de Controle -^> Regiao -^> Administrativo -^> desmarque "Beta: usar UTF-8" -^> reinicie.
echo.
echo   [MSET9 - exploit]
echo   - Tela VERMELHA ao reinserir o SD: falta SafeB9S.bin na raiz -^> copie; remova o trigger (opcao 4) e repita.
echo   - Configuracoes carregando sem parar: modelo/versao errados no script -^> opcao 4, corrija, repita.
echo   - "An exception occurred" ao disparar: o console ja tinha CFW -^> menu, opcao 6/JA TEM CFW.
echo.
echo   [SafeB9SInstaller]
echo   - "Failed to open SafeB9SInstaller.bin": falta o .bin na raiz.   - "MicroSD Card - init failed": reformate/troque o cartao.
echo   - "SigHaxed FIRM - File not found / invalid": faltam boot9strap.firm e .sha na pasta boot9strap -^> baixe de novo.
echo.
echo   [Finalizing Setup]
echo   - Nao consegue atualizar: DNS automatico / proxy nao; tente outra rede; 3ds.hacks.guide/troubleshooting-finalizing-setup.
echo   - #02, #04, #06, #18, #22: veja o passo 25 (tabela de erros do script).
echo   - Rosalina nao abre: Luma nao esta rodando -^> boot.firm na raiz; SELECT ao ligar para confirmar.
echo.
echo   [Apos instalar]
echo   - "An error has occurred. Hold down the POWER button": segure SELECT ao ligar -^> ative "Enable ARM11 exception handlers".
echo   - "Unable to mount CTRNAND": 3ds.hacks.guide/ctrtransfer.
echo   - Tela AZUL "BOOTROM ERROR": brick serio; so recupera com flashcart ntrboot ou hardmod -^> Discord Nintendo Homebrew.
echo.
echo   Suporte oficial: Discord "Nintendo Homebrew" (discord.gg/MWxPgEp) - canal #3ds-assistance.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DESFAZER
cls
echo.
echo   COMO DESFAZER (remover o CFW)
echo   -----------------------------
echo   AVISO: so remova se realmente precisar (ex.: vender/garantia). Consoles com regiao alterada, tema/teclado
echo   customizado ou "unban" NAO podem ser restaurados sem antes voltar a NAND original. Na duvida, nao remova.
echo.
echo   METODO RECOMENDADO: script oficial "uninstall_cfw" no GodMode9 (guia: 3ds.hacks.guide/uninstall-cfw)
echo     1. Baixe safety_test.gm9 e uninstall_cfw.gm9 (links no guia) e coloque em SD:\gm9\scripts\ ;
echo        atualize Luma3DS e GodMode9 para as versoes mais recentes; remova DSiWare/homebrew conforme o guia.
echo     2. Desligue; segure START e ligue -^> GodMode9 -^> HOME -^> Scripts... -^> "safety_test". Se FALHAR, PARE.
echo     3. HOME -^> Scripts... -^> "uninstall_cfw" -^> siga as instrucoes (unlock SysNAND) -^> reinicia sem CFW.
echo     4. No PC, apague do cartao: boot.firm, boot.3dsx, pasta luma, pasta gm9 e apps homebrew.
echo.
echo   ALTERNATIVA: restaurar o backup da NAND (feito no passo 25/26) pelo GodMode9:
echo     GodMode9 -^> navegue ate [0:] SDCARD -^> gm9 -^> backups -^> arquivo *_sysnand_*.bin -^> (A) -^> "NAND image options"
echo     -^> "Restore SysNAND (safe)" -^> digite a combinacao pedida. Isso volta o console EXATAMENTE ao estado do backup.
echo     Nunca restaure uma NAND de OUTRO console.
echo.
echo   Para desfazer so o cartao SD: copie de volta o conteudo do backup do passo 8.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   Abrindo links oficiais no navegador padrao...
start "" "https://3ds.hacks.guide/get-started"
start "" "https://3ds.hacks.guide/installing-boot9strap-(super-skaterhax)"
start "" "https://3ds.hacks.guide/installing-boot9strap-(mset9-cli)"
start "" "https://3ds.hacks.guide/finalizing-setup"
start "" "https://3ds.hacks.guide/troubleshooting"
start "" "https://discord.gg/MWxPgEp"
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:FERR_SD
cls
echo.
echo   FERRAMENTAS DO CARTAO SD
echo   ------------------------
echo   [1] Teste de velocidade (escrita/leitura de 200 MB)
echo   [2] Verificar formato e espaco (FAT32)
echo   [3] Abrir a pagina do H2testw (detecta cartao falso)
echo   [4] Migrar para um cartao maior (passo 30)
echo   [0] Voltar
choice /c 12340 /n /m "   Escolha: "
if errorlevel 5 goto MENU
if errorlevel 4 goto PASSO_30
if errorlevel 3 (start "" "https://www.heise.de/download/product/h2testw-50539" & goto FERR_SD)
if errorlevel 2 goto PASSO_9
call :TESTE_VELOCIDADE
call :AGUARDAR "Pressione qualquer tecla"
goto FERR_SD

:TESTE_VELOCIDADE
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" exit /b
echo   Testando %SDL%: (escreve e apaga um arquivo temporario de 200 MB; nao altera seus dados)...
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand %PSSPEED%
exit /b

:SAFECERTHAX
cls
echo.
echo   ROTEIRO safecerthax  -  Old 3DS / Old 2DS (CTR-001, SPR-001, FTR-001), versoes 1.0 a 11.14, todas as regioes
echo   (Old 3DS em 11.15-11.17: use o MSET9, passos 17-22 deste guia, escolhendo "Old 3DS" no script.)
echo   Fonte: 3ds.hacks.guide/installing-boot9strap-(safecerthax)
echo.
echo   I. TESTE DOS BOTOES: ligue, no HOME aperte L + R juntos -^> a camera deve abrir. Se nao abrir, use MSET9.
echo   II. CARTAO SD (no PC): copie o conteudo do Luma3DS .zip para a raiz; crie a pasta boot9strap e coloque
echo       boot9strap.firm e boot9strap.firm.sha (release do boot9strap) dentro; SafeB9SInstaller.bin na raiz.
echo       Links: github.com/LumaTeam/Luma3DS  github.com/SciresM/boot9strap  github.com/d0k3/SafeB9SInstaller
call :AGUARDAR "Pressione qualquer tecla quando o cartao estiver pronto e de volta no console"
echo   III. PROXY: Configuracoes -^> Configuracoes da Internet -^> Configuracoes de Conexao -^> sua rede -^> Alterar
echo        configuracoes -^> proxima pagina -^> Configuracoes de Proxy -^> "Sim" -^> Configuracao detalhada:
echo        Servidor proxy:  ssloth.nintendohomebrew.com     Porta:  8080   -^> OK -^> Salvar -^> Testar conexao -^> desligue.
call :AGUARDAR "Pressione qualquer tecla quando o teste de conexao passar com o proxy"
echo   IV. MODO SEGURO: com o console desligado, SEGURE  L + R + D-Pad CIMA + A  e ligue; continue segurando ate
echo       aparecer o Modo Seguro -^> "OK" para atualizar -^> "Aceito" -^> aparece o erro 003-1099 (esperado) -^> "OK"
echo       -^> o SafeB9SInstaller abre.
call :AGUARDAR "Pressione qualquer tecla quando o SafeB9SInstaller aparecer"
echo   V. Digite a combinacao de botoes mostrada -^> espere concluir -^> (A) reinicia -^> menu do Luma3DS -^> START.
echo   VI. REMOVER O PROXY: mesmo caminho do passo III -^> Proxy "Nao" -^> Salvar -^> Testar conexao.
echo   Depois continue no passo 23 (Finalizar) deste guia: os passos 23-30 valem para o Old 3DS tambem.
echo.
choice /c 12 /n /m "   [1] Ir para o passo 23 (Finalizar)    [2] Menu : "
if errorlevel 2 goto MENU
goto PASSO_23

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
set "METODO="
set "REGIAO="
set "FAIXA="
set "SDL="
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

:CHECA_STORE
echo %~1| findstr /i "WindowsApps" >nul && echo   AVISO: o "python" encontrado e o da Microsoft Store: %~1 - ele NAO serve para o MSET9. Instale pelo python.org.
exit /b

:CHECA
if exist "%~1" echo     OK     %~1
if not exist "%~1" echo     FALTA  %~1
if not exist "%~1" set /a FALTA+=1
exit /b

:PEDIR_SD
set "SDL="
set /p "SDL=   Digite a LETRA da unidade do cartao SD (ex.: E) ou ENTER para cancelar: "
if "%SDL%"=="" exit /b
set "SDL=%SDL:~0,1%"
if not exist %SDL%:\ (echo   Unidade %SDL%: nao encontrada. & set "SDL=" & exit /b)
if /i "%SDL%"=="C" (echo   C: e o disco do Windows, nao o cartao! & set "SDL=" & exit /b)
echo   Unidade selecionada: %SDL%:
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
>>"%LOG%" echo %DATE% %TIME%  passo=%PASSO%  metodo=%METODO%  regiao=%REGIAO%  faixa=%FAIXA%  sd=%SDL%
>"%PROG%" echo PASSO=%PASSO%
>>"%PROG%" echo METODO=%METODO%
>>"%PROG%" echo REGIAO=%REGIAO%
>>"%PROG%" echo FAIXA=%FAIXA%
>>"%PROG%" echo SDL=%SDL%
>>"%PROG%" echo BKP=%BKP%
exit /b

:CARREGAR
if not exist "%PROG%" exit /b
for /f "usebackq tokens=1,* delims==" %%A in ("%PROG%") do set "%%A=%%B"
exit /b
