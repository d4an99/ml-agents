@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul 2>&1
title Guia interativo - Meta Quest 3S: ambiente Android, emuladores (3DS/NDS/PS2/Xbox/Switch) e Stremio
color 0E
mode con: cols=112 lines=50 >nul 2>&1

rem ============================================================================
rem  GUIA INTERATIVO - META QUEST 3S (PARTE 2)
rem  Launcher Android (Lightning Launcher), emuladores CitraVR (3DS), melonDS (NDS),
rem  NetherSX2 (PS2), X1 BOX/xemu (Xbox original), Eden (Switch), Xbox Cloud Gaming e Stremio.
rem  Pre-requisito: Modo Desenvolvedor + SideQuest funcionando (guia Desbloqueio_Meta_Quest_3S.bat).
rem  Fontes: GitHub oficial de cada projeto, Meta Help, stremio.com (consultados em set/2026).
rem  Salve como UTF-8 SEM BOM com finais de linha CRLF.
rem ============================================================================

set "PASTA=%~dp0"
set "PROG=%PASTA%progresso_quest3s_emuladores.txt"
set "TOTAL=26"
set "ASCII=1"
set "PSB64=CgAkAHMAcgBjAD0AJABlAG4AdgA6AFMAQQBfAFMAUgBDADsAIAAkAGQAcwB0AD0AJABlAG4AdgA6AFMAQQBfAEQAUwBUAAoAJAB0AD0AWwBJAE8ALgBGAGkAbABlAF0AOgA6AFIAZQBhAGQAQQBsAGwAVABlAHgAdAAoACQAcwByAGMALABbAFQAZQB4AHQALgBFAG4AYwBvAGQAaQBuAGcAXQA6ADoAVQBUAEYAOAApAAoAJABtAGEAcAA9AEAAewAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADQAKQA9ACcAIABvAHUAIAAnADsACgAgACgAWwBzAHQAcgBpAG4AZwBdAFsAYwBoAGEAcgBdADAAeAAyADYAMwAwACkAPQAnAFsAbQBlAG4AdQBdACcAOwAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIANwAxADMAKQA9ACcATwBLACcAOwAKACAAKAAnAOVlLGcnACkAPQAnAE4AaQBoAG8AbgAgACgASgBhAHAAYQBvACkAJwA7AAoAIAAoACcALYqaW1cwajBEMCcAKQA9ACcAbgBhAG8AIABkAGUAZgBpAG4AaQByACcAOwAKACAAKAAnAACzXNX8u22tJwApAD0AJwBEAGEAZQBoAGEAbgAgAE0AaQBuAGcAdQBrACAAKABDAG8AcgBlAGkAYQApACcAOwAKACAAKAAnACTBFchY1cDJIABKxUzHJwApAD0AJwBuAGEAbwAgAGQAZQBmAGkAbgBpAHIAJwAKAH0ACgBmAG8AcgBlAGEAYwBoACgAJABrACAAaQBuACAAJABtAGEAcAAuAEsAZQB5AHMAKQB7ACAAJAB0AD0AJAB0AC4AUgBlAHAAbABhAGMAZQAoACQAawAsACQAbQBhAHAAWwAkAGsAXQApACAAfQAKACQAYQByAHIAbwB3AD0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADIACgAkAHMAYgAyAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFQAZQB4AHQALgBTAHQAcgBpAG4AZwBCAHUAaQBsAGQAZQByAAoAZgBvAHIAZQBhAGMAaAAoACQAbABpAG4AZQAgAGkAbgAgACQAdAAgAC0AcwBwAGwAaQB0ACAAIgBgAHIAYABuACIAKQB7AAoAIAAgAGkAZgAoACQAbABpAG4AZQAuAEkAbgBkAGUAeABPAGYAKAAkAGEAcgByAG8AdwApACAALQBnAGUAIAAwACkAewAKACAAIAAgACAAJABxAD0AJABmAGEAbABzAGUAOwAgACQAbgBsAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAFQAZQB4AHQALgBTAHQAcgBpAG4AZwBCAHUAaQBsAGQAZQByAAoAIAAgACAAIABmAG8AcgBlAGEAYwBoACgAJABjACAAaQBuACAAJABsAGkAbgBlAC4AVABvAEMAaABhAHIAQQByAHIAYQB5ACgAKQApAHsACgAgACAAIAAgACAAIABpAGYAKAAkAGMAIAAtAGUAcQAgACcAIgAnACkAewAgACQAcQA9AC0AbgBvAHQAIAAkAHEAOwAgAFsAdgBvAGkAZABdACQAbgBsAC4AQQBwAHAAZQBuAGQAKAAkAGMAKQAgAH0ACgAgACAAIAAgACAAIABlAGwAcwBlAGkAZgAoACQAYwAgAC0AZQBxACAAJABhAHIAcgBvAHcAKQB7ACAAaQBmACgAJABxACkAewBbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJwAtAD4AJwApAH0AIABlAGwAcwBlACAAewBbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJwAtAF4APgAnACkAfQAgAH0ACgAgACAAIAAgACAAIABlAGwAcwBlAHsAIABbAHYAbwBpAGQAXQAkAG4AbAAuAEEAcABwAGUAbgBkACgAJABjACkAIAB9AAoAIAAgACAAIAB9AAoAIAAgACAAIAAkAGwAaQBuAGUAPQAkAG4AbAAuAFQAbwBTAHQAcgBpAG4AZwAoACkACgAgACAAfQAKACAAIABbAHYAbwBpAGQAXQAkAHMAYgAyAC4AQQBwAHAAZQBuAGQAKAAkAGwAaQBuAGUAKQA7ACAAWwB2AG8AaQBkAF0AJABzAGIAMgAuAEEAcABwAGUAbgBkACgAIgBgAHIAYABuACIAKQAKAH0ACgAkAHQAPQAkAHMAYgAyAC4AVABvAFMAdAByAGkAbgBnACgAKQA7ACAAaQBmACgAJAB0AC4ATABlAG4AZwB0AGgAIAAtAGcAZQAgADIAKQB7ACAAJAB0AD0AJAB0AC4AUwB1AGIAcwB0AHIAaQBuAGcAKAAwACwAJAB0AC4ATABlAG4AZwB0AGgALQAyACkAIAB9AAoAJABuAD0AJAB0AC4ATgBvAHIAbQBhAGwAaQB6AGUAKABbAFQAZQB4AHQALgBOAG8AcgBtAGEAbABpAHoAYQB0AGkAbwBuAEYAbwByAG0AXQA6ADoARgBvAHIAbQBEACkACgAkAHMAYgA9AE4AZQB3AC0ATwBiAGoAZQBjAHQAIABUAGUAeAB0AC4AUwB0AHIAaQBuAGcAQgB1AGkAbABkAGUAcgAKAGYAbwByAGUAYQBjAGgAKAAkAGMAIABpAG4AIAAkAG4ALgBUAG8AQwBoAGEAcgBBAHIAcgBhAHkAKAApACkAewAKACAAIABpAGYAKABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBDAGgAYQByAFUAbgBpAGMAbwBkAGUASQBuAGYAbwBdADoAOgBHAGUAdABVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQAoACQAYwApACAALQBuAGUAIABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQBdADoAOgBOAG8AbgBTAHAAYQBjAGkAbgBnAE0AYQByAGsAKQB7ACAAWwB2AG8AaQBkAF0AJABzAGIALgBBAHAAcABlAG4AZAAoACQAYwApACAAfQAKAH0ACgAkAG8AdQB0AD0AJABzAGIALgBUAG8AUwB0AHIAaQBuAGcAKAApAAoAJABvAHUAdAA9AFsAcgBlAGcAZQB4AF0AOgA6AFIAZQBwAGwAYQBjAGUAKAAkAG8AdQB0ACwAJwBbAF4AXAB4ADAAMAAtAFwAeAA3AEYAXQAnACwAJwA/ACcAKQAKACQAbwB1AHQAPQAkAG8AdQB0AC4AUgBlAHAAbABhAGMAZQAoACcAcwBlAHQAIAAiAEEAUwBDAEkASQA9ADAAIgAnACwAJwBzAGUAdAAgACIAQQBTAEMASQBJAD0AMQAiACcAKQAKAFsASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABzAHQALAAkAG8AdQB0ACwAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAVABlAHgAdAAuAFUAVABGADgARQBuAGMAbwBkAGkAbgBnACgAJABmAGEAbABzAGUAKQApACkACgA="
set "DESTINO=MENU"
set "VOLTAR=MENU"
set "PASSO=0"
set "ADB="
set "QROOT=/sdcard/Emuladores"
call :CARREGAR

:MENU
cls
echo.
echo  ============================================================================================
echo   META QUEST 3S (PARTE 2)  -  AMBIENTE ANDROID, EMULADORES E STREMIO
echo  ============================================================================================
echo.
echo   Cobre: launcher Android (Lightning Launcher), CitraVR (3DS), melonDS (NDS), NetherSX2 (PS2),
echo   X1 BOX/xemu (Xbox original), Xbox Cloud Gaming, Eden (Switch), como colocar jogos, como jogar e Stremio.
echo.
echo   Pre-requisito: o guia 1 (Desbloqueio_Meta_Quest_3S.bat) concluido - Modo Desenvolvedor ligado
echo   e SideQuest com a bolinha VERDE.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: voce parou no passo %PASSO% de %TOTAL%.
if not "%PASSO%"=="0" echo.
echo   [1] Comecar do inicio          [6] Como desfazer (remover apps / voltar ao padrao)
echo   [2] Continuar de onde parei    [7] Abrir links oficiais
echo   [3] Ir para um passo/console   [8] Ferramentas ADB (criar pastas, instalar APK, enviar jogos)
echo   [4] Requisitos e downloads     [9] Apagar o progresso salvo
echo   [5] Erros comuns               [A] Modo sem acentos (texto com caracteres estranhos)
echo                                  [0] Sair
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
echo    BASE                                              XBOX
echo     1  O que e "Android no Quest" e regras            11  Xbox original: X1 BOX / xemu (experimental)
echo     2  Pre-requisitos e espaco livre                  12  Xbox 360/One/Series: Cloud Gaming e streaming do PC
echo     3  Parear um controle Bluetooth (fisico)         SWITCH
echo     4  Criar a estrutura de pastas no headset         13  Eden: requisitos (keys e firmware do SEU Switch)
echo     5  Lightning Launcher (o "sistema Android")       14  Eden: instalar, configurar driver GPU e jogar
echo    3DS                                               COMO JOGAR
echo     6  CitraVR: instalar                              15  Como jogar apps 2D em VR (janela, controle, bateria)
echo     7  CitraVR: preparar e enviar os jogos            16  Organizar biblioteca e backups de saves
echo     8  CitraVR: configurar e jogar (Touch controllers) STREMIO
echo    NDS                                                17  Stremio: instalar
echo     9  melonDS: instalar, jogos, controles            18  Stremio: conta, add-ons e reproducao
echo    PS2                                                19  Stremio: dicas para VR (janela, audio, legendas)
echo    10  NetherSX2: instalar, BIOS, jogos, desempenho   26  Verificacao final
echo    MAIS EMULADORES                                   EXTRAS
echo    20  RetroArch (NES/SNES/MD/GBA/PS1/N64/DC/Saturn)     23  Streaming completo do PC (Sunshine + Moonlight)
echo    21  PPSSPP (PSP)                                      24  Backup automatico de saves (tarefa agendada)
echo    22  Dolphin (GameCube/Wii)                            25  Icones, capas e atalhos (Lightning Launcher/Daijisho)
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
rem  BLOCO A - BASE
rem ============================================================================

