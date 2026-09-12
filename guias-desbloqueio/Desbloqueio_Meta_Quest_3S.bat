@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul 2>&1
title Guia interativo - Desbloqueio Meta Quest 3S (Developer Mode + sideload)
color 0A
mode con: cols=110 lines=50 >nul 2>&1

rem ============================================================================
rem  GUIA INTERATIVO - META QUEST 3S: MODO DESENVOLVEDOR + SIDELOAD (SideQuest/ADB)
rem  Baseado na documentacao oficial da Meta (Device Setup / Enable Developer Mode)
rem  e no fluxo atual do SideQuest, consultados em set/2026.
rem  Salve este arquivo como UTF-8 SEM BOM com finais de linha CRLF.
rem ============================================================================

set "PASTA=%~dp0"
set "PROG=%PASTA%progresso_quest3s.txt"
set "TOTAL=18"
set "ASCII=0"
set "PSB64=CgAkAHMAcgBjAD0AJABlAG4AdgA6AFMAQQBfAFMAUgBDADsAIAAkAGQAcwB0AD0AJABlAG4AdgA6AFMAQQBfAEQAUwBUAAoAJAB0AD0AWwBJAE8ALgBGAGkAbABlAF0AOgA6AFIAZQBhAGQAQQBsAGwAVABlAHgAdAAoACQAcwByAGMALABbAFQAZQB4AHQALgBFAG4AYwBvAGQAaQBuAGcAXQA6ADoAVQBUAEYAOAApAAoAJABtAGEAcAA9AEAAewAKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIAMQA5ADIAKQA9ACcALQBeAD4AJwA7ACAAIAAgACMAIACSIQoAIAAoAFsAcwB0AHIAaQBuAGcAXQBbAGMAaABhAHIAXQAwAHgAMgAxADkANAApAD0AJwAgAG8AdQAgACcAOwAgACAAIwAgAJQhCgAgACgAWwBzAHQAcgBpAG4AZwBdAFsAYwBoAGEAcgBdADAAeAAyADYAMwAwACkAPQAnAFsAbQBlAG4AdQBdACcAOwAjACAAMCYKACAAKABbAHMAdAByAGkAbgBnAF0AWwBjAGgAYQByAF0AMAB4ADIANwAxADMAKQA9ACcATwBLACcAOwAgACAAIAAgACMAIAATJwoAIAAoACcA5WUsZycAKQA9ACcATgBpAGgAbwBuACAAKABKAGEAcABhAG8AKQAnADsACgAgACgAJwAtippbVzBqMEQwJwApAD0AJwBuAGEAbwAgAGQAZQBmAGkAbgBpAHIAJwA7AAoAIAAoACcAALNc1fy7ba0nACkAPQAnAEQAYQBlAGgAYQBuACAATQBpAG4AZwB1AGsAIAAoAEMAbwByAGUAaQBhACkAJwA7AAoAIAAoACcAJMEVyFjVwMkgAErFTMcnACkAPQAnAG4AYQBvACAAZABlAGYAaQBuAGkAcgAnAAoAfQAKAGYAbwByAGUAYQBjAGgAKAAkAGsAIABpAG4AIAAkAG0AYQBwAC4ASwBlAHkAcwApAHsAIAAkAHQAPQAkAHQALgBSAGUAcABsAGEAYwBlACgAJABrACwAJABtAGEAcABbACQAawBdACkAIAB9AAoAJABuAD0AJAB0AC4ATgBvAHIAbQBhAGwAaQB6AGUAKABbAFQAZQB4AHQALgBOAG8AcgBtAGEAbABpAHoAYQB0AGkAbwBuAEYAbwByAG0AXQA6ADoARgBvAHIAbQBEACkACgAkAHMAYgA9AE4AZQB3AC0ATwBiAGoAZQBjAHQAIABUAGUAeAB0AC4AUwB0AHIAaQBuAGcAQgB1AGkAbABkAGUAcgAKAGYAbwByAGUAYQBjAGgAKAAkAGMAIABpAG4AIAAkAG4ALgBUAG8AQwBoAGEAcgBBAHIAcgBhAHkAKAApACkAewAKACAAIABpAGYAKABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBDAGgAYQByAFUAbgBpAGMAbwBkAGUASQBuAGYAbwBdADoAOgBHAGUAdABVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQAoACQAYwApACAALQBuAGUAIABbAEcAbABvAGIAYQBsAGkAegBhAHQAaQBvAG4ALgBVAG4AaQBjAG8AZABlAEMAYQB0AGUAZwBvAHIAeQBdADoAOgBOAG8AbgBTAHAAYQBjAGkAbgBnAE0AYQByAGsAKQB7ACAAWwB2AG8AaQBkAF0AJABzAGIALgBBAHAAcABlAG4AZAAoACQAYwApACAAfQAKAH0ACgAkAG8AdQB0AD0AJABzAGIALgBUAG8AUwB0AHIAaQBuAGcAKAApAAoAJABvAHUAdAA9AFsAcgBlAGcAZQB4AF0AOgA6AFIAZQBwAGwAYQBjAGUAKAAkAG8AdQB0ACwAJwBbAF4AXAB4ADAAMAAtAFwAeAA3AEYAXQAnACwAJwA/ACcAKQAKACQAbwB1AHQAPQAkAG8AdQB0AC4AUgBlAHAAbABhAGMAZQAoACcAcwBlAHQAIAAiAEEAUwBDAEkASQA9ADAAIgAnACwAJwBzAGUAdAAgACIAQQBTAEMASQBJAD0AMQAiACcAKQAKAFsASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABzAHQALAAkAG8AdQB0ACwAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAVABlAHgAdAAuAFUAVABGADgARQBuAGMAbwBkAGkAbgBnACgAJABmAGEAbABzAGUAKQApACkACgA="
set "DESTINO=MENU"
set "VOLTAR=MENU"
set "PASSO=0"
set "ADB="
call :CARREGAR

