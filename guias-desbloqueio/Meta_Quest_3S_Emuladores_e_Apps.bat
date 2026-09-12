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
set "TOTAL=20"
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
echo   Pré-requisito: o guia 1 (Desbloqueio_Meta_Quest_3S.bat) concluído - Modo Desenvolvedor ligado
echo   e SideQuest com a bolinha VERDE.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: você parou no passo %PASSO% de %TOTAL%.
if not "%PASSO%"=="0" echo.
echo   [1] Começar do início          [6] Como desfazer (remover apps / voltar ao padrão)
echo   [2] Continuar de onde parei    [7] Abrir links oficiais
echo   [3] Ir para um passo/console   [8] Ferramentas ADB (criar pastas, instalar APK, enviar jogos)
echo   [4] Requisitos e downloads     [9] Apagar o progresso salvo
echo   [5] Erros comuns               [0] Sair
echo.
choice /c 1234567890 /n /m "   Escolha uma opção: "
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
echo     1  O que é "Android no Quest" e regras            11  Xbox original: X1 BOX / xemu (experimental)
echo     2  Pré-requisitos e espaço livre                  12  Xbox 360/One/Series: Cloud Gaming e streaming do PC
echo     3  Parear um controle Bluetooth (físico)         SWITCH
echo     4  Criar a estrutura de pastas no headset         13  Eden: requisitos (keys e firmware do SEU Switch)
echo     5  Lightning Launcher (o "sistema Android")       14  Eden: instalar, configurar driver GPU e jogar
echo    3DS                                               COMO JOGAR
echo     6  CitraVR: instalar                              15  Como jogar apps 2D em VR (janela, controle, bateria)
echo     7  CitraVR: preparar e enviar os jogos            16  Organizar biblioteca e backups de saves
echo     8  CitraVR: configurar e jogar (Touch controllers) STREMIO
echo    NDS                                                17  Stremio: instalar
echo     9  melonDS: instalar, jogos, controles            18  Stremio: conta, add-ons e reprodução
echo    PS2                                                19  Stremio: dicas para VR (janela, áudio, legendas)
echo    10  NetherSX2: instalar, BIOS, jogos, desempenho   20  Verificação final
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
rem  BLOCO A - BASE
rem ============================================================================

:PASSO_1
cls
call :CABECALHO 1 "O que é 'Android no Quest' e regras do jogo"
echo   O Horizon OS do Quest 3S JÁ É Android (base AOSP). Não existe outro "sistema Android" para instalar,
echo   nem custom ROM, nem root. O que dá para fazer, e é o que este guia faz:
echo     - instalar qualquer APK Android compatível (arm64) por sideload;
echo     - instalar um LAUNCHER (Lightning Launcher) que mostra todos os apps como um celular/Android TV,
echo       abre apps 2D em janelas de tamanho ajustável e organiza em grupos;
echo     - usar controle Bluetooth como em um console.
echo.
echo   EMULADORES QUE FUNCIONAM NO QUEST 3S (set/2026):
echo     3DS   → CitraVR   (nativo em VR, feito para Quest, suporta Quest 3S)       ....... BOM
echo     NDS   → melonDS   (app 2D Android, roda em janela)                           ....... ÓTIMO
echo     PS2   → NetherSX2 (app 2D, base AetherSX2/PCSX2)                             ....... BOM (1x-2x)
echo     Xbox  → X1 BOX / xemu-android (port não oficial, experimental, pesado)      ....... FRACO
echo     Xbox 360 / One / Series → NÃO há emulador Android; use Xbox Cloud Gaming ou streaming do PC.
echo     Switch → Eden (app 2D; XR2 Gen 2 é mais fraco que celular top: jogos leves ok) .. EXPERIMENTAL
echo.
echo   REGRAS:
echo     1. Jogos, BIOS e chaves (keys) devem vir dos SEUS consoles/jogos. O 3DS que você desbloqueou no
echo        guia 1 serve para extrair seus jogos (GodMode9). Este guia não cobre downloads de jogos.
echo     2. Baixe APKs SOMENTE do GitHub oficial de cada projeto (links no menu 7).
echo     3. Tudo é reversível: desinstalar o app remove o emulador; as pastas de jogos você apaga quando quiser.
echo.
call :AGUARDAR "Li e entendi. Pressione qualquer tecla para continuar"
call :FIM_PASSO 1
goto %DESTINO%

:PASSO_2
cls
call :CABECALHO 2 "Pré-requisitos e espaço livre"
echo   1. Modo Desenvolvedor ligado e SideQuest com bolinha VERDE (guia 1). Se não estiver, rode o guia 1.
echo   2. Cabo USB-C conectado ao PC (ou ADB sem fio já ativado).
echo   3. Espaço livre no headset: coloque o headset → Configurações → Armazenamento.
echo        Reserve:  3DS 1-4 GB por jogo   /   NDS até 512 MB   /   PS2 1-4,5 GB por jogo   /   Switch 1-16 GB por jogo
echo        + firmware do Switch ~ 400 MB.  O Quest 3S de 128 GB comporta bem uma biblioteca pequena.
echo   4. Bateria: conecte o carregador durante instalações grandes (adb push de vários GB demora).
echo.
echo   Teste automático da conexão ADB:
call :ACHAR_ADB
if defined ADB "%ADB%" devices
echo.
call :AGUARDAR "Pressione qualquer tecla quando aparecer o número de série com 'device' acima"
call :FIM_PASSO 2
goto %DESTINO%