:PASSO_1
cls
call :CABECALHO 1 "O que e 'Android no Quest' e regras do jogo"
echo   O Horizon OS do Quest 3S JA E Android (base AOSP). Nao existe outro "sistema Android" para instalar,
echo   nem custom ROM, nem root. O que da para fazer, e e o que este guia faz:
echo     - instalar qualquer APK Android compativel (arm64) por sideload;
echo     - instalar um LAUNCHER (Lightning Launcher) que mostra todos os apps como um celular/Android TV,
echo       abre apps 2D em janelas de tamanho ajustavel e organiza em grupos;
echo     - usar controle Bluetooth como em um console.
echo.
echo   EMULADORES QUE FUNCIONAM NO QUEST 3S (set/2026):
echo     3DS   -^> CitraVR   (nativo em VR, feito para Quest, suporta Quest 3S)       ....... BOM
echo     NDS   -^> melonDS   (app 2D Android, roda em janela)                           ....... OTIMO
echo     PS2   -^> NetherSX2 (app 2D, base AetherSX2/PCSX2)                             ....... BOM (1x-2x)
echo     Xbox  -^> X1 BOX / xemu-android (port nao oficial, experimental, pesado)      ....... FRACO
echo     Xbox 360 / One / Series -^> NAO ha emulador Android; use Xbox Cloud Gaming ou streaming do PC.
echo     Switch -^> Eden (app 2D; XR2 Gen 2 e mais fraco que celular top: jogos leves ok) .. EXPERIMENTAL
echo.
echo   REGRAS:
echo     1. Jogos, BIOS e chaves (keys) devem vir dos SEUS consoles/jogos. O 3DS que voce desbloqueou no
echo        guia 1 serve para extrair seus jogos (GodMode9). Este guia nao cobre downloads de jogos.
echo     2. Baixe APKs SOMENTE do GitHub oficial de cada projeto (links no menu 7).
echo     3. Tudo e reversivel: desinstalar o app remove o emulador; as pastas de jogos voce apaga quando quiser.
echo.
call :AGUARDAR "Li e entendi. Pressione qualquer tecla para continuar"
call :FIM_PASSO 1
goto %DESTINO%

:PASSO_2
cls
call :CABECALHO 2 "Pre-requisitos e espaco livre"
echo   1. Modo Desenvolvedor ligado e SideQuest com bolinha VERDE (guia 1). Se nao estiver, rode o guia 1.
echo   2. Cabo USB-C conectado ao PC (ou ADB sem fio ja ativado).
echo   3. Espaco livre no headset: coloque o headset -^> Configuracoes -^> Armazenamento.
echo        Reserve:  3DS 1-4 GB por jogo   /   NDS ate 512 MB   /   PS2 1-4,5 GB por jogo   /   Switch 1-16 GB por jogo
echo        + firmware do Switch ~ 400 MB.  O Quest 3S de 128 GB comporta bem uma biblioteca pequena.
echo   4. Bateria: conecte o carregador durante instalacoes grandes (adb push de varios GB demora).
echo.
echo   Teste automatico da conexao ADB:
call :ACHAR_ADB
if defined ADB "%ADB%" devices
echo.
call :AGUARDAR "Pressione qualquer tecla quando aparecer o numero de serie com 'device' acima"
call :FIM_PASSO 2
goto %DESTINO%

:PASSO_3
cls
call :CABECALHO 3 "Parear um controle Bluetooth (acao fisica)"
echo   Os Touch controllers funcionam no CitraVR e como mouse nos apps 2D. Para NDS/PS2/Xbox/Switch use um
echo   controle Bluetooth de verdade: Xbox Wireless (Series), DualSense, 8BitDo Pro 2/Ultimate, Switch Pro.
echo.
echo   1. ACAO FISICA: ponha o controle em modo de pareamento:
echo        Xbox: segure o botao de pareamento (em cima, perto do USB) ate o logo piscar rapido.
echo        DualSense: segure Create + PS ate a barra de luz piscar.
echo        8BitDo: segure Start por 3 s (modo X ou D), depois o botao de pareamento.
echo   2. ACAO FISICA: coloque o headset. Botao Meta -^> Configuracoes -^> "Dispositivos" -^> "Bluetooth" -^>
echo      "Parear" / "Parear novo dispositivo" -^> escolha o controle na lista -^> aguarde "Conectado".
echo   3. Teste: no menu do Quest, mexa o analogico; o cursor/selecao deve responder.
echo.
echo   Sem controle fisico? Da para jogar NDS/PS2 com o Touch como mouse + botoes virtuais na tela,
echo   mas e ruim. Vale muito a pena um controle.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o controle aparecer como Conectado (ou se for pular)"
call :FIM_PASSO 3
goto %DESTINO%

:PASSO_4
cls
call :CABECALHO 4 "Criar a estrutura de pastas no headset (automatico via ADB)"
echo   Estrutura que vamos usar (armazenamento interno do headset, o que o Windows mostra como
echo   "Quest 3S\Armazenamento interno compartilhado"):
echo.
echo     %QROOT%\
echo       BIOS\            (BIOS do PS2, mcpx/BIOS/HDD do Xbox, firmware+keys do Switch)
echo       ROMs\3DS\        (.3ds / .cci / .cxi DESCRIPTOGRAFADOS)
echo       ROMs\NDS\        (.nds)
echo       ROMs\PS2\        (.iso / .chd / .cso)
echo       ROMs\Xbox\       (.iso / .xiso)
echo       ROMs\Switch\     (.nsp / .xci)
echo       ROMs\PSP\  ROMs\GC\  ROMs\Wii\          (PPSSPP e Dolphin - passos 21 e 22)
echo       ROMs\Retro\NES SNES MD GBA PS1 N64 DC Saturn   (RetroArch - passo 20)
echo       Saves_Backup\    (copias de saves)
echo.
call :ACHAR_ADB
if not defined ADB goto PASSO_4_MANUAL
choice /c SN /n /m "   [S] Criar as pastas agora via ADB    [N] Vou criar manualmente : "
if errorlevel 2 goto PASSO_4_MANUAL
"%ADB%" shell "mkdir -p %QROOT%/BIOS %QROOT%/ROMs/3DS %QROOT%/ROMs/NDS %QROOT%/ROMs/PS2 %QROOT%/ROMs/Xbox %QROOT%/ROMs/Switch %QROOT%/Saves_Backup %QROOT%/ROMs/PSP %QROOT%/ROMs/GC %QROOT%/ROMs/Wii %QROOT%/ROMs/Retro/NES %QROOT%/ROMs/Retro/SNES %QROOT%/ROMs/Retro/MD %QROOT%/ROMs/Retro/GBA %QROOT%/ROMs/Retro/PS1 %QROOT%/ROMs/Retro/N64 %QROOT%/ROMs/Retro/DC %QROOT%/ROMs/Retro/Saturn"
echo.
echo   Conferindo:
"%ADB%" shell "ls -la %QROOT% %QROOT%/ROMs"
goto PASSO_4_FIM
:PASSO_4_MANUAL
echo.
echo   Manual: Explorador do Windows -^> "Quest 3S" (MTP; aceite "Permitir acesso aos dados" no headset)
echo   -^> Armazenamento interno compartilhado -^> crie a pasta Emuladores e as subpastas acima.
echo   Se o Quest nao aparecer no Explorador: headset -^> Configuracoes -^> Sistema -^> Desenvolvedor -^> "Notificacao MTP" ligada,
echo   reconecte o cabo e aceite a notificacao dentro do headset.
:PASSO_4_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando as pastas existirem"
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Lightning Launcher: o 'sistema Android' do Quest"
echo   O Lightning Launcher mostra apps oficiais e sideloaded numa grade, abre apps 2D em janelas com tamanho
echo   ajustavel, agrupa (Emuladores, Video, Jogos...), esconde e renomeia apps. E o que da a sensacao de
echo   "Android TV" dentro do Quest.
echo.
echo   1. Baixe o APK:  https://github.com/threethan/LightningLauncher/releases/latest
echo      (arquivo LightningLauncher-*.apk; ou instale pelo catalogo do SideQuest, app 21783)
echo   2. Instale: arraste o .apk para a janela do SideQuest (ou use a opcao 8 do menu -^> Instalar APK).
echo   3. ACAO FISICA: coloque o headset -^> Biblioteca -^> filtro "Fontes desconhecidas" -^> "Lightning Launcher".
echo   4. Na primeira abertura, aceite as permissoes. Va em Configuracoes (engrenagem) -^>
echo      "Shortcut Settings" e escolha como abrir o launcher (ex.: ao passar o ponteiro sobre o icone
echo      da Biblioteca na barra). Voce tambem pode fixa-lo na barra (dock) como qualquer app.
echo   5. Ainda em Configuracoes: ative "Open 2D apps in windows" e escolha o tamanho padrao da janela.
echo   6. Crie grupos: segure o clique (gatilho) num app -^> "Group" -^> "Emuladores", "Video" etc.
echo.
echo   Dica: mantenha o Horizon Home como esta; o Lightning Launcher e um app por cima, nao substitui o sistema.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o Lightning Launcher abrir e listar seus apps"
call :FIM_PASSO 5
goto %DESTINO%