:MENU
cls
echo.
echo  ==========================================================================================
echo   GUIA INTERATIVO DE DESBLOQUEIO  -  META QUEST 3S  (Developer Mode + SideQuest / ADB)
echo  ==========================================================================================
echo.
echo   "Desbloquear" o Quest 3S = ativar o Modo Desenvolvedor e liberar a instalação de apps de fora
echo   da loja (sideload) via SideQuest/ADB. É o método OFICIAL da Meta: não perde garantia, não apaga
echo   dados, é 100%% reversível. NÃO existe jailbreak/root público para o Quest 3S; qualquer site que
echo   prometa isso é golpe.
echo.
if not "%PASSO%"=="0" echo   Progresso salvo: você parou no passo %PASSO% de %TOTAL%.
if not "%PASSO%"=="0" echo.
echo   [1] Começar do início (passo 1)
echo   [2] Continuar de onde parei
echo   [3] Ir para um passo específico
echo   [4] Requisitos e downloads
echo   [5] Erros comuns e como corrigir
echo   [6] Como desfazer (desativar o modo desenvolvedor / remover apps)
echo   [7] Abrir links oficiais no navegador
echo   [8] Diagnóstico rápido da conexão ADB (headset ligado no cabo)
echo   [9] Apagar o progresso salvo
echo   [A] Modo sem acentos (use se o texto aparecer com caracteres estranhos)
echo   [0] Sair
echo.
choice /c 1234567890A /n /m "   Escolha uma opção: "
if errorlevel 11 goto SEM_ACENTOS
if errorlevel 10 goto SAIR
if errorlevel 9 goto APAGAR_PROGRESSO
if errorlevel 8 (set "VOLTAR=MENU" & goto DIAG_ADB)
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
echo    1  O que é e o que não é este desbloqueio          9  Conectar o cabo USB-C (físico)
echo    2  Conhecer o headset: botões e portas (físico)   10  Aceitar "Permitir depuração USB" no headset
echo    3  Carregar, ligar e atualizar o Horizon OS       11  Ajustes do menu Desenvolvedor no headset
echo    4  Conta Meta e app Meta Horizon no celular       12  Verificar a conexão no SideQuest / ADB
echo    5  Criar a organização de desenvolvedor (site)    13  Instalar o primeiro app (sideload de teste)
echo    6  Verificar a conta (SMS ou cartão)              14  Encontrar os apps: aba "Fontes desconhecidas"
echo    7  Ativar o Modo Desenvolvedor no app do celular  15  (Opcional) ADB sem fio pelo Wi-Fi
echo    8  PC: drivers ADB + SideQuest                    16  Backup inicial (capturas, vídeos, lista de apps)
echo                                                    17  Ajustes de conforto via ADB (Hz, textura, CPU/GPU, Guardian)
echo                                                    18  Verificação final e boas práticas
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
rem  PASSOS
rem ============================================================================

:PASSO_1
cls
call :CABECALHO 1 "O que é (e o que não é) este desbloqueio"
echo   O QUE VOCÊ VAI CONSEGUIR:
echo     - Instalar APKs de fora da loja (emuladores, apps open-source, jogos de sideload, mods).
echo     - Usar SideQuest para ajustar resolução, taxa de atualização, nível de CPU/GPU, gravar tela etc.
echo     - Usar ADB (Android Debug Bridge) pelo cabo ou pelo Wi-Fi.
echo.
echo   O QUE NÃO EXISTE (em set/2026):
echo     - Root, bootloader destravado, custom ROM ou "jailbreak" para o Quest 3S.
echo     - Rodar jogos pagos da loja da Meta sem comprar. Este guia não cobre pirataria.
echo.
echo   SEGURANÇA / REVERSIBILIDADE:
echo     - Nada é apagado. O Modo Desenvolvedor pode ser desligado a qualquer momento (opção 6).
echo     - A Meta permite o Modo Desenvolvedor oficialmente; não afeta garantia.
echo     - Regra: só instale APKs de fontes que você conhece (GitHub oficial do projeto, SideQuest).
echo.
echo   REQUISITOS RÁPIDOS:
echo     - Conta Meta com 18+ anos (contas de menor/gerenciadas NÃO conseguem ativar o modo dev).
echo     - Celular com o app "Meta Horizon" já pareado com o headset.
echo     - PC com Windows 10/11 e uma porta USB (ideal USB 3.0, azul).
echo     - Cabo USB-C de DADOS (o cabo de carga da caixa serve; cabos "só carga" não funcionam).
echo     - Wi-Fi para o headset e para o PC.
echo.
call :PERGUNTA "   A conta Meta usada no headset é de maior de 18 anos e NÃO é gerenciada por um responsável?"
if errorlevel 2 goto CONTA_MENOR
call :FIM_PASSO 1
goto %DESTINO%

:CONTA_MENOR
echo.
echo   PARE AQUI: contas de menor de idade (10-17, gerenciadas pelo app dos pais) NÃO podem ativar o Modo Desenvolvedor.
echo   A Meta não oferece exceção. Opções reais:
echo     - usar uma conta Meta de um adulto como conta principal do headset (Configurações → Contas → adicionar);
echo     - esperar completar 18 anos e converter a conta.
echo   Não adianta continuar o guia com a conta atual: a opção simplesmente não aparece no app.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:PASSO_2
cls
call :CABECALHO 2 "Conhecer o headset: botões e portas (ação física)"
echo   Pegue o Quest 3S nas mãos, com as lentes voltadas para você (como se fosse colocar na cabeça).
echo.
echo        VISTA DE CIMA (lentes para você, faixa da cabeça para trás)
echo.
echo                   [ lado ESQUERDO ]              [ lado DIREITO ]
echo        +-------------------------------------------------------------+
echo        :  (o) botão POWER e LED de status                            :
echo        :  [=] porta USB-C (carga e dados)                            :
echo        :                                                             :
echo        :   parte de BAIXO:  [botão de AÇÃO] ........ [ volume - + ]  :
echo        +-------------------------------------------------------------+
echo.
echo   - POWER: lado esquerdo do visor. Segure 2 s para ligar; toque rápido para dormir/acordar.
echo   - LED ao lado do POWER: branco = ligado; laranja = carregando; verde = carga completa; azul = ligando.
echo   - Porta USB-C: lado esquerdo do visor. É nela que o cabo do PC vai ser ligado.
echo   - Botão de AÇÃO (só no 3S): embaixo, à esquerda; alterna passthrough (ver o quarto pela câmera).
echo   - Volume: embaixo, à direita.
echo.
echo   AÇÃO: localize com o dedo o botão POWER e a porta USB-C. Você vai precisar deles nos passos 3 e 9.
echo.
call :AGUARDAR "Pressione qualquer tecla quando tiver localizado o POWER e a porta USB-C"
call :FIM_PASSO 2
goto %DESTINO%