:PASSO_3
cls
call :CABECALHO 3 "Parear um controle Bluetooth (ação física)"
echo   Os Touch controllers funcionam no CitraVR e como mouse nos apps 2D. Para NDS/PS2/Xbox/Switch use um
echo   controle Bluetooth de verdade: Xbox Wireless (Series), DualSense, 8BitDo Pro 2/Ultimate, Switch Pro.
echo.
echo   1. AÇÃO FÍSICA: ponha o controle em modo de pareamento:
echo        Xbox: segure o botão de pareamento (em cima, perto do USB) até o logo piscar rápido.
echo        DualSense: segure Create + PS até a barra de luz piscar.
echo        8BitDo: segure Start por 3 s (modo X ou D), depois o botão de pareamento.
echo   2. AÇÃO FÍSICA: coloque o headset. Botão Meta → Configurações → "Dispositivos" → "Bluetooth" →
echo      "Parear" / "Parear novo dispositivo" → escolha o controle na lista → aguarde "Conectado".
echo   3. Teste: no menu do Quest, mexa o analógico; o cursor/seleção deve responder.
echo.
echo   Sem controle físico? Dá para jogar NDS/PS2 com o Touch como mouse + botões virtuais na tela,
echo   mas é ruim. Vale muito a pena um controle.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o controle aparecer como Conectado (ou se for pular)"
call :FIM_PASSO 3
goto %DESTINO%

