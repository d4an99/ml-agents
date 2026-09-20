# Pokemon ROM Hacks (NDS + 3DS) - downloader de patches feitos por fas

`baixar_pokemon_hacks.bat` e um script unico para Windows 10/11 que:

1. baixa as **ferramentas de patch** direto dos releases oficiais no GitHub
   (7-Zip console, xdelta3, Flips, Delta Patcher, Luma3DS);
2. baixa os **patches / pacotes** dos hacks a partir das fontes dos proprios autores
   (Google Drive do Drayano, pCloud do Dio Vento);
3. extrai os pacotes e **aplica o patch na sua ROM limpa** (`.xdelta`, `.ups`, `.ips`, `.bps`).

O script **nao baixa ROMs da Nintendo**. Voce precisa do dump do seu proprio cartucho.

## Uso

```bat
baixar_pokemon_hacks.bat              :: menu interativo
baixar_pokemon_hacks.bat --all        :: ferramentas + NDS + 3DS + extrair (~2,4 GB)
baixar_pokemon_hacks.bat --all --lite :: 3DS so pacotes menores (~450 MB)
baixar_pokemon_hacks.bat --tools | --nds | --3ds | --extract | --links
```

Requisitos: Windows 10/11 (PowerShell 5.1 e `curl.exe` ja vem instalados). Nao precisa de Python.

## Estrutura criada

```
PokemonHacks\
  Tools\            7zr.exe, xdelta3.exe, flips.exe, DeltaPatcher\, Luma3DS\
  Patches\NDS\      Renegade Platinum\, Blaze Black 2 Redux - Volt White 2 Redux\
  Patches\3DS\      Nova Sun - Umbra Moon\, Supernova Sun - Penumbra Moon\, Rutile Ruby - Star Sapphire\
  ROMs-Base\NDS\    <-- coloque aqui seus .nds limpos
  ROMs-Base\3DS\    <-- coloque aqui seus .3ds/.cia descriptografados
  Jogos\NDS\        saida das ROMs com patch aplicado
  Jogos\3DS\        (reservado para os CIA/3DS que voce gerar)
  Docs\             documentacao dos hacks, guia RRSS (PDF), LINKS-MANUAIS.txt
  Logs\             log_AAAAMMDD.txt
```

Cada pasta de hack recebe um `ROM-BASE.txt` dizendo qual jogo/versao base e necessario.

## Fontes (verificadas em 2026-09)

| Console | Hack | Autor | Fonte usada pelo script |
|---|---|---|---|
| NDS | Renegade Platinum v1.3.0 | Drayano | Google Drive publico do autor (pasta `1gM7nse4qGKJMkcvlQwf5wPVbXwPcC4XV`) |
| NDS | Blaze Black 2 Redux / Volt White 2 Redux v1.4.1 | AphexCubed & Drayano | Google Drive publico do autor (pasta `1xGtMbYtM2JIsTGg9PeRBvr5NBghBUqJ5`) |
| NDS | Sacred Gold / Storm Silver (documentacao) | Drayano | Google Drive publico (`1oSurQpYjTCMBxC3G6g3vcxsqBjI04ILT`) |
| 3DS | Nova Sun / Umbra Moon (8 pacotes) | Dio Vento | pCloud listado em diovento.wordpress.com/nsum |
| 3DS | Supernova Sun / Penumbra Moon (8 pacotes) | Dio Vento | pCloud listado em diovento.wordpress.com/snspum |
| 3DS | Rutile Ruby / Star Sapphire (6 pacotes + guia PDF) | Dio Vento | pCloud listado em diovento.wordpress.com/rrss |

Fontes que **exigem login no Google ou navegador** (opcao 8 abre os links e salva em `Docs\LINKS-MANUAIS.txt`):

* Drayano: Blaze Black / Volt White, Blaze Black 2 / Volt White 2 (2012), Sacred Gold / Storm Silver, Rising Ruby / Sinking Sapphire (3DS). As pastas antigas do Drive do autor devolvem 401 sem login.
* Eternal X / Wilting Y (3DS X/Y): topico oficial no PokeCommunity.

Baixe manualmente e solte os arquivos em `Patches\NDS` ou `Patches\3DS`; a opcao 4 extrai e a 7 aplica.

## Como aplicar (NDS)

1. Opcao 1 (ferramentas), opcao 2 (patches), opcao 4 (extrair).
2. Copie o dump limpo do seu cartucho para `ROMs-Base\NDS\`.
3. Opcao 7, escolha o patch e a ROM. Saida em `Jogos\NDS\<nome do patch>.nds`.

Comando equivalente que o script executa:

```bat
Tools\xdelta3.exe -d -f -s "ROMs-Base\NDS\base.nds" "Patches\NDS\...\hack.xdelta" "Jogos\NDS\hack.nds"
Tools\flips.exe --apply "hack.ups" "base.nds" "Jogos\NDS\hack.nds"
```

Renegade Platinum: use `RenegadePlatinum3541.xdelta` para Platinum v1.0 e `RenegadePlatinum4997.xdelta` para v1.1; os patches em "Additional Patches" sao aplicados **por cima** do resultado.

## Como usar (3DS)

Os pacotes `.7z` do Dio Vento ja vem prontos para **drag & drop com Luma3DS** (pasta `luma\titles\<TitleID>` para copiar no SD) e trazem o kit para gerar CIA/3DS a partir do seu dump. Siga o `README` dentro de cada pacote e o `ROM-BASE.txt` (versao do jogo exigida).

## Erros comuns

| Sintoma | Causa | Correcao |
|---|---|---|
| `curl retornou codigo 22/56` | link fora do ar, cota do Drive ou bloqueio de rede | rode de novo mais tarde; o script pula o que ja baixou |
| `o servidor devolveu uma pagina HTML` | Drive pediu confirmacao/login ou pCloud expirou | baixe o item pelo navegador (opcao 8) e solte na pasta |
| `Nenhum asset compativel em ...` | o autor da ferramenta renomeou o release | baixe o .zip/.exe manualmente para `Tools\` |
| `xdelta3: target window checksum mismatch` | ROM base errada (regiao, versao, trimada ou ja modificada) | use um dump limpo e a versao indicada no `ROM-BASE.txt` |
| `Expand-Archive` falha | ZIP corrompido (download interrompido) | apague o arquivo e rode a opcao 2/3 de novo |

## Desfazer

Apague a pasta `PokemonHacks\`. O script nao altera nada fora dela e nao mexe no registro.
