@echo off
:: =====================================================================
::  baixar_pokemon_hacks.bat  -  Pokemon ROM Hacks de fas (NDS + 3DS)
::
::  O que faz:
::    1) Baixa as ferramentas de patch (7-Zip console, xdelta3, Flips,
::       Delta Patcher, Luma3DS) direto dos releases oficiais no GitHub.
::    2) Baixa os PATCHES / pacotes dos hacks a partir das fontes dos
::       proprios autores (Google Drive do Drayano, pCloud do Dio Vento).
::    3) Extrai os pacotes e aplica os patches .xdelta/.ups/.ips/.bps
::       nas SUAS ROMs limpas (dump dos seus cartuchos).
::
::  O script NAO baixa ROMs da Nintendo. Coloque seus dumps em:
::    PokemonHacks\ROMs-Base\NDS   e   PokemonHacks\ROMs-Base\3DS
::
::  Uso:  baixar_pokemon_hacks.bat            (menu interativo)
::        baixar_pokemon_hacks.bat --all      (baixa tudo e extrai)
::        baixar_pokemon_hacks.bat --all --lite  (so pacotes "Lite" no 3DS)
::        baixar_pokemon_hacks.bat --tools | --nds | --3ds | --extract | --links
::
::  Requisitos: Windows 10/11 (PowerShell 5.1+ e curl.exe ja inclusos).
:: =====================================================================
setlocal EnableExtensions
set "HERE=%~dp0"
set "HERE=%HERE:~0,-1%"
set "PS=%TEMP%\pokehacks_engine.ps1"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$src=[IO.File]::ReadAllLines('%~f0',[Text.Encoding]::UTF8); $out=New-Object System.Collections.Generic.List[string]; foreach($l in $src){ if($l.StartsWith('::PS:')){ $out.Add($l.Substring(5)) } }; [IO.File]::WriteAllLines('%PS%',$out,(New-Object Text.UTF8Encoding($true)))"
if errorlevel 1 (
  echo [ERRO] Nao foi possivel preparar o motor PowerShell. Verifique se o PowerShell esta instalado.
  pause
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS%" "%HERE%" %*
set "RC=%ERRORLEVEL%"
if "%~1"=="" pause
exit /b %RC%

:: =====================================================================
::  MOTOR POWERSHELL (linhas com prefixo ::PS: sao extraidas e executadas)
:: =====================================================================
::PS:param([string]$BatDir, [Parameter(ValueFromRemainingArguments=$true)][string[]]$Rest)
::PS:
::PS:$ErrorActionPreference = 'Stop'
::PS:$ProgressPreference   = 'SilentlyContinue'
::PS:try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch {}
::PS:
::PS:# ---------------- Pastas ----------------
::PS:$Root = Join-Path $BatDir 'PokemonHacks'
::PS:$D = [ordered]@{
::PS:  Tools    = Join-Path $Root 'Tools'
::PS:  PatchNDS = Join-Path $Root 'Patches\NDS'
::PS:  Patch3DS = Join-Path $Root 'Patches\3DS'
::PS:  RomNDS   = Join-Path $Root 'ROMs-Base\NDS'
::PS:  Rom3DS   = Join-Path $Root 'ROMs-Base\3DS'
::PS:  GameNDS  = Join-Path $Root 'Jogos\NDS'
::PS:  Game3DS  = Join-Path $Root 'Jogos\3DS'
::PS:  Docs     = Join-Path $Root 'Docs'
::PS:  Logs     = Join-Path $Root 'Logs'
::PS:}
::PS:foreach ($p in $D.Values) { New-Item -ItemType Directory -Force -Path $p | Out-Null }
::PS:$LogFile = Join-Path $D.Logs ("log_{0}.txt" -f (Get-Date -Format 'yyyyMMdd'))
::PS:
::PS:function Log([string]$Msg, [string]$Color = 'Gray') {
::PS:  $line = "[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $Msg
::PS:  Write-Host $line -ForegroundColor $Color
::PS:  Add-Content -Path $LogFile -Value $line -Encoding UTF8
::PS:}
::PS:
::PS:$leiame = @(
::PS:  'Coloque aqui as SUAS ROMs limpas (dump do seu cartucho), sem renomear a extensao.',
::PS:  'NDS: arquivo .nds   |   3DS: arquivo .3ds descriptografado ou .cia (ver Docs).',
::PS:  'O script nunca baixa ROMs. Ele so baixa patches feitos por fas.'
::PS:)
::PS:foreach ($p in @($D.RomNDS, $D.Rom3DS)) { $f = Join-Path $p 'LEIA-ME.txt'; if (-not (Test-Path $f)) { Set-Content -Path $f -Value $leiame -Encoding UTF8 } }
::PS:
::PS:# ---------------- Download generico ----------------
::PS:$Curl = Get-Command curl.exe -ErrorAction SilentlyContinue
::PS:
::PS:function Test-LooksLikeHtml([string]$Path) {
::PS:  try {
::PS:    $fs = [IO.File]::OpenRead($Path); $buf = New-Object byte[] 64; $n = $fs.Read($buf, 0, 64); $fs.Close()
::PS:    $head = [Text.Encoding]::ASCII.GetString($buf, 0, $n).TrimStart().ToLower()
::PS:    return ($head.StartsWith('<!doctype html') -or $head.StartsWith('<html'))
::PS:  } catch { return $false }
::PS:}
::PS:
::PS:function Get-File([string]$Url, [string]$Dest, [switch]$Force) {
::PS:  $leaf = Split-Path $Dest -Leaf
::PS:  if ((Test-Path $Dest) -and -not $Force -and ((Get-Item $Dest).Length -gt 0)) { Log "  ja existe: $leaf" DarkGray; return $true }
::PS:  New-Item -ItemType Directory -Force -Path (Split-Path $Dest -Parent) | Out-Null
::PS:  $tmp = "$Dest.part"
::PS:  if (Test-Path $tmp) { Remove-Item $tmp -Force }
::PS:  Log "  baixando: $leaf" Cyan
::PS:  try {
::PS:    if ($Curl) {
::PS:      & $Curl.Source -L --fail --retry 3 --retry-delay 3 -A 'Mozilla/5.0' -o $tmp $Url
::PS:      if ($LASTEXITCODE -ne 0) { throw "curl retornou codigo $LASTEXITCODE" }
::PS:    } else {
::PS:      Invoke-WebRequest -Uri $Url -OutFile $tmp -UserAgent 'Mozilla/5.0' -UseBasicParsing
::PS:    }
::PS:    if (-not (Test-Path $tmp) -or (Get-Item $tmp).Length -eq 0) { throw 'arquivo vazio' }
::PS:    $ext = [IO.Path]::GetExtension($Dest).ToLower()
::PS:    if ($ext -notin @('.html', '.htm', '.txt') -and (Test-LooksLikeHtml $tmp)) { throw 'o servidor devolveu uma pagina HTML em vez do arquivo (link expirado, limite de cota ou exige login)' }
::PS:    Move-Item -Force $tmp $Dest
::PS:    $mb = [math]::Round((Get-Item $Dest).Length / 1MB, 1)
::PS:    Log "  ok: $leaf ($mb MB)" Green
::PS:    return $true
::PS:  } catch {
::PS:    Log "  ERRO em $leaf : $($_.Exception.Message)" Red
::PS:    if (Test-Path $tmp) { Remove-Item $tmp -Force -ErrorAction SilentlyContinue }
::PS:    return $false
::PS:  }
::PS:}
::PS:
::PS:function Expand-Any([string]$Archive, [string]$Dest) {
::PS:  New-Item -ItemType Directory -Force -Path $Dest | Out-Null
::PS:  $ext = [IO.Path]::GetExtension($Archive).ToLower()
::PS:  if ($ext -eq '.zip') { Expand-Archive -LiteralPath $Archive -DestinationPath $Dest -Force; return $true }
::PS:  if ($ext -eq '.7z') {
::PS:    $sz = Join-Path $D.Tools '7zr.exe'
::PS:    if (-not (Test-Path $sz)) { Log '  7zr.exe nao encontrado. Rode a opcao 1 (ferramentas).' Yellow; return $false }
::PS:    & $sz x -y "-o$Dest" $Archive | Out-Null
::PS:    if ($LASTEXITCODE -ne 0) { Log "  ERRO ao extrair $Archive (7zr codigo $LASTEXITCODE)" Red; return $false }
::PS:    return $true
::PS:  }
::PS:  Log "  formato nao suportado: $Archive" Yellow; return $false
::PS:}
::PS:
::PS:# ---------------- GitHub Releases ----------------
::PS:function Get-GitHubAsset([string]$Repo, [string[]]$Patterns, [string]$DestDir) {
::PS:  try {
::PS:    $rels = Invoke-RestMethod -Uri "https://api.github.com/repos/$Repo/releases?per_page=20" -Headers @{ 'User-Agent' = 'PokemonHacksDownloader'; 'Accept' = 'application/vnd.github+json' } -UseBasicParsing
::PS:  } catch { Log "  ERRO na API do GitHub ($Repo): $($_.Exception.Message)" Red; return $null }
::PS:  foreach ($r in @($rels)) {
::PS:    if ($r.draft) { continue }
::PS:    foreach ($pat in $Patterns) {
::PS:      $a = @($r.assets | Where-Object { $_.name -like $pat }) | Select-Object -First 1
::PS:      if ($a) {
::PS:        $dest = Join-Path $DestDir $a.name
::PS:        if (Get-File $a.browser_download_url $dest) { return $dest } else { return $null }
::PS:      }
::PS:    }
::PS:  }
::PS:  $seen = @(); foreach ($r in @($rels) | Select-Object -First 3) { $seen += @($r.assets.name) }
::PS:  Log "  Nenhum asset compativel em $Repo. Assets recentes: $($seen -join ', ')" Yellow
::PS:  return $null
::PS:}
::PS:
::PS:function Install-GitHubTool([string]$Repo, [string[]]$Patterns, [string]$ExeName, [string]$SubDir) {
::PS:  $target = if ($ExeName) { Join-Path $D.Tools $ExeName } else { Join-Path $D.Tools $SubDir }
::PS:  if (Test-Path $target) { Log "  ja instalado: $(Split-Path $target -Leaf)" DarkGray; return }
::PS:  $dl = Join-Path $D.Tools '_downloads'
::PS:  $asset = Get-GitHubAsset $Repo $Patterns $dl
::PS:  if (-not $asset) { return }
::PS:  if ($ExeName) {
::PS:    if ([IO.Path]::GetExtension($asset).ToLower() -eq '.exe') { Copy-Item $asset $target -Force; Log "  ok: $ExeName" Green; return }
::PS:    $tmp = Join-Path $dl ('_x_' + [IO.Path]::GetFileNameWithoutExtension($asset))
::PS:    if (Expand-Any $asset $tmp) {
::PS:      $exe = Get-ChildItem $tmp -Recurse -Filter '*.exe' -File | Sort-Object Length -Descending | Select-Object -First 1
::PS:      if ($exe) { Copy-Item $exe.FullName $target -Force; Log "  ok: $ExeName (de $($exe.Name))" Green } else { Log "  nenhum .exe dentro de $asset" Yellow }
::PS:    }
::PS:    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
::PS:  } else {
::PS:    if (Expand-Any $asset $target) { Log "  ok: $SubDir\" Green }
::PS:  }
::PS:}
::PS:
::PS:function Install-Tools {
::PS:  Log '=== Ferramentas ===' Green
::PS:  Get-File 'https://www.7-zip.org/a/7zr.exe' (Join-Path $D.Tools '7zr.exe') | Out-Null
::PS:  Install-GitHubTool 'jmacd/xdelta-gpl'           @('*x86_64*.exe.zip', '*x86_64*.zip', '*win*64*.zip', '*x86_64*.exe', '*win*') 'xdelta3.exe' $null
::PS:  Install-GitHubTool 'Alcaro/Flips'               @('*windows*.zip', '*win*.zip', '*.zip') 'flips.exe' $null
::PS:  Install-GitHubTool 'marco-calautti/DeltaPatcher' @('*win*x86_64*.zip', '*win*64*.zip', '*win*.zip', '*Windows*.zip') $null 'DeltaPatcher'
::PS:  Install-GitHubTool 'LumaTeam/Luma3DS'           @('Luma3DS*.zip', '*.zip') $null 'Luma3DS'
::PS:  Log "Ferramentas em: $($D.Tools)" Gray
::PS:}
::PS:
::PS:# ---------------- Google Drive (pastas publicas, sem login) ----------------
::PS:function Get-DriveFolder([string]$FolderId, [string]$Dest) {
::PS:  New-Item -ItemType Directory -Force -Path $Dest | Out-Null
::PS:  try {
::PS:    $html = (Invoke-WebRequest -Uri "https://drive.google.com/embeddedfolderview?id=$FolderId" -UserAgent 'Mozilla/5.0' -UseBasicParsing).Content
::PS:  } catch { Log "  ERRO ao listar pasta do Drive $FolderId : $($_.Exception.Message)" Red; return }
::PS:  $rx = [regex]'(?s)<div class="flip-entry" id="entry-([^"]+)".*?<a href="([^"]+)".*?<div class="flip-entry-title">([^<]*)</div>'
::PS:  $ms = $rx.Matches($html)
::PS:  if ($ms.Count -eq 0) { Log "  pasta vazia ou sem acesso anonimo: $FolderId" Yellow; return }
::PS:  foreach ($m in $ms) {
::PS:    $id   = $m.Groups[1].Value
::PS:    $href = $m.Groups[2].Value
::PS:    $name = [System.Net.WebUtility]::HtmlDecode($m.Groups[3].Value)
::PS:    $safe = ($name -replace '[\\/:*?"<>|]', '_').Trim()
::PS:    if ($href -like '*/drive/folders/*') {
::PS:      if ($safe -eq 'Older Versions') { Log "  (pulada pasta 'Older Versions')" DarkGray; continue }
::PS:      Get-DriveFolder $id (Join-Path $Dest $safe)
::PS:    }
::PS:    elseif ($href -like '*docs.google.com*') { Log "  (pulado documento nativo do Google: $name)" DarkGray }
::PS:    else { Get-File "https://drive.usercontent.google.com/download?id=$id&export=download&confirm=t" (Join-Path $Dest $safe) | Out-Null }
::PS:  }
::PS:}
::PS:
::PS:# ---------------- pCloud (links publicos) ----------------
::PS:function Get-PCloud([string]$Code, [string]$DestDir, [string]$Label) {
::PS:  try { $r = Invoke-RestMethod -Uri "https://api.pcloud.com/getpublinkdownload?code=$Code" -UseBasicParsing }
::PS:  catch { Log "  ERRO pCloud ($Label): $($_.Exception.Message)" Red; return $false }
::PS:  if ($r.result -ne 0) { Log "  ERRO pCloud ($Label): result=$($r.result) $($r.error)" Red; return $false }
::PS:  $url  = 'https://' + $r.hosts[0] + $r.path
::PS:  $name = [Uri]::UnescapeDataString($r.path.Split('/')[-1])
::PS:  return (Get-File $url (Join-Path $DestDir $name))
::PS:}
::PS:
::PS:# ---------------- CATALOGO ----------------
::PS:# NDS - Drayano (pastas publicas do Google Drive do autor)
::PS:$HacksNDS = @(
::PS:  @{ Name = 'Renegade Platinum v1.3.0 (Drayano)'; Folder = 'Renegade Platinum'; DriveId = '1gM7nse4qGKJMkcvlQwf5wPVbXwPcC4XV'; Kind = 'Patch';
::PS:     Base = 'Pokemon Platinum (USA) .nds - use o patch 3541 para v1.0 ou 4997 para v1.1' },
::PS:  @{ Name = 'Blaze Black 2 Redux / Volt White 2 Redux v1.4.1 (AphexCubed & Drayano)'; Folder = 'Blaze Black 2 Redux - Volt White 2 Redux'; DriveId = '1xGtMbYtM2JIsTGg9PeRBvr5NBghBUqJ5'; Kind = 'Patch';
::PS:     Base = 'Pokemon Black 2 ou White 2 (USA/EUR) .nds de 524.288 KB' },
::PS:  @{ Name = 'Sacred Gold / Storm Silver - documentacao (Drayano)'; Folder = 'Sacred Gold - Storm Silver'; DriveId = '1oSurQpYjTCMBxC3G6g3vcxsqBjI04ILT'; Kind = 'Docs';
::PS:     Base = 'Pokemon HeartGold / SoulSilver (USA) .nds' }
::PS:)
::PS:
::PS:# 3DS - Dio Vento (pCloud oficial listado nas paginas do autor)
::PS:$Hacks3DS = @(
::PS:  @{ Game = 'Nova Sun & Umbra Moon (Sun/Moon)'; Folder = 'Nova Sun - Umbra Moon'; Base = 'Pokemon Sun/Moon v1.2 (drag & drop Luma3DS) ou v1.0 (para gerar CIA/3DS)'; Files = @(
::PS:      @{ Name = 'Nova_Sun_Expanded';   Code = 'XZfrlY7ZKQ32UNc0Kk4jmFuIMvyvV8i1QpVV'; Lite = $false },
::PS:      @{ Name = 'Nova_Sun_Leveled';    Code = 'XZerlY7ZQPGvyPLhq4hs0LsgkHEcMLpPTxmX'; Lite = $false },
::PS:      @{ Name = 'Nova_Sun_Legit';      Code = 'XZ2rlY7ZtFGCsaITdOmFx9HCyUrwASYDYWVX'; Lite = $false },
::PS:      @{ Name = 'Nova_Sun_Lite';       Code = 'XZTrlY7ZDER1z2fk7wkpVwLgDfgyXp1m0Ghk'; Lite = $true  },
::PS:      @{ Name = 'Umbra_Moon_Expanded'; Code = 'XZPrlY7Zr7RflSoUPShLIgilh1py7Q8Ed0wk'; Lite = $false },
::PS:      @{ Name = 'Umbra_Moon_Leveled';  Code = 'XZwrlY7ZtvhaObMA2OkOhSS9uoOF6yT9Bf0V'; Lite = $false },
::PS:      @{ Name = 'Umbra_Moon_Legit';    Code = 'XZCrlY7ZaOhuyLHyiTpOlLJGE5pDNui4rXxX'; Lite = $false },
::PS:      @{ Name = 'Umbra_Moon_Lite';     Code = 'XZdrlY7ZDWGgSuGrSLu7W10PbSI4lyQ5mNoy'; Lite = $true  }
::PS:  ) },
::PS:  @{ Game = 'Supernova Sun & Penumbra Moon (Ultra Sun/Ultra Moon)'; Folder = 'Supernova Sun - Penumbra Moon'; Base = 'Pokemon Ultra Sun/Ultra Moon atualizado (drag & drop) ou v1.0 (para gerar CIA/3DS)'; Files = @(
::PS:      @{ Name = 'Supernova_Sun_Expanded';  Code = 'XZXalY7ZE4mH4dvJxy80R9WVNFLtuV4JhQe7'; Lite = $false },
::PS:      @{ Name = 'Supernova_Sun_Leveled';   Code = 'XZ5alY7ZNYCnpnDUz3JyYh4bw4MYkmYUWogX'; Lite = $false },
::PS:      @{ Name = 'Supernova_Sun_Legit';     Code = 'XZValY7ZGgJu7QoaL1f7jyHB6wKDDpm6NRB7'; Lite = $false },
::PS:      @{ Name = 'Supernova_Sun_Lite';      Code = 'XZpalY7ZkJqOoat3XYz3WW3WxC5RmpjujseX'; Lite = $true  },
::PS:      @{ Name = 'Penumbra_Moon_Expanded';  Code = 'XZONlY7ZYPiYMIuynv4qIbeJvVJ5AF9l2jeX'; Lite = $false },
::PS:      @{ Name = 'Penumbra_Moon_Leveled';   Code = 'XZrNlY7ZzDXjS5udFdjfQFK4bGmR8LYVIsyV'; Lite = $false },
::PS:      @{ Name = 'Penumbra_Moon_Legit';     Code = 'XZUNlY7Z8HLm5httgBQbB9gklsxw0hHlDY2k'; Lite = $false },
::PS:      @{ Name = 'Penumbra_Moon_Lite';      Code = 'XZcNlY7ZUj5Qwk30MqzGSlzo1dGejztysIcV'; Lite = $true  }
::PS:  ) },
::PS:  @{ Game = 'Rutile Ruby & Star Sapphire (Omega Ruby/Alpha Sapphire)'; Folder = 'Rutile Ruby - Star Sapphire'; Base = 'Pokemon Omega Ruby/Alpha Sapphire v1.4'; Files = @(
::PS:      @{ Name = 'Rutile_Ruby_679';        Code = 'XZ93lY7ZWWODtw7YWupgGyqYBw5NrSC45ogk'; Lite = $true },
::PS:      @{ Name = 'Rutile_Ruby_Leveled';    Code = 'XZC3lY7ZHHlAVrF459bYG5W2TlFppuHpNF6V'; Lite = $true },
::PS:      @{ Name = 'Rutile_Ruby_Legit';      Code = 'XZP3lY7Zu89svslGrJyaV1WGNa7IyfpIhpLy'; Lite = $true },
::PS:      @{ Name = 'Star_Sapphire_679';      Code = 'XZx3lY7ZCBxbdy0DMUJifs590OeEx7mR6pOX'; Lite = $true },
::PS:      @{ Name = 'Star_Sapphire_Leveled';  Code = 'XZd3lY7ZiYF7CxHetC71fGbyu7kEzHRTXfDV'; Lite = $true },
::PS:      @{ Name = 'Star_Sapphire_Legit';    Code = 'XZl3lY7ZF0e08JLvdvLl4fVtQ2KAfpFmGNg7'; Lite = $true }
::PS:  ) }
::PS:)
::PS:$Docs3DS = @( @{ Name = 'RRSS Strategy Guide (PDF)'; Code = 'XZvGlY7ZDhq3WfnH4YbypjrlyYuV2FF95IxX' } )
::PS:
::PS:# Fontes que exigem login no Google ou navegador (o script abre os links)
::PS:$ManualLinks = @(
::PS:  @{ Name = 'Drayano - pasta raiz (Blaze Black/Volt White, Blaze Black 2/Volt White 2, Sacred Gold/Storm Silver, Rising Ruby/Sinking Sapphire) - exige login Google'; Url = 'https://drive.google.com/drive/folders/0B-zmEVN0Mas6Q3lLbDJDaWNyaVU?resourcekey=0-o98YGOlDJ0JVXXjxoHprIA' },
::PS:  @{ Name = 'Sacred Gold / Storm Silver (HGSS) - patches'; Url = 'https://drive.google.com/drive/folders/0B-zmEVN0Mas6VlhJNHc0YWx3UUk?resourcekey=0-2ujVwGdN8ypDAEFr813nCw' },
::PS:  @{ Name = 'Blaze Black / Volt White (BW) - patches'; Url = 'https://drive.google.com/drive/folders/0B-zmEVN0Mas6RmNhOThPaVN1YXc?resourcekey=0-HdnbgmfHVA0gaX2FNkz8MQ' },
::PS:  @{ Name = 'Blaze Black 2 / Volt White 2 (B2W2, original 2012) - patches'; Url = 'https://drive.google.com/drive/folders/0B-zmEVN0Mas6ZGt0ZmVva2pYeTQ?resourcekey=0-TZSnjaOU9AoAYLxAQg-IUw' },
::PS:  @{ Name = 'Rising Ruby / Sinking Sapphire (3DS ORAS, Drayano) - patches'; Url = 'https://drive.google.com/drive/folders/0B-zmEVN0Mas6b3p1cUg3UVNXNWM?resourcekey=0-RYApzpdEIcGIkiTfKxyKqw' },
::PS:  @{ Name = 'Eternal X / Wilting Y (3DS X/Y) - topico oficial no PokeCommunity'; Url = 'https://www.pokecommunity.com/threads/pok%C3%A9mon-eternal-x-wilting-y-version-2-67-released.362505/' },
::PS:  @{ Name = 'Dio Vento - site oficial (3DS)'; Url = 'https://diovento.wordpress.com/' }
::PS:)
::PS:
::PS:# ---------------- Acoes ----------------
::PS:function Download-NDS {
::PS:  Log '=== Patches NDS (Drayano) ===' Green
::PS:  foreach ($h in $HacksNDS) {
::PS:    Log "-> $($h.Name)" White
::PS:    $dest = if ($h.Kind -eq 'Docs') { Join-Path $D.Docs $h.Folder } else { Join-Path $D.PatchNDS $h.Folder }
::PS:    Get-DriveFolder $h.DriveId $dest
::PS:    Set-Content -Path (Join-Path $dest 'ROM-BASE.txt') -Value @("Hack: $($h.Name)", "ROM base necessaria: $($h.Base)", "Fonte: https://drive.google.com/drive/folders/$($h.DriveId)") -Encoding UTF8
::PS:  }
::PS:}
::PS:
::PS:function Download-3DS([switch]$LiteOnly) {
::PS:  Log '=== Pacotes 3DS (Dio Vento) ===' Green
::PS:  if ($LiteOnly) { Log 'modo --lite: baixando apenas os pacotes menores' Yellow }
::PS:  foreach ($h in $Hacks3DS) {
::PS:    Log "-> $($h.Game)" White
::PS:    $dest = Join-Path $D.Patch3DS $h.Folder
::PS:    New-Item -ItemType Directory -Force -Path $dest | Out-Null
::PS:    Set-Content -Path (Join-Path $dest 'ROM-BASE.txt') -Value @("Hack: $($h.Game)", "Jogo base necessario: $($h.Base)", 'Os pacotes .7z ja trazem os arquivos drag & drop para Luma3DS (pasta luma\titles) e o kit para gerar CIA/3DS.') -Encoding UTF8
::PS:    foreach ($f in $h.Files) {
::PS:      if ($LiteOnly -and -not $f.Lite) { continue }
::PS:      Get-PCloud $f.Code $dest $f.Name | Out-Null
::PS:    }
::PS:  }
::PS:  foreach ($d in $Docs3DS) { Get-PCloud $d.Code $D.Docs $d.Name | Out-Null }
::PS:}
::PS:
::PS:function Extract-All {
::PS:  Log '=== Extraindo pacotes ===' Green
::PS:  $arcs = @(Get-ChildItem $D.PatchNDS, $D.Patch3DS -Recurse -Include *.zip, *.7z -File)
::PS:  if ($arcs.Count -eq 0) { Log 'nada para extrair (rode as opcoes 2/3 antes).' Yellow; return }
::PS:  foreach ($a in $arcs) {
::PS:    $dest = Join-Path $a.DirectoryName $a.BaseName
::PS:    if (Test-Path $dest) { Log "  ja extraido: $($a.Name)" DarkGray; continue }
::PS:    Log "  extraindo: $($a.Name)" Cyan
::PS:    if (Expand-Any $a.FullName $dest) { Log "  ok -> $dest" Green }
::PS:  }
::PS:}
::PS:
::PS:function Choose-Item([object[]]$Items, [string]$Prompt, [scriptblock]$Label) {
::PS:  for ($i = 0; $i -lt $Items.Count; $i++) { Write-Host ("  [{0}] {1}" -f ($i + 1), (& $Label $Items[$i])) }
::PS:  $ans = Read-Host $Prompt
::PS:  if ($ans -notmatch '^\d+$' -or [int]$ans -lt 1 -or [int]$ans -gt $Items.Count) { return $null }
::PS:  return $Items[[int]$ans - 1]
::PS:}
::PS:
::PS:function Apply-PatchNDS {
::PS:  Log '=== Aplicar patch em ROM NDS ===' Green
::PS:  $xd = Join-Path $D.Tools 'xdelta3.exe'; $fl = Join-Path $D.Tools 'flips.exe'
::PS:  $patches = @(Get-ChildItem $D.PatchNDS -Recurse -Include *.xdelta, *.ups, *.ips, *.bps -File)
::PS:  $roms    = @(Get-ChildItem $D.RomNDS -Filter *.nds -File)
::PS:  if ($patches.Count -eq 0) { Log 'Nenhum patch encontrado. Rode a opcao 2 e depois a 4 (extrair).' Yellow; return }
::PS:  if ($roms.Count -eq 0)    { Log "Nenhuma ROM .nds em $($D.RomNDS). Coloque o dump do seu cartucho la." Yellow; return }
::PS:  Write-Host ''; Write-Host 'Patches disponiveis:' -ForegroundColor White
::PS:  $p = Choose-Item $patches 'Numero do patch' { param($x) $x.FullName.Substring($D.PatchNDS.Length + 1) }
::PS:  if (-not $p) { Log 'opcao invalida' Yellow; return }
::PS:  Write-Host ''; Write-Host 'ROMs base:' -ForegroundColor White
::PS:  $r = Choose-Item $roms 'Numero da ROM base' { param($x) "{0}  ({1} KB)" -f $x.Name, [math]::Round($x.Length / 1KB) }
::PS:  if (-not $r) { Log 'opcao invalida' Yellow; return }
::PS:  $out = Join-Path $D.GameNDS ($p.BaseName + '.nds')
::PS:  if (Test-Path $out) { Remove-Item $out -Force }
::PS:  switch ($p.Extension.ToLower()) {
::PS:    '.xdelta' {
::PS:      if (-not (Test-Path $xd)) { Log 'xdelta3.exe nao encontrado (opcao 1).' Yellow; return }
::PS:      Log "  xdelta3 -d -s `"$($r.Name)`" `"$($p.Name)`" -> $(Split-Path $out -Leaf)" Cyan
::PS:      & $xd -d -f -s $r.FullName $p.FullName $out
::PS:    }
::PS:    default {
::PS:      if (-not (Test-Path $fl)) { Log 'flips.exe nao encontrado (opcao 1).' Yellow; return }
::PS:      Log "  flips --apply `"$($p.Name)`" `"$($r.Name)`" -> $(Split-Path $out -Leaf)" Cyan
::PS:      & $fl --apply $p.FullName $r.FullName $out
::PS:    }
::PS:  }
::PS:  if ($LASTEXITCODE -eq 0 -and (Test-Path $out) -and ((Get-Item $out).Length -gt 0)) {
::PS:    Log "  OK: $out ($([math]::Round((Get-Item $out).Length / 1MB, 1)) MB)" Green
::PS:  } else {
::PS:    Log "  FALHOU (codigo $LASTEXITCODE). Causas comuns: ROM base errada (regiao/versao), ROM trimada ou ja modificada." Red
::PS:    if (Test-Path $out) { Remove-Item $out -Force -ErrorAction SilentlyContinue }
::PS:  }
::PS:}
::PS:
::PS:function Open-Links {
::PS:  Log '=== Fontes manuais (abrindo no navegador) ===' Green
::PS:  $txt = @()
::PS:  foreach ($l in $ManualLinks) { Log "  $($l.Name)" White; Log "    $($l.Url)" DarkGray; $txt += "$($l.Name)`r`n  $($l.Url)`r`n"; Start-Process $l.Url }
::PS:  Set-Content -Path (Join-Path $D.Docs 'LINKS-MANUAIS.txt') -Value $txt -Encoding UTF8
::PS:  Log 'Baixe os arquivos e coloque em PokemonHacks\Patches\NDS ou \3DS. Depois use a opcao 4 (extrair).' Yellow
::PS:}
::PS:
::PS:function Show-Summary {
::PS:  Write-Host ''
::PS:  Write-Host "Pasta principal: $Root" -ForegroundColor White
::PS:  $nds = @(Get-ChildItem $D.PatchNDS -Recurse -Include *.xdelta, *.ups, *.ips, *.bps -File).Count
::PS:  $p3  = @(Get-ChildItem $D.Patch3DS -Recurse -Filter *.7z -File).Count
::PS:  Write-Host "  patches NDS encontrados: $nds   pacotes 3DS (.7z): $p3" -ForegroundColor Gray
::PS:  Write-Host "  log: $LogFile" -ForegroundColor Gray
::PS:}
::PS:
::PS:# ---------------- Modo por argumentos ----------------
::PS:$argsL = @($Rest | ForEach-Object { $_.ToLower() })
::PS:$lite  = $argsL -contains '--lite'
::PS:if ($argsL.Count -gt 0 -and ($argsL | Where-Object { $_ -ne '--lite' }).Count -gt 0) {
::PS:  if ($argsL -contains '--all' -or $argsL -contains '--tools')   { Install-Tools }
::PS:  if ($argsL -contains '--all' -or $argsL -contains '--nds')     { Download-NDS }
::PS:  if ($argsL -contains '--all' -or $argsL -contains '--3ds')     { Download-3DS -LiteOnly:$lite }
::PS:  if ($argsL -contains '--all' -or $argsL -contains '--extract') { Extract-All }
::PS:  if ($argsL -contains '--links')                                { Open-Links }
::PS:  Show-Summary
::PS:  exit 0
::PS:}
::PS:
::PS:# ---------------- Menu ----------------
::PS:while ($true) {
::PS:  Write-Host ''
::PS:  Write-Host '================ Pokemon ROM Hacks - NDS / 3DS ================' -ForegroundColor Yellow
::PS:  Write-Host "Pasta: $Root" -ForegroundColor DarkGray
::PS:  Write-Host '  1) Instalar ferramentas (7-Zip, xdelta3, Flips, Delta Patcher, Luma3DS)'
::PS:  Write-Host '  2) Baixar patches NDS  (Renegade Platinum, Blaze Black 2 Redux / Volt White 2 Redux)'
::PS:  Write-Host '  3) Baixar pacotes 3DS  (Nova Sun/Umbra Moon, Supernova Sun/Penumbra Moon, Rutile Ruby/Star Sapphire)'
::PS:  Write-Host '  4) Extrair todos os pacotes baixados'
::PS:  Write-Host '  5) BAIXAR TUDO (1 + 2 + 3 + 4)'
::PS:  Write-Host '  6) Baixar tudo no modo LITE (3DS so pacotes menores, ~400 MB em vez de ~2.3 GB)'
::PS:  Write-Host '  7) Aplicar patch em uma ROM NDS (xdelta / ups / ips / bps)'
::PS:  Write-Host '  8) Abrir fontes manuais (Sacred Gold/Storm Silver, Blaze Black/Volt White, Eternal X/Wilting Y...)'
::PS:  Write-Host '  9) Abrir a pasta PokemonHacks'
::PS:  Write-Host '  0) Sair'
::PS:  $op = Read-Host 'Opcao'
::PS:  switch ($op) {
::PS:    '1' { Install-Tools }
::PS:    '2' { Download-NDS }
::PS:    '3' { Download-3DS }
::PS:    '4' { Extract-All }
::PS:    '5' { Install-Tools; Download-NDS; Download-3DS; Extract-All; Show-Summary }
::PS:    '6' { Install-Tools; Download-NDS; Download-3DS -LiteOnly; Extract-All; Show-Summary }
::PS:    '7' { Apply-PatchNDS }
::PS:    '8' { Open-Links }
::PS:    '9' { Start-Process explorer.exe $Root }
::PS:    '0' { exit 0 }
::PS:    default { Write-Host 'opcao invalida' -ForegroundColor Yellow }
::PS:  }
::PS:}