:PASSO_4
cls
call :CABECALHO 4 "Criar a estrutura de pastas no headset (automático via ADB)"
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
echo       Saves_Backup\    (cópias de saves)
echo.
call :ACHAR_ADB
if not defined ADB goto PASSO_4_MANUAL
choice /c SN /n /m "   [S] Criar as pastas agora via ADB    [N] Vou criar manualmente : "
if errorlevel 2 goto PASSO_4_MANUAL
"%ADB%" shell "mkdir -p %QROOT%/BIOS %QROOT%/ROMs/3DS %QROOT%/ROMs/NDS %QROOT%/ROMs/PS2 %QROOT%/ROMs/Xbox %QROOT%/ROMs/Switch %QROOT%/Saves_Backup"
echo.
echo   Conferindo:
"%ADB%" shell "ls -la %QROOT% %QROOT%/ROMs"
goto PASSO_4_FIM
:PASSO_4_MANUAL
echo.
echo   Manual: Explorador do Windows → "Quest 3S" (MTP; aceite "Permitir acesso aos dados" no headset)
echo   → Armazenamento interno compartilhado → crie a pasta Emuladores e as subpastas acima.
echo   Se o Quest não aparecer no Explorador: headset → Configurações → Sistema → Desenvolvedor → "Notificação MTP" ligada,
echo   reconecte o cabo e aceite a notificação dentro do headset.
:PASSO_4_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando as pastas existirem"
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Lightning Launcher: o 'sistema Android' do Quest"
echo   O Lightning Launcher mostra apps oficiais e sideloaded numa grade, abre apps 2D em janelas com tamanho
echo   ajustável, agrupa (Emuladores, Vídeo, Jogos...), esconde e renomeia apps. É o que dá a sensação de
echo   "Android TV" dentro do Quest.
echo.
echo   1. Baixe o APK:  https://github.com/threethan/LightningLauncher/releases/latest
echo      (arquivo LightningLauncher-*.apk; ou instale pelo catálogo do SideQuest, app 21783)
echo   2. Instale: arraste o .apk para a janela do SideQuest (ou use a opção 8 do menu → Instalar APK).
echo   3. AÇÃO FÍSICA: coloque o headset → Biblioteca → filtro "Fontes desconhecidas" → "Lightning Launcher".
echo   4. Na primeira abertura, aceite as permissões. Vá em Configurações (engrenagem) →
echo      "Shortcut Settings" e escolha como abrir o launcher (ex.: ao passar o ponteiro sobre o ícone
echo      da Biblioteca na barra). Você também pode fixá-lo na barra (dock) como qualquer app.
echo   5. Ainda em Configurações: ative "Open 2D apps in windows" e escolha o tamanho padrão da janela.
echo   6. Crie grupos: segure o clique (gatilho) num app → "Group" → "Emuladores", "Vídeo" etc.
echo.
echo   Dica: mantenha o Horizon Home como está; o Lightning Launcher é um app por cima, não substitui o sistema.
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
echo   CitraVR é um port do Citra/Azahar feito para Quest: as duas telas do 3DS flutuam à sua frente em VR,
echo   com os Touch controllers mapeados como um 3DS. Suporta Quest 2, Pro, 3 e 3S.
echo.
echo   1. Baixe:  https://github.com/amwatson/CitraVR/releases/latest   → arquivo CitraVR.apk (ou CitraVR-*.apk)
echo   2. Instale pelo SideQuest (arraste o .apk) ou pela opção 8 do menu.
echo   3. AÇÃO FÍSICA: coloque o headset → Biblioteca → "Fontes desconhecidas" → "CitraVR". Abra uma vez para
echo      ele criar as pastas e pedir permissões. Se o botão OK do navegador de arquivos não responder:
echo      saia, Configurações do Quest → busque "permissões de apps" → CitraVR → ligue "Microfone" → reabra.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o CitraVR tiver aberto pelo menos uma vez"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "CitraVR (3DS): preparar e enviar os jogos"
echo   FORMATO: o núcleo Azahar (CitraVR 0.6+) só aceita jogos DESCRIPTOGRAFADOS (.3ds/.cci/.cxi/.app).
echo   Jogos criptografados não abrem.
echo.
echo   Como extrair do SEU 3DS (que você desbloqueou no guia do New 3DS XL):
echo     Cartucho: desligue, segure START e ligue → GodMode9 → [C:] GAMECART → (A) no .3ds → "Dump title"...
echo               hacks.guide: https://github.com/amwatson/CitraVR/wiki/Backing-up-3DS-Games
echo     Jogo instalado: GodMode9 → [A:] SYSNAND SD → title → ... → "Dump CXI/NDS file" (gera .cxi já decriptado)
echo     Ou decriptar um .3ds no próprio GodMode9: (A) no arquivo → "NCSD image options" → "Decrypt file (0:/gm9/out)"
echo     Os arquivos ficam em SD:\gm9\out\ do cartão do 3DS. Copie para o PC.
echo.
echo   Envio para o headset (escolha uma):
echo     A) Opção 8 do menu → "Enviar jogos" → informe a pasta do PC → destino %QROOT%/ROMs/3DS  (adb push)
echo     B) Explorador do Windows (MTP): arraste para Quest 3S → Armazenamento interno → Emuladores → ROMs → 3DS
echo.
choice /c SN /n /m "   [S] Enviar uma pasta de jogos 3DS agora via ADB    [N] Já enviei / vou usar o Explorador : "
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
echo   AÇÃO FÍSICA: coloque o headset, abra o CitraVR (Biblioteca → Fontes desconhecidas).
echo.
echo   1. Na tela inicial, toque em "Add games folder" / ícone de pasta → navegue até
echo      Emuladores → ROMs → 3DS → "Use this folder" / OK. Os jogos aparecem na lista.
echo   2. Toque no jogo. As duas telas do 3DS aparecem à sua frente.
echo   3. Controles Touch (diagrama oficial: wiki "Touch Controller Input Bindings"):
echo        Analógico esquerdo = Circle Pad     Analógico direito = C-Stick
echo        A/B/X/Y = A/B/X/Y do 3DS           Gatilhos = L/R      Grips = ZL/ZR
echo        Pressionar os analógicos = D-Pad / Start / Select (veja o diagrama)
echo        Tela de toque (tela de baixo): aponte com o controle e aperte o gatilho, como uma caneta.
echo        Segure o botão META (controle direito) para RECENTRALIZAR as telas.
echo   4. Menu do emulador em VR: aperte o botão de menu (☰, controle esquerdo) → "Settings":
echo        Renderer: Vulkan (padrão)   /   Async shader compilation: ON (padrão)   /   Resolution: 2x (3S aguenta)
echo        Se travar/engasgar: Resolution 1x e "Use disk shader cache" ON.
echo   5. Para um controle Bluetooth: Settings → Controller → Input Bindings. Se sempre aparecer
echo      "Virtual Device 4", aperte Select+Start no controle logo antes de mapear cada botão.
echo.
echo   Jogos que precisam de arquivos do sistema (Mii, tema, DLC): copie do seu 3DS a pasta
echo   Nintendo 3DS\...\ (sysdata) conforme a wiki; a maioria dos jogos NÃO precisa disso.
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
echo      → arquivo app-gitHub-prod-release.apk (versão GitHub; a da Play Store não instala no Quest).
echo   2. Instale pelo SideQuest ou pela opção 8 do menu.
echo.
echo   JOGOS
echo   3. Copie seus .nds para %QROOT%/ROMs/NDS (opção 8 → Enviar jogos, ou Explorador/MTP).
echo      Do seu 3DS: GodMode9 dumpa cartuchos DS pelo [C:] GAMECART também (gera .nds).
echo.
echo   CONFIGURAR (headset na cabeça; o melonDS abre como janela 2D)
echo   4. Abra melonDS (Fontes desconhecidas). Na primeira vez ele pede "ROM search directories":
echo      toque em "+" → Emuladores → ROMs → NDS → "Use this folder". A lista de jogos aparece.
echo   5. Configurações → "System" → "Console type: DS". BIOS/firmware de DS NÃO são obrigatórios
echo      (ele usa uma BIOS interna). Para modo DSi você precisaria dos dumps do seu DSi/3DS.
echo   6. Configurações → "Input" → "Key mapping" → mapeie o controle Bluetooth (A, B, X, Y, L, R, Start, Select, D-Pad).
echo      Toque na tela de baixo: aponte com o Touch controller e aperte o gatilho.
echo   7. Configurações → "Video": "Renderer: OpenGL", "Internal resolution: 2x-4x", "Threaded rendering: ON",
echo      "JIT: ON" (em Configurações → System, se disponível). Layout: "Layout editor" para pôr as telas lado a lado.
echo.
echo   JOGAR: toque no jogo na lista. Saves ficam em Android/data/me.magnum.melonds/files/saves (faça backup).
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
echo   NetherSX2-classic = AetherSX2 (base PCSX2) com correções da comunidade. O AetherSX2 original foi
echo   descontinuado; use SOMENTE o APK do GitHub oficial do NetherSX2.
echo.
echo   INSTALAR
echo   1. Baixe:  https://github.com/Trixarian/NetherSX2-classic/releases/latest  → NetherSX2-vX.X-3668.apk
echo   2. Instale pelo SideQuest ou pela opção 8 do menu.
echo.
echo   BIOS (obrigatória; vem do SEU PS2)
echo   3. Dump da BIOS com o PS2 (FreeMcBoot + biosdrain) gera um .bin (ex.: SCPH-70004_BIOS_V12_EUR_200.bin).
echo      Copie para %QROOT%/BIOS.
echo.
echo   JOGOS
echo   4. Seus discos em .iso ou .chd (CHD ocupa menos; converta no PC com chdman). Copie para %QROOT%/ROMs/PS2.
echo.
echo   CONFIGURAR (headset na cabeça, app 2D)
echo   5. Abra NetherSX2 → assistente inicial: "BIOS" → escolha a pasta Emuladores/BIOS → selecione a BIOS;
echo      "Game directories" → Emuladores/ROMs/PS2 → "Use this folder". A lista aparece com capas.
echo   6. Configurações → Graphics:  Renderer "Vulkan"   /   Upscale "1.5x ou 2x" (3S roda 2x na maioria dos jogos)
echo      Se cair FPS: 1x. "Widescreen patches: ON" para 16:9.
echo   7. Configurações → System: "EE cycle rate 100%%", "Cycle skip 0" (só mude em jogos muito pesados: EE 75%%).
echo   8. Configurações → Controller → Port 1 → "Automatic mapping" com o controle Bluetooth ligado, ou mapeie manual.
echo   9. Toque no jogo. Menu do emulador: botão "voltar" do controle ou o ícone no canto → save states, fechar.
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
echo   SITUAÇÃO (set/2026): existe um port NÃO oficial do xemu para Android chamado X1 BOX. A versão paga
echo   da Play Store é polêmica; a versão gratuita está no GitHub. A equipe do xemu confirmou que fará um
echo   Android oficial, sem data. Requisitos: Android 8+, arm64, GPU Vulkan, 8 GB de RAM (o Quest 3S tem 8 GB,
echo   mas o sistema usa parte). Espere desempenho FRACO: teste só jogos leves.
echo.
echo   1. Baixe o APK gratuito no GitHub (ex.: https://github.com/phobos665/xemu-android/releases ou
echo      https://github.com/izzy2lost/xemu/releases) - confira sempre a release mais recente.
echo   2. Instale pelo SideQuest / opção 8.
echo   3. ARQUIVOS DO SEU XBOX (o app tem um assistente que pede cada um):
echo        mcpx_1.0.bin          (boot ROM MCPX)
echo        Complex_4627.bin      (BIOS/flash ROM)
echo        xbox_hdd.qcow2        (imagem de HD; o xemu para PC gera uma vazia, use a mesma)
echo      Copie os três para %QROOT%/BIOS. Jogos: .iso/.xiso extraídos dos seus discos → %QROOT%/ROMs/Xbox.
echo   4. Abra o app (2D) → assistente → aponte cada arquivo → em "Games" aponte a pasta ROMs/Xbox.
echo   5. Controle: Bluetooth (mapeado automaticamente como Xbox) ou controle virtual na tela.
echo.
echo   Se travar na tela do Xbox (bolha verde) ou fechar: o jogo não é compatível ainda. Veja a lista de
echo   compatibilidade do xemu (xemu.app/titles) e lembre que no Android é ainda menor.
echo.
choice /c SN /n /m "   [S] Enviar jogos de Xbox agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/ROMs/Xbox"
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Xbox 360 / One / Series: Cloud Gaming oficial e streaming do PC"
echo   Não existe emulador de Xbox 360/One/Series para Android. Duas formas reais de jogar Xbox no Quest 3S:
echo.
echo   A) XBOX CLOUD GAMING (oficial, sem sideload)  → MÉTODO RECOMENDADO para jogos modernos
echo      1. Headset → Loja (Meta Horizon Store) → busque "Xbox" → instale o app "Xbox" (grátis).
echo         Requer Horizon OS build 60 ou mais recente (você já atualizou no guia 1).
echo      2. Precisa de assinatura Xbox Game Pass (Ultimate para o catálogo completo; alguns jogos free-to-play
echo         funcionam só com conta Microsoft). O plano Horizon+ do Quest também inclui horas de Cloud Gaming.
echo      3. Controle: Bluetooth (Xbox Wireless, DualShock 4, Switch Pro, Backbone...). A Meta anunciou
echo         emulação de gamepad com os Touch controllers; se a opção existir no app, use.
echo      4. Abra o app Xbox → entre com a conta Microsoft → escolha o jogo → "Play". A tela vira um telão VR.
echo      5. Internet: 20 Mbps ou mais e Wi-Fi 5 GHz; fique perto do roteador.
echo.
echo   B) STREAMING DO SEU PC (para 360 via emulador Xenia, ou jogos do PC/Game Pass PC)
echo      1. No PC: instale Xenia (xenia.jp, Xbox 360) ou o jogo do Game Pass PC.
echo      2. Streaming: Virtual Desktop (loja Meta, pago, melhor), Steam Link (loja Meta, grátis, se o jogo
echo         estiver na Steam ou adicionado como "jogo não-Steam") ou Moonlight (sideload) + Sunshine no PC.
echo      3. No Quest, abra o app de streaming → conecte ao PC → o desktop do PC aparece em VR; rode o Xenia.
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
echo   Eden é o emulador de Switch mais ativo em 2026 (fork do yuzu), com versão Android. No Quest 3S
echo   (Snapdragon XR2 Gen 2, CPU mais fraca que um celular top) espere: jogos 2D/indie e leves = jogável;
echo   jogos 3D pesados = lento. Considere EXPERIMENTAL.
echo.
echo   VOCÊ PRECISA (extraídos do SEU Switch desbloqueado - homebrew):
echo     prod.keys e title.keys   → dump com Lockpick_RCM (ou fork) no seu console
echo     Firmware (pasta com .nca, versão 20.0.1 recomendada) → dump com TegraExplorer ou "Firmware dumper"
echo     Jogos em .nsp ou .xci    → dump com nxdumptool no seu console
echo   Sem esses arquivos DO SEU CONSOLE o Eden não abre jogos. Este guia não cobre a obtenção por outras vias.
echo.
echo   1. Coloque no PC uma pasta  Switch_Sistema\  com prod.keys, title.keys e a pasta Firmware\.
echo   2. Envie para o headset: %QROOT%/BIOS/Switch  (opção 8 → Enviar → destino manual, ou MTP).
echo   3. Jogos → %QROOT%/ROMs/Switch.
echo.
choice /c SN /n /m "   [S] Enviar a pasta Switch_Sistema agora via ADB    [N] Pular : "
if not errorlevel 2 call :ENVIAR "%QROOT%/BIOS/Switch"
call :AGUARDAR "Pressione qualquer tecla quando keys, firmware e jogos estiverem no headset"
call :FIM_PASSO 13
goto %DESTINO%

