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
set "ASCII=0"
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
echo   Este guia segue o 3ds.hacks.guide, passo a passo, e pede confirmação a cada ação física
echo   (virar o console, tirar o cartão, apertar botões). Nada é feito no console pelo PC.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: você parou no passo %PASSO% de %TOTAL%   ^(método: %METODO%  região: %REGIAO%^)
if not "%PASSO%"=="0" echo.
echo   [1] Começar do início (passo 1)
echo   [2] Continuar de onde parei
echo   [3] Ir para um passo específico
echo   [4] Requisitos, downloads e estrutura do cartão SD
echo   [5] Erros comuns e como corrigir
echo   [6] Como desfazer (remover o CFW / restaurar NAND)
echo   [7] Abrir links oficiais no navegador
echo   [8] Apagar o progresso salvo
echo   [9] Ferramentas do cartão SD (teste de velocidade, H2testw, migração para cartão maior)
echo   [A] Modo sem acentos (use se o texto aparecer com caracteres estranhos)
echo   [0] Sair
echo.
choice /c 1234567890A /n /m "   Escolha uma opção: "
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
echo    1  Regras de ouro e avisos                     14  [skaterhax] Ajustar região, data e hora
echo    2  Confirmar o modelo (New 3DS XL)             15  [skaterhax] Rodar o exploit no navegador
echo    3  Ver versão do firmware e região             16  [skaterhax] SafeB9SInstaller e Luma3DS
echo    4  Teste: já tem CFW? (Select ao ligar)        17  [MSET9] Instalar Python 3
echo    5  Escolher o método                           18  [MSET9] Preparação - criar ID1 hackeado
echo    6  Bateria e carregador                        19  [MSET9] Mii Maker, Reset do banco de títulos
echo    7  Desligar e REMOVER o microSD (físico)       20  [MSET9] Disparar o exploit (SD com console ligado)
echo    8  Backup completo do cartão no PC             21  [MSET9] SafeB9SInstaller e Luma3DS
echo    9  Verificar formato FAT32 e espaço            22  [MSET9] Remover o MSET9 (obrigatório)
echo   10  Baixar os arquivos                          23  Finalizar: atualização do sistema
echo   11  Copiar arquivos para o SD e conferir        24  Finalizar: Rosalina (DSP e relógio)
echo   12  Colocar o SD no console (físico)            25  Finalizar: script "finalize" no GodMode9
echo   13  Ligar e conectar ao Wi-Fi                   26  Backup da NAND no PC e verificação final
echo   PÓS-INSTALAÇÃO:  27  Universal-Updater e game patching   28  Pretendo Network (online)
echo                    29  Backup de saves com Checkpoint     30  Migrar para um cartão SD maior
echo.
set "N="
set /p "N=   Digite o número do passo (1-%TOTAL%) ou ENTER para voltar: "
if "%N%"=="" goto MENU
:STRIP_ZERO
if "%N:~0,1%"=="0" if not "%N%"=="0" (set "N=%N:~1%" & goto STRIP_ZERO)
echo %N%| findstr /r "^[0-9][0-9]*$" >nul || goto IR_PARA
if %N% LSS 1 goto IR_PARA
if %N% GTR %TOTAL% goto IR_PARA
goto PASSO_%N%

rem ============================================================================
rem  BLOCO A - PREPARAÇÃO
rem ============================================================================

:PASSO_1
cls
call :CABECALHO 1 "Regras de ouro e avisos (leia com calma)"
echo   O que você vai instalar:
echo     - boot9strap  : carregador que roda antes do sistema (a "chave" do desbloqueio).
echo     - Luma3DS     : o custom firmware (CFW). Permite homebrew, backups e mais.
echo     - GodMode9    : ferramenta de manutenção usada no final para backup da NAND.
echo.
echo   Regras de ouro:
echo     1. NÃO desligue o console durante a instalação do boot9strap (tela do SafeB9SInstaller).
echo     2. Carregador conectado e bateria acima de 50%% durante todo o processo.
echo     3. Use SOMENTE os arquivos das releases oficiais indicadas neste guia.
echo     4. Não misture tutoriais antigos (vídeos de 2019-2022 usam métodos que já mudaram).
echo     5. Faça backup do cartão SD antes de mexer (o guia faz isso no passo 8).
echo     6. Se algo der errado, NÃO tente "adivinhar": use a opção [E] Erros deste guia
echo        ou o Discord Nintendo Homebrew (link na opção 7 do menu).
echo.
echo   Risco real: com os métodos atuais (super-skaterhax / MSET9) o risco de brick é muito baixo
echo   desde que você siga a ordem exata. O único momento crítico é o SafeB9SInstaller.
echo.
echo   Reversível? Sim. No final você terá um backup da NAND e existe um script oficial de
echo   remoção do CFW (opção 6 do menu).
echo.
call :AGUARDAR "Li e entendi as regras. Pressione qualquer tecla para continuar"
call :FIM_PASSO 1
goto %DESTINO%

:PASSO_2
cls
call :CABECALHO 2 "Confirmar o modelo: New Nintendo 3DS XL"
echo   AÇÃO FÍSICA: pegue o console, feche a tampa e VIRE-O DE CABEÇA PARA BAIXO.
echo.
echo   Na parte de baixo há uma etiqueta branca/prateada. Procure o código do modelo:
echo.
echo       +----------------------------------------------+
echo       :  New Nintendo 3DS XL                         :
echo       :  MODEL NO. / MODELO:  RED-001                :   ^<-- New 3DS XL (todas as regiões)
echo       :  SERIAL NO.  ....                            :
echo       +----------------------------------------------+
echo.
echo   Outras formas de confirmar:
echo     - Existe um "C-Stick" (bolinha cinza) acima dos botões ABXY.
echo     - Existem os gatilhos ZL e ZR (além de L e R).
echo     - Abaixo da tela inferior está escrito "NEW" antes de "Nintendo 3DS XL".
echo.
echo   Tabela de modelos (só para referência):
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
echo   ATENÇÃO: este guia foi escrito para o New 3DS XL (RED-001).
echo     - KTR-001 (New 3DS) e JAN-001 (New 2DS XL): os MESMOS métodos funcionam. Pode continuar,
echo       apenas o local do slot SD/microSD muda (New 2DS XL: slot atrás da tampa da esquerda).
echo     - CTR/SPR/FTR (modelos antigos): use OUTRO método (safecerthax). Vá em 3ds.hacks.guide/get-started
echo       e selecione "Old 3DS/2DS". Este guia NÃO serve para eles.
echo.
choice /c 123 /n /m "   [1] Continuar (New 3DS / New 2DS XL)   [2] Ver o roteiro safecerthax para Old 3DS/2DS   [3] Menu : "
if errorlevel 3 goto MENU
if errorlevel 2 goto SAFECERTHAX
call :FIM_PASSO 2
goto %DESTINO%

:PASSO_3
cls
call :CABECALHO 3 "Ver a versão do firmware e a região"
echo   AÇÃO: ligue o console (botão POWER, canto inferior direito da tela de baixo).
echo   Se pedir usuário/PIN de controle parental, entre normalmente.
echo.
echo   1. No menu HOME, toque no ícone de chave inglesa "Configurações do Console" / "System Settings".
echo   2. No canto SUPERIOR DIREITO da tela de cima aparece a versão, por exemplo:
echo.
echo          Ver. 11.17.0-50U
echo               ^^      ^^  ^^
echo               :      :  +-- LETRA DA REGIÃO:  U = USA   E = Europa   J = Japão   K = Coreia
echo               :      +----- versão do NVer (50)
echo               +------------ versão do sistema (11.17.0)
echo.
call :AGUARDAR "Pressione qualquer tecla quando estiver vendo a versão na tela"
echo.
echo   O texto começa com "Ver." ?  (Se começar com "Luma", "GM9", "B9S" ou outra coisa, o console JÁ tem CFW.)
choice /c SN /n /m "   [S] Começa com Ver.   [N] Começa com outra coisa : "
if errorlevel 2 goto JA_TEM_CFW
echo.
echo   Qual é a LETRA no final da versão?
choice /c UEJKO /n /m "   [U] USA   [E] Europa   [J] Japão   [K] Coreia   [O] outra (C/T) : "
if errorlevel 5 set "REGIAO=OUTRA"
if errorlevel 5 goto REGIAO_OUTRA
if errorlevel 4 set "REGIAO=KOR"
if errorlevel 3 if not errorlevel 4 set "REGIAO=JPN"
if errorlevel 2 if not errorlevel 3 set "REGIAO=EUR"
if not errorlevel 2 set "REGIAO=USA"
echo.
echo   Em qual faixa está a versão do sistema?
choice /c 123 /n /m "   [1] 11.15 até 11.17    [2] 11.4 até 11.14    [3] abaixo de 11.4 : "
if errorlevel 3 set "FAIXA=3"
if errorlevel 2 if not errorlevel 3 set "FAIXA=2"
if not errorlevel 2 set "FAIXA=1"
echo.
echo   Anotado: região %REGIAO%, faixa de versão %FAIXA%.
call :FIM_PASSO 3
goto %DESTINO%