rem ============================================================================
rem  BLOCO B - 3DS (CitraVR)
rem ============================================================================

:PASSO_6
cls
call :CABECALHO 6 "CitraVR (3DS): instalar"
echo   CitraVR e um port do Citra/Azahar feito para Quest: as duas telas do 3DS flutuam a sua frente em VR,
echo   com os Touch controllers mapeados como um 3DS. Suporta Quest 2, Pro, 3 e 3S.
echo.
echo   1. Baixe:  https://github.com/amwatson/CitraVR/releases/latest   -^> arquivo CitraVR.apk (ou CitraVR-*.apk)
echo   2. Instale pelo SideQuest (arraste o .apk) ou pela opcao 8 do menu.
echo   3. ACAO FISICA: coloque o headset -^> Biblioteca -^> "Fontes desconhecidas" -^> "CitraVR". Abra uma vez para
echo      ele criar as pastas e pedir permissoes. Se o botao OK do navegador de arquivos nao responder:
echo      saia, Configuracoes do Quest -^> busque "permissoes de apps" -^> CitraVR -^> ligue "Microfone" -^> reabra.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o CitraVR tiver aberto pelo menos uma vez"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "CitraVR (3DS): preparar e enviar os jogos"
echo   FORMATO: o nucleo Azahar (CitraVR 0.6+) so aceita jogos DESCRIPTOGRAFADOS (.3ds/.cci/.cxi/.app).
echo   Jogos criptografados nao abrem.
echo.
echo   Como extrair do SEU 3DS (que voce desbloqueou no guia do New 3DS XL):
echo     Cartucho: desligue, segure START e ligue -^> GodMode9 -^> [C:] GAMECART -^> (A) no .3ds -^> "Dump title"...
echo               hacks.guide: https://github.com/amwatson/CitraVR/wiki/Backing-up-3DS-Games
echo     Jogo instalado: GodMode9 -^> [A:] SYSNAND SD -^> title -^> ... -^> "Dump CXI/NDS file" (gera .cxi ja decriptado)
echo     Ou decriptar um .3ds no proprio GodMode9: (A) no arquivo -^> "NCSD image options" -^> "Decrypt file (0:/gm9/out)"
echo     Os arquivos ficam em SD:\gm9\out\ do cartao do 3DS. Copie para o PC.
echo.
echo   Envio para o headset (escolha uma):
echo     A) Opcao 8 do menu -^> "Enviar jogos" -^> informe a pasta do PC -^> destino %QROOT%/ROMs/3DS  (adb push)
echo     B) Explorador do Windows (MTP): arraste para Quest 3S -^> Armazenamento interno -^> Emuladores -^> ROMs -^> 3DS
echo.
choice /c SN /n /m "   [S] Enviar uma pasta de jogos 3DS agora via ADB    [N] Ja enviei / vou usar o Explorador : "
if errorlevel 2 goto PASSO_7_FIM
call :ENVIAR "%QROOT%/ROMs/3DS"
:PASSO_7_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando os jogos estiverem em Emuladores\ROMs\3DS no headset"
call :FIM_PASSO 7
goto %DESTINO%

:PASSO_8
cls
call :CABECALHO 8 "CitraVR (3DS): configurar e jogar com os Touch controllers"
echo   ACAO FISICA: coloque o headset, abra o CitraVR (Biblioteca -^> Fontes desconhecidas).
echo.
echo   1. Na tela inicial, toque em "Add games folder" / icone de pasta -^> navegue ate
echo      Emuladores -^> ROMs -^> 3DS -^> "Use this folder" / OK. Os jogos aparecem na lista.
echo   2. Toque no jogo. As duas telas do 3DS aparecem a sua frente.
echo   3. Controles Touch (diagrama oficial: wiki "Touch Controller Input Bindings"):
echo        Analogico esquerdo = Circle Pad     Analogico direito = C-Stick
echo        A/B/X/Y = A/B/X/Y do 3DS           Gatilhos = L/R      Grips = ZL/ZR
echo        Pressionar os analogicos = D-Pad / Start / Select (veja o diagrama)
echo        Tela de toque (tela de baixo): aponte com o controle e aperte o gatilho, como uma caneta.
echo        Segure o botao META (controle direito) para RECENTRALIZAR as telas.
echo   4. Menu do emulador em VR: aperte o botao de menu ([menu], controle esquerdo) -^> "Settings":
echo        Renderer: Vulkan (padrao)   /   Async shader compilation: ON (padrao)   /   Resolution: 2x (3S aguenta)
echo        Se travar/engasgar: Resolution 1x e "Use disk shader cache" ON.
echo   5. Para um controle Bluetooth: Settings -^> Controller -^> Input Bindings. Se sempre aparecer
echo      "Virtual Device 4", aperte Select+Start no controle logo antes de mapear cada botao.
echo.
echo   Jogos que precisam de arquivos do sistema (Mii, tema, DLC): copie do seu 3DS a pasta
echo   Nintendo 3DS\...\ (sysdata) conforme a wiki; a maioria dos jogos NAO precisa disso.
echo.
call :AGUARDAR "Pressione qualquer tecla quando um jogo de 3DS estiver rodando"
call :FIM_PASSO 8
goto %DESTINO%

rem ============================================================================
rem  BLOCO C - NDS (melonDS)
rem ============================================================================

:PASSO_9
cls
call :CABECALHO 9 "melonDS (NDS): instalar, colocar jogos e configurar controles"
echo   INSTALAR
echo   1. Baixe:  https://github.com/rafaelvcaetano/melonDS-android/releases/latest
echo      -^> arquivo app-gitHub-prod-release.apk (versao GitHub; a da Play Store nao instala no Quest).
echo   2. Instale pelo SideQuest ou pela opcao 8 do menu.
echo.
echo   JOGOS
echo   3. Copie seus .nds para %QROOT%/ROMs/NDS (opcao 8 -^> Enviar jogos, ou Explorador/MTP).
echo      Do seu 3DS: GodMode9 dumpa cartuchos DS pelo [C:] GAMECART tambem (gera .nds).
echo.
echo   CONFIGURAR (headset na cabeca; o melonDS abre como janela 2D)
echo   4. Abra melonDS (Fontes desconhecidas). Na primeira vez ele pede "ROM search directories":
echo      toque em "+" -^> Emuladores -^> ROMs -^> NDS -^> "Use this folder". A lista de jogos aparece.
echo   5. Configuracoes -^> "System" -^> "Console type: DS". BIOS/firmware de DS NAO sao obrigatorios
echo      (ele usa uma BIOS interna). Para modo DSi voce precisaria dos dumps do seu DSi/3DS.
echo   6. Configuracoes -^> "Input" -^> "Key mapping" -^> mapeie o controle Bluetooth (A, B, X, Y, L, R, Start, Select, D-Pad).
echo      Toque na tela de baixo: aponte com o Touch controller e aperte o gatilho.
echo   7. Configuracoes -^> "Video": "Renderer: OpenGL", "Internal resolution: 2x-4x", "Threaded rendering: ON",
echo      "JIT: ON" (em Configuracoes -^> System, se disponivel). Layout: "Layout editor" para por as telas lado a lado.
echo.
echo   JOGAR: toque no jogo na lista. Saves ficam em Android/data/me.magnum.melonds/files/saves (faca backup).
echo.
choice /c SN /n /m "   [S] Enviar uma pasta de jogos NDS agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/NDS"
call :AGUARDAR "Pressione qualquer tecla quando um jogo de DS estiver rodando"
call :FIM_PASSO 9
goto %DESTINO%

rem ============================================================================
rem  BLOCO D - PS2 (NetherSX2)
rem ============================================================================

:PASSO_10
cls
call :CABECALHO 10 "NetherSX2 (PS2): instalar, BIOS, jogos e desempenho"
echo   NetherSX2-classic = AetherSX2 (base PCSX2) com correcoes da comunidade. O AetherSX2 original foi
echo   descontinuado; use SOMENTE o APK do GitHub oficial do NetherSX2.
echo.
echo   INSTALAR
echo   1. Baixe:  https://github.com/Trixarian/NetherSX2-classic/releases/latest  -^> NetherSX2-vX.X-3668.apk
echo   2. Instale pelo SideQuest ou pela opcao 8 do menu.
echo.
echo   BIOS (obrigatoria; vem do SEU PS2)
echo   3. Dump da BIOS com o PS2 (FreeMcBoot + biosdrain) gera um .bin (ex.: SCPH-70004_BIOS_V12_EUR_200.bin).
echo      Copie para %QROOT%/BIOS.
echo.
echo   JOGOS
echo   4. Seus discos em .iso ou .chd (CHD ocupa menos; converta no PC com chdman). Copie para %QROOT%/ROMs/PS2.
echo.
echo   CONFIGURAR (headset na cabeca, app 2D)
echo   5. Abra NetherSX2 -^> assistente inicial: "BIOS" -^> escolha a pasta Emuladores/BIOS -^> selecione a BIOS;
echo      "Game directories" -^> Emuladores/ROMs/PS2 -^> "Use this folder". A lista aparece com capas.
echo   6. Configuracoes -^> Graphics:  Renderer "Vulkan"   /   Upscale "1.5x ou 2x" (3S roda 2x na maioria dos jogos)
echo      Se cair FPS: 1x. "Widescreen patches: ON" para 16:9.
echo   7. Configuracoes -^> System: "EE cycle rate 100%%", "Cycle skip 0" (so mude em jogos muito pesados: EE 75%%).
echo   8. Configuracoes -^> Controller -^> Port 1 -^> "Automatic mapping" com o controle Bluetooth ligado, ou mapeie manual.
echo   9. Toque no jogo. Menu do emulador: botao "voltar" do controle ou o icone no canto -^> save states, fechar.
echo.
choice /c SN /n /m "   [S] Enviar uma pasta de jogos PS2 agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/PS2"
call :AGUARDAR "Pressione qualquer tecla quando um jogo de PS2 estiver rodando"
call :FIM_PASSO 10
goto %DESTINO%

rem ============================================================================
rem  BLOCO E - XBOX
rem ============================================================================