:PASSO_14
cls
call :CABECALHO 14 "Eden (Switch): instalar, driver de GPU, configurar e jogar"
echo   1. Baixe:  https://github.com/eden-emulator/Releases/releases/latest  → APK Android (arm64 / "android" no nome).
echo   2. Instale pelo SideQuest / opção 8.
echo   3. DRIVER DE GPU (Turnip): melhora muito em Adreno. Baixe um .zip de driver Turnip/Mesa recente:
echo        https://github.com/K11MCH1/AdrenoToolsDrivers/releases   (ex.: turnip-vX.X.X.zip; NÃO extraia)
echo      Envie o .zip para %QROOT%/BIOS (ou qualquer pasta).
echo   4. AÇÃO FÍSICA: coloque o headset, abra Eden (Fontes desconhecidas). Primeira execução:
echo        - "Install keys" → aponte prod.keys (Emuladores/BIOS/Switch)
echo        - "Install firmware" → aponte a pasta Firmware (ou .zip dela)
echo        - "Add game folder" → Emuladores/ROMs/Switch
echo   5. Configurações → "Graphics" → "GPU driver" → "Install driver" → escolha o .zip Turnip → selecione-o.
echo        Renderer: Vulkan   /   Accuracy: Normal   /   Resolution: 0.5x ou 0.75x (comece baixo no 3S)
echo        Async shaders: ON   /   Use disk shader cache: ON   /   Anisotropic: 1x
echo   6. Configurações → "System" → "Docked mode: OFF" (modo portátil é mais leve).
echo   7. Configurações → "Controls" → Player 1 → mapeie o controle Bluetooth.
echo   8. Toque no jogo. A primeira vez compila shaders (engasgos normais nos primeiros minutos).
echo.
echo   Se o Eden fechar sozinho: memória insuficiente → feche outros apps, reduza resolução, e teste um jogo leve.
echo   Alternativas se um jogo específico não rodar: Citron ou Sudachi (mesmo processo de keys/firmware).
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
echo     - No Lightning Launcher você define o tamanho padrão da janela (passo 5). Um painel de 3-4 m de largura
echo       a 2 m de distância vira um "telão".
echo     - Botão Meta (controle direito) segurado = recentraliza a visão. Toque simples = barra universal.
echo   CONTROLE
echo     - Controle Bluetooth: alguns emuladores só reconhecem quando o app já está aberto; se não responder,
echo       feche e reabra o app com o controle já conectado.
echo     - Toque na tela: aponte o Touch controller e aperte o gatilho (funciona como dedo).
echo   DESEMPENHO E BATERIA
echo     - Passthrough desligado economiza bateria. Brilho em 50-70%%.
echo     - Emuladores pesados (PS2/Switch) drenam a bateria em 1,5-2 h: jogue com o cabo de carga.
echo     - Se esquentar muito, reduza resolução interna e feche o navegador/outros apps.
echo   ÁUDIO
echo     - O áudio dos apps 2D sai pelos alto-falantes do headset; fones no P2 (3,5 mm) do lado esquerdo funcionam.
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "Organizar a biblioteca e fazer backup dos saves"
echo   ORGANIZAÇÃO
echo     - Lightning Launcher → grupos "3DS", "NDS", "PS2", "Switch", "Vídeo". Esconda apps de sistema que não usa.
echo     - No PC, espelhe a mesma estrutura: Quest\Emuladores\ROMs\^<console^> e Quest\Emuladores\BIOS.
echo.
echo   BACKUP DE SAVES (faça toda semana; cabo conectado)
echo     Onde cada emulador guarda:
echo       CitraVR   : Android/data/org.citra.citra_emu/files  (ou pasta citra-emu no armazenamento interno)
echo       melonDS   : Android/data/me.magnum.melonds/files/saves
echo       NetherSX2 : Android/data/xyz.aethersx2.android/files  (memcards, sstates)
echo       Eden      : Android/data/dev.eden.eden_emulator/files (nand, saves)  (nome do pacote pode variar)
echo     Como copiar:
echo       A) SideQuest → "Currently installed apps" → engrenagem do app → "Backup app data"
echo       B) Opção 8 do menu → "Baixar (pull) uma pasta do headset" → informe o caminho acima → salva no PC
echo       C) Explorador (MTP): Android\data\^<pacote^>\files → copie para o PC.
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
echo   O Stremio é um centralizador de vídeo (filmes, séries, canais, YouTube) com add-ons. É um app Android
echo   normal; no Quest vira um telão. Existem duas versões:
echo     - Stremio (mobile)     : interface de toque, funciona com o Touch controller como ponteiro. → RECOMENDADA
echo     - Stremio Android TV   : interface para controle remoto/gamepad (navegação por D-Pad).
echo.
echo   1. Abra a página oficial:  https://www.stremio.com/downloads
echo   2. Em "Android", baixe o APK **ARM64 (arm64-v8a)** da versão estável (ex.: com.stremio.one-2.x.x-...-arm64-v8a.apk).
echo      (Se quiser a versão TV: seção "Android TV" → arm64-v8a.)
echo   3. Instale pelo SideQuest / opção 8 do menu.
echo   4. AÇÃO FÍSICA: coloque o headset → Biblioteca → Fontes desconhecidas → "Stremio".
echo.
choice /c SN /n /m "   [S] Abrir a página de downloads agora    [N] Já baixei : "
if not errorlevel 2 start "" "https://www.stremio.com/downloads"
call :AGUARDAR "Pressione qualquer tecla quando o Stremio abrir no headset"
call :FIM_PASSO 17
goto %DESTINO%