:PASSO_3
cls
call :CABECALHO 3 "Carregar, ligar e atualizar o Horizon OS"
echo   1. Conecte o carregador na porta USB-C do headset. Deixe carregar até o LED ficar VERDE (ou pelo menos 50%%).
echo      Carregue também os dois controles (pilhas AA) - você vai precisar deles para navegar nos menus.
echo   2. AÇÃO FÍSICA: segure o POWER por 2 s até o LED ficar branco/azul. Coloque o headset na cabeça e
echo      ajuste a faixa. Se pedir padrão/PIN de desbloqueio, desenhe/digite.
echo   3. Dentro do headset: aperte o botão Meta (o "O" do controle direito) para abrir a barra universal.
echo   4. Toque no relógio/bateria (lado esquerdo da barra) → abre as "Configurações rápidas" → clique em
echo      "Configurações" (ícone de engrenagem, canto superior direito).
echo   5. Vá em "Sistema" → "Atualização de software". Se houver atualização, instale e espere reiniciar.
echo      (O Modo Desenvolvedor exige o Horizon OS atual; versões antigas dão erro ao ativar.)
echo   6. Ainda em Configurações → "Sistema" → "Sobre": anote a "Versão" (ex.: v81 / v82...).
echo.
call :AGUARDAR "Pressione qualquer tecla quando o headset estiver atualizado e ligado"
call :FIM_PASSO 3
goto %DESTINO%

:PASSO_4
cls
call :CABECALHO 4 "Conta Meta e app Meta Horizon no celular"
echo   1. No celular, instale/abra o app "Meta Horizon" (Play Store ou App Store; antigo "Meta Quest").
echo   2. Entre com a MESMA conta Meta que está logada no headset. Isso é essencial: o Modo Desenvolvedor
echo      só aparece para a conta que é dona do headset E que for verificada como desenvolvedora.
echo      Para conferir a conta do headset: Configurações → Contas.
echo   3. No app, toque no ícone de headset (barra inferior, "Dispositivos"). O "Meta Quest 3S" deve
echo      aparecer como pareado, com status "Conectado" quando ligado e na mesma rede Wi-Fi.
echo      Se não estiver pareado: "+" / "Parear novo headset" e siga as instruções do app.
echo   4. Anote o e-mail da conta Meta - você vai usá-lo no site de desenvolvedor (passo 5).
echo.
call :AGUARDAR "Pressione qualquer tecla quando o app mostrar o Quest 3S pareado"
call :FIM_PASSO 4
goto %DESTINO%

:PASSO_5
cls
call :CABECALHO 5 "Criar a organização de desenvolvedor (site da Meta)"
echo   A Meta exige que a conta pertença a uma "organização de desenvolvedor". Criar é grátis e leva 2 minutos.
echo.
echo   1. No PC, abra:  https://developers.meta.com/horizon/manage/
echo   2. Clique em "Log in" e entre com a MESMA conta Meta do headset (e-mail anotado no passo 4).
echo   3. Se aparecer a tela de boas-vindas, clique em "Create New Organization" / "Criar organização".
echo   4. Nome da organização: qualquer coisa (ex.: "Daniel Homebrew"). Marque que leu o acordo
echo      (Non-Disclosure Agreement / termos) e confirme.
echo   5. Ao terminar, o painel "Developer Dashboard" abre com o nome da organização no topo.
echo.
echo   Se o site pedir para "verificar" antes de criar: faça o passo 6 e volte.
echo   Se disser que a conta não é elegível: a conta é de menor de idade ou gerenciada por responsável → não é possível.
echo.
choice /c SN /n /m "   [S] Abrir o site agora    [N] Já abri : "
if not errorlevel 2 start "" "https://developers.meta.com/horizon/manage/"
call :AGUARDAR "Pressione qualquer tecla quando a organização estiver criada"
call :FIM_PASSO 5
goto %DESTINO%

:PASSO_6
cls
call :CABECALHO 6 "Verificar a conta de desenvolvedor (SMS ou cartão)"
echo   A Meta só libera o Modo Desenvolvedor para contas verificadas. Escolha UM dos dois:
echo     - Número de celular (código por SMS)  → gratuito, recomendado.
echo     - Cartão de crédito/débito (não cobra nada; só valida).
echo.
echo   1. Abra:  https://developers.meta.com/horizon/manage/verify/
echo   2. Entre com a mesma conta. Escolha "Phone Number" (ou "Payment Method").
echo   3. Digite o número com DDI (+55 e DDD), receba o SMS, digite o código.
echo   4. Se pedir autenticação de dois fatores (2FA), ative com app autenticador ou SMS.
echo   5. Ao final, a página mostra um ✓ "Verified" / "Verificado".
echo.
echo   Se o SMS não chegar: tente outro número, ou use o cartão. Se der "temporarily blocked": espere 24 h.
echo.
choice /c SN /n /m "   [S] Abrir a página de verificação agora    [N] Já abri : "
if not errorlevel 2 start "" "https://developers.meta.com/horizon/manage/verify/"
call :AGUARDAR "Pressione qualquer tecla quando a conta estiver verificada"
call :FIM_PASSO 6
goto %DESTINO%

