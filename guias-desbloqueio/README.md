# Guias interativos de desbloqueio (.bat)

Dois scripts de Prompt de Comando do Windows que guiam, passo a passo e com confirmação a cada ação física, o desbloqueio de:

| Arquivo | Console | Método |
|---|---|---|
| `Desbloqueio_New_3DS_XL.bat` | New Nintendo 3DS XL (RED-001) | boot9strap + Luma3DS via super-skaterhax (11.15–11.17, USA/EUR/KOR) ou MSET9 (11.4–11.17, todas as regiões), seguindo o [3ds.hacks.guide](https://3ds.hacks.guide) |
| `Desbloqueio_Meta_Quest_3S.bat` | Meta Quest 3S | Modo Desenvolvedor oficial da Meta + sideload com SideQuest/ADB |
| `Meta_Quest_3S_Emuladores_e_Apps.bat` | Meta Quest 3S (parte 2) | Lightning Launcher, CitraVR (3DS), melonDS (NDS), NetherSX2 (PS2), X1 BOX/xemu (Xbox original), Xbox Cloud Gaming, Eden (Switch), envio de jogos via ADB, como jogar e Stremio |

## Como usar

1. Copie o `.bat` para qualquer pasta do PC (Windows 10/11).
2. Dê duplo clique. Se o SmartScreen avisar: "Mais informações" → "Executar assim mesmo".
3. Escolha `[1]` para começar. Cada passo termina com `[S] Próximo  [R] Repetir  [M] Menu  [E] Erros`.
4. O progresso é salvo em `progresso_*.txt` ao lado do script; `[2]` no menu continua de onde parou.

O script do 3DS também faz, no PC: backup completo do cartão SD (robocopy), verificação de FAT32/espaço, criação de `luma\payloads`, conferência dos arquivos na raiz do cartão e cópia do backup da NAND. O do Quest procura o `adb.exe` do SideQuest e roda `adb devices` para diagnosticar a conexão.
O guia de emuladores tem um menu de ferramentas ADB: criar a estrutura `/sdcard/Emuladores`, instalar APK, enviar (push) e baixar (pull) pastas, listar e desinstalar pacotes.

## Requisitos de formato

Os arquivos são **UTF-8 sem BOM** com finais de linha **CRLF** (o `.gitattributes` desta pasta força isso). Se editar, mantenha esse formato: BOM no início quebra a primeira linha do batch, e `chcp 65001` é o que permite os acentos.

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