:PASSO_18
cls
call :CABECALHO 18 "Stremio: conta, add-ons e reprodução"
echo   1. Na tela inicial, "Log in" (conta existente) ou "Sign up" / "Continue as guest". Uma conta sincroniza
echo      biblioteca e add-ons com o PC/celular - recomendado.
echo   2. Add-ons: ícone de peça de quebra-cabeça (ou Menu → Add-ons) → "Community add-ons" → instale os que
echo      quiser (ex.: YouTube, Twitch, catálogos públicos, legendas OpenSubtitles). Também dá para adicionar
echo      um add-on pela URL do manifesto (campo "Add-on repository URL").
echo      Nota: a legalidade do conteúdo depende do add-on que você instala, não do Stremio.
echo   3. Busca: lupa → digite → escolha o título → escolha a fonte (stream) → play.
echo   4. Player: toque na tela para mostrar controles; legendas no ícone "CC"; áudio/faixa no ícone de engrenagem.
echo   5. Sincronizar com o PC: instale o Stremio no Windows com a mesma conta; a biblioteca e o "continuar assistindo"
echo      aparecem nos dois.
echo.
call :AGUARDAR "Pressione qualquer tecla quando um vídeo tiver reproduzido"
call :FIM_PASSO 18
goto %DESTINO%