:PASSO_7
cls
call :CABECALHO 7 "Ativar o Modo Desenvolvedor no app Meta Horizon (celular)"
echo   O Modo Desenvolvedor é ligado pelo CELULAR, não pelo headset.
echo   Pré-requisito: headset LIGADO (acordado) e na mesma rede Wi-Fi do celular.
echo.
echo   1. Abra o app Meta Horizon.
echo   2. Toque no ícone de headset (barra inferior) → toque no card do "Meta Quest 3S".
echo   3. Toque em "Configurações do headset" / "Headset Settings" (logo abaixo da imagem do headset).
echo   4. Toque em "Modo de desenvolvedor" / "Developer Mode".
echo   5. Ligue a chave "Modo de desenvolvedor". O app pode pedir para aceitar termos - aceite.
echo   6. AÇÃO FÍSICA: reinicie o headset para aplicar: segure POWER por 2 s → "Reiniciar". (Ou desligue e ligue.)
echo.
echo   Se a opção "Modo de desenvolvedor" NÃO aparece no app:
echo     a) o app está desatualizado → atualize na loja;
echo     b) a conta do app é diferente da conta do headset → saia e entre com a conta certa;
echo     c) a conta não está verificada / sem organização → refaça os passos 5 e 6, espere 5 min, feche e reabra o app;
echo     d) o headset está desligado ou em outra rede → ligue e conecte na mesma rede Wi-Fi.
echo.
call :AGUARDAR "Pressione qualquer tecla quando a chave estiver LIGADA e o headset reiniciado"
call :FIM_PASSO 7
goto %DESTINO%

:PASSO_8
cls
call :CABECALHO 8 "PC: instalar os drivers ADB da Meta e o SideQuest"
echo   A) DRIVERS ADB (Windows) - necessários para o PC "enxergar" o headset:
echo      1. Baixe: https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/
echo      2. Extraia o .zip (botão direito → "Extrair tudo").
echo      3. Dentro da pasta, botão direito em "android_winusb.inf" → "Instalar". Confirme o aviso do Windows.
echo         (Se não aparecer "Instalar", o Windows está mostrando o arquivo como "Informações de instalação";
echo          use botão direito → "Mostrar mais opções" → "Instalar" no Windows 11.)
echo.
echo   B) SIDEQUEST (programa que gerencia o sideload):
echo      1. Baixe: https://sidequestvr.com/setup-howto  → "Advanced Installer" → Windows.
echo         (Método recomendado: Advanced Installer. O "Easy Installer" é mais limitado.)
echo      2. Instale (Next, Next, Finish). Abra o SideQuest. Pode criar conta ou usar sem login.
echo.
echo   Alternativa oficial da Meta: "Meta Quest Developer Hub" (MQDH) - faz o mesmo com menos recursos:
echo      https://developers.meta.com/horizon/downloads/package/oculus-developer-hub-win/
echo.
echo   AUTOMAÇÃO (opcional):
echo     [1] Instalar o SideQuest agora pelo winget (gerenciador de pacotes do Windows)
echo     [2] Instalar o driver ADB automaticamente (procura o .zip da Meta na pasta Downloads e instala com pnputil)
echo     [3] Abrir os dois links no navegador
echo     [4] Já instalei tudo manualmente
choice /c 1234 /n /m "   Escolha: "
if errorlevel 4 goto PASSO_8_FIM
if errorlevel 3 (start "" "https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/" & start "" "https://sidequestvr.com/setup-howto" & goto PASSO_8_FIM)
if errorlevel 2 (call :DRIVER_AUTO & goto PASSO_8_FIM)
call :SIDEQUEST_WINGET
:PASSO_8_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla quando os drivers e o SideQuest estiverem instalados"
call :FIM_PASSO 8
goto %DESTINO%

:PASSO_9
cls
call :CABECALHO 9 "Conectar o cabo USB-C (ação física)"
echo   1. Abra o SideQuest no PC e deixe aberto.
echo   2. AÇÃO FÍSICA: ligue o headset (POWER 2 s) e deixe-o ACORDADO. Dica: coloque-o na cabeça, ou
echo      tampe o sensor de proximidade (entre as lentes) com um pedaço de fita/papel para ele não dormir.
echo   3. AÇÃO FÍSICA: conecte a ponta USB-C do cabo na porta do LADO ESQUERDO do visor (passo 2).
echo   4. Conecte a outra ponta em uma porta USB do PC:
echo        - prefira uma porta TRASEIRA do gabinete (ligada direto à placa-mãe);
echo        - USB 3.0 (azul) é ideal; USB 2.0 funciona;
echo        - evite hubs USB e extensões.
echo   5. O Windows deve tocar o som de "dispositivo conectado". Se o cabo for "só carga", nada acontece
echo      (o LED do headset acende laranja mas o PC não vê nada) → troque o cabo.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o cabo estiver conectado nas duas pontas e o headset acordado"
call :FIM_PASSO 9
goto %DESTINO%

:PASSO_10
cls
call :CABECALHO 10 "Aceitar 'Permitir depuração USB' dentro do headset"
echo   AÇÃO FÍSICA: coloque o headset na cabeça, com o cabo conectado, e pegue o controle direito.
echo.
echo   1. Assim que o SideQuest tentar falar com o headset, aparece dentro dele uma janela:
echo         "Permitir depuração USB?" / "Allow USB debugging?"
echo         com a impressão digital RSA do computador.
echo   2. Marque a caixa "Sempre permitir deste computador" / "Always allow from this computer".
echo   3. Clique em "Permitir" / "Allow" (ou "OK").
echo   4. Pode aparecer também "Permitir acesso aos dados?" (MTP). Pode clicar em "Negar" - não é necessário.
echo.
echo   Se a janela NÃO aparecer:
echo     - Tire o headset da cabeça, desconecte e reconecte o cabo, coloque de novo. Espere 10 s.
echo     - No headset: Configurações → Sistema → Desenvolvedor → ligue "Caixa de diálogo de conexão USB"
echo       ("USB Connection Dialog") e "Notificação MTP" (passo 11) → reconecte o cabo.
echo     - Se a aba "Desenvolvedor" não existir nas Configurações: o Modo Desenvolvedor não foi ativado
echo       (passo 7) ou o headset não foi reiniciado.
echo     - No SideQuest, clique no ícone de "refresh" ao lado da bolinha de status.
echo.
call :AGUARDAR "Pressione qualquer tecla quando tiver clicado em Permitir com 'Sempre permitir' marcado"
call :FIM_PASSO 10
goto %DESTINO%