:REGIAO_OUTRA
echo.
echo   Regiões C (China) e T (Taiwan) não existem em New 3DS XL de varejo comum.
echo   Confira a letra novamente. Se for mesmo C ou T, use 3ds.hacks.guide/get-started
echo   para o método específico. Este guia continua só para U / E / J / K.
call :AGUARDAR "Pressione qualquer tecla para repetir o passo"
goto PASSO_3

:JA_TEM_CFW
cls
echo.
echo   ESTE CONSOLE JÁ TEM CUSTOM FIRMWARE.
echo   Não siga este guia (instalar de novo por cima pode causar erros).
echo.
echo   O que fazer:
echo     - Para atualizar o Luma3DS / restaurar homebrew: 3ds.hacks.guide/restoring-updating-cfw
echo     - Para checar qual versão de Luma tem: desligue, segure SELECT e ligue (abre o menu do Luma).
echo     - Para remover tudo: opção 6 do menu deste guia.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:PASSO_4
cls
call :CABECALHO 4 "Teste: o console já tem CFW? (SELECT ao ligar)"
echo   Mesmo que o passo 3 tenha mostrado "Ver.", faça este teste (consoles usados podem ter CFW oculto).
echo.
echo   AÇÃO FÍSICA:
echo     1. Desligue o console COMPLETAMENTE: segure POWER por 1 segundo e toque em "Desligar" / "Power Off".
echo        (Fechar a tampa NÃO desliga, só suspende.)
echo     2. Com o console desligado, SEGURE o botão SELECT (o pequeno, à esquerda abaixo da tela inferior).
echo     3. Sem soltar SELECT, aperte POWER e continue segurando SELECT por uns 3 segundos.
echo     4. Observe a tela.
echo.
call :AGUARDAR "Pressione qualquer tecla depois de fazer o teste"
echo.
echo   O que apareceu?
choice /c 12 /n /m "   [1] Menu HOME normal (sem CFW)    [2] Menu de configuração do Luma3DS ou outra tela preta com texto : "
if errorlevel 2 goto JA_TEM_CFW
echo.
echo   OK: console sem CFW. Pode desligar ou deixar ligado no menu HOME.
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Escolher o método (recomendação automática)"
if "%FAIXA%"=="" (echo   Você ainda não informou a versão. Volte ao passo 3. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_3)
if "%FAIXA%"=="3" goto PRECISA_ATUALIZAR
set "REC=MSET9"
if "%FAIXA%"=="1" if "%REGIAO%"=="USA" set "REC=SKATER"
if "%FAIXA%"=="1" if "%REGIAO%"=="EUR" set "REC=SKATER"
if "%FAIXA%"=="1" if "%REGIAO%"=="KOR" set "REC=SKATER"
echo   Seus dados: New 3DS XL, região %REGIAO%, faixa de versão %FAIXA%.
echo.
echo   Métodos disponíveis para este console:
echo.
echo     super-skaterhax  - Exploit pelo NAVEGADOR do 3DS. Precisa de Wi-Fi. Não precisa de Python.
echo                        New 3DS 11.15 a 11.17, regiões USA/EUR/KOR (JPN não: erro 032-0420 no navegador).
echo                        Pode falhar algumas vezes (é normal repetir até 10x).
echo.
echo     MSET9            - Exploit pelo cartão SD + script no PC (Python). Funciona SEM internet.
echo                        New 3DS 11.4 a 11.17, TODAS as regiões. Exige remover o cartão com o console LIGADO
echo                        (no New 3DS XL isso significa abrir a tampa traseira com ele ligado - dá para fazer
echo                        com cuidado, o guia explica).
echo.
if "%REC%"=="SKATER" echo   MÉTODO RECOMENDADO: super-skaterhax  ^(é o que o seletor oficial do 3ds.hacks.guide indica para o seu caso^)
if "%REC%"=="MSET9"  echo   MÉTODO RECOMENDADO: MSET9  ^(é o que o seletor oficial do 3ds.hacks.guide indica para o seu caso^)
echo.
choice /c 12 /n /m "   [1] super-skaterhax    [2] MSET9    : "
if errorlevel 2 set "METODO=MSET9"
if not errorlevel 2 set "METODO=SKATER"
if "%METODO%"=="SKATER" if "%REGIAO%"=="JPN" echo   AVISO: skaterhax em console japonês costuma falhar ^(erro 032-0420^). Prefira MSET9.
if "%METODO%"=="SKATER" if "%FAIXA%"=="2" echo   AVISO: skaterhax exige 11.15 ou superior. Na sua versão use MSET9.
echo.
echo   Método escolhido: %METODO%
call :FIM_PASSO 5
goto %DESTINO%

:PRECISA_ATUALIZAR
echo   Seu console está abaixo de 11.4. Os métodos deste guia exigem 11.4 ou superior.
echo.
echo   MÉTODO RECOMENDADO: atualizar o console para a versão mais recente (é seguro em console SEM CFW)
echo   e depois usar super-skaterhax ou MSET9.
echo.
echo     1. Conecte o console ao Wi-Fi (Configurações → Configurações da Internet).
echo     2. Configurações do Console → Outras Configurações → última aba → Atualização do Sistema.
echo     3. Aceite e aguarde. O console reinicia sozinho.
echo     4. Volte ao passo 3 deste guia e informe a nova versão.
echo.
echo   Se a atualização der erro: Configurações da Internet → sua rede → DNS = Automático, Proxy = Não.
echo   Se não quiser atualizar, veja outras opções em 3ds.hacks.guide/get-started.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao passo 3"
goto PASSO_3

:PASSO_6
cls
call :CABECALHO 6 "Bateria e carregador"
echo   AÇÃO FÍSICA:
echo     1. Conecte o carregador original (ou compatível 4.6V) na porta do lado de trás do console.
echo     2. Confira que o LED laranja de carga (canto do console, perto da dobradiça) está aceso.
echo     3. Espere até a bateria estar com pelo menos 50%% (ícone de bateria no canto superior direito
echo        da tela de baixo no menu HOME, ou o LED laranja apagar = 100%%).
echo.
echo   Mantenha o carregador conectado durante TODO o restante do guia.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o carregador estiver conectado e a bateria acima de 50%%"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "Desligar e REMOVER o cartão microSD (ação física)"
echo   1. Desligue o console COMPLETAMENTE (segure POWER → "Desligar"). Espere a luz azul apagar.
echo   2. Feche a tampa. Desconecte o carregador só durante este passo.
echo   3. VIRE O CONSOLE DE CABEÇA PARA BAIXO sobre um pano ou superfície macia.
echo.
echo        PARTE DE BAIXO DO NEW 3DS XL (tampa traseira):
echo.
echo        +--------------------------------------------------------+
echo        :                                                        :
echo        :        [ etiqueta RED-001 ]                            :
echo        :                                                        :
echo        :   (o)                                            (o)   :   ^<-- 2 parafusos Phillips
echo        +---^^----------------------------------------------^^-----+       (cativos: afrouxam
echo            :        entalhe para levantar a tampa           :             mas NÃO saem)
echo.
echo   4. Com uma chave Phillips #0 (ou #00), AFROUXE os dois parafusos da tampa (uns 10-15 giros).
echo      Eles ficam presos na tampa - não force para tirá-los.
echo   5. Coloque a unha ou uma palheta de plástico no ENTALHE da borda e levante a tampa a partir
echo      do lado dos parafusos. Ela sai inteira.
echo   6. Você verá a bateria (bloco grande) e, ao lado dela, o slot do microSD.
echo   7. ANOTE a orientação do cartão (lado da etiqueta / contatos dourados) antes de tirar.
echo   8. Empurre o microSD levemente para DENTRO: ele destrava e salta (slot com mola). Puxe-o.
echo.
echo   Dica: se o cartão original for de 4 GB, considere trocar por um microSD de 32-64 GB Classe 10
echo   de marca conhecida (SanDisk, Samsung, Kingston). Se trocar, copie TODO o conteúdo do antigo para o novo.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o microSD estiver fora do console"
call :FIM_PASSO 7
goto %DESTINO%