:PASSO_11
cls
call :CABECALHO 11 "Xbox original: X1 BOX / xemu-android (experimental)"
echo   SITUACAO (set/2026): existe um port NAO oficial do xemu para Android chamado X1 BOX. A versao paga
echo   da Play Store e polemica; a versao gratuita esta no GitHub. A equipe do xemu confirmou que fara um
echo   Android oficial, sem data. Requisitos: Android 8+, arm64, GPU Vulkan, 8 GB de RAM (o Quest 3S tem 8 GB,
echo   mas o sistema usa parte). Espere desempenho FRACO: teste so jogos leves.
echo.
echo   1. Baixe o APK gratuito em  https://github.com/izzy2lost/xemu/releases  (release mais recente).
echo      Alternativa: https://github.com/WinDroidEmulation/X1-BOX/releases  (versao mais antiga).
echo      Confira a data da release antes de baixar; o projeto muda de maos com frequencia.
echo   2. Instale pelo SideQuest / opcao 8.
echo   3. ARQUIVOS DO SEU XBOX (o app tem um assistente que pede cada um):
echo        mcpx_1.0.bin          (boot ROM MCPX)
echo        Complex_4627.bin      (BIOS/flash ROM)
echo        xbox_hdd.qcow2        (imagem de HD; o xemu para PC gera uma vazia, use a mesma)
echo      Copie os tres para %QROOT%/BIOS. Jogos: .iso/.xiso extraidos dos seus discos -^> %QROOT%/ROMs/Xbox.
echo   4. Abra o app (2D) -^> assistente -^> aponte cada arquivo -^> em "Games" aponte a pasta ROMs/Xbox.
echo   5. Controle: Bluetooth (mapeado automaticamente como Xbox) ou controle virtual na tela.
echo.
echo   Se travar na tela do Xbox (bolha verde) ou fechar: o jogo nao e compativel ainda. Veja a lista de
echo   compatibilidade do xemu (xemu.app/titles) e lembre que no Android e ainda menor.
echo.
choice /c SN /n /m "   [S] Enviar jogos de Xbox agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/Xbox"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Xbox 360 / One / Series: Cloud Gaming oficial e streaming do PC"
echo   Nao existe emulador de Xbox 360/One/Series para Android. Duas formas reais de jogar Xbox no Quest 3S:
echo.
echo   A) XBOX CLOUD GAMING (oficial, sem sideload)  -^> METODO RECOMENDADO para jogos modernos
echo      1. Headset -^> Loja (Meta Horizon Store) -^> busque "Xbox" -^> instale o app "Xbox" (gratis).
echo         Requer Horizon OS build 60 ou mais recente (voce ja atualizou no guia 1).
echo      2. Precisa de assinatura Xbox Game Pass (Ultimate para o catalogo completo; alguns jogos free-to-play
echo         funcionam so com conta Microsoft). O plano Horizon+ do Quest tambem inclui horas de Cloud Gaming.
echo      3. Controle: Bluetooth (Xbox Wireless, DualShock 4, Switch Pro, Backbone...). A Meta anunciou
echo         emulacao de gamepad com os Touch controllers; se a opcao existir no app, use.
echo      4. Abra o app Xbox -^> entre com a conta Microsoft -^> escolha o jogo -^> "Play". A tela vira um telao VR.
echo      5. Internet: 20 Mbps ou mais e Wi-Fi 5 GHz; fique perto do roteador.
echo.
echo   B) STREAMING DO SEU PC (para 360 via emulador Xenia, ou jogos do PC/Game Pass PC)
echo      1. No PC: instale Xenia (xenia.jp, Xbox 360) ou o jogo do Game Pass PC.
echo      2. Streaming: Virtual Desktop (loja Meta, pago, melhor), Steam Link (loja Meta, gratis, se o jogo
echo         estiver na Steam ou adicionado como "jogo nao-Steam") ou Moonlight (sideload) + Sunshine no PC.
echo      3. No Quest, abra o app de streaming -^> conecte ao PC -^> o desktop do PC aparece em VR; rode o Xenia.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 12
goto %DESTINO%

rem ============================================================================
rem  BLOCO F - SWITCH (Eden)
rem ============================================================================

:PASSO_13
cls
call :CABECALHO 13 "Eden (Switch): requisitos - keys e firmware do SEU Switch"
echo   Eden e o emulador de Switch mais ativo em 2026 (fork do yuzu), com versao Android. No Quest 3S
echo   (Snapdragon XR2 Gen 2, CPU mais fraca que um celular top) espere: jogos 2D/indie e leves = jogavel;
echo   jogos 3D pesados = lento. Considere EXPERIMENTAL.
echo.
echo   VOCE PRECISA (extraidos do SEU Switch desbloqueado - homebrew):
echo     prod.keys e title.keys   -^> dump com Lockpick_RCM (ou fork) no seu console
echo     Firmware (pasta com .nca, versao 20.0.1 recomendada) -^> dump com TegraExplorer ou "Firmware dumper"
echo     Jogos em .nsp ou .xci    -^> dump com nxdumptool no seu console
echo   Sem esses arquivos DO SEU CONSOLE o Eden nao abre jogos. Este guia nao cobre a obtencao por outras vias.
echo.
echo   1. Coloque no PC uma pasta  Switch_Sistema\  com prod.keys, title.keys e a pasta Firmware\.
echo   2. Envie para o headset: %QROOT%/BIOS/Switch  (opcao 8 -^> Enviar -^> destino manual, ou MTP).
echo   3. Jogos -^> %QROOT%/ROMs/Switch.
echo.
choice /c SN /n /m "   [S] Enviar a pasta Switch_Sistema agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/BIOS/Switch"
call :AGUARDAR "Pressione qualquer tecla quando keys, firmware e jogos estiverem no headset"
call :FIM_PASSO 13
goto %DESTINO%

:PASSO_14
cls
call :CABECALHO 14 "Eden (Switch): instalar, driver de GPU, configurar e jogar"
echo   1. Baixe no site oficial:  https://eden-emu.dev/downloads  -^> secao Android -^> "Standard APK" (arm64).
echo      (O espelho do Eden no GitHub foi retirado do ar; use o site oficial ou git.eden-emu.dev.)
echo   2. Instale pelo SideQuest / opcao 8.
echo   3. DRIVER DE GPU (Turnip): melhora muito em Adreno. Baixe um .zip de driver Turnip/Mesa recente:
echo        https://github.com/K11MCH1/AdrenoToolsDrivers/releases   (ex.: turnip-vX.X.X.zip; NAO extraia)
echo      Envie o .zip para %QROOT%/BIOS (ou qualquer pasta).
echo   4. ACAO FISICA: coloque o headset, abra Eden (Fontes desconhecidas). Primeira execucao:
echo        - "Install keys" -^> aponte prod.keys (Emuladores/BIOS/Switch)
echo        - "Install firmware" -^> aponte a pasta Firmware (ou .zip dela)
echo        - "Add game folder" -^> Emuladores/ROMs/Switch
echo   5. Configuracoes -^> "Graphics" -^> "GPU driver" -^> "Install driver" -^> escolha o .zip Turnip -^> selecione-o.
echo        Renderer: Vulkan   /   Accuracy: Normal   /   Resolution: 0.5x ou 0.75x (comece baixo no 3S)
echo        Async shaders: ON   /   Use disk shader cache: ON   /   Anisotropic: 1x
echo   6. Configuracoes -^> "System" -^> "Docked mode: OFF" (modo portatil e mais leve).
echo   7. Configuracoes -^> "Controls" -^> Player 1 -^> mapeie o controle Bluetooth.
echo   8. Toque no jogo. A primeira vez compila shaders (engasgos normais nos primeiros minutos).
echo.
echo   Se o Eden fechar sozinho: memoria insuficiente -^> feche outros apps, reduza resolucao, e teste um jogo leve.
echo   Alternativas se um jogo especifico nao rodar: Citron ou Sudachi (mesmo processo de keys/firmware).
echo.
call :AGUARDAR "Pressione qualquer tecla quando um jogo de Switch tiver aberto"
call :FIM_PASSO 14
goto %DESTINO%

rem ============================================================================
rem  BLOCO G - COMO JOGAR / ORGANIZAR
rem ============================================================================

:PASSO_15
cls
call :CABECALHO 15 "Como jogar apps 2D em VR: janela, controle, bateria"
echo   JANELA
echo     - Apps 2D (melonDS, NetherSX2, Eden, X1 BOX, Stremio) abrem como painel flutuante. Pegue a barra
echo       inferior do painel com o gatilho para mover; arraste o canto para redimensionar.
echo     - No Lightning Launcher voce define o tamanho padrao da janela (passo 5). Um painel de 3-4 m de largura
echo       a 2 m de distancia vira um "telao".
echo     - Botao Meta (controle direito) segurado = recentraliza a visao. Toque simples = barra universal.
echo   CONTROLE
echo     - Controle Bluetooth: alguns emuladores so reconhecem quando o app ja esta aberto; se nao responder,
echo       feche e reabra o app com o controle ja conectado.
echo     - Toque na tela: aponte o Touch controller e aperte o gatilho (funciona como dedo).
echo   DESEMPENHO E BATERIA
echo     - Passthrough desligado economiza bateria. Brilho em 50-70%%.
echo     - Emuladores pesados (PS2/Switch) drenam a bateria em 1,5-2 h: jogue com o cabo de carga.
echo     - Se esquentar muito, reduza resolucao interna e feche o navegador/outros apps.
echo   AUDIO
echo     - O audio dos apps 2D sai pelos alto-falantes do headset; fones no P2 (3,5 mm) do lado esquerdo funcionam.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "Organizar a biblioteca e fazer backup dos saves"
echo   ORGANIZACAO
echo     - Lightning Launcher -^> grupos "3DS", "NDS", "PS2", "Switch", "Video". Esconda apps de sistema que nao usa.
echo     - No PC, espelhe a mesma estrutura: Quest\Emuladores\ROMs\^<console^> e Quest\Emuladores\BIOS.
echo.
echo   BACKUP DE SAVES (faca toda semana; cabo conectado)
echo     Onde cada emulador guarda:
echo       CitraVR   : Android/data/org.citra.citra_emu/files  (ou pasta citra-emu no armazenamento interno)
echo       melonDS   : Android/data/me.magnum.melonds/files/saves
echo       NetherSX2 : Android/data/xyz.aethersx2.android/files  (memcards, sstates)
echo       Eden      : Android/data/dev.eden.eden_emulator/files (nand, saves)  (nome do pacote pode variar)
echo     Como copiar:
echo       A) SideQuest -^> "Currently installed apps" -^> engrenagem do app -^> "Backup app data"
echo       B) Opcao 8 do menu -^> "Baixar (pull) uma pasta do headset" -^> informe o caminho acima -^> salva no PC
echo       C) Explorador (MTP): Android\data\^<pacote^>\files -^> copie para o PC.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 16
goto %DESTINO%