:PASSO_11
cls
call :CABECALHO 11 "Ajustes do menu Desenvolvedor no headset"
echo   Ainda com o headset na cabeça:
echo.
echo   1. Botão Meta → Configurações rápidas → "Configurações" (engrenagem) → "Sistema" → "Desenvolvedor".
echo      (Em algumas versões: Configurações → "Avançado" → "Desenvolvedor". Use a lupa e busque "desenvolvedor".)
echo   2. Ligue:
echo        - "Caixa de diálogo de conexão USB"  (USB Connection Dialog)   → mostra o pedido de depuração USB.
echo        - "Notificação MTP"                  (MTP Notification)        → recomendado pela Meta.
echo   3. Deixe DESLIGADO tudo que você não sabe para que serve (ex.: "Recursos de espaço físico",
echo      "Modo de link para desenvolvimento" etc.). Não é necessário para sideload.
echo   4. Opcional: Configurações → Sistema → Energia → "Tempo até dormir" = 15 min (evita o headset
echo      dormir no meio de uma instalação).
echo.
call :AGUARDAR "Pressione qualquer tecla quando as opções estiverem ligadas"
call :FIM_PASSO 11
goto %DESTINO%

:PASSO_12
cls
call :CABECALHO 12 "Verificar a conexão no SideQuest (e pelo ADB)"
echo   No PC, no SideQuest (Advanced Installer):
echo     - No canto SUPERIOR ESQUERDO há uma bolinha de status:
echo         VERDE + nome do headset (ex.: "Quest 3S" com um IP)  = conectado. Tudo certo.
echo         AMARELA / "unauthorized"                              = você não aceitou "Permitir depuração USB" (passo 10).
echo         VERMELHA / "no device"                                = driver, cabo ou headset dormindo (passos 8 e 9).
echo.
echo   Verificação automática pelo ADB (este script procura o adb.exe instalado com o SideQuest):
echo.
call :DIAG_ADB_CORE
echo.
echo   Resultado esperado na lista acima:  ^<número de série^>   device
echo     "unauthorized" → refaça o passo 10.     "offline" → desconecte/reconecte o cabo.
echo     lista vazia    → driver/cabo (passo 8/9) ou o headset está dormindo.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o SideQuest mostrar a bolinha VERDE"
call :FIM_PASSO 12
goto %DESTINO%

:PASSO_13
cls
call :CABECALHO 13 "Instalar o primeiro app (sideload de teste)"
echo   Duas formas (use a A para o teste):
echo.
echo   A) Pelo catálogo do SideQuest (mais fácil):
echo      1. No SideQuest, aba de apps (ícone de casa). Escolha um app GRATUITO qualquer para teste.
echo      2. Clique no app → "Install to headset" / "Sideload". Uma barra de progresso aparece no topo direito.
echo      3. Ao terminar, clique no ícone de "tarefas" (canto superior direito) para ver "Success".
echo.
echo   B) Por um arquivo .apk que você já tem no PC:
echo      1. No SideQuest, ícone da caixa com seta ("Install APK file from folder on computer"), canto superior direito.
echo      2. Escolha o .apk → espere "Success" na lista de tarefas.
echo      Alternativa por linha de comando (se o adb estiver no PATH ou usando o caminho encontrado no passo 12):
echo          adb install -r "C:\caminho\do\app.apk"
echo.
echo   Se der "INSTALL_FAILED_...": veja [E] Erros (falta de espaço, versão de Android, APK corrompido).
echo.
call :AGUARDAR "Pressione qualquer tecla quando a instalação terminar com 'Success'"
call :FIM_PASSO 13
goto %DESTINO%

:PASSO_14
cls
call :CABECALHO 14 "Encontrar os apps instalados: aba 'Fontes desconhecidas'"
echo   AÇÃO FÍSICA: coloque o headset na cabeça.
echo.
echo   1. Botão Meta → na barra universal, clique em "Biblioteca" / "Library" (ícone de grade).
echo   2. No canto superior direito da Biblioteca há um filtro/menu suspenso ("Todos" / "All").
echo   3. Abra-o e escolha "Fontes desconhecidas" / "Unknown Sources".
echo      (Essa opção SÓ aparece depois que o primeiro app é instalado por sideload - passo 13.)
echo   4. O app instalado aparece na lista. Clique para abrir. Pode pedir permissões (armazenamento etc.).
echo.
echo   Dica: a lista "Fontes desconhecidas" não mostra ícones bonitos nem aparece no Home; isso é normal.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o app de teste tiver aberto no headset"
call :FIM_PASSO 14
goto %DESTINO%

:PASSO_15
cls
call :CABECALHO 15 "(Opcional) ADB sem fio pelo Wi-Fi"
echo   Permite usar o SideQuest sem cabo. Só funciona com PC e headset na mesma rede Wi-Fi.
echo.
echo   1. Com o cabo AINDA conectado e a bolinha verde, clique no ícone de Wi-Fi no topo do SideQuest
echo      ("Enable Wireless Mode" / "Modo sem fio").
echo   2. O SideQuest mostra o IP do headset e a bolinha continua verde.
echo   3. AÇÃO FÍSICA: desconecte o cabo do headset. A bolinha deve continuar VERDE (sem fio).
echo   4. Isso é perdido ao reiniciar o headset - basta repetir com o cabo quando precisar.
echo.
echo   AUTOMÁTICO: este guia pode fazer isso agora (cabo conectado): adb tcpip 5555 → descobre o IP → adb connect.
choice /c SN /n /m "   [S] Ativar ADB sem fio agora    [N] Pular : "
if not errorlevel 2 call :ADB_WIFI
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 15
goto %DESTINO%

:PASSO_16
cls
call :CABECALHO 16 "Backup inicial: capturas de tela, vídeos e lista de apps (automático)"
echo   Antes de mexer em mais coisas, guarde no PC o que já existe no headset. Cabo conectado e depuração aceita.
echo   Destino: %USERPROFILE%\Desktop\Quest_Backup\
echo     Screenshots\   ← /sdcard/Oculus/Screenshots
echo     VideoShots\    ← /sdcard/Oculus/VideoShots
echo     apps_instalados.txt  ← lista de pacotes (útil para reinstalar depois)
echo     info_headset.txt     ← modelo, build, número de série
echo.
call :ACHAR_ADB
if not defined ADB goto PASSO_16_FIM
choice /c SN /n /m "   [S] Fazer o backup agora    [N] Pular : "
if errorlevel 2 goto PASSO_16_FIM
set "QB=%USERPROFILE%\Desktop\Quest_Backup"
if not exist "%QB%" mkdir "%QB%"
"%ADB%" pull /sdcard/Oculus/Screenshots "%QB%\Screenshots"
"%ADB%" pull /sdcard/Oculus/VideoShots "%QB%\VideoShots"
"%ADB%" shell pm list packages -3 > "%QB%\apps_instalados.txt"
"%ADB%" shell getprop ro.product.model > "%QB%\info_headset.txt"
"%ADB%" shell getprop ro.build.display.id >> "%QB%\info_headset.txt"
"%ADB%" shell getprop ro.serialno >> "%QB%\info_headset.txt"
echo.
echo   Concluído. Conteúdo de %QB%:
dir /b "%QB%"
:PASSO_16_FIM
echo.
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 16
goto %DESTINO%

