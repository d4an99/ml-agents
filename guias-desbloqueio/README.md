# Guias interativos de desbloqueio (.bat)

Quatro scripts de Prompt de Comando do Windows que guiam, passo a passo e com confirmação a cada ação física, o desbloqueio de:

| Arquivo | Console | Método |
|---|---|---|
| `Desbloqueio_New_3DS_XL.bat` | New Nintendo 3DS XL (RED-001) | boot9strap + Luma3DS via super-skaterhax (11.15–11.17, USA/EUR/KOR) ou MSET9 (11.4–11.17, todas as regiões), seguindo o [3ds.hacks.guide](https://3ds.hacks.guide) |
| `Desbloqueio_Meta_Quest_3S.bat` | Meta Quest 3S | Modo Desenvolvedor oficial da Meta + sideload com SideQuest/ADB |
| `Meta_Quest_3S_Emuladores_e_Apps.bat` | Meta Quest 3S (parte 2) | Lightning Launcher, CitraVR (3DS), melonDS (NDS), NetherSX2 (PS2), X1 BOX/xemu (Xbox original), Xbox Cloud Gaming, Eden (Switch), envio de jogos via ADB, como jogar e Stremio |
| `Desbloqueio_PSP.bat` | PSP-1000, 2000, 3000, Go (N1000) e Street (E1000) | CFW [ARK-4](https://github.com/PSP-Archive/ARK-4) v4.20.69 r206 sobre o firmware oficial 6.61: primeiro temporária (ARK Loader), depois permanente (cIPL) |

## Como usar

1. Copie o `.bat` para qualquer pasta do PC (Windows 10/11).
2. Dê duplo clique. Se o SmartScreen avisar: "Mais informações" → "Executar assim mesmo".
3. Escolha `[1]` para começar. Cada passo termina com `[S] Próximo  [R] Repetir  [M] Menu  [E] Erros`.
4. O progresso é salvo em `progresso_*.txt` ao lado do script; `[2]` no menu continua de onde parou.

O script do 3DS também faz, no PC: backup completo do cartão SD (robocopy), verificação de FAT32/espaço, criação de `luma\payloads`, conferência dos arquivos na raiz do cartão e cópia do backup da NAND. O do Quest procura o `adb.exe` do SideQuest e roda `adb devices` para diagnosticar a conexão.
O guia de emuladores tem um menu de ferramentas ADB: criar a estrutura `/sdcard/Emuladores`, instalar APK, enviar (push, com checagem de espaço) e baixar (pull) pastas, listar e desinstalar pacotes, verificar hashes de BIOS/keys, converter ISO para CHD com o chdman e aplicar perfis de desempenho.

Todos os quatro têm a opção **Modo sem acentos** no menu: gera uma cópia `*_sem_acentos.bat` em ASCII puro e a abre, para consoles que exibem os acentos trocados. As quatro cópias já vêm prontas nesta pasta (`*_sem_acentos.bat`); se editar um guia, regenere a sua pela opção do menu.

### Conteúdo extra por guia

- **3DS**: pós-instalação (Universal-Updater, game patching do Luma, Pretendo Network, backup de saves com Checkpoint, migração para cartão maior), roteiro safecerthax para Old 3DS/2DS, teste de velocidade do cartão, link do H2testw e log com horário de cada passo em `log_new3dsxl.txt`.
- **Quest (guia 1)**: checagem de conta de menor, instalação do SideQuest via winget, instalação automática do driver ADB (pnputil), verificação real via `adb shell getprop`, ADB sem fio automático, backup inicial (capturas, vídeos, lista de apps) e ajustes reversíveis via `setprop` (Hz, textura, CPU/GPU, Guardian).
- **Quest (guia 2)**: RetroArch, PPSSPP, Dolphin, streaming completo do PC (Sunshine + Moonlight), backup automático de saves por tarefa agendada, ícones e atalhos (Lightning Launcher + Daijishō).
- **PSP**: identificação do modelo pela etiqueta da traseira, aviso de risco de brick **por modelo** (recuperação por bateria Pandora só no 1000 e no 2000 TA-085 ou anterior), atualização para o firmware oficial 6.61, cópia automática de `ARK_01234`/`ARK_Loader`/`ARK_cIPL` para os caminhos certos, conferência dos arquivos, instalação em duas etapas (temporária antes da permanente), configuração do menu VSH, onde colocar ISO/CSO/homebrew/PS1, backup dos saves e remoção do cIPL com o DC-ARK.

## Requisitos de formato

Os arquivos são **UTF-8 sem BOM** com finais de linha **CRLF** (o `.gitattributes` desta pasta força isso). Se editar, mantenha esse formato: BOM no início quebra a primeira linha do batch, e `chcp 65001` é o que permite os acentos.

## Testes executados

Os quatro scripts foram executados de verdade sob o `cmd.exe` do Wine 9.0 (Linux), não só analisados:

- **Cobertura total de rótulos**: os 484 rótulos dos oito arquivos (quatro guias + quatro cópias ASCII) foram executados um a um por um despachante de teste. Zero erros de sintaxe, zero rótulo inexistente, zero comando não reconhecido.
- **Fluxos completos**: 3DS passos 1-16 e 23-30; Quest guia 1 passos 1-18; Quest guia 2 passos 1-26; PSP passos 1-7 em sequência e os 24 passos individualmente.
- **Ramificações condicionais** (método MSET9 x super-skaterhax, regiões, faixas de versão) forçadas por meio do arquivo de progresso.
- **Comandos externos** verificados pelos argumentos montados: robocopy, curl, format, winget, adb, schtasks, powershell.
- **PowerShell embutido**: os 9 trechos validados com o parser do PowerShell 7.4; os executáveis no Linux rodados de verdade.
- **Modo sem acentos**: conversão aplicada aos quatro arquivos, resultado com 0 bytes não-ASCII em cada cópia, e as cópias geradas também executadas sob o Wine sem erros.
- **Defeito encontrado no guia do PSP e corrigido**: 12 linhas do tipo `if ... echo` traziam parênteses sem escape no texto, o que fazia o `cmd.exe` tentar executar pedaços da frase como comando. Foram escapados como `^(` e `^)` e a varredura voltou limpa.

Limitações do ambiente: o `set /p`, o `choice` e o `if exist` de diretório do Wine divergem do Windows, então essas chamadas foram substituídas ou neutralizadas apenas na cópia de teste. Os arquivos entregues não foram alterados por isso.

## Fontes consultadas (setembro/2026)

- https://3ds.hacks.guide/get-started (seletor de método, `assets/js/selecting.js`)
- https://3ds.hacks.guide/installing-boot9strap-(super-skaterhax)
- https://3ds.hacks.guide/installing-boot9strap-(mset9-cli)
- https://3ds.hacks.guide/finalizing-setup e páginas de troubleshooting
- https://developers.meta.com/horizon/documentation/native/android/mobile-device-setup/
- https://developers.meta.com/horizon/documentation/android-apps/enable-developer-mode/
- https://developers.meta.com/horizon/downloads/package/oculus-adb-drivers/
- https://github.com/amwatson/CitraVR (README, wiki de instalação e troubleshooting)
- https://github.com/rafaelvcaetano/melonDS-android
- https://github.com/Trixarian/NetherSX2-classic
- https://github.com/phobos665/xemu-android e https://www.meta.com/help/quest/3644196869183457/ (Xbox Cloud Gaming)
- https://github.com/eden-emulator/Releases e https://eden-emu.dev/
- https://github.com/threethan/LightningLauncher
- https://www.stremio.com/downloads
- https://github.com/PSP-Archive/ARK-4/wiki (páginas Installation, Installation on PSP, cIPL, Infinity e Full Flash Installation)
- https://github.com/PSP-Archive/ARK-4/releases (v4.20.69 r206, maio/2026; repositório arquivado em agosto/2026)
- https://github.com/PSP-Arkfive/ARK-5 e https://github.com/PSP-Arkfive/FasterARK (sucessor, lançamentos pré-release)
- https://www.pspunk.com/psp-ark4/ e https://www.pspunk.com/psp-cfw/