rem ============================================================================
rem  BLOCO H - STREMIO
rem ============================================================================

:PASSO_17
cls
call :CABECALHO 17 "Stremio: instalar"
echo   O Stremio e um centralizador de video (filmes, series, canais, YouTube) com add-ons. E um app Android
echo   normal; no Quest vira um telao. Existem duas versoes:
echo     - Stremio (mobile)     : interface de toque, funciona com o Touch controller como ponteiro. -^> RECOMENDADA
echo     - Stremio Android TV   : interface para controle remoto/gamepad (navegacao por D-Pad).
echo.
echo   1. Abra a pagina oficial:  https://www.stremio.com/downloads
echo   2. Em "Android", baixe o APK **ARM64 (arm64-v8a)** da versao estavel (ex.: com.stremio.one-2.x.x-...-arm64-v8a.apk).
echo      (Se quiser a versao TV: secao "Android TV" -^> arm64-v8a.)
echo   3. Instale pelo SideQuest / opcao 8 do menu.
echo   4. ACAO FISICA: coloque o headset -^> Biblioteca -^> Fontes desconhecidas -^> "Stremio".
echo.
choice /c SN /n /m "   [S] Abrir a pagina de downloads agora    [N] Ja baixei : "
if not errorlevel 2 start "" "https://www.stremio.com/downloads"
call :AGUARDAR "Pressione qualquer tecla quando o Stremio abrir no headset"
call :FIM_PASSO 17
goto %DESTINO%

:PASSO_18
cls
call :CABECALHO 18 "Stremio: conta, add-ons e reproducao"
echo   1. Na tela inicial, "Log in" (conta existente) ou "Sign up" / "Continue as guest". Uma conta sincroniza
echo      biblioteca e add-ons com o PC/celular - recomendado.
echo   2. Add-ons: icone de peca de quebra-cabeca (ou Menu -^> Add-ons) -^> "Community add-ons" -^> instale os que
echo      quiser (ex.: YouTube, Twitch, catalogos publicos, legendas OpenSubtitles). Tambem da para adicionar
echo      um add-on pela URL do manifesto (campo "Add-on repository URL").
echo      Nota: a legalidade do conteudo depende do add-on que voce instala, nao do Stremio.
echo   3. Busca: lupa -^> digite -^> escolha o titulo -^> escolha a fonte (stream) -^> play.
echo   4. Player: toque na tela para mostrar controles; legendas no icone "CC"; audio/faixa no icone de engrenagem.
echo   5. Sincronizar com o PC: instale o Stremio no Windows com a mesma conta; a biblioteca e o "continuar assistindo"
echo      aparecem nos dois.
echo.
call :AGUARDAR "Pressione qualquer tecla quando um video tiver reproduzido"
call :FIM_PASSO 18
goto %DESTINO%

:PASSO_19
cls
call :CABECALHO 19 "Stremio: dicas para VR (janela, audio, legendas, Wi-Fi)"
echo   - Janela: aumente o painel ate ~4 m de largura e afaste 2-3 m; com o Lightning Launcher defina esse tamanho como padrao.
echo   - Ambiente: Configuracoes do Quest -^> Personalizacao -^> Ambiente virtual escuro (cinema) melhora contraste.
echo   - Wi-Fi: 5 GHz; para 1080p precisa ~10 Mbps, 4K ~30 Mbps. O 3S decodifica H.264/H.265 ate 4K, mas 1080p e o ideal.
echo   - Se o video travar: escolha uma fonte 1080p em vez de 4K; feche outros apps; aproxime-se do roteador.
echo   - Legendas: ajuste tamanho em Player -^> configuracoes de legenda (icone CC -^> engrenagem).
echo   - Deitado: Quest -^> Configuracoes -^> Acessibilidade/Experimental -^> "Modo de deitar" / recentre com o botao Meta.
echo   - Alternativa sem instalar nada: no navegador do Quest abra https://web.stremio.com (mesma conta).
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 19
goto %DESTINO%

rem ============================================================================
rem  BLOCO I - MAIS EMULADORES
rem ============================================================================