:PASSO_19
cls
call :CABECALHO 19 "Stremio: dicas para VR (janela, áudio, legendas, Wi-Fi)"
echo   - Janela: aumente o painel até ~4 m de largura e afaste 2-3 m; com o Lightning Launcher defina esse tamanho como padrão.
echo   - Ambiente: Configurações do Quest → Personalização → Ambiente virtual escuro (cinema) melhora contraste.
echo   - Wi-Fi: 5 GHz; para 1080p precisa ~10 Mbps, 4K ~30 Mbps. O 3S decodifica H.264/H.265 até 4K, mas 1080p é o ideal.
echo   - Se o vídeo travar: escolha uma fonte 1080p em vez de 4K; feche outros apps; aproxime-se do roteador.
echo   - Legendas: ajuste tamanho em Player → configurações de legenda (ícone CC → engrenagem).
echo   - Deitado: Quest → Configurações → Acessibilidade/Experimental → "Modo de deitar" / recentre com o botão Meta.
echo   - Alternativa sem instalar nada: no navegador do Quest abra https://web.stremio.com (mesma conta).
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 19
goto %DESTINO%

:PASSO_20
cls
call :CABECALHO 20 "Verificação final"
echo   CHECKLIST:
echo     [ ] Lightning Launcher abre e lista todos os apps (oficiais + Fontes desconhecidas).
echo     [ ] Controle Bluetooth aparece como Conectado e funciona em pelo menos um emulador.
echo     [ ] CitraVR abre um jogo de 3DS com as duas telas em VR.
echo     [ ] melonDS abre um jogo de DS em janela 2D.
echo     [ ] NetherSX2 abre um jogo de PS2 com a BIOS do seu console.
echo     [ ] (Opcional) X1 BOX abre a tela do Xbox; app Xbox Cloud Gaming instalado da loja.
echo     [ ] (Opcional) Eden abre um jogo leve de Switch.
echo     [ ] Stremio reproduz um vídeo.
echo     [ ] Você sabe onde ficam os saves e fez o primeiro backup (passo 16).
echo.
echo   Pacotes instalados detectados via ADB (se conectado):
call :ACHAR_ADB
if defined ADB "%ADB%" shell "pm list packages | grep -iE 'citra|melonds|aethersx2|nethersx2|xemu|x1box|eden|citron|sudachi|stremio|lightning|threethan'" 2>nul
echo.
call :AGUARDAR "Pressione qualquer tecla para concluir"
call :FIM_PASSO 20
goto %DESTINO%