:PASSO_17
cls
call :CABECALHO 17 "Ajustes de conforto e desempenho via ADB (reversíveis)"
echo   Estes ajustes usam "setprop" e valem até o headset REINICIAR (reiniciar = tudo volta ao padrão).
echo   O SideQuest faz o mesmo em "Device Settings ^& Tools"; aqui é direto.
echo.
call :AJUSTES_ADB
call :AGUARDAR "Pressione qualquer tecla para continuar"
call :FIM_PASSO 17
goto %DESTINO%

:PASSO_18
cls
call :CABECALHO 18 "Verificação final e boas práticas"
echo   CHECKLIST (todas devem ser SIM):
echo     [ ] App Meta Horizon → headset → Configurações do headset → Modo de desenvolvedor = LIGADO.
echo     [ ] Headset → Configurações → Sistema → aba "Desenvolvedor" existe.
echo     [ ] SideQuest com bolinha VERDE ao conectar o cabo (sem pedir permissão de novo).
echo     [ ] Biblioteca → Fontes desconhecidas mostra o app de teste e ele abre.
echo     [ ] Backup inicial feito (passo 16) em Desktop\Quest_Backup.
echo.
echo   BOAS PRÁTICAS:
echo     - Antes de instalar um APK, confira a fonte (GitHub oficial do projeto ou catálogo SideQuest).
echo     - Para desinstalar: Biblioteca → Fontes desconhecidas → "..." no app → Desinstalar
echo       (ou SideQuest → "Currently installed apps" → lixeira).
echo     - Backup de saves de apps sideloaded: SideQuest → "Currently installed apps" → engrenagem → "Backup app data",
echo       ou pelo Explorador do Windows (headset aparece como dispositivo MTP) na pasta Android\data\^<pacote^>\files.
echo     - Não use "Factory reset" para resolver problemas de sideload; isso apaga tudo. Veja [E] Erros primeiro.
echo     - Ajustes de desempenho (resolução, Hz, CPU/GPU level) ficam em SideQuest → "Device Settings ^& Tools".
echo       Voltam ao padrão ao reiniciar o headset; nada é permanente.
echo.
call :AGUARDAR "Pressione qualquer tecla quando o checklist estiver completo"
call :FIM_PASSO 18
goto %DESTINO%

:CONCLUIDO
cls
echo.
echo  ==========================================================================================
echo   PARABÉNS: Meta Quest 3S com Modo Desenvolvedor ativo e sideload funcionando.
echo  ==========================================================================================
echo.
echo   Próximos passos (opcional):
echo     - Emuladores e homebrew: procure sempre o GitHub oficial de cada projeto.
echo     - Streaming do PC: Virtual Desktop / Steam Link / Meta Quest Link (nenhum precisa de sideload).
echo     - Ambiente/desempenho: SideQuest → Device Settings ^& Tools (resolução, Hz, CPU/GPU level).
echo     - Organização no PC sugerida:  Quest\APKs   Quest\Backups   Quest\Tools
echo.
echo   Para desfazer: opção 6 do menu.
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
echo   Headset  : Meta Quest 3S atualizado, bateria acima de 50%%, conta Meta 18+ (não gerenciada).
echo   Celular  : app Meta Horizon pareado com o headset, mesma conta Meta, mesma rede Wi-Fi.
echo   PC       : Windows 10/11, porta USB (ideal 3.0 traseira), cabo USB-C de DADOS.
echo   Internet : para verificar a conta e baixar programas.
echo.
echo   DOWNLOADS (todos oficiais)
echo   --------------------------
echo   Painel de desenvolvedor ...... https://developers.meta.com/horizon/manage/
echo   Verificação da conta ......... https://developers.meta.com/horizon/manage/verify/
echo   Drivers ADB (Windows) ........ https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/
echo   SideQuest (Advanced) ......... https://sidequestvr.com/setup-howto
echo   Meta Quest Developer Hub ..... https://developers.meta.com/horizon/downloads/package/oculus-developer-hub-win/
echo   Doc oficial (Device Setup) ... https://developers.meta.com/horizon/documentation/native/android/mobile-device-setup/
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:ERROS
cls
echo.
echo   ERROS COMUNS E CORREÇÕES  (causa → correção → teste)
echo   ---------------------------------------------------
echo.
echo   [Conta / app Meta Horizon]
echo   - "Modo de desenvolvedor" não aparece: (1) conta não verificada/sem organização → passos 5-6, espere 5 min;
echo     (2) conta do app diferente da do headset → entre com a conta certa; (3) app antigo → atualize;
echo     (4) headset desligado/outra rede → ligue e conecte. Teste: feche o app, reabra, refaça o passo 7.
echo   - "Sua conta não é elegível": conta de menor de idade ou gerenciada → não há solução oficial.
echo   - Verificação por SMS não chega: outro número; ou use cartão. "Too many attempts": espere 24 h.
echo.
echo   [Conexão USB / ADB]
echo   - Nada acontece ao conectar: cabo "só carga" → troque; porta USB frontal/hub → use porta traseira.
echo   - "Permitir depuração USB" não aparece: headset dormindo → acorde e recoloque; USB Connection Dialog desligado
echo     → passo 11; aba Desenvolvedor não existe → passo 7 e reinicie o headset.
echo   - SideQuest "unauthorized": aceite a janela no headset com "Sempre permitir". Se já aceitou e persiste:
echo     Configurações → Sistema → Desenvolvedor → "Revogar autorizações de depuração USB" (se existir) → reconecte.
echo   - SideQuest "offline" / trocando entre online e offline: cabo ruim ou porta USB fraca → troque; desligue
echo     o "Link" no headset se estiver ativo; feche o app Meta Quest Link no PC (ele disputa o ADB).
echo   - "adb: device not found" / "no devices": driver não instalado → passo 8 (android_winusb.inf);
echo     no Gerenciador de Dispositivos o headset deve aparecer como "Android Composite ADB Interface" ou similar.
echo   - "adb server version doesn't match": dois ADBs (SideQuest + Android Studio/MQDH) → feche os outros programas
echo     e rode: adb kill-server  (no adb do SideQuest).
echo.
echo   [Instalação de APK]
echo   - INSTALL_FAILED_INSUFFICIENT_STORAGE: libere espaço (Configurações → Armazenamento).
echo   - INSTALL_FAILED_UPDATE_INCOMPATIBLE / VERSION_DOWNGRADE: desinstale a versão antiga antes (ou use "adb install -r").
echo   - INSTALL_FAILED_OLDER_SDK / NO_MATCHING_ABIS: o APK não é para Quest (precisa ser Android arm64).
echo   - INSTALL_PARSE_FAILED: download corrompido → baixe de novo.
echo   - App instalado mas não aparece: Biblioteca → filtro → "Fontes desconhecidas" (passo 14).
echo   - App abre e fecha: falta de arquivos de dados (obb/assets) → leia o README do projeto; muitos pedem copiar
echo     arquivos para Android\data\^<pacote^>\files ou Android\obb\^<pacote^>\ via MTP ou SideQuest → "Manage files".
echo.
echo   Suporte: SideQuest Discord (link no site do SideQuest) e fórum da Meta (communityforums.atmeta.com).
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DESFAZER
cls
echo.
echo   COMO DESFAZER
echo   -------------
echo   1. Remover apps sideloaded: Biblioteca → Fontes desconhecidas → "..." no app → Desinstalar.
echo      Ou: SideQuest → "Currently installed apps" → ícone de lixeira.
echo   2. Desativar o Modo Desenvolvedor: app Meta Horizon → headset → Configurações do headset → Modo de
echo      desenvolvedor → DESLIGAR. Reinicie o headset. A aba "Desenvolvedor" some das Configurações.
echo   3. Revogar autorizações de depuração USB (se a opção existir): headset → Configurações → Sistema →
echo      Desenvolvedor → "Revogar autorizações".
echo   4. Sair da organização de desenvolvedor (opcional): https://developers.meta.com/horizon/manage/ →
echo      Members → sua conta → Leave. A verificação da conta é permanente e inofensiva.
echo   5. No PC: desinstalar SideQuest pelo Painel de Controle. Os drivers ADB podem ficar.
echo.
echo   Nada disso apaga dados do headset. Um "Factory reset" NÃO é necessário para desfazer.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:LINKS
cls
echo.
echo   Abrindo links oficiais no navegador padrão...
start "" "https://developers.meta.com/horizon/documentation/native/android/mobile-device-setup/"
start "" "https://developers.meta.com/horizon/manage/"
start "" "https://developers.meta.com/horizon/manage/verify/"
start "" "https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/"
start "" "https://sidequestvr.com/setup-howto"
call :AGUARDAR "Pressione qualquer tecla para voltar ao menu"
goto MENU