:PASSO_8
cls
call :CABECALHO 8 "Backup completo do cartão no PC (automático)"
echo   1. Coloque o microSD em um adaptador SD ou leitor USB e conecte ao PC.
echo   2. Abra "Este Computador" e veja qual LETRA o cartão recebeu (ex.: E:, F:).
echo      Dentro dele deve existir a pasta "Nintendo 3DS".
echo.
call :PEDIR_SD
if "%SDL%"=="" goto PASSO_8
set "BKP=%USERPROFILE%\Desktop\Backup_3DS_%DATE:/=-%"
set "BKP=%BKP: =_%"
echo.
echo   Vou copiar TUDO de %SDL%:\ para:
echo      %BKP%
echo   (robocopy, não altera nada no cartão; pode demorar alguns minutos)
echo.
call :PERGUNTA "   Iniciar a cópia agora?"
if errorlevel 2 goto PASSO_8_MANUAL
robocopy %SDL%:\ "%BKP%" /E /R:2 /W:2 /NP /NFL /NDL /XJ
if errorlevel 8 goto PASSO_8_FALHA
echo.
echo   Backup concluído em: %BKP%
echo   Guarde essa pasta. Ela permite restaurar o cartão exatamente como estava.
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
echo   robocopy relatou falha (código %ERRORLEVEL%). Causas prováveis:
echo     1. Cartão com setores ruins → rode: chkdsk %SDL%: /f   (em um Prompt como administrador)
echo     2. Leitor/adaptador ruim → troque o adaptador ou a porta USB.
echo     3. Letra errada → confira em "Este Computador".
call :AGUARDAR "Pressione qualquer tecla para repetir o passo"
goto PASSO_8