:CONCLUIDO
cls
echo.
echo  ============================================================================================
echo   PRONTO: Quest 3S com launcher Android, emuladores de 3DS/NDS/PS2 (+ Xbox e Switch experimentais) e Stremio.
echo  ============================================================================================
echo.
echo   Sugestões extras:
echo     - RetroArch (retroarch.com → Android APK "aarch64") cobre SNES, GBA, PS1, N64, Dreamcast e muito mais.
echo     - PPSSPP (ppsspp.org) para PSP roda muito bem no 3S.
echo     - Dolphin (dolphin-emu.org, Android) para GameCube/Wii: jogos leves rodam.
echo     - Mantenha os emuladores atualizados pelo GitHub; releases novas corrigem muita coisa.
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
echo   Quest 3S com Modo Desenvolvedor + SideQuest OK (guia 1); cabo USB-C; controle Bluetooth; espaço livre;
echo   seus próprios jogos/BIOS/keys extraídos dos seus consoles.
echo.
echo   DOWNLOADS OFICIAIS
echo   ------------------
echo   Lightning Launcher ...... https://github.com/threethan/LightningLauncher/releases/latest
echo   CitraVR (3DS) ........... https://github.com/amwatson/CitraVR/releases/latest
echo   melonDS (NDS) ........... https://github.com/rafaelvcaetano/melonDS-android/releases/latest
echo   NetherSX2 (PS2) ......... https://github.com/Trixarian/NetherSX2-classic/releases/latest
echo   X1 BOX / xemu (Xbox) .... https://github.com/phobos665/xemu-android/releases   (não oficial)
echo   Eden (Switch) ........... https://github.com/eden-emulator/Releases/releases/latest
echo   Turnip GPU drivers ...... https://github.com/K11MCH1/AdrenoToolsDrivers/releases
echo   Stremio ................. https://www.stremio.com/downloads   (Android → arm64-v8a)
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
echo   ERROS COMUNS E CORREÇÕES  (causa → correção → teste)
echo   ---------------------------------------------------
echo   [Instalação]
echo   - "App not installed" / INSTALL_FAILED_NO_MATCHING_ABIS: APK não é arm64 → baixe a variante arm64-v8a.
echo   - INSTALL_FAILED_UPDATE_INCOMPATIBLE: versão antiga assinada por outra chave → desinstale a antiga (faça backup dos saves).
echo   - App não aparece: Biblioteca → filtro "Fontes desconhecidas".
echo   [Pastas e jogos]
echo   - Emulador não vê a pasta: use o seletor de pasta DO APP ("Use this folder"); não digite caminho à mão.
echo   - adb push lento/travando: use cabo USB 3.0 e porta traseira; ou copie por MTP; ou ADB sem fio só para arquivos pequenos.
echo   [CitraVR]
echo   - Jogo não abre / tela preta: ROM criptografada → decripte no GodMode9 do seu 3DS.
echo   - OK do navegador de arquivos não funciona: permissão de microfone (Configurações do Quest → permissões de apps).
echo   - Telas fora do centro: segure o botão Meta.   - Mapeamento "Virtual Device 4": Select+Start antes de mapear.
echo   - Rebind não pega: apague [dados do app]/Configs/config.ini e reabra.
echo   [melonDS]
echo   - Lento: ative JIT e Threaded rendering; resolução 1x-2x.   - Controle não responde: reabra o app com o controle já pareado.
echo   [NetherSX2]
echo   - "BIOS not found": aponte a pasta com o .bin e selecione-o na lista; confira que o dump é completo (4 MB).
echo   - Gráficos quebrados: Renderer Vulkan ↔ OpenGL; desative upscale; use os "game fixes" automáticos (GameDB).
echo   - Som picotado: Audio → "Time stretch" ON; reduza upscale.
echo   [X1 BOX / xemu]
echo   - Fecha ao abrir: RAM insuficiente → feche tudo, reinicie o headset, abra só o X1 BOX.
echo   - Trava na bolha verde/logo: BIOS/MCPX/HDD errados ou jogo incompatível.
echo   [Eden]
echo   - "Missing keys/firmware": reinstale prod.keys e a pasta Firmware (versão 20.0.1) pelas opções do app.
echo   - Fecha em jogos pesados: resolução 0.5x, modo portátil, driver Turnip; ou o jogo não é viável no 3S.
echo   - Driver Turnip não instala: baixe o .zip sem extrair; use uma versão mais antiga.
echo   [Xbox Cloud Gaming]
echo   - App não aparece na loja: Horizon OS abaixo de 60 → atualize; região/conta sem Game Pass.
echo   - Lag: Wi-Fi 5 GHz, 20+ Mbps, perto do roteador; feche downloads no PC.
echo   [Stremio]
echo   - Tela preta no player: troque a fonte; ou Configurações → Player → "Hardware decoding" OFF/ON.
echo   - Não faz login: verifique data/hora do headset e rede; use web.stremio.com no navegador para testar a conta.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DESFAZER
cls
echo.
echo   COMO DESFAZER
echo   -------------
echo   1. Remover um emulador/app: Biblioteca → Fontes desconhecidas → "..." → Desinstalar
echo      (ou SideQuest → "Currently installed apps" → lixeira; ou opção 8 → Desinstalar por nome de pacote).
echo      Antes, faça backup dos saves (passo 16) se quiser mantê-los.
echo   2. Apagar jogos e BIOS: Explorador (MTP) → apague a pasta Emuladores; ou opção 8 → "Apagar pasta Emuladores".
echo   3. Remover o Lightning Launcher: desinstale como qualquer app; a barra do Quest volta ao padrão sozinha.
echo   4. Desconectar o controle Bluetooth: Configurações → Dispositivos → Bluetooth → esquecer.
echo   5. Para desligar o Modo Desenvolvedor: guia 1, opção 6.
echo   Nada disso exige reset de fábrica.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   Abrindo links oficiais no navegador padrão...
start "" "https://github.com/threethan/LightningLauncher/releases/latest"
start "" "https://github.com/amwatson/CitraVR/releases/latest"
start "" "https://github.com/amwatson/CitraVR/wiki"
start "" "https://github.com/rafaelvcaetano/melonDS-android/releases/latest"
start "" "https://github.com/Trixarian/NetherSX2-classic/releases/latest"
start "" "https://github.com/eden-emulator/Releases/releases/latest"
start "" "https://www.stremio.com/downloads"
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