:DIAG_ADB
cls
echo.
echo   DIAGNÓSTICO RÁPIDO DA CONEXÃO ADB
echo   ---------------------------------
echo   Conecte o headset pelo cabo, acorde-o e aceite "Permitir depuração USB" se aparecer.
echo.
call :DIAG_ADB_CORE
echo.
echo   Leitura:  "device" = OK   "unauthorized" = aceite no headset   "offline" = reconecte o cabo   vazio = driver/cabo.
echo.
call :AGUARDAR "Pressione qualquer tecla para voltar"
goto %VOLTAR%

:DIAG_ADB_CORE
set "ADB="
for /f "delims=" %%P in ('where adb 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%LOCALAPPDATA%\Programs\SideQuest\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%ProgramFiles%\SideQuest\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB (echo   adb.exe não encontrado. Instale o SideQuest, passo 8, e reabra este guia. & exit /b)
echo   adb encontrado em: %ADB%
echo   Executando: adb devices
echo.
"%ADB%" devices
echo.
echo   Informações do headset (se conectado e autorizado):
for /f "usebackq delims=" %%V in (`call "%ADB%" shell getprop ro.product.model 2^>nul`) do echo     Modelo ............ %%V
for /f "usebackq delims=" %%V in (`call "%ADB%" shell getprop ro.build.display.id 2^>nul`) do echo     Build Horizon OS .. %%V
for /f "usebackq delims=" %%V in (`call "%ADB%" shell getprop ro.build.version.release 2^>nul`) do echo     Base Android ...... %%V
for /f "usebackq delims=" %%V in (`call "%ADB%" shell settings get global development_settings_enabled 2^>nul`) do echo     Opções de desenvolvedor ativas (1 = sim) .. %%V
for /f "usebackq delims=" %%V in (`call "%ADB%" shell settings get global adb_enabled 2^>nul`) do echo     Depuração ADB ativa (1 = sim) ............ %%V
for /f "usebackq delims=" %%V in (`call "%ADB%" shell dumpsys battery 2^>nul ^| findstr /c:"level"`) do echo     Bateria ........... %%V
exit /b

:SIDEQUEST_WINGET
echo.
where winget >nul 2>&1 || goto SQ_SEM_WINGET
echo   Instalando SideQuest via winget (aceita os termos automaticamente)...
winget install -e --id SideQuestVR.SideQuest --accept-source-agreements --accept-package-agreements
if errorlevel 1 (echo   winget falhou. Baixe manualmente: https://sidequestvr.com/setup-howto & start "" "https://sidequestvr.com/setup-howto")
exit /b
:SQ_SEM_WINGET
echo   winget não encontrado - Windows 10 antigo. Instale "Instalador de Aplicativo" pela Microsoft Store ou baixe o SideQuest do site.
start "" "https://sidequestvr.com/setup-howto"
exit /b

:DRIVER_AUTO
echo.
set "DRVZIP="
for /f "delims=" %%Z in ('dir /b /s "%USERPROFILE%\Downloads\*adb*driver*.zip" 2^>nul') do if not defined DRVZIP set "DRVZIP=%%Z"
if not defined DRVZIP for /f "delims=" %%Z in ('dir /b /s "%USERPROFILE%\Downloads\*adb-driver*.zip" 2^>nul') do if not defined DRVZIP set "DRVZIP=%%Z"
if not defined DRVZIP (echo   Não achei o .zip do driver em Downloads. Baixe em https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/ e repita. & start "" "https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/" & exit /b)
echo   Encontrado: %DRVZIP%
set "DRVDIR=%PUBLIC%\adbdrv"
if exist "%DRVDIR%" rd /s /q "%DRVDIR%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%DRVZIP%' -DestinationPath '%DRVDIR%' -Force"
set "INF="
for /f "delims=" %%I in ('dir /b /s "%DRVDIR%\android_winusb.inf" 2^>nul') do if not defined INF set "INF=%%I"
if not defined INF (echo   android_winusb.inf não encontrado dentro do zip. & exit /b)
echo   Instalando o driver (o Windows vai pedir permissão de administrador)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process pnputil -ArgumentList '/add-driver %INF% /install' -Verb RunAs -Wait"
echo   Verificando se o driver ficou registrado:
pnputil /enum-drivers | findstr /i "android_winusb" >nul && echo   OK: driver android_winusb instalado. || echo   Não apareceu na lista; repita com botão direito → Instalar no .inf.
exit /b

:ADB_WIFI
call :ACHAR_ADB
if not defined ADB exit /b
echo   1/3 Colocando o ADB do headset em modo TCP (porta 5555)...
"%ADB%" tcpip 5555
timeout /t 3 >nul
set "QIP="
for /f "usebackq tokens=2" %%A in (`call "%ADB%" shell ip -f inet addr show wlan0 2^>nul ^| findstr /c:"inet "`) do if not defined QIP set "QIP=%%A"
for /f "delims=/" %%A in ("%QIP%") do set "QIP=%%A"
if not defined QIP (echo   Não consegui ler o IP do headset - Wi-Fi desligado? Veja o IP em Configurações → Wi-Fi → sua rede. & exit /b)
echo   2/3 IP do headset: %QIP%
echo   3/3 Conectando sem fio...
"%ADB%" connect %QIP%:5555
echo.
echo   Agora pode desconectar o cabo. No SideQuest a bolinha deve continuar verde (ou clique no ícone de Wi-Fi).
echo   Para reconectar depois de reiniciar o headset: conecte o cabo e repita este passo.
"%ADB%" devices
exit /b

:AJUSTES_ADB
call :ACHAR_ADB
if not defined ADB exit /b
:AJUSTES_MENU
echo.
echo   AJUSTES VIA ADB (setprop; voltam ao padrão ao reiniciar o headset)
echo   [1] Taxa de atualização 120 Hz (ative antes "120 Hz" em Configurações → Sistema → Tela, experimental)
echo   [2] Taxa de atualização 90 Hz (padrão)        [3] 72 Hz (economia de bateria)
echo   [4] Resolução de textura 1,3x (mais nítido; custa bateria)   [5] Textura padrão
echo   [6] CPU e GPU no nível máximo (emuladores/jogos pesados)    [7] CPU/GPU automático (padrão)
echo   [8] Pausar o Guardian (modo sentado; CUIDADO com o ambiente)  [9] Reativar o Guardian
echo   [R] Reverter TUDO agora (sem reiniciar)       [0] Voltar
choice /c 123456789R0 /n /m "   Escolha: "
if errorlevel 11 exit /b
if errorlevel 10 goto AJ_REVERT
if errorlevel 9 ("%ADB%" shell setprop debug.oculus.guardian_pause 0 & goto AJ_OK)
if errorlevel 8 ("%ADB%" shell setprop debug.oculus.guardian_pause 1 & goto AJ_OK)
if errorlevel 7 ("%ADB%" shell "setprop debug.oculus.cpuLevel '' ; setprop debug.oculus.gpuLevel ''" & goto AJ_OK)
if errorlevel 6 ("%ADB%" shell "setprop debug.oculus.cpuLevel 4 ; setprop debug.oculus.gpuLevel 4" & goto AJ_OK)
if errorlevel 5 ("%ADB%" shell "setprop debug.oculus.textureWidth '' ; setprop debug.oculus.textureHeight ''" & goto AJ_OK)
if errorlevel 4 ("%ADB%" shell "setprop debug.oculus.textureWidth 2184 ; setprop debug.oculus.textureHeight 2288" & goto AJ_OK)
if errorlevel 3 ("%ADB%" shell setprop debug.oculus.refreshRate 72 & goto AJ_OK)
if errorlevel 2 ("%ADB%" shell setprop debug.oculus.refreshRate 90 & goto AJ_OK)
"%ADB%" shell setprop debug.oculus.refreshRate 120
:AJ_OK
echo   Aplicado. Valores atuais:
"%ADB%" shell "getprop | grep -E 'debug.oculus.(refreshRate|textureWidth|textureHeight|cpuLevel|gpuLevel|guardian_pause)'"
goto AJUSTES_MENU
:AJ_REVERT
"%ADB%" shell "setprop debug.oculus.refreshRate '' ; setprop debug.oculus.textureWidth '' ; setprop debug.oculus.textureHeight '' ; setprop debug.oculus.cpuLevel '' ; setprop debug.oculus.gpuLevel '' ; setprop debug.oculus.guardian_pause 0"
echo   Tudo revertido para o padrão.
goto AJUSTES_MENU

:ACHAR_ADB
if defined ADB if exist "%ADB%" exit /b
set "ADB="
for /f "delims=" %%P in ('where adb 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%LOCALAPPDATA%\Programs\SideQuest\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%ProgramFiles%\SideQuest\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB for /f "delims=" %%P in ('dir /b /s "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" 2^>nul') do if not defined ADB set "ADB=%%P"
if not defined ADB (echo   adb.exe não encontrado. Instale o SideQuest, passo 8, e reabra este guia. & exit /b)
exit /b

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
exit /b

:CARREGAR
if not exist "%PROG%" exit /b
for /f "usebackq tokens=1,* delims==" %%A in ("%PROG%") do set "%%A=%%B"
exit /b