:PASSO_9
cls
call :CABECALHO 9 "Verificar formato FAT32, tamanho de cluster e espaço livre"
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_9
echo   Verificando a unidade %SDL%: ...
echo.
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "try{$v=Get-Volume -DriveLetter '%SDL%' -ErrorAction Stop; '{0};{1};{2}' -f $v.FileSystemType,[math]::Round($v.SizeRemaining/1GB,2),[math]::Round($v.Size/1GB,2)}catch{'?;?;?'}"`) do set "INFO=%%A"
for /f "tokens=1-3 delims=;" %%A in ("%INFO%") do (set "FS=%%A" & set "LIVRE=%%B" & set "TAM=%%C")
echo     Sistema de arquivos : %FS%
echo     Tamanho total       : %TAM% GB
echo     Espaço livre        : %LIVRE% GB
if exist "%SDL%:\Nintendo 3DS\" echo     Pasta "Nintendo 3DS" : encontrada ^(OK^)
if not exist "%SDL%:\Nintendo 3DS\" echo     Pasta "Nintendo 3DS" : NÃO encontrada ^(o console cria ao ligar com o cartão; para MSET9 ela é obrigatória^)
echo.
echo   Requisitos do 3DS:
echo     - Sistema de arquivos: FAT32 (exFAT e NTFS NÃO funcionam; cartões acima de 32 GB vêm em exFAT).
echo     - Cluster de 32 KB é o ideal (formatação padrão do Windows até 32 GB já usa 32 KB).
echo     - Espaço livre: mínimo 1,3 GB para o backup da NAND no final (recomendado 2 GB ou mais).
echo.
if /i "%FS%"=="FAT32" echo   RESULTADO: formato OK.
if /i not "%FS%"=="FAT32" echo   RESULTADO: PRECISA FORMATAR EM FAT32. Veja abaixo.
echo.
echo   Como formatar em FAT32 (APAGA TUDO no cartão - você já fez o backup no passo 8):
echo     - Até 32 GB : Este Computador → botão direito no cartão → Formatar → FAT32, "Tamanho da unidade de alocação: 32 KB".
echo     - Acima de 32 GB: use a ferramenta "guiformat" (FAT32 Format, de Ridgecrop) com Allocation unit size = 32768.
echo       Depois copie de volta o conteúdo do backup (passo 8) para o cartão.
echo.
choice /c SN /n /m "   [S] Testar a velocidade do cartão agora (200 MB, 1 min)    [N] Pular : "
if not errorlevel 2 call :TESTE_VELOCIDADE
echo.
echo   Para detectar cartão FALSO (capacidade mentirosa) use o H2testw: https://www.heise.de/download/product/h2testw-50539
echo   (grave o cartão inteiro; "Test finished without errors" = cartão real). Demora 1 h por 64 GB.
call :AGUARDAR "Pressione qualquer tecla quando o cartão estiver em FAT32 com espaço suficiente"
call :FIM_PASSO 9
goto %DESTINO%

:PASSO_10
cls
call :CABECALHO 10 "Baixar os arquivos"
if "%METODO%"=="" (echo   Método não definido. Volte ao passo 5. & call :AGUARDAR "Pressione qualquer tecla" & goto PASSO_5)
echo   Crie uma pasta no PC, por exemplo:  %USERPROFILE%\Desktop\3DS_Downloads
echo   e baixe para lá. NÃO extraia ainda; o passo 11 explica onde cada coisa vai.
echo.
echo   COMUNS A TODOS OS MÉTODOS:
echo     [A] Luma3DS (release mais recente, arquivo Luma3DSvXX.X.zip)
echo         https://github.com/LumaTeam/Luma3DS/releases/latest
echo     [B] finalize.romfs
echo         https://github.com/hacks-guide/finalize/releases/latest/download/finalize.romfs
echo     [C] x_finalize_helper.firm
echo         https://github.com/hacks-guide/finalize/releases/latest/download/x_finalize_helper.firm
echo.
if "%METODO%"=="SKATER" echo   ESPECÍFICO DO super-skaterhax:
if "%METODO%"=="SKATER" echo     [D] Super-skaterhax .zip para a SUA região ^(%REGIAO%^) e SUA versão ^(ex.: 11.17.0-50^)
if "%METODO%"=="SKATER" echo         https://skater.nintendohomebrew.com
if "%METODO%"=="MSET9"  echo   ESPECÍFICO DO MSET9:
if "%METODO%"=="MSET9"  echo     [D] MSET9 ^(arquivo MSET9-vX.X.zip da release mais recente^)
if "%METODO%"=="MSET9"  echo         https://github.com/hacks-guide/MSET9/releases/latest
if "%METODO%"=="MSET9"  echo     [E] Python 3 ^(instalador do site oficial; NÃO use a versão da Microsoft Store^)
if "%METODO%"=="MSET9"  echo         https://www.python.org/downloads/windows/
echo.
choice /c SN /n /m "   [S] Abrir todos esses links no navegador agora    [N] Já baixei / vou baixar manualmente : "
if errorlevel 2 goto PASSO_10_CHECK
start "" "https://github.com/LumaTeam/Luma3DS/releases/latest"
if "%METODO%"=="SKATER" start "" "https://skater.nintendohomebrew.com"
if "%METODO%"=="MSET9"  start "" "https://github.com/hacks-guide/MSET9/releases/latest"
if "%METODO%"=="MSET9"  start "" "https://www.python.org/downloads/windows/"
echo.
echo   Tentando baixar finalize.romfs e x_finalize_helper.firm direto para a área de trabalho...
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
call :CABECALHO 11 "Copiar os arquivos para o cartão SD e conferir a estrutura"
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_11
echo   ESTRUTURA FINAL ESPERADA na RAIZ do cartão (%SDL%:\):
echo.
echo     %SDL%:\
echo     :-- boot.firm                      (de dentro do Luma3DS .zip)
echo     :-- boot.3dsx                      (de dentro do Luma3DS .zip)
echo     :-- finalize.romfs                 (download [B])
echo     :-- luma\
echo     :     +-- payloads\
echo     :           +-- x_finalize_helper.firm   (download [C])
echo     :-- Nintendo 3DS\                  (já existe; NÃO mexa)
if "%METODO%"=="SKATER" echo     :-- ^(TODO o conteúdo do Super-skaterhax .zip, na raiz, sobrescrevendo se perguntar^)
if "%METODO%"=="MSET9"  echo     :-- ^(TODO o conteúdo do MSET9 .zip, na raiz, sobrescrevendo se perguntar^)
if "%METODO%"=="MSET9"  echo     :-- MSET9-Windows.bat, mset9.py, boot9strap\, SafeB9S.bin ...  ^(vêm do MSET9 .zip^)
echo.
echo   Como fazer:
echo     1. Abra o Luma3DS .zip → copie boot.firm e boot.3dsx para a raiz do cartão.
echo        Use o Explorador do Windows ou 7-Zip. Evite WinRAR (já corrompeu boot.firm em alguns casos).
echo     2. Copie finalize.romfs para a raiz do cartão.
echo     3. Crie a pasta luma e dentro dela a pasta payloads (este script cria para você).
echo     4. Copie x_finalize_helper.firm para dentro de %SDL%:\luma\payloads\
if "%METODO%"=="SKATER" echo     5. Abra o Super-skaterhax .zip e copie TODO o conteúdo para a raiz. Se perguntar, SUBSTITUA.
if "%METODO%"=="MSET9"  echo     5. Abra o MSET9 .zip e copie TODO o conteúdo para a raiz. Se perguntar, SUBSTITUA.
echo.
if not exist "%SDL%:\luma\payloads\" (mkdir "%SDL%:\luma\payloads" && echo   Criei a pasta %SDL%:\luma\payloads\ )
choice /c SA /n /m "   [S] Abrir o cartão no Explorador e a pasta de downloads    [A] Já copiei, só conferir : "
if errorlevel 2 goto PASSO_11_VERIFICA
start "" "%SDL%:\"
if exist "%USERPROFILE%\Desktop\3DS_Downloads" start "" "%USERPROFILE%\Desktop\3DS_Downloads"
call :AGUARDAR "Pressione qualquer tecla quando terminar de copiar"
:PASSO_11_VERIFICA
echo.
echo   CONFERÊNCIA AUTOMÁTICA:
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
if "%FALTA%"=="0" echo   RESULTADO: todos os arquivos esperados estão no lugar.
if not "%FALTA%"=="0" echo   RESULTADO: faltam %FALTA% arquivo^(s^). Copie os que estão marcados como FALTA e repita este passo.
if not "%FALTA%"=="0" echo   ^(Se o nome do arquivo do exploit mudou em uma release nova, confira dentro do .zip; o essencial é
if not "%FALTA%"=="0" echo    ter TUDO do .zip na raiz do cartão.^)
echo.
echo   Por último: no Windows, clique em "Remover hardware com segurança" antes de tirar o cartão.
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Colocar o microSD de volta no console (ação física)"
echo   1. No PC: "Remover hardware com segurança" → tire o cartão do adaptador.
echo   2. Console ainda DESLIGADO e de cabeça para baixo, tampa traseira aberta.
echo   3. Encaixe o microSD no slot NA MESMA ORIENTAÇÃO anotada no passo 7 (normalmente etiqueta para cima,
echo      contatos dourados para baixo, voltados para a placa). Empurre até ouvir o "clique" da trava.
echo      Nunca force: se não entrar suave, a orientação está errada.
echo   4. Recoloque a tampa traseira: encaixe primeiro o lado da dobradiça, depois pressione o lado dos parafusos.
echo   5. Aperte os dois parafusos sem exagerar (só até parar de girar).
echo   6. Vire o console de volta e reconecte o carregador.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o cartão estiver no console, tampa fechada e carregador conectado"
call :FIM_PASSO 12
goto %DESTINO%

:PASSO_13
cls
call :CABECALHO 13 "Ligar o console e (se necessário) conectar ao Wi-Fi"
echo   1. Ligue o console. Espere o menu HOME.
echo   2. Se aparecer aviso de "cartão SD não reconhecido": desligue, refaça o passo 12 (cartão mal encaixado
echo      ou formato errado - veja passo 9).
if "%METODO%"=="SKATER" echo   3. O super-skaterhax PRECISA de internet. Configurações do Console → Configurações da Internet →
if "%METODO%"=="SKATER" echo      Configurações de Conexão → escolha uma conexão → conecte à sua rede Wi-Fi ^(2,4 GHz; o 3DS não usa 5 GHz^).
if "%METODO%"=="SKATER" echo      Teste a conexão até aparecer "Conexão bem-sucedida".
if "%METODO%"=="MSET9"  echo   3. O MSET9 NÃO precisa de internet. Se o console pedir para conectar, pode ignorar por enquanto.
echo   4. Confirme que o ícone do cartão SD aparece no menu HOME (canto superior esquerdo mostra os blocos livres).
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
call :CABECALHO 14 "[super-skaterhax] Ajustar região do perfil, data e hora"
echo   No console, ligado no menu HOME:
echo.
echo   1. Configurações do Console → "Outras Configurações" / "Other Settings".
echo   2. Aba "Perfil" / "Profile" → "Configurações de Região" / "Region Settings".
echo   3. Escolha EXATAMENTE conforme a região do seu console:
echo        USA : país "United States"  → estado: "Do Not Set" / "Não definir"
echo        EUR : país "United Kingdom" → região: "Do Not Set" / "Não definir"
echo        KOR : país "대한민국"        → "설정하지 않음"
echo      (Isso é temporário; depois do desbloqueio você pode voltar para Brasil.)
echo   4. Ainda em Outras Configurações → "Data e Hora" / "Date and Time":
echo        "Data de Hoje" e "Hora Atual" = data e hora REAIS de agora.
echo   5. Saia das Configurações (botão HOME ou "Fechar").
echo.
call :AGUARDAR "Pressione qualquer tecla quando região, data e hora estiverem ajustadas"
call :FIM_PASSO 14
goto %DESTINO%

:PASSO_15
cls
call :CABECALHO 15 "[super-skaterhax] Rodar o exploit no Navegador da Internet"
if "%REGIAO%"=="KOR" set "URLSK=https://skater.686178.xyz/go/korea"
if not "%REGIAO%"=="KOR" set "URLSK=https://skater.686178.xyz/go/super"
echo   Siga EXATAMENTE nesta ordem (é o procedimento oficial atual):
echo.
echo    1. Abra o "Navegador da Internet" (ícone do globo no menu HOME).
echo    2. Toque no ícone de 3 linhas (☰) no canto INFERIOR DIREITO da tela de baixo.
echo    3. Toque em Configurações → role até o fim → "Redefinir Dados Salvos" / "Reset Save Data"
echo       → "Apagar Tudo" / "Clear All" → "Apagar" → OK.  (O navegador fecha.)
echo    4. Abra o Navegador de novo.
echo    5. Toque em "Avançar"/"Next" → escolha "Google" → OK → OK.
echo    6. Toque na barra de endereço no topo da tela de baixo e digite, sem errar:
echo.
echo            %URLSK%
echo.
echo    7. Toque em "Abrir"/"Open" e espere a página carregar.
echo    8. Toque no ícone ☰ → "Adicionar aos Favoritos" / "Add to Bookmarks".
echo    9. Toque no ícone ☰ → Configurações → "Apagar Cookies" / "Delete Cookies" → Sim.
echo   10. Aperte HOME para voltar ao menu HOME e IMEDIATAMENTE abra o Navegador de novo.
echo   11. Espere a página carregar por completo e toque no botão "GO GO!".
echo   12. Espere carregar e aperte (A) para fechar o pop-up.
echo   13. Deve aparecer a tela do "Homebrew Launcher" com uma lista de apps.
echo.
echo   Se der erro, veja a tabela abaixo (é NORMAL precisar repetir várias vezes):
echo     - Mensagem de erro BRANCA  : repita a partir do item 10 (até 10 tentativas). Entre uma e outra,
echo                                  troque o idioma do console (Configurações → Outras → Idioma) e tente de novo.
echo     - Tela PRETA com erro      : algum arquivo do .zip não está na raiz do cartão → refaça o passo 11.
echo     - Tela AMARELA             : desligue o console e repita a partir do item 1.
echo     - Aparece só a palavra "Text": o console é um 3DS antigo, não New. Use MSET9/safecerthax.
echo     - Console TRAVOU           : segure POWER até desligar e repita a partir do item 1.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o Homebrew Launcher aparecer na tela"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "[super-skaterhax] nimdsphax → SafeB9SInstaller → Luma3DS"
echo   A PARTE CRÍTICA. Console no carregador. NÃO desligue, NÃO tire o cartão até o passo terminar.
echo.
echo   1. No Homebrew Launcher, toque em "nimdsphax" na lista e aperte (A).
echo   2. A tela deve trocar para o SafeB9SInstaller (fundo preto, texto "SafeB9SInstaller").
echo      Se em vez disso o console travar/desligar: espere 10 s, ligue e refaça o passo 15.
echo   3. A tela de CIMA mostra "Input the key combo" seguida de uma sequência de botões.
echo      Aperte EXATAMENTE os botões mostrados, na ordem (ex.: ↑ ↓ → ← A).
echo      Caso a tela de cima esteja em branco e a de baixo mostre "Crypto Status - all checks passed",
echo      aperte às cegas: Esquerda, Baixo, Direita, Cima, A  (no D-Pad).
echo   4. Espere as 7 etapas na tela de baixo ficarem VERDES ("Installing boot9strap ... done").
echo   5. Aperte (A) para reiniciar.
echo   6. O console reinicia no "Luma3DS configuration" (tela preta com opções).
echo      NÃO mude nada. Aperte START para salvar e reiniciar.
echo   7. O console volta ao menu HOME normal. Pronto: o CFW está instalado.
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
echo   Testando se o Python está acessível...
for /f "delims=" %%P in ('where python 2^>nul') do call :CHECA_STORE "%%P"
python --version 2>nul && goto PASSO_17_OK
py -3 --version 2>nul && goto PASSO_17_OK
echo   Python NÃO encontrado (ou é o atalho da Microsoft Store, que não serve).
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
call :CABECALHO 18 "[MSET9] Seção I - Preparação: criar o ID1 hackeado"
echo   O cartão precisa estar no PC (se está no console: desligue o console e repita o passo 7).
echo   O conteúdo do MSET9 .zip precisa estar na RAIZ do cartão (passo 11).
echo.
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_18
echo   1. Abra a raiz do cartão (%SDL%:\) e dê DUPLO CLIQUE em "MSET9-Windows" (MSET9-Windows.bat).
echo      Se o Windows avisar sobre segurança, "Mais informações" → "Executar assim mesmo".
echo   2. O script pergunta o MODELO e a VERSÃO: escolha New 3DS e a sua versão (ex.: 11.17).
echo   3. Digite 1 → "Create MSET9 ID1" e depois 1 de novo para aceitar o aviso.
echo   4. Deve aparecer:  "Created hacked ID1"
echo   5. Feche o script (0).
echo.
choice /c SN /n /m "   [S] Abrir a raiz do cartão agora    [N] Já abri : "
if not errorlevel 2 start "" "%SDL%:\"
call :AGUARDAR "Pressione qualquer tecla quando aparecer 'Created hacked ID1'"
echo.
echo   6. "Remover hardware com segurança" e tire o cartão do PC.
call :FIM_PASSO 18
goto %DESTINO%

:PASSO_19
cls
call :CABECALHO 19 "[MSET9] Mii Maker + Reset do banco de títulos + conferir 'Ready'"
echo   AÇÃO FÍSICA: coloque o cartão no console (passo 12: vire, abra tampa, encaixe, feche).
echo.
echo   No console:
echo    1. Ligue o console.
echo    2. Abra o "Mii Maker" (ícone com o Mii). Espere a tela de boas-vindas aparecer e volte ao HOME.
echo    3. Configurações do Console → "Gerenciamento de Dados" / "Data Management" → "Nintendo 3DS"
echo       → "Programas" / "Software" → "Reiniciar" / "Reset" → confirme.
echo       (Se NÃO aparecer o botão Reset, tudo bem: continue.)
echo    4. DESLIGUE o console completamente.
echo.
echo   AÇÃO FÍSICA: tire o cartão de novo (passo 7) e coloque no PC.
echo.
echo   No PC:
echo    5. Rode MSET9-Windows.bat de novo, escolha modelo e versão.
echo    6. A tela de status deve mostrar "Ready" (e NÃO "Not ready"). Se estiver "Not ready", o script diz o que
echo       falta (HOME Menu extdata / Mii Maker extdata / Title database) → repita o item correspondente.
echo    7. Digite 0 para fechar. "Remover hardware com segurança".
echo.
echo   AÇÃO FÍSICA: coloque o cartão de volta no console (passo 12). Deixe o console DESLIGADO.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o status for 'Ready' e o cartão estiver no console desligado"
call :FIM_PASSO 19
goto %DESTINO%

:PASSO_20
cls
call :CABECALHO 20 "[MSET9] Seção II - Disparar o exploit (remover o SD com o console LIGADO)"
echo   Siga EXATAMENTE. Não aperte nada além do indicado. Não toque na tela de baixo fora do indicado.
echo.
echo   PREPARE ANTES: chave Phillips na mão, console no carregador, tampa traseira com os parafusos
echo   já AFROUXADOS (pode deixar a tampa só encostada durante este passo).
echo.
echo    1. Ligue o console. Na tela do menu HOME, use o D-Pad para deixar o cursor em cima de
echo       "Configurações do Console" (System Settings). Não abra nada mais.
echo    2. Aperte (A) para abrir as Configurações do Console.
echo    3. Toque em "Gerenciamento de Dados" → "Nintendo 3DS" → "Dados Extras" / "Extra Data".
echo    4. Pare. Não aperte botões, não toque na tela.
echo    5. AÇÃO FÍSICA (com o console LIGADO): vire o console de lado com cuidado, levante a tampa traseira,
echo       empurre o microSD para destravar e RETIRE-O. A tela do console vai piscar e mostrar que não há cartão.
echo       Isso é esperado. Deixe o console ligado e apoiado.
echo    6. Coloque o cartão no PC. Rode MSET9-Windows.bat, escolha modelo e versão.
echo    7. Digite 3 → "Inject MSET9". Deve aparecer: "MSET9 successfully injected!"
echo    8. Feche o script (0), "Remover hardware com segurança", tire o cartão do PC.
echo    9. AÇÃO FÍSICA: coloque o cartão de volta no console (ainda ligado, na tela de Dados Extras),
echo       sem apertar botões nem tocar na tela.
echo   10. O console deve carregar sozinho a tela do SafeB9SInstaller em até 10 segundos.
echo.
echo   Se apareceu tela VERMELHA, ou ficou carregando por mais de 10 s: FALHOU. Segure POWER até desligar,
echo   coloque o SD no PC, rode o MSET9 e use a opção 4 (remover trigger). Verifique modelo/versão e
echo   repita o passo. (Ver também [E] Erros → MSET9.)
echo.
call :AGUARDAR "Pressione qualquer tecla quando o SafeB9SInstaller aparecer"
call :FIM_PASSO 20
goto %DESTINO%

:PASSO_21
cls
call :CABECALHO 21 "[MSET9] Seção III - SafeB9SInstaller → Luma3DS"
echo   A PARTE CRÍTICA. Console no carregador. NÃO desligue, NÃO tire o cartão até o passo terminar.
echo.
echo   1. A tela de CIMA mostra "Input the key combo" e uma sequência de botões. Aperte EXATAMENTE
echo      os botões mostrados, na ordem.
echo      Se a tela de cima estiver em BRANCO e a de baixo mostrar "Crypto Status - all checks passed",
echo      aperte às cegas no D-Pad: Esquerda, Baixo, Direita, Cima, A.
echo   2. Espere as 7 etapas na tela de baixo ficarem VERDES.
echo   3. Aperte (A) para reiniciar.
echo   4. O console reinicia no "Luma3DS configuration". NÃO mude nada. Aperte START.
echo   5. O console volta ao menu HOME. O CFW está instalado - mas AINDA FALTA remover o MSET9.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver de volta no menu HOME"
call :FIM_PASSO 21
goto %DESTINO%

:PASSO_22
cls
call :CABECALHO 22 "[MSET9] Seção IV - Remover o MSET9 (OBRIGATÓRIO)"
echo   Se pular isso, apps vão travar e o script 'finalize' vai dar erro #18.
echo.
echo   1. DESLIGUE o console completamente.
echo   2. AÇÃO FÍSICA: tire o cartão (passo 7) e coloque no PC.
echo   3. Rode MSET9-Windows.bat, escolha modelo e versão.
echo   4. Se o status mostrar "Injected": digite 4 (remove o arquivo de trigger). Se já mostrar "Ready", pule.
echo   5. Digite 5 → "Remove MSET9". Deve aparecer: "Successfully removed MSET9!"
echo   6. Feche o script (0). "Remover hardware com segurança".
echo   7. AÇÃO FÍSICA: coloque o cartão de volta no console e feche a tampa com os parafusos (passo 12).
echo.
call :AGUARDAR "Pressione qualquer tecla quando aparecer 'Successfully removed MSET9!' e o cartão estiver no console"
call :FIM_PASSO 22
goto %DESTINO%

rem ============================================================================
rem  BLOCO C - FINALIZAÇÃO (comum)
rem ============================================================================

:PASSO_23
cls
call :CABECALHO 23 "Finalizar (1/4): atualização do sistema (segura com Luma3DS)"
echo   Com boot9strap + Luma3DS instalados, atualizar o sistema é SEGURO e recomendado.
echo.
echo   1. Ligue o console. Conecte ao Wi-Fi se ainda não estiver (Configurações → Configurações da Internet).
echo   2. Configurações do Console → "Outras Configurações" → última aba → "Atualização do Sistema".
echo   3. Aceite. Se disser que já está atualizado, ótimo.
echo   4. Se der erro: Configurações da Internet → sua rede → alterar → DNS "Automático" e Proxy "Não";
echo      tente de novo. Se persistir, veja [E] Erros → "Não consigo atualizar".
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver atualizado (ou já estava)"
call :FIM_PASSO 23
goto %DESTINO%

:PASSO_24
cls
call :CABECALHO 24 "Finalizar (2/4): Rosalina - dump do DSP e ajuste do relógio"
echo   O Rosalina é o menu do Luma3DS que abre por cima de qualquer tela.
echo.
echo   1. No menu HOME, segure ao mesmo tempo:   L  +  D-Pad BAIXO  +  SELECT
echo      (L é o gatilho superior esquerdo; SELECT é o botão pequeno da esquerda abaixo da tela.)
echo   2. Abre um menu preto "Rosalina menu". Use o D-Pad e (A):
echo   3. "Miscellaneous options" → "Dump DSP firmware" → espere "DSP firmware dumped" → aperte (B).
echo   4. "Nullify user time offset" → aperte (B) para confirmar.
echo   5. Aperte (B) duas vezes para fechar o Rosalina.
echo.
echo   Se o Rosalina NÃO abrir: o Luma não está rodando → desligue, segure SELECT ao ligar; se não aparecer o
echo   menu do Luma, o boot.firm não está na raiz do cartão → refaça o passo 11.
echo.
call :AGUARDAR "Pressione qualquer tecla quando os dois itens estiverem feitos"
call :FIM_PASSO 24
goto %DESTINO%

:PASSO_25
cls
call :CABECALHO 25 "Finalizar (3/4): script 'finalize' no GodMode9 (instala apps e faz backup da NAND)"
echo   Requer: finalize.romfs na raiz e luma\payloads\x_finalize_helper.firm (passo 11), e no mínimo
echo   1,3 GB livres no cartão (passo 9).
echo.
echo   1. DESLIGUE o console completamente.
echo   2. SEGURE o botão (X) e, sem soltar, aperte POWER. Continue segurando X até aparecer uma tela preta
echo      com texto (é o GodMode9 sendo carregado pelo helper).
echo   3. Se perguntar sobre idioma/teclado, escolha e confirme. Se perguntar "backup essential files?"
echo      responda (A) Yes. Se perguntar sobre ajustar o relógio (RTC), pode confirmar.
echo   4. Aperte o botão HOME → abre o menu de ações → "Scripts..." → "finalize".
echo   5. Siga o que o script pede na tela. Ele vai:
echo        - pedir para "unlock SysNAND writing": digite a combinação de botões que ele mostra;
echo        - copiar os apps (FBI, Anemone3DS, Checkpoint, Universal-Updater, Homebrew Launcher...);
echo        - fazer o BACKUP DA NAND (demora alguns minutos; barra de progresso);
echo        - limpar os arquivos do exploit do cartão.
echo   6. No final aparece "Setup complete!". Aperte (A): o console desliga.
echo.
echo   Erros do script (o número aparece na tela):
echo     #02 falta essential.exefs → reinicie no GodMode9 (segure START ao ligar) e aceite o backup dos essenciais.
echo     #04 / #06 sem espaço → libere 1,3 GB (mova temporariamente a pasta Nintendo 3DS para o PC... e devolva depois).
echo     #18a/#18b MSET9 detectado → aceite: o script remove; ou refaça o passo 22.
echo     #22 finalize.romfs inválido → baixe de novo (passo 10) e substitua.
echo.
call :AGUARDAR "Pressione qualquer tecla quando aparecer 'Setup complete!' e o console desligar"
call :FIM_PASSO 25
goto %DESTINO%

:PASSO_26
cls
call :CABECALHO 26 "Finalizar (4/4): guardar o backup da NAND no PC e verificar tudo"
echo   AÇÃO FÍSICA: com o console desligado, tire o cartão (passo 7) e coloque no PC.
echo.
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_26
set "NANDBKP=%USERPROFILE%\Desktop\Backup_NAND_New3DSXL"
echo   Vou copiar %SDL%:\gm9\backups\ para %NANDBKP%
echo   (contém a NAND completa ~1,3 GB + essential.exefs: é o seu "seguro de vida" contra brick)
echo.
if not exist "%SDL%:\gm9\backups\" echo   AVISO: a pasta gm9\backups não existe no cartão. O backup não foi feito - refaça o passo 25.
if exist "%SDL%:\gm9\backups\" (robocopy "%SDL%:\gm9\backups" "%NANDBKP%" /E /R:2 /W:2 /NP /NFL /NDL & echo   Copiado. & dir /b "%NANDBKP%")
echo.
echo   Guarde essa pasta em 2 lugares (PC + nuvem/HD externo). Depois de copiar, você PODE apagar do cartão
echo   os dois arquivos grandes *_sysnand_*.bin e .bin.sha para liberar espaço. MANTENHA o essential.exefs.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o backup estiver salvo no PC"
echo.
echo   AÇÃO FÍSICA: devolva o cartão ao console, feche a tampa, aperte os parafusos, vire o console.
echo.
echo   VERIFICAÇÃO FINAL (faça as 4):
echo     1. Ligue normalmente → menu HOME aparece; novos ícones: FBI, Anemone3DS, Checkpoint, Universal-Updater,
echo        Homebrew Launcher.  (Se não aparecerem, o cartão não foi lido: reencaixe.)
echo     2. Desligue; segure SELECT e ligue → aparece o "Luma3DS configuration" (aperte START para sair).
echo     3. Desligue; segure START e ligue → aparece o GodMode9 (aperte R + START para desligar... ou POWER).
echo     4. No HOME, L + Baixo + SELECT → abre o Rosalina (B para fechar).
echo.
echo   Se quiser, volte a região do perfil para Brasil (Configurações → Outras → Perfil → Região).
echo.
call :AGUARDAR "Pressione qualquer tecla quando as 4 verificações passarem"
call :FIM_PASSO 26
goto %DESTINO%

rem ============================================================================
rem  BLOCO D - PÓS-INSTALAÇÃO
rem ============================================================================

:PASSO_27
cls
call :CABECALHO 27 "Pós-instalação (1/4): Universal-Updater e game patching do Luma"
echo   UNIVERSAL-UPDATER (loja de homebrew, já instalada pelo finalize)
echo     1. No menu HOME abra "Universal-Updater". Precisa de Wi-Fi.
echo     2. Aba de busca (lupa) → instale o que quiser. Recomendados:
echo          Nimbus         (troca entre Nintendo Network e Pretendo - passo 28)
echo          ftpd           (transferir arquivos pelo Wi-Fi sem tirar o cartão)
echo          TWiLight Menu++ (roda jogos de DS/GBA/NES/SNES pelo cartão SD)
echo          GodMode9 e Luma3DS (para atualizar depois: "Update" na própria loja)
echo     3. Apps instalados aparecem no HOME após reiniciar ou como .3dsx no Homebrew Launcher.
echo.
echo   GAME PATCHING (traduções, mods, patches de widescreen/60fps)
echo     4. Desligue; segure SELECT e ligue → menu do Luma3DS → marque com (A) "Enable game patching" → START.
echo     5. Patches ficam em  SD:\luma\titles\^<TitleID^>\   com os arquivos code.ips (ou .bps) e/ou pasta romfs\.
echo        O TitleID de cada jogo aparece no FBI → Titles → jogo (16 caracteres, ex.: 00040000000EDF00).
echo     6. Traduções PT-BR: procure o patch do jogo no site do grupo tradutor; a maioria já vem na estrutura luma\titles.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o Universal-Updater tiver instalado pelo menos o Nimbus"
call :FIM_PASSO 27
goto %DESTINO%

:PASSO_28
cls
call :CABECALHO 28 "Pós-instalação (2/4): Pretendo Network (online de volta)"
echo   A Nintendo Network desligou em 2024. A Pretendo Network é o servidor alternativo da comunidade
echo   (Miiverse, online de alguns jogos, lista de amigos). Documentação: https://pretendo.network/docs/install/3ds
echo.
echo   Requisitos: Luma3DS atualizado (13.0 ou superior; o Universal-Updater atualiza) e Nimbus instalado.
echo.
echo   1. Abra o Nimbus no HOME → escolha "Pretendo" → confirme. O console reinicia.
echo   2. Crie a conta PNID no próprio console: Configurações do Console → Configurações de Nintendo Network ID
echo      → "Criar" → siga (o Nimbus redireciona para os servidores da Pretendo). Se já tinha NNID, crie uma PNID nova.
echo   3. Confirme em https://pretendo.network/account (login com a PNID) que o console apareceu.
echo   4. Para voltar à Nintendo Network (por exemplo, para atualizar o sistema): Nimbus → "Nintendo".
echo.
echo   Erros comuns: 002-0102 (banido/não-oficial) = está no servidor errado, troque no Nimbus; 022-2634 = NNID
echo   não vinculada, use a PNID; erro ao criar conta = data/hora do console erradas.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o console estiver na Pretendo com a PNID criada (ou se for pular)"
call :FIM_PASSO 28
goto %DESTINO%

:PASSO_29
cls
call :CABECALHO 29 "Pós-instalação (3/4): backup de saves com o Checkpoint (e cópia para o PC)"
echo   NO CONSOLE
echo     1. Abra "Checkpoint" no HOME (instalado pelo finalize). Ele lista cartuchos e jogos instalados.
echo     2. Selecione o jogo com o D-Pad, aperte (A) → "Backup" → digite um nome → (A). Repita para cada jogo.
echo        Aba superior (L/R) alterna entre saves normais e "extdata".
echo     3. Restaurar depois: selecione o jogo → escolha o backup na lista → "Restore".
echo   Os backups ficam em  SD:\3ds\Checkpoint\saves\^<jogo^>\^<nome^>\  (e extdata em ...\extdata\).
echo.
echo   NO PC (opcional, recomendado): copiar a pasta do Checkpoint para a área de trabalho.
if "%SDL%"=="" call :PEDIR_SD
if "%SDL%"=="" goto PASSO_29_FIM
if not exist "%SDL%:\3ds\Checkpoint\" goto PASSO_29_SEM
set "SAVEBKP=%USERPROFILE%\Desktop\Backup_Saves_3DS"
robocopy "%SDL%:\3ds\Checkpoint" "%SAVEBKP%" /E /R:2 /W:2 /NP /NFL /NDL
echo   Copiado para %SAVEBKP%
:PASSO_29_SEM
if not exist "%SDL%:\3ds\Checkpoint\" echo   Pasta %SDL%:\3ds\Checkpoint não existe ainda ^(faça pelo menos um backup no console^).
:PASSO_29_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 29
goto %DESTINO%

:PASSO_30
cls
call :CABECALHO 30 "Pós-instalação (4/4): migrar para um cartão SD maior (sem perder nada)"
echo   Regra de ouro: o 3DS aceita trocar de cartão desde que TODO o conteúdo (inclusive a pasta "Nintendo 3DS")
echo   seja copiado igual. Jogos instalados ficam presos ao console, não ao cartão, então a cópia funciona.
echo.
echo   1. Console DESLIGADO. Tire o cartão antigo (passo 7) e coloque no PC.
set "SDL="
call :PEDIR_SD
if "%SDL%"=="" goto PASSO_30_FIM
set "MIG=%USERPROFILE%\Desktop\Migracao_3DS"
echo   2. Copiando TUDO do cartão antigo para %MIG% ...
robocopy %SDL%:\ "%MIG%" /E /R:2 /W:2 /NP /NFL /NDL /XJ
if errorlevel 8 (echo   Falha na cópia. Verifique o cartão com chkdsk %SDL%: /f e repita. & goto PASSO_30_FIM)
echo   Cópia concluída.
echo.
echo   3. Tire o cartão antigo do PC ("Remover hardware com segurança"). Coloque o cartão NOVO no PC.
echo   4. O cartão novo precisa estar em FAT32 com cluster de 32 KB e VAZIO (se veio de outro 3DS, apague a pasta
echo      Nintendo 3DS dele).
echo        - até 32 GB: o script pode formatar (abaixo).   - acima de 32 GB: use o guiformat (FAT32 Format), 32768.
set "SDL="
call :PEDIR_SD
if "%SDL%"=="" goto PASSO_30_FIM
echo.
echo   ATENÇÃO: formatar APAGA TUDO no cartão %SDL%: . Só aceite se %SDL%: for o cartão NOVO.
choice /c SN /n /m "   Formatar %SDL%: agora em FAT32 32 KB? (só até 32 GB)  [S] Sim   [N] Não, já está formatado : "
if errorlevel 2 goto PASSO_30_COPIA
set "CONF="
set /p "CONF=   Para confirmar, digite a letra %SDL% de novo: "
if /i not "%CONF%"=="%SDL%" (echo   Não confirmado. Pulando a formatação. & goto PASSO_30_COPIA)
format %SDL%: /FS:FAT32 /A:32K /Q /V:3DS /Y
:PASSO_30_COPIA
echo.
echo   5. Copiando tudo de %MIG% para o cartão novo %SDL%: ...
robocopy "%MIG%" %SDL%:\ /E /R:2 /W:2 /NP /NFL /NDL
if errorlevel 8 (echo   Falha ao copiar para o cartão novo. & goto PASSO_30_FIM)
echo   Concluído. Conferindo pastas essenciais:
set "FALTA=0"
call :CHECA "%SDL%:\boot.firm"
call :CHECA "%SDL%:\Nintendo 3DS"
call :CHECA "%SDL%:\luma"
echo.
echo   6. Recomendado: rode o H2testw no cartão novo ANTES de confiar nele (cartões falsos são comuns).
echo   7. "Remover hardware com segurança", coloque o cartão novo no console (passo 12) e ligue.
echo      Todos os jogos, saves e temas devem aparecer. Se aparecer "cartão SD não reconhecido": formato errado.
echo   8. Guarde o cartão antigo intacto por alguns dias como segurança.
:PASSO_30_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 30
goto %DESTINO%

:CONCLUIDO
cls
echo.
echo  ==========================================================================================
echo   PARABÉNS: New 3DS XL desbloqueado com boot9strap + Luma3DS.
echo  ==========================================================================================
echo.
echo   Próximos passos recomendados (opcional):
echo     - Universal-Updater : loja de homebrew (temas, emuladores, ferramentas).
echo     - FBI               : instala arquivos .cia (seus backups/homebrew).
echo     - Checkpoint        : backup e restauração de saves (faça agora um backup dos seus saves).
echo     - Anemone3DS        : temas do menu HOME.
echo     - Manter atualizado : de tempos em tempos veja 3ds.hacks.guide/restoring-updating-cfw
echo     - Online            : Nintendo Network desligou; Pretendo Network é o servidor alternativo (pretendo.network).
echo.
echo   Onde estão seus backups:
echo     - Cartão SD original : %BKP%
echo     - NAND               : %USERPROFILE%\Desktop\Backup_NAND_New3DSXL
echo.
echo   Para desfazer tudo: opção 6 do menu.  Log de tudo que você respondeu: %LOG%
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

rem ============================================================================
rem  SEÇÕES AUXILIARES
rem ============================================================================

:REQUISITOS
cls
echo.
echo   REQUISITOS
echo   ----------
echo   Hardware : New Nintendo 3DS XL (RED-001) sem CFW; carregador; chave Phillips #0/#00;
echo              microSD (FAT32, 32 KB, mín. 2 GB livres; ideal 32-64 GB Classe 10); adaptador/leitor SD para o PC.
echo   PC       : Windows 10/11. Para MSET9: Python 3 do python.org. Internet para baixar arquivos.
echo   Console  : versão 11.4 a 11.17 (abaixo disso: atualize antes). Wi-Fi 2,4 GHz só para super-skaterhax
echo              e para a atualização do sistema.
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
echo   ESTRUTURA DO CARTÃO (raiz)
echo   --------------------------
echo   \boot.firm   \boot.3dsx   \finalize.romfs   \luma\payloads\x_finalize_helper.firm   \Nintendo 3DS\
echo   + todo o conteúdo do .zip do exploit escolhido (skaterhax ou MSET9) na raiz.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:ERROS
cls
echo.
echo   ERROS COMUNS E CORREÇÕES  (causa → correção → teste)
echo   ---------------------------------------------------
echo.
echo   [SD / arquivos]
echo   - Console não lê o cartão / "SD card not recognized": formato exFAT/NTFS → formatar FAT32 32 KB (passo 9) → religar.
echo   - "Failed to apply 1 FIRM patch(es)" ou exceção no processo pm: boot.firm antigo/corrompido → baixe Luma de novo,
echo     extraia com Explorador/7-Zip (não WinRAR) → religar.
echo   - Tela preta com luz azul ao ligar: SD mal encaixado → reencaixe; espere até 10 min; renomeie "Nintendo 3DS"
echo     para "Nintendo 3DS_bak" para testar; se persistir, 3ds.hacks.guide/ctrtransfer.
echo.
echo   [super-skaterhax]
echo   - Erro branco: repita (até 10x) trocando o idioma do console entre tentativas.
echo   - Tela preta com erro: arquivos do .zip fora da raiz → passo 11.   - Tela amarela: desligue e repita.
echo   - "Text": é um 3DS antigo → use safecerthax (3ds.hacks.guide).       - Travou: segure POWER e repita.
echo   - Erro 032-0420 ao abrir o site: console JPN ou navegador bloqueado → use MSET9.
echo.
echo   [MSET9 - script]
echo   - "Python 3 is not installed": instale do python.org com "Add to PATH".
echo   - "HOME Menu extdata: Missing!": ligue o console com o cartão dentro (e volte ao PC).
echo   - "Mii Maker extdata: Missing!": abra o Mii Maker no console até a tela inicial.
echo   - "Title database: Not initialized!": Configurações → Gerenciamento de Dados → Nintendo 3DS → Programas → Reiniciar.
echo   - Error 01 (pasta Nintendo 3DS não encontrada): rode o script a partir da RAIZ do cartão.
echo   - Error 02 (write protected): trava lateral do adaptador SD; reencaixe.
echo   - Error 04 (mais de 1 ID0) / 05 (mais de 1 ID1): siga 3ds.hacks.guide/troubleshooting-mset9 (identificar a pasta certa).
echo   - Error 06: libere 16 MB.   Error 07: baixe o MSET9 de novo e extraia na raiz.
echo   - Error 18 (Windows Locale): Painel de Controle → Região → Administrativo → desmarque "Beta: usar UTF-8" → reinicie.
echo.
echo   [MSET9 - exploit]
echo   - Tela VERMELHA ao reinserir o SD: falta SafeB9S.bin na raiz → copie; remova o trigger (opção 4) e repita.
echo   - Configurações carregando sem parar: modelo/versão errados no script → opção 4, corrija, repita.
echo   - "An exception occurred" ao disparar: o console já tinha CFW → menu, opção 6/JÁ TEM CFW.
echo.
echo   [SafeB9SInstaller]
echo   - "Failed to open SafeB9SInstaller.bin": falta o .bin na raiz.   - "MicroSD Card - init failed": reformate/troque o cartão.
echo   - "SigHaxed FIRM - File not found / invalid": faltam boot9strap.firm e .sha na pasta boot9strap → baixe de novo.
echo.
echo   [Finalizing Setup]
echo   - Não consegue atualizar: DNS automático / proxy não; tente outra rede; 3ds.hacks.guide/troubleshooting-finalizing-setup.
echo   - #02, #04, #06, #18, #22: veja o passo 25 (tabela de erros do script).
echo   - Rosalina não abre: Luma não está rodando → boot.firm na raiz; SELECT ao ligar para confirmar.
echo.
echo   [Após instalar]
echo   - "An error has occurred. Hold down the POWER button": segure SELECT ao ligar → ative "Enable ARM11 exception handlers".
echo   - "Unable to mount CTRNAND": 3ds.hacks.guide/ctrtransfer.
echo   - Tela AZUL "BOOTROM ERROR": brick sério; só recupera com flashcart ntrboot ou hardmod → Discord Nintendo Homebrew.
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
echo   AVISO: só remova se realmente precisar (ex.: vender/garantia). Consoles com região alterada, tema/teclado
echo   customizado ou "unban" NÃO podem ser restaurados sem antes voltar a NAND original. Na dúvida, não remova.
echo.
echo   MÉTODO RECOMENDADO: script oficial "uninstall_cfw" no GodMode9 (guia: 3ds.hacks.guide/uninstall-cfw)
echo     1. Baixe safety_test.gm9 e uninstall_cfw.gm9 (links no guia) e coloque em SD:\gm9\scripts\ ;
echo        atualize Luma3DS e GodMode9 para as versões mais recentes; remova DSiWare/homebrew conforme o guia.
echo     2. Desligue; segure START e ligue → GodMode9 → HOME → Scripts... → "safety_test". Se FALHAR, PARE.
echo     3. HOME → Scripts... → "uninstall_cfw" → siga as instruções (unlock SysNAND) → reinicia sem CFW.
echo     4. No PC, apague do cartão: boot.firm, boot.3dsx, pasta luma, pasta gm9 e apps homebrew.
echo.
echo   ALTERNATIVA: restaurar o backup da NAND (feito no passo 25/26) pelo GodMode9:
echo     GodMode9 → navegue até [0:] SDCARD → gm9 → backups → arquivo *_sysnand_*.bin → (A) → "NAND image options"
echo     → "Restore SysNAND (safe)" → digite a combinação pedida. Isso volta o console EXATAMENTE ao estado do backup.
echo     Nunca restaure uma NAND de OUTRO console.
echo.
echo   Para desfazer só o cartão SD: copie de volta o conteúdo do backup do passo 8.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   Abrindo links oficiais no navegador padrão...
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
echo   FERRAMENTAS DO CARTÃO SD
echo   ------------------------
echo   [1] Teste de velocidade (escrita/leitura de 200 MB)
echo   [2] Verificar formato e espaço (FAT32)
echo   [3] Abrir a página do H2testw (detecta cartão falso)
echo   [4] Migrar para um cartão maior (passo 30)
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
echo   Testando %SDL%: (escreve e apaga um arquivo temporário de 200 MB; não altera seus dados)...
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand %PSSPEED%
exit /b

:SAFECERTHAX
cls
echo.
echo   ROTEIRO safecerthax  -  Old 3DS / Old 2DS (CTR-001, SPR-001, FTR-001), versões 1.0 a 11.14, todas as regiões
echo   (Old 3DS em 11.15-11.17: use o MSET9, passos 17-22 deste guia, escolhendo "Old 3DS" no script.)
echo   Fonte: 3ds.hacks.guide/installing-boot9strap-(safecerthax)
echo.
echo   I. TESTE DOS BOTÕES: ligue, no HOME aperte L + R juntos → a câmera deve abrir. Se não abrir, use MSET9.
echo   II. CARTÃO SD (no PC): copie o conteúdo do Luma3DS .zip para a raiz; crie a pasta boot9strap e coloque
echo       boot9strap.firm e boot9strap.firm.sha (release do boot9strap) dentro; SafeB9SInstaller.bin na raiz.
echo       Links: github.com/LumaTeam/Luma3DS  github.com/SciresM/boot9strap  github.com/d0k3/SafeB9SInstaller
call :AGUARDAR "Pressione qualquer tecla quando o cartão estiver pronto e de volta no console"
echo   III. PROXY: Configurações → Configurações da Internet → Configurações de Conexão → sua rede → Alterar
echo        configurações → próxima página → Configurações de Proxy → "Sim" → Configuração detalhada:
echo        Servidor proxy:  ssloth.nintendohomebrew.com     Porta:  8080   → OK → Salvar → Testar conexão → desligue.
call :AGUARDAR "Pressione qualquer tecla quando o teste de conexão passar com o proxy"
echo   IV. MODO SEGURO: com o console desligado, SEGURE  L + R + D-Pad CIMA + A  e ligue; continue segurando até
echo       aparecer o Modo Seguro → "OK" para atualizar → "Aceito" → aparece o erro 003-1099 (esperado) → "OK"
echo       → o SafeB9SInstaller abre.
call :AGUARDAR "Pressione qualquer tecla quando o SafeB9SInstaller aparecer"
echo   V. Digite a combinação de botões mostrada → espere concluir → (A) reinicia → menu do Luma3DS → START.
echo   VI. REMOVER O PROXY: mesmo caminho do passo III → Proxy "Não" → Salvar → Testar conexão.
echo   Depois continue no passo 23 (Finalizar) deste guia: os passos 23-30 valem para o Old 3DS também.
echo.
choice /c 12 /n /m "   [1] Ir para o passo 23 (Finalizar)    [2] Menu : "
if errorlevel 2 goto MENU
goto PASSO_23

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
choice /c SN /n /m "%~1  [S] Sim   [N] Não : "
if errorlevel 2 exit /b 2
exit /b 1

:CHECA_STORE
echo %~1| findstr /i "WindowsApps" >nul && echo   AVISO: o "python" encontrado é o da Microsoft Store: %~1 - ele NÃO serve para o MSET9. Instale pelo python.org.
exit /b

:CHECA
if exist "%~1" echo     OK     %~1
if not exist "%~1" echo     FALTA  %~1
if not exist "%~1" set /a FALTA+=1
exit /b

:PEDIR_SD
set "SDL="
set /p "SDL=   Digite a LETRA da unidade do cartão SD (ex.: E) ou ENTER para cancelar: "
if "%SDL%"=="" exit /b
set "SDL=%SDL:~0,1%"
if not exist %SDL%:\ (echo   Unidade %SDL%: não encontrada. & set "SDL=" & exit /b)
if /i "%SDL%"=="C" (echo   C: é o disco do Windows, não o cartão! & set "SDL=" & exit /b)
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
choice /c SRME /n /m "   [S] Próximo passo    [R] Repetir este passo    [M] Menu    [E] Erros e correções : "
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