:PASSO_20
cls
call :CABECALHO 20 "RetroArch: NES, SNES, Mega Drive, GBA, PS1, N64, Dreamcast, Saturn"
echo   INSTALAR
echo   1. Baixe o APK "RetroArch_aarch64.apk" (64 bits) em https://buildbot.libretro.com/stable/  -^> versao mais recente
echo      -^> android -^> RetroArch_aarch64.apk   (ou https://www.retroarch.com/?page=platforms -^> Android).
echo   2. Instale pelo SideQuest / opcao 8. Abra uma vez (Fontes desconhecidas) e aceite as permissoes.
echo.
echo   CORES (o "emulador" de cada console, baixado dentro do RetroArch: Menu -^> Online Updater -^> Core Downloader)
echo      NES: Mesen ou Nestopia      SNES: Snes9x        Mega Drive: Genesis Plus GX     GBA: mGBA
echo      PS1: SwanStation (DuckStation) ou Beetle PSX HW    N64: Mupen64Plus-Next   Dreamcast: Flycast   Saturn: Beetle Saturn ou Kronos
echo      Depois: Online Updater -^> "Update Assets", "Update Core Info Files", "Update Databases".
echo.
echo   BIOS (vao em /sdcard/RetroArch/system - copie do seu console; opcao 8 -^> Enviar -^> destino /sdcard/RetroArch/system)
echo      PS1: scph5500.bin (JP) scph5501.bin (US) scph5502.bin (EU)   Saturn: sega_101.bin, mpr-17933.bin
echo      Dreamcast: dc/dc_boot.bin e dc/dc_flash.bin (Flycast roda muitos jogos sem BIOS)   Confira os hashes: opcao 8 -^> [9].
echo.
echo   JOGOS: %QROOT%/ROMs/Retro/^<console^>. No RetroArch: Menu -^> "Import Content" / "Scan Directory" -^> escolha a pasta
echo      -^> as playlists por console aparecem no menu esquerdo.
echo.
echo   CONTROLE: Settings -^> Input -^> Port 1 Controls -^> "Set All Controls" com o controle Bluetooth. Hotkeys: Settings -^> Input -^> Hotkeys
echo      (Menu Toggle no botao Home/Guide; Save State/Load State em L3/R3).
echo   VIDEO: Settings -^> Video -^> Driver "vulkan" (reinicie o app); Output -^> resolucao nativa; Scaling "Integer" opcional.
echo   Shaders: Quick Menu -^> Shaders -^> "crt-royale-fast" ou "lcd3x" para GBA.
echo.
choice /c SN /n /m "   [S] Enviar uma pasta de jogos Retro agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/Retro"
call :AGUARDAR "Pressione qualquer tecla quando um jogo tiver aberto no RetroArch"
call :FIM_PASSO 20
goto %DESTINO%

:PASSO_21
cls
call :CABECALHO 21 "PPSSPP (PSP): roda muito bem no Quest 3S"
echo   1. Baixe o APK em https://www.ppsspp.org/download/  (Android -^> "PPSSPP" livre, arm64) ou
echo      https://github.com/hrydgard/ppsspp/releases/latest. Instale pelo SideQuest / opcao 8.
echo   2. Jogos: seus UMDs em .iso ou .cso -^> %QROOT%/ROMs/PSP. Nao precisa de BIOS.
echo   3. Abra PPSSPP -^> "Games" -^> "Browse..." -^> Emuladores/ROMs/PSP. Toque no jogo.
echo   4. Configuracoes -^> Graficos: Backend "Vulkan"; Rendering resolution "3x PSP" (o 3S aguenta 3x-4x);
echo      Frame skipping OFF; Texture filtering "Auto"; "Upscale type" xBRZ 2x opcional; "Hardware transform" ON.
echo   5. Configuracoes -^> Controles -^> "Control mapping" -^> mapeie o controle Bluetooth. "Enable touch controls" OFF.
echo   6. Saves ficam em Android/data/org.ppsspp.ppsspp/files/PSP/SAVEDATA (backup: passo 24).
echo.
choice /c SN /n /m "   [S] Enviar jogos de PSP agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/PSP"
call :AGUARDAR "Pressione qualquer tecla quando um jogo de PSP tiver aberto"
call :FIM_PASSO 21
goto %DESTINO%

:PASSO_22
cls
call :CABECALHO 22 "Dolphin (GameCube / Wii): jogos leves rodam"
echo   1. Baixe o APK em https://dolphin-emu.org/download/  (Android, versao "beta"/estavel mais recente). Instale.
echo   2. Jogos: seus discos em .rvz (menor) ou .iso -^> %QROOT%/ROMs/GC e %QROOT%/ROMs/Wii. Nao precisa de BIOS.
echo   3. Abra Dolphin -^> "+" -^> escolha a pasta ROMs/GC (e depois ROMs/Wii). A lista aparece com capas.
echo   4. Configuracoes -^> Graficos: Backend "Vulkan"; Internal Resolution "1x" (suba para 2x em jogos leves);
echo      "Compile shaders before starting" ON; "Asynchronous ubershaders" ON reduz engasgos.
echo   5. Configuracoes -^> Controllers -^> GameCube Controller 1 -^> "Emulated" -^> mapeie o controle Bluetooth.
echo      Wii: "Wii Remote 1" -^> "Emulated Wii Remote" -^> mapeie; jogos que exigem apontar (IR) sao dificeis sem Wiimote.
echo   6. Se ficar lento: Configuracoes -^> Advanced -^> "CPU Clock Override" 80%%; desligue "Enable Cheats"; resolucao 1x.
echo.
choice /c SN /n /m "   [S] Enviar jogos de GC/Wii agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/GC"
call :AGUARDAR "Pressione qualquer tecla quando um jogo tiver aberto no Dolphin"
call :FIM_PASSO 22
goto %DESTINO%

rem ============================================================================
rem  BLOCO J - EXTRAS
rem ============================================================================

:PASSO_23
cls
call :CABECALHO 23 "Streaming completo do PC: Sunshine (PC) + Moonlight (Quest)"
echo   Serve para Xbox 360 no Xenia, jogos de PC, Game Pass PC e qualquer coisa que o headset nao roda sozinho.
echo   Latencia tipica em Wi-Fi 5 GHz/6 GHz no mesmo comodo: 20-40 ms. Cabo de rede no PC ajuda muito.
echo.
echo   NO PC (Windows):
echo   1. Instalar o Sunshine (servidor, gratuito):
echo        winget install -e --id LizardByte.Sunshine      (ou https://github.com/LizardByte/Sunshine/releases/latest)
choice /c SN /n /m "   [S] Instalar o Sunshine agora pelo winget    [N] Ja tenho / vou baixar : "
if not errorlevel 2 (winget install -e --id LizardByte.Sunshine --accept-source-agreements --accept-package-agreements)
echo   2. Abra https://localhost:47990 no navegador do PC -^> crie usuario/senha do Sunshine.
echo   3. Em "Applications" adicione os jogos/emuladores (ex.: Xenia: comando = caminho do xenia.exe; "Desktop" ja vem).
echo   4. Placa de video: NVIDIA (NVENC), AMD (AMF) ou Intel (QSV) - o Sunshine detecta. Configuracao -^> Audio/Video: HEVC ON.
echo.
echo   NO QUEST:
echo   5. Baixe o Moonlight: https://github.com/moonlight-stream/moonlight-android/releases/latest -^> app-...-arm64-v8a.apk (ou .apk unico).
echo      Instale pelo SideQuest / opcao 8. Abra (Fontes desconhecidas).
echo   6. O PC aparece na lista (mesma rede). Toque -^> mostra um PIN -^> no PC abra Sunshine -^> aba "PIN" -^> digite -^> Pair.
echo   7. Moonlight -^> Configuracoes: Resolucao 1920x1080 (ou 2560x1440), 90 fps, Bitrate 30-50 Mbps, Codec HEVC,
echo      "Frame pacing" ON, "Video decoder" Hardware. Controle Bluetooth conectado ao Quest e passado ao PC.
echo   8. Toque em "Desktop" ou no jogo. A tela do PC vira um painel; redimensione como telao.
echo.
echo   Alternativas: Virtual Desktop (loja Meta, pago; mais facil, tambem faz VR de PC) e Steam Link (loja Meta, gratis, so Steam).
echo.
call :AGUARDAR "Pressione qualquer tecla quando o Moonlight mostrar o desktop do PC"
call :FIM_PASSO 23
goto %DESTINO%

:PASSO_24
cls
call :CABECALHO 24 "Backup automatico de saves: tarefa agendada no Windows (a cada hora, se o headset estiver no cabo)"
echo   Cria o script  %PASTA%backup_saves_quest.bat  e uma tarefa do Agendador do Windows que o roda de hora em hora.
echo   O script so faz algo se o headset estiver conectado e autorizado; senao termina em silencio.
echo   Destino: %USERPROFILE%\Desktop\Quest_Saves_Backup\^<pacote^>\  (sobrescreve com a versao mais nova).
echo   Pastas copiadas: dados de CitraVR, melonDS, NetherSX2, Eden, PPSSPP, Dolphin, RetroArch (saves/states/system).
echo.
call :ACHAR_ADB
if not defined ADB goto PASSO_24_FIM
choice /c SNR /n /m "   [S] Criar script + tarefa agora    [N] Pular    [R] Remover a tarefa agendada : "
if errorlevel 3 (schtasks /delete /tn "QuestSavesBackup" /f & goto PASSO_24_FIM)
if errorlevel 2 goto PASSO_24_FIM
set "BKS=%PASTA%backup_saves_quest.bat"
>"%BKS%" echo @echo off
>>"%BKS%" echo set "ADB=%ADB%"
>>"%BKS%" echo set "DST=%%USERPROFILE%%\Desktop\Quest_Saves_Backup"
>>"%BKS%" echo "%%ADB%%" get-state ^>nul 2^>^&1 ^|^| exit /b 0
>>"%BKS%" echo if not exist "%%DST%%" mkdir "%%DST%%"
>>"%BKS%" echo for %%%%S in (org.citra.citra_emu me.magnum.melonds xyz.aethersx2.android dev.eden.eden_emulator org.ppsspp.ppsspp org.dolphinemu.dolphinemu com.retroarch) do "%%ADB%%" pull /sdcard/Android/data/%%%%S/files "%%DST%%\%%%%S" ^>nul 2^>^&1
>>"%BKS%" echo "%%ADB%%" pull /sdcard/RetroArch/saves "%%DST%%\RetroArch\saves" ^>nul 2^>^&1
>>"%BKS%" echo "%%ADB%%" pull /sdcard/RetroArch/states "%%DST%%\RetroArch\states" ^>nul 2^>^&1
>>"%BKS%" echo echo %%DATE%% %%TIME%% backup ok^>^>"%%DST%%\log.txt"
echo   Script criado. Testando uma vez agora (pode demorar na primeira execucao)...
call "%BKS%"
echo   Registrando a tarefa agendada "QuestSavesBackup" (a cada 1 hora)...
schtasks /create /tn "QuestSavesBackup" /tr "\"%BKS%\"" /sc hourly /mo 1 /f
echo   Para conferir: Agendador de Tarefas -^> Biblioteca -^> QuestSavesBackup.  Log: Desktop\Quest_Saves_Backup\log.txt
:PASSO_24_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 24
goto %DESTINO%

:PASSO_25
cls
call :CABECALHO 25 "Icones, capas e atalhos diretos para jogos"
echo   ICONES POR APP (Lightning Launcher)
echo   1. No launcher, segure o gatilho sobre um app -^> "Icon" / "Custom icon" -^> escolha uma imagem (png/jpg) do headset.
echo      Coloque as imagens em /sdcard/Pictures/Icones (opcao 8 -^> Enviar -^> destino manual). Sugestao: 512x512.
echo   2. "Rename" para nomes curtos (ex.: "PS2", "Switch"); "Hide" para esconder apps de sistema que nao usa.
echo   3. Grupos com icone: "Emuladores", "Streaming", "Video". Arraste a ordem.
echo.
echo   ATALHOS DIRETOS PARA JOGOS (com capas) - frontend Daijisho
echo   4. Baixe o Daijisho (frontend Android de emulacao): https://github.com/TapiocaFox/Daijishou/releases/latest -^> .apk
echo      Instale pelo SideQuest / opcao 8. Abra (Fontes desconhecidas).
echo   5. "Settings" -^> "Platforms" -^> adicione cada console -^> "Player" = o emulador instalado (melonDS, NetherSX2, PPSSPP,
echo      Dolphin, RetroArch + core). "Paths" -^> aponte Emuladores/ROMs/^<console^>. Ele baixa capas e metadados sozinho.
echo   6. Na tela inicial ficam os jogos com capa; tocar abre direto no emulador certo. Funciona em janela 2D no Quest.
echo      Limitacao: CitraVR (VR nativo) nao e lancado pelo Daijisho; abra o CitraVR direto.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 25
goto %DESTINO%

:PASSO_26
cls
call :CABECALHO 26 "Verificacao final"
echo   CHECKLIST:
echo     [ ] Lightning Launcher abre e lista todos os apps (oficiais + Fontes desconhecidas).
echo     [ ] Controle Bluetooth aparece como Conectado e funciona em pelo menos um emulador.
echo     [ ] CitraVR abre um jogo de 3DS com as duas telas em VR.
echo     [ ] melonDS abre um jogo de DS em janela 2D.
echo     [ ] NetherSX2 abre um jogo de PS2 com a BIOS do seu console.
echo     [ ] (Opcional) X1 BOX abre a tela do Xbox; app Xbox Cloud Gaming instalado da loja.
echo     [ ] (Opcional) Eden abre um jogo leve de Switch.
echo     [ ] Stremio reproduz um video.
echo     [ ] (Opcional) RetroArch, PPSSPP e Dolphin abrem um jogo cada.
echo     [ ] (Opcional) Moonlight conecta ao PC com Sunshine.   [ ] Tarefa agendada de backup criada (passo 24).
echo     [ ] Voce sabe onde ficam os saves e fez o primeiro backup (passo 16).
echo.
echo   Pacotes instalados detectados via ADB (se conectado):
call :ACHAR_ADB
if defined ADB "%ADB%" shell "pm list packages | grep -iE 'citra|melonds|aethersx2|nethersx2|xemu|x1box|eden|citron|sudachi|stremio|lightning|threethan|retroarch|ppsspp|dolphin|moonlight|daijisho'" 2>nul
echo.
call :AGUARDAR "Pressione qualquer tecla para concluir"
call :FIM_PASSO 26
goto %DESTINO%

:CONCLUIDO
cls
echo.
echo  ============================================================================================
echo   PRONTO: Quest 3S com launcher Android, emuladores de 3DS/NDS/PS2 (+ Xbox e Switch experimentais) e Stremio.
echo  ============================================================================================
echo.
echo   Sugestoes extras:
echo     - RetroArch (retroarch.com -^> Android APK "aarch64") cobre SNES, GBA, PS1, N64, Dreamcast e muito mais.
echo     - PPSSPP (ppsspp.org) para PSP roda muito bem no 3S.
echo     - Dolphin (dolphin-emu.org, Android) para GameCube/Wii: jogos leves rodam.
echo     - Mantenha os emuladores atualizados pelo GitHub; releases novas corrigem muita coisa.
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
echo   Quest 3S com Modo Desenvolvedor + SideQuest OK (guia 1); cabo USB-C; controle Bluetooth; espaco livre;
echo   seus proprios jogos/BIOS/keys extraidos dos seus consoles.
echo.
echo   DOWNLOADS OFICIAIS
echo   ------------------
echo   Lightning Launcher ...... https://github.com/threethan/LightningLauncher/releases/latest
echo   CitraVR (3DS) ........... https://github.com/amwatson/CitraVR/releases/latest
echo   melonDS (NDS) ........... https://github.com/rafaelvcaetano/melonDS-android/releases/latest
echo   NetherSX2 (PS2) ......... https://github.com/Trixarian/NetherSX2-classic/releases/latest
echo   X1 BOX / xemu (Xbox) .... https://github.com/izzy2lost/xemu/releases   (nao oficial)
echo   Eden (Switch) ........... https://eden-emu.dev/downloads
echo   Turnip GPU drivers ...... https://github.com/K11MCH1/AdrenoToolsDrivers/releases
echo   Stremio ................. https://www.stremio.com/downloads   (Android -^> arm64-v8a)
echo   RetroArch ............... https://buildbot.libretro.com/stable/  (android -^> RetroArch_aarch64.apk)
echo   PPSSPP .................. https://github.com/hrydgard/ppsspp/releases/latest
echo   Dolphin ................. https://dolphin-emu.org/download/
echo   Moonlight / Sunshine .... https://github.com/moonlight-stream/moonlight-android/releases/latest  /  https://github.com/LizardByte/Sunshine/releases/latest
echo   Daijisho ................ https://github.com/TapiocaFox/Daijishou/releases/latest
echo   chdman (MAME) ........... https://www.mamedev.org/release.html
echo   Xbox Cloud Gaming ....... app "Xbox" na Meta Horizon Store (dentro do headset)
echo   SideQuest ............... https://sidequestvr.com/setup-howto
echo.
echo   ESTRUTURA NO HEADSET
echo   --------------------
echo   %QROOT%/BIOS   %QROOT%/ROMs/{3DS,NDS,PS2,Xbox,Switch}   %QROOT%/Saves_Backup
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:ERROS
cls
echo.
echo   ERROS COMUNS E CORRECOES  (causa -^> correcao -^> teste)
echo   ---------------------------------------------------
echo   [Instalacao]
echo   - "App not installed" / INSTALL_FAILED_NO_MATCHING_ABIS: APK nao e arm64 -^> baixe a variante arm64-v8a.
echo   - INSTALL_FAILED_UPDATE_INCOMPATIBLE: versao antiga assinada por outra chave -^> desinstale a antiga (faca backup dos saves).
echo   - App nao aparece: Biblioteca -^> filtro "Fontes desconhecidas".
echo   [Pastas e jogos]
echo   - Emulador nao ve a pasta: use o seletor de pasta DO APP ("Use this folder"); nao digite caminho a mao.
echo   - adb push lento/travando: use cabo USB 3.0 e porta traseira; ou copie por MTP; ou ADB sem fio so para arquivos pequenos.
echo   [CitraVR]
echo   - Jogo nao abre / tela preta: ROM criptografada -^> decripte no GodMode9 do seu 3DS.
echo   - OK do navegador de arquivos nao funciona: permissao de microfone (Configuracoes do Quest -^> permissoes de apps).
echo   - Telas fora do centro: segure o botao Meta.   - Mapeamento "Virtual Device 4": Select+Start antes de mapear.
echo   - Rebind nao pega: apague [dados do app]/Configs/config.ini e reabra.
echo   [melonDS]
echo   - Lento: ative JIT e Threaded rendering; resolucao 1x-2x.   - Controle nao responde: reabra o app com o controle ja pareado.
echo   [NetherSX2]
echo   - "BIOS not found": aponte a pasta com o .bin e selecione-o na lista; confira que o dump e completo (4 MB).
echo   - Graficos quebrados: Renderer Vulkan  ou  OpenGL; desative upscale; use os "game fixes" automaticos (GameDB).
echo   - Som picotado: Audio -^> "Time stretch" ON; reduza upscale.
echo   [X1 BOX / xemu]
echo   - Fecha ao abrir: RAM insuficiente -^> feche tudo, reinicie o headset, abra so o X1 BOX.
echo   - Trava na bolha verde/logo: BIOS/MCPX/HDD errados ou jogo incompativel.
echo   [Eden]
echo   - "Missing keys/firmware": reinstale prod.keys e a pasta Firmware (versao 20.0.1) pelas opcoes do app.
echo   - Fecha em jogos pesados: resolucao 0.5x, modo portatil, driver Turnip; ou o jogo nao e viavel no 3S.
echo   - Driver Turnip nao instala: baixe o .zip sem extrair; use uma versao mais antiga.
echo   [Xbox Cloud Gaming]
echo   - App nao aparece na loja: Horizon OS abaixo de 60 -^> atualize; regiao/conta sem Game Pass.
echo   - Lag: Wi-Fi 5 GHz, 20+ Mbps, perto do roteador; feche downloads no PC.
echo   [Stremio]
echo   - Tela preta no player: troque a fonte; ou Configuracoes -^> Player -^> "Hardware decoding" OFF/ON.
echo   - Nao faz login: verifique data/hora do headset e rede; use web.stremio.com no navegador para testar a conta.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DESFAZER
cls
echo.
echo   COMO DESFAZER
echo   -------------
echo   1. Remover um emulador/app: Biblioteca -^> Fontes desconhecidas -^> "..." -^> Desinstalar
echo      (ou SideQuest -^> "Currently installed apps" -^> lixeira; ou opcao 8 -^> Desinstalar por nome de pacote).
echo      Antes, faca backup dos saves (passo 16) se quiser mante-los.
echo   2. Apagar jogos e BIOS: Explorador (MTP) -^> apague a pasta Emuladores; ou opcao 8 -^> "Apagar pasta Emuladores".
echo   3. Remover o Lightning Launcher: desinstale como qualquer app; a barra do Quest volta ao padrao sozinha.
echo   4. Desconectar o controle Bluetooth: Configuracoes -^> Dispositivos -^> Bluetooth -^> esquecer.
echo   5. Para desligar o Modo Desenvolvedor: guia 1, opcao 6.
echo   Nada disso exige reset de fabrica.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   Abrindo links oficiais no navegador padrao...
start "" "https://github.com/threethan/LightningLauncher/releases/latest"
start "" "https://github.com/amwatson/CitraVR/releases/latest"
start "" "https://github.com/amwatson/CitraVR/wiki"
start "" "https://github.com/rafaelvcaetano/melonDS-android/releases/latest"
start "" "https://github.com/Trixarian/NetherSX2-classic/releases/latest"
start "" "https://eden-emu.dev/downloads"
start "" "https://www.stremio.com/downloads"
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

rem ============================================================================
rem  FERRAMENTAS ADB
rem ============================================================================

:FERRAMENTAS
cls
echo.
echo   FERRAMENTAS ADB  (headset conectado e depuracao USB permitida)
echo   -------------------------------------------------------------
call :ACHAR_ADB
if not defined ADB (call :AGUARDAR "Pressione qualquer tecla para voltar" & goto MENU)
echo.
echo   [1] Testar conexao (adb devices)
echo   [2] Criar a estrutura de pastas %QROOT%
echo   [3] Instalar um APK do PC
echo   [4] Enviar (push) uma pasta de jogos do PC para o headset
echo   [5] Baixar (pull) uma pasta do headset para o PC (saves, etc.)
echo   [6] Listar pacotes instalados (emuladores e apps sideloaded)
echo   [7] Desinstalar um app por nome de pacote
echo   [8] Apagar a pasta %QROOT% do headset (CUIDADO)
echo   [9] Verificar hashes MD5 e tamanhos de BIOS / keys (detecta dump ruim)
echo   [A] Converter ISO/CUE para CHD com o chdman (economiza espaco)
echo   [B] Perfis de desempenho via ADB (CPU/GPU/Hz) para emulacao
echo   [0] Voltar
echo.
choice /c 123456789AB0 /n /m "   Escolha: "
if errorlevel 12 goto MENU
if errorlevel 11 goto FERR_PERF
if errorlevel 10 goto FERR_CHD
if errorlevel 9 goto FERR_HASH
if errorlevel 8 goto FERR_APAGAR
if errorlevel 7 goto FERR_DESINSTALAR
if errorlevel 6 goto FERR_LISTAR
if errorlevel 5 goto FERR_PULL
if errorlevel 4 goto FERR_PUSH
if errorlevel 3 goto FERR_APK
if errorlevel 2 goto FERR_PASTAS
"%ADB%" devices
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_PASTAS
"%ADB%" shell "mkdir -p %QROOT%/BIOS %QROOT%/ROMs/3DS %QROOT%/ROMs/NDS %QROOT%/ROMs/PS2 %QROOT%/ROMs/Xbox %QROOT%/ROMs/Switch %QROOT%/Saves_Backup %QROOT%/ROMs/PSP %QROOT%/ROMs/GC %QROOT%/ROMs/Wii %QROOT%/ROMs/Retro/NES %QROOT%/ROMs/Retro/SNES %QROOT%/ROMs/Retro/MD %QROOT%/ROMs/Retro/GBA %QROOT%/ROMs/Retro/PS1 %QROOT%/ROMs/Retro/N64 %QROOT%/ROMs/Retro/DC %QROOT%/ROMs/Retro/Saturn"
"%ADB%" shell "ls -la %QROOT% %QROOT%/ROMs"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_APK
echo.
set "APK="
set /p "APK=   Arraste o arquivo .apk para esta janela (ou cole o caminho) e ENTER: "
set "APK=%APK:"=%"
if "%APK%"=="" goto FERRAMENTAS
if not exist "%APK%" (echo   Arquivo nao encontrado. & call :AGUARDAR "Pressione qualquer tecla" & goto FERRAMENTAS)
echo   Instalando (adb install -r)... aguarde, pode levar 1-2 minutos.
"%ADB%" install -r "%APK%"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_PUSH
echo.
echo   Destinos:  [1] ROMs/3DS   [2] ROMs/NDS   [3] ROMs/PS2   [4] ROMs/Xbox   [5] ROMs/Switch   [6] BIOS   [7] outro
choice /c 1234567 /n /m "   Destino: "
if errorlevel 7 goto FERR_PUSH_OUTRO
if errorlevel 6 (call :ENVIAR "%QROOT%/BIOS" & goto FERRAMENTAS)
if errorlevel 5 (call :ENVIAR "%QROOT%/ROMs/Switch" & goto FERRAMENTAS)
if errorlevel 4 (call :ENVIAR "%QROOT%/ROMs/Xbox" & goto FERRAMENTAS)
if errorlevel 3 (call :ENVIAR "%QROOT%/ROMs/PS2" & goto FERRAMENTAS)
if errorlevel 2 (call :ENVIAR "%QROOT%/ROMs/NDS" & goto FERRAMENTAS)
call :ENVIAR "%QROOT%/ROMs/3DS"
goto FERRAMENTAS
:FERR_PUSH_OUTRO
set "DST="
set /p "DST=   Caminho de destino no headset (ex.: /sdcard/Emuladores/BIOS/Switch): "
if "%DST%"=="" goto FERRAMENTAS
call :ENVIAR "%DST%"
goto FERRAMENTAS

:FERR_PULL
echo.
set "SRC="
set /p "SRC=   Caminho no headset (ex.: /sdcard/Android/data/me.magnum.melonds/files/saves): "
if "%SRC%"=="" goto FERRAMENTAS
set "DSTPC=%USERPROFILE%\Desktop\Quest_Backup"
if not exist "%DSTPC%" mkdir "%DSTPC%"
echo   Copiando %SRC% para %DSTPC% ...
"%ADB%" pull "%SRC%" "%DSTPC%"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_LISTAR
echo.
"%ADB%" shell "pm list packages -3"
echo.
echo   (pacotes de terceiros = instalados por voce ou pela loja; os da loja comecam geralmente com com.oculus/com.meta ou nome do estudio)
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_DESINSTALAR
echo.
set "PKG="
set /p "PKG=   Nome do pacote (ex.: me.magnum.melonds) ou ENTER para voltar: "
if "%PKG%"=="" goto FERRAMENTAS
call :PERGUNTA "   Desinstalar %PKG% e apagar seus dados?"
if errorlevel 2 goto FERRAMENTAS
"%ADB%" uninstall "%PKG%"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_APAGAR
echo.
echo   ATENCAO: isto apaga %QROOT% (todos os jogos, BIOS, keys e backups copiados para la). Nao afeta os apps.
call :PERGUNTA "   Tem certeza?"
if errorlevel 2 goto FERRAMENTAS
"%ADB%" shell "rm -rf %QROOT%"
echo   Apagado.
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_HASH
echo.
set "HDIR="
set /p "HDIR=   Pasta no PC com as BIOS/keys (arraste ou cole o caminho): "
set "HDIR=%HDIR:"=%"
if "%HDIR%"=="" goto FERRAMENTAS
if not exist "%HDIR%\" (echo   Pasta nao encontrada. & call :AGUARDAR "Pressione qualquer tecla" & goto FERRAMENTAS)
echo.
echo   Calculando MD5 (pode demorar em arquivos grandes)...
powershell -NoProfile -Command "Get-ChildItem -LiteralPath '%HDIR%' -File | ForEach-Object { '   {0,-34} {1,14:N0} bytes  MD5 {2}' -f $_.Name,$_.Length,(Get-FileHash -LiteralPath $_.FullName -Algorithm MD5).Hash }"
echo.
echo   VALORES ESPERADOS (dumps originais; fonte: docs libretro/PCSX2):
echo     PS1  scph5500.bin (JP) 524.288 bytes  MD5 8DD7D5296A650FAC7319BCE665A6A53C
echo     PS1  scph5501.bin (US) 524.288 bytes  MD5 490F666E1AFB15B7362B406ED1CEA246
echo     PS1  scph5502.bin (EU) 524.288 bytes  MD5 32736F17079D0B2B7024407C39BD3050
echo     PS2  qualquer SCPH-xxxxx.bin: 4.194.304 bytes (4 MB); MD5 varia por modelo/regiao - confira em pcsx2.net/docs
echo     Saturn  sega_101.bin 524.288 bytes MD5 85EC9CA47D8F6807718151CBCCA8B964   mpr-17933.bin 524.288 bytes MD5 3240872C70984B6CBFDA1586CAB68DBE
echo     Dreamcast  dc_boot.bin 2.097.152 bytes MD5 E10C53C2F8B90BAB96EAD2D368858623   dc_flash.bin 131.072 bytes MD5 0A93F7940C455905BEA6E392DFDE92A4
echo     Xbox  mcpx_1.0.bin 512 bytes   Complex_4627.bin 1.048.576 bytes   xbox_hdd.qcow2 tamanho variavel
echo     Switch prod.keys: arquivo de texto com linhas "master_key_00 = ..." ; firmware: pasta com dezenas de .nca
if exist "%HDIR%\prod.keys" (findstr /c:"master_key_0" "%HDIR%\prod.keys" >nul && echo   prod.keys: contem master_key - OK || echo   prod.keys: NAO contem master_key - arquivo invalido)
echo.
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_CHD
echo.
set "CHD="
for /f "delims=" %%C in ('where chdman 2^>nul') do if not defined CHD set "CHD=%%C"
if not defined CHD if exist "%PASTA%tools\chdman.exe" set "CHD=%PASTA%tools\chdman.exe"
if not defined CHD if exist "%PASTA%chdman.exe" set "CHD=%PASTA%chdman.exe"
if defined CHD goto FERR_CHD_RUN
echo   chdman.exe nao encontrado. Ele vem dentro do MAME (oficial):
echo     1. Abra https://www.mamedev.org/release.html -^> baixe o "mame0xxxb_64bit.exe" (e um auto-extraivel).
echo     2. Extraia em uma pasta temporaria e copie SO o chdman.exe para:  %PASTA%tools\chdman.exe
echo     3. Volte aqui e repita.
if not exist "%PASTA%tools" mkdir "%PASTA%tools"
start "" "https://www.mamedev.org/release.html"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS
:FERR_CHD_RUN
echo   chdman: %CHD%
set "CDIR="
set /p "CDIR=   Pasta no PC com os jogos (.cue/.bin, .gdi, .iso): "
set "CDIR=%CDIR:"=%"
if "%CDIR%"=="" goto FERRAMENTAS
if not exist "%CDIR%\" (echo   Pasta nao encontrada. & call :AGUARDAR "Pressione qualquer tecla" & goto FERRAMENTAS)
echo   Tipo:  [1] CD (PS1, Saturn, Dreamcast .cue/.gdi/.iso)    [2] DVD (PS2 .iso)
choice /c 12 /n /m "   Escolha: "
if errorlevel 2 goto FERR_CHD_DVD
for %%F in ("%CDIR%\*.cue" "%CDIR%\*.gdi" "%CDIR%\*.iso") do (echo   -- %%~nxF & "%CHD%" createcd -i "%%F" -o "%%~dpnF.chd")
goto FERR_CHD_FIM
:FERR_CHD_DVD
for %%F in ("%CDIR%\*.iso") do (echo   -- %%~nxF & "%CHD%" createdvd -i "%%F" -o "%%~dpnF.chd")
:FERR_CHD_FIM
echo.
echo   Concluido. Os .chd ficaram ao lado dos originais. Teste um no emulador antes de apagar os originais.
echo   NetherSX2, RetroArch (Beetle PSX/SwanStation/Flycast/Beetle Saturn) e Dolphin (.rvz, nao CHD) aceitam CHD.
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_PERF
echo.
echo   PERFIS DE DESEMPENHO (setprop; voltam ao padrao ao reiniciar o headset)
echo   [1] Emulacao pesada (PS2 / Switch / Dolphin): CPU e GPU nivel 4, 72 Hz
echo   [2] Equilibrado (3DS / PSP / NDS): CPU e GPU nivel 3, 90 Hz
echo   [3] Padrao do sistema (automatico)
echo   [0] Voltar
choice /c 1230 /n /m "   Escolha: "
if errorlevel 4 goto FERRAMENTAS
if errorlevel 3 ("%ADB%" shell "setprop debug.oculus.cpuLevel '' ; setprop debug.oculus.gpuLevel '' ; setprop debug.oculus.refreshRate ''" & goto FERR_PERF_OK)
if errorlevel 2 ("%ADB%" shell "setprop debug.oculus.cpuLevel 3 ; setprop debug.oculus.gpuLevel 3 ; setprop debug.oculus.refreshRate 90" & goto FERR_PERF_OK)
"%ADB%" shell "setprop debug.oculus.cpuLevel 4 ; setprop debug.oculus.gpuLevel 4 ; setprop debug.oculus.refreshRate 72"
:FERR_PERF_OK
echo   Aplicado. Valores atuais:
"%ADB%" shell "getprop | grep -E 'debug.oculus.(cpuLevel|gpuLevel|refreshRate)'"
call :AGUARDAR "Pressione qualquer tecla"
goto FERR_PERF

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

:ACHAR_ADB
if defined ADB if exist "%ADB%" exit /b
set "ADB="
for /f "delims=" %%P in ('where adb 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%LOCALAPPDATA%\Programs\SideQuest\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%ProgramFiles%\SideQuest\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB (echo   adb.exe nao encontrado. Instale o SideQuest, guia 1 passo 8, e reabra este guia. & exit /b)
echo   adb: %ADB%
exit /b

:ENVIAR
rem %1 = destino no headset
call :ACHAR_ADB
if not defined ADB exit /b
echo.
set "ORIG="
set /p "ORIG=   Pasta no PC com os arquivos (arraste a pasta para ca ou cole o caminho) e ENTER: "
set "ORIG=%ORIG:"=%"
if "%ORIG%"=="" exit /b
if not exist "%ORIG%\" (echo   Pasta nao encontrada. & exit /b)
set "SZKB=" & set "FREEKB="
for /f "usebackq delims=" %%K in (`powershell -NoProfile -Command "[int64]((Get-ChildItem -LiteralPath '%ORIG%' -Recurse -File ^| Measure-Object Length -Sum).Sum/1KB)"`) do set "SZKB=%%K"
for /f "usebackq skip=1 tokens=4" %%K in (`call "%ADB%" shell df /sdcard 2^>nul`) do if not defined FREEKB set "FREEKB=%%K"
if defined SZKB for /f "delims=0123456789" %%Z in ("%SZKB%") do set "SZKB="
if defined FREEKB for /f "delims=0123456789" %%Z in ("%FREEKB%") do set "FREEKB="
if defined SZKB if defined FREEKB (set /a SZMB=%SZKB%/1024 & set /a FREEMB=%FREEKB%/1024)
if defined SZKB if defined FREEKB echo   Tamanho da pasta: %SZMB% MB   Livre no headset: %FREEMB% MB
if defined SZKB if defined FREEKB if %SZKB% GTR %FREEKB% (echo   NAO CABE: libere espaco no headset ou envie menos jogos. & exit /b)
echo   Enviando o CONTEUDO de "%ORIG%" para %~1 ... (barra de progresso do adb abaixo; pode demorar)
"%ADB%" shell "mkdir -p %~1"
"%ADB%" push "%ORIG%\." "%~1"
echo.
echo   Conteudo do destino agora:
"%ADB%" shell "ls -la %~1"
exit /b

:CABECALHO
echo.
echo  ============================================================================================
echo   PASSO %~1 de %TOTAL%  -  %~2
echo  ============================================================================================
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

:FIM_PASSO
set "PASSO=%~1"
set "PROXIMO=%~2"
if "%PROXIMO%"=="" set /a PROXIMO=%PASSO%+1
call :SALVAR
echo.
echo  --------------------------------------------------------------------------------------------
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
exit /b

:CARREGAR
if not exist "%PROG%" exit /b
for /f "usebackq tokens=1,* delims==" %%A in ("%PROG%") do set "%%A=%%B"
exit /b