rem ============================================================================
rem  FERRAMENTAS ADB
rem ============================================================================

:FERRAMENTAS
cls
echo.
echo   FERRAMENTAS ADB  (headset conectado e depuração USB permitida)
echo   -------------------------------------------------------------
call :ACHAR_ADB
if not defined ADB (call :AGUARDAR "Pressione qualquer tecla para voltar" & goto MENU)
echo.
echo   [1] Testar conexão (adb devices)
echo   [2] Criar a estrutura de pastas %QROOT%
echo   [3] Instalar um APK do PC
echo   [4] Enviar (push) uma pasta de jogos do PC para o headset
echo   [5] Baixar (pull) uma pasta do headset para o PC (saves, etc.)
echo   [6] Listar pacotes instalados (emuladores e apps sideloaded)
echo   [7] Desinstalar um app por nome de pacote
echo   [8] Apagar a pasta %QROOT% do headset (CUIDADO)
echo   [0] Voltar
echo.
choice /c 123456780 /n /m "   Escolha: "
if errorlevel 9 goto MENU
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
"%ADB%" shell "mkdir -p %QROOT%/BIOS %QROOT%/ROMs/3DS %QROOT%/ROMs/NDS %QROOT%/ROMs/PS2 %QROOT%/ROMs/Xbox %QROOT%/ROMs/Switch %QROOT%/Saves_Backup"
"%ADB%" shell "ls -la %QROOT% %QROOT%/ROMs"
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

:FERR_APK
echo.
set "APK="
set /p "APK=   Arraste o arquivo .apk para esta janela (ou cole o caminho) e ENTER: "
set "APK=%APK:"=%"
if "%APK%"=="" goto FERRAMENTAS
if not exist "%APK%" (echo   Arquivo não encontrado. & call :AGUARDAR "Pressione qualquer tecla" & goto FERRAMENTAS)
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
echo   (pacotes de terceiros = instalados por você ou pela loja; os da loja começam geralmente com com.oculus/com.meta ou nome do estúdio)
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
echo   ATENÇÃO: isto apaga %QROOT% (todos os jogos, BIOS, keys e backups copiados para lá). Não afeta os apps.
call :PERGUNTA "   Tem certeza?"
if errorlevel 2 goto FERRAMENTAS
"%ADB%" shell "rm -rf %QROOT%"
echo   Apagado.
call :AGUARDAR "Pressione qualquer tecla"
goto FERRAMENTAS

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
if not defined ADB (echo   adb.exe não encontrado. Instale o SideQuest, guia 1 passo 8, e reabra este guia. & exit /b)
echo   adb: %ADB%
exit /b

:ENVIAR
rem %1 = destino no headset
call :ACHAR_ADB
if not defined ADB exit /b
echo.
set "ORIG="
set /p "ORIG=   Pasta no PC com os arquivos (arraste a pasta para cá ou cole o caminho) e ENTER: "
set "ORIG=%ORIG:"=%"
if "%ORIG%"=="" exit /b
if not exist "%ORIG%\" (echo   Pasta não encontrada. & exit /b)
echo   Enviando o CONTEÚDO de "%ORIG%" para %~1 ... (barra de progresso do adb abaixo; pode demorar)
"%ADB%" shell "mkdir -p %~1"
"%ADB%" push "%ORIG%\." "%~1"
echo.
echo   Conteúdo do destino agora:
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
choice /c SN /n /m "%~1  [S] Sim   [N] Não : "
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
choice /c SRME /n /m "   [S] Próximo passo    [R] Repetir este passo    [M] Menu    [E] Erros e correções : "
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
