#Requires -Version 5.1
<#
.SYNOPSIS
    Guias interativos de desbloqueio: New 3DS XL, Meta Quest 3S (duas partes) e PSP.

.DESCRIPTION
    Porte em PowerShell dos quatro guias .bat da pasta guias-desbloqueio.
    Conduz passo a passo, pede confirmacao em cada acao fisica, salva o progresso
    e faz a parte automatizavel no PC: achar o cartao/unidade, backup com robocopy,
    conferir FAT32 e espaco, criar a estrutura de pastas, copiar arquivos nos
    caminhos certos, conferir se chegaram, achar o adb.exe, conferir hashes de
    BIOS/keys e copiar saves.

    Funciona no Windows PowerShell 5.1 (que ja vem no Windows 10/11) e no
    PowerShell 7. Nao precisa instalar nada.

.PARAMETER Guia
    Abre direto um guia: 3ds, quest, quest-emu ou psp.

.PARAMETER Passo
    Comeca em um passo especifico (use junto com -Guia).

.PARAMETER Listar
    Lista os guias e os passos de cada um e sai. Nao interage.

.PARAMETER SelfTest
    Roda a autoverificacao do script (nao toca em console nem em cartao) e sai.

.PARAMETER SemCor
    Desliga as cores, para terminais que nao as suportam.

.EXAMPLE
    .\Guias-Desbloqueio.ps1
    Abre o menu principal.

.EXAMPLE
    .\Guias-Desbloqueio.ps1 -Guia psp -Passo 16
    Vai direto ao passo 16 do guia do PSP.

.EXAMPLE
    .\Guias-Desbloqueio.ps1 -SelfTest
    Confere se o script esta sadio antes de usar.

.NOTES
    Fontes: 3ds.hacks.guide, developers.meta.com e a wiki do ARK-4
    (github.com/PSP-Archive/ARK-4), consultadas em set/2026.
    Nao baixa jogos, BIOS nem chaves. Use os seus proprios.
#>

[CmdletBinding()]
param(
    [ValidateSet('3ds', 'quest', 'quest-emu', 'psp')]
    [string] $Guia,

    [ValidateRange(0, 30)]
    [int] $Passo = 0,

    [switch] $Listar,
    [switch] $SelfTest,
    [switch] $SemCor
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Estado global
# ---------------------------------------------------------------------------

$script:Base = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$script:GuiaAtual = $null
$script:Unidade = $null
$script:Modelo = $null
$script:Adb = $null
$script:Cores = -not $SemCor

# ---------------------------------------------------------------------------
# Saida na tela
# ---------------------------------------------------------------------------

function Write-Cor {
    param(
        [Parameter(Mandatory)] [AllowEmptyString()] [string] $Texto,
        [string] $Cor = 'Gray'
    )
    if ($script:Cores) { Write-Host $Texto -ForegroundColor $Cor }
    else { Write-Host $Texto }
}

function Write-Titulo {
    param([Parameter(Mandatory)] [string] $Texto)
    $linha = '=' * 90
    Write-Host ''
    Write-Cor " $linha" 'DarkCyan'
    Write-Cor "  $Texto" 'White'
    Write-Cor " $linha" 'DarkCyan'
    Write-Host ''
}

function Write-Aviso {
    param([Parameter(Mandatory)] [string] $Texto)
    Write-Cor "  ATENCAO: $Texto" 'Yellow'
}

function Write-Erro {
    param([Parameter(Mandatory)] [string] $Texto)
    Write-Cor "  ERRO: $Texto" 'Red'
}

function Write-Ok {
    param([Parameter(Mandatory)] [string] $Texto)
    Write-Cor "  OK: $Texto" 'Green'
}

function Wait-Tecla {
    param([string] $Texto = 'Pressione ENTER para continuar')
    Write-Host ''
    Write-Cor "  >> $Texto" 'DarkGray'
    [void](Read-Host)
}

function Read-SimNao {
    param(
        [Parameter(Mandatory)] [string] $Pergunta,
        [bool] $PadraoSim = $true
    )
    $dica = if ($PadraoSim) { '[S/n]' } else { '[s/N]' }
    while ($true) {
        $r = (Read-Host "  $Pergunta $dica").Trim().ToLower()
        if ($r -eq '') { return $PadraoSim }
        if ($r -in @('s', 'si', 'sim', 'y', 'yes')) { return $true }
        if ($r -in @('n', 'nao', 'no')) { return $false }
        Write-Cor '  Responda S ou N.' 'DarkGray'
    }
}

# ---------------------------------------------------------------------------
# Progresso e registro
# ---------------------------------------------------------------------------

function Get-CaminhoProgresso {
    param([Parameter(Mandatory)] [string] $Chave)
    return (Join-Path $script:Base ("progresso-$Chave.json"))
}

function Get-CaminhoRegistro {
    param([Parameter(Mandatory)] [string] $Chave)
    return (Join-Path $script:Base ("log-$Chave.txt"))
}

function Write-Registro {
    param(
        [Parameter(Mandatory)] [string] $Chave,
        [Parameter(Mandatory)] [string] $Texto
    )
    try {
        $linha = ('[{0}] {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Texto)
        Add-Content -LiteralPath (Get-CaminhoRegistro -Chave $Chave) -Value $linha -Encoding UTF8
    }
    catch {
        Write-Cor "  (nao consegui escrever no registro: $($_.Exception.Message))" 'DarkGray'
    }
}

function Save-Progresso {
    param(
        [Parameter(Mandatory)] [string] $Chave,
        [Parameter(Mandatory)] [int] $Numero
    )
    $dados = [ordered]@{
        passo    = $Numero
        unidade  = $script:Unidade
        modelo   = $script:Modelo
        salvoEm  = (Get-Date -Format 's')
    }
    try {
        $json = $dados | ConvertTo-Json
        Set-Content -LiteralPath (Get-CaminhoProgresso -Chave $Chave) -Value $json -Encoding UTF8
    }
    catch {
        Write-Cor "  (nao consegui salvar o progresso: $($_.Exception.Message))" 'DarkGray'
    }
}

function Get-Progresso {
    param([Parameter(Mandatory)] [string] $Chave)
    $arq = Get-CaminhoProgresso -Chave $Chave
    if (-not (Test-Path -LiteralPath $arq)) { return 0 }
    try {
        $d = Get-Content -LiteralPath $arq -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($d.PSObject.Properties.Name -contains 'unidade' -and $d.unidade) { $script:Unidade = [string]$d.unidade }
        if ($d.PSObject.Properties.Name -contains 'modelo' -and $d.modelo) { $script:Modelo = [string]$d.modelo }
        if ($d.PSObject.Properties.Name -contains 'passo') { return [int]$d.passo }
        return 0
    }
    catch { return 0 }
}

function Clear-Progresso {
    param([Parameter(Mandatory)] [string] $Chave)
    $arq = Get-CaminhoProgresso -Chave $Chave
    if (Test-Path -LiteralPath $arq) { Remove-Item -LiteralPath $arq -Force }
    Write-Ok 'Progresso apagado.'
}

# ---------------------------------------------------------------------------
# Ferramentas de PC: unidades, backup, sistema de arquivos, pastas
# ---------------------------------------------------------------------------

function Get-UnidadesCandidatas {
    # Volumes removiveis com letra, do mais provavel ao menos provavel.
    $saida = New-Object System.Collections.ArrayList
    try {
        $vols = Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter }
        foreach ($v in $vols) {
            if ($v.DriveLetter -eq 'C') { continue }
            $tipo = ''
            try { $tipo = [string]$v.DriveType } catch { $tipo = '' }
            $totalGb = 0
            $livreGb = 0
            if ($v.Size) { $totalGb = [math]::Round($v.Size / 1GB, 2) }
            if ($v.SizeRemaining) { $livreGb = [math]::Round($v.SizeRemaining / 1GB, 2) }
            [void]$saida.Add([pscustomobject]@{
                Letra     = [string]$v.DriveLetter
                Rotulo    = [string]$v.FileSystemLabel
                Sistema   = [string]$v.FileSystemType
                TotalGB   = $totalGb
                LivreGB   = $livreGb
                Tipo      = $tipo
                Removivel = ($tipo -eq 'Removable')
            })
        }
    }
    catch {
        # Fallback para sistemas sem Get-Volume
        foreach ($d in (Get-PSDrive -PSProvider FileSystem)) {
            if ($d.Name -eq 'C') { continue }
            $livreGb = 0
            if ($d.Free) { $livreGb = [math]::Round($d.Free / 1GB, 2) }
            [void]$saida.Add([pscustomobject]@{
                Letra     = $d.Name
                Rotulo    = ''
                Sistema   = ''
                TotalGB   = 0
                LivreGB   = $livreGb
                Tipo      = ''
                Removivel = $true
            })
        }
    }
    return @($saida | Sort-Object -Property @{Expression = 'Removivel'; Descending = $true}, 'Letra')
}

function Get-UnidadeAlvo {
    <#
      Acha a unidade do console. $Marcadores sao pastas que indicam o console
      (ex.: 'Nintendo 3DS' para o 3DS, 'PSP' para o PSP).
    #>
    param(
        [string[]] $Marcadores = @(),
        [string]   $Descricao = 'o cartao do console',
        [switch]   $Forcar
    )

    if ($script:Unidade -and -not $Forcar) {
        if (Test-Path -LiteralPath ("{0}:\" -f $script:Unidade)) {
            Write-Ok ("usando a unidade {0}: (ja escolhida)" -f $script:Unidade)
            return $script:Unidade
        }
        $script:Unidade = $null
    }

    $cand = Get-UnidadesCandidatas

    # 1) tenta achar pelos marcadores
    foreach ($m in $Marcadores) {
        foreach ($c in $cand) {
            $alvo = Join-Path ("{0}:\" -f $c.Letra) $m
            if (Test-Path -LiteralPath $alvo) {
                Write-Ok ("achei '{0}' em {1}: - deve ser {2}" -f $m, $c.Letra, $Descricao)
                $script:Unidade = $c.Letra
                return $c.Letra
            }
        }
    }

    # 2) mostra a lista e pergunta
    Write-Host ''
    Write-Cor "  Nao identifiquei automaticamente. Unidades disponiveis:" 'Yellow'
    Write-Host ''
    if ($cand.Count -eq 0) {
        Write-Erro 'Nenhuma unidade removivel encontrada. Conecte o cartao/console e tente de novo.'
        return $null
    }
    $i = 1
    foreach ($c in $cand) {
        $marca = if ($c.Removivel) { '*' } else { ' ' }
        Write-Host ("   [{0}] {1}{2}:  {3,-14} {4,-6} {5,7} GB total  {6,7} GB livre" -f `
            $i, $marca, $c.Letra, $c.Rotulo, $c.Sistema, $c.TotalGB, $c.LivreGB)
        $i++
    }
    Write-Host ''
    Write-Cor '  (* = removivel, o mais provavel)' 'DarkGray'
    Write-Host ''
    $r = (Read-Host "  Numero da unidade, ou a letra dela, ou ENTER para cancelar").Trim()
    if ($r -eq '') { return $null }

    $escolhida = $null
    if ($r -match '^\d+$') {
        $idx = [int]$r - 1
        if ($idx -ge 0 -and $idx -lt $cand.Count) { $escolhida = $cand[$idx].Letra }
    }
    else {
        $escolhida = $r.Substring(0, 1).ToUpper()
    }

    if (-not $escolhida) { Write-Erro 'Escolha invalida.'; return $null }
    if ($escolhida -eq 'C') { Write-Erro 'C: e o disco do Windows, nao o console.'; return $null }
    if (-not (Test-Path -LiteralPath ("{0}:\" -f $escolhida))) {
        Write-Erro ("a unidade {0}: nao existe." -f $escolhida)
        return $null
    }

    $script:Unidade = $escolhida
    Write-Ok ("unidade escolhida: {0}:" -f $escolhida)
    return $escolhida
}

function Test-SistemaArquivos {
    <# Confere FAT32 e espaco livre. Retorna um objeto com o diagnostico. #>
    param(
        [Parameter(Mandatory)] [string] $Letra,
        [double] $MinimoLivreGB = 0.1
    )
    $info = [pscustomobject]@{
        Letra      = $Letra
        Sistema    = '?'
        TotalGB    = 0
        LivreGB    = 0
        Fat32      = $false
        EspacoOk   = $false
        Mensagens  = @()
    }
    try {
        $v = Get-Volume -DriveLetter $Letra -ErrorAction Stop
        $info.Sistema = [string]$v.FileSystemType
        $info.TotalGB = [math]::Round($v.Size / 1GB, 2)
        $info.LivreGB = [math]::Round($v.SizeRemaining / 1GB, 2)
    }
    catch {
        try {
            $d = Get-PSDrive -Name $Letra -ErrorAction Stop
            $info.LivreGB = [math]::Round($d.Free / 1GB, 2)
            $info.TotalGB = [math]::Round(($d.Used + $d.Free) / 1GB, 2)
            $info.Mensagens += 'Get-Volume indisponivel: nao consegui ler o sistema de arquivos.'
        }
        catch {
            $info.Mensagens += ("nao consegui ler a unidade {0}: - {1}" -f $Letra, $_.Exception.Message)
            return $info
        }
    }

    $info.Fat32 = ($info.Sistema -eq 'FAT32')
    $info.EspacoOk = ($info.LivreGB -ge $MinimoLivreGB)

    Write-Host ''
    Write-Host ("    Sistema de arquivos : {0}" -f $info.Sistema)
    Write-Host ("    Tamanho total       : {0} GB" -f $info.TotalGB)
    Write-Host ("    Espaco livre        : {0} GB" -f $info.LivreGB)
    Write-Host ''

    if ($info.Fat32) { Write-Ok 'esta em FAT32.' }
    elseif ($info.Sistema -eq '?') { Write-Aviso 'nao foi possivel confirmar o sistema de arquivos.' }
    else {
        Write-Aviso ("esta em {0}. O console precisa de FAT32." -f $info.Sistema)
        Write-Host '    - Formatar APAGA tudo. Faca o backup primeiro (ha um passo para isso).'
        Write-Host '    - Ate 32 GB, num Prompt como administrador:  format X: /FS:FAT32 /Q'
        Write-Host '    - Acima de 32 GB o Windows nao oferece FAT32 na janela; use o comando acima'
        Write-Host '      ou formate pelo proprio console (o 3DS e o PSP formatam do jeito certo).'
    }
    if (-not $info.EspacoOk) {
        Write-Aviso ("espaco livre abaixo do minimo sugerido ({0} GB)." -f $MinimoLivreGB)
    }
    return $info
}

function Backup-Unidade {
    <# Copia a unidade inteira para a Area de Trabalho com robocopy. Nao altera a origem. #>
    param(
        [Parameter(Mandatory)] [string] $Letra,
        [Parameter(Mandatory)] [string] $Prefixo,
        [string] $Chave = 'geral'
    )
    $data = Get-Date -Format 'yyyy-MM-dd_HHmm'
    $destino = Join-Path ([Environment]::GetFolderPath('Desktop')) ("{0}_{1}" -f $Prefixo, $data)

    Write-Host ''
    Write-Host ("  Origem : {0}:\" -f $Letra)
    Write-Host ("  Destino: {0}" -f $destino)
    Write-Cor '  robocopy somente LE a origem; nada e apagado nem alterado nela.' 'DarkGray'
    Write-Host ''
    if (-not (Read-SimNao 'Iniciar a copia agora?')) {
        Write-Cor '  Pulado. Voce pode copiar a mao: selecione tudo no cartao e cole numa pasta nova.' 'DarkGray'
        return $null
    }

    $null = New-Item -ItemType Directory -Path $destino -Force
    $origem = "{0}:\" -f $Letra
    & robocopy $origem $destino /E /R:2 /W:2 /NP /NFL /NDL /XJ | Out-Host
    $rc = $LASTEXITCODE

    # robocopy: 0-7 = sucesso (com ou sem copias), 8+ = falha real
    if ($rc -ge 8) {
        Write-Erro ("robocopy falhou (codigo {0})." -f $rc)
        Write-Host '    1. Cabo ou porta USB instavel -> troque o cabo e a porta, evite hub.'
        Write-Host ("    2. Cartao com setores ruins   -> chkdsk {0}: /f  num Prompt como administrador." -f $Letra)
        Write-Host '    3. Destino sem espaco          -> libere espaco no disco do PC.'
        return $null
    }
    Write-Ok ("backup concluido em: {0}" -f $destino)
    Write-Registro -Chave $Chave -Texto ("Backup de {0}: para {1} (robocopy rc={2})" -f $Letra, $destino, $rc)
    return $destino
}

function New-EstruturaPastas {
    <# Cria as pastas que o console espera. Retorna o numero de pastas criadas. #>
    param(
        [Parameter(Mandatory)] [string]   $Letra,
        [Parameter(Mandatory)] [string[]] $Pastas,
        [string] $Chave = 'geral'
    )
    $criadas = 0
    foreach ($p in $Pastas) {
        $alvo = Join-Path ("{0}:\" -f $Letra) $p
        if (Test-Path -LiteralPath $alvo) {
            Write-Host ("    existe  {0}" -f $p)
        }
        else {
            try {
                $null = New-Item -ItemType Directory -Path $alvo -Force
                Write-Cor ("    criada  {0}" -f $p) 'Green'
                $criadas++
            }
            catch {
                Write-Erro ("nao criei {0} - {1}" -f $p, $_.Exception.Message)
            }
        }
    }
    Write-Registro -Chave $Chave -Texto ("Estrutura de pastas em {0}: ({1} criadas)" -f $Letra, $criadas)
    return $criadas
}

function Test-ArquivosEsperados {
    <# Confere se cada caminho relativo existe na unidade. Retorna $true se tudo existe. #>
    param(
        [Parameter(Mandatory)] [string] $Letra,
        [Parameter(Mandatory)] [hashtable] $Esperado,   # caminho relativo -> 'obrigatorio' | 'opcional'
        [string] $Chave = 'geral'
    )
    $faltando = @()
    Write-Host ''
    foreach ($k in ($Esperado.Keys | Sort-Object)) {
        $alvo = Join-Path ("{0}:\" -f $Letra) $k
        if (Test-Path -LiteralPath $alvo) {
            Write-Cor ("    OK      {0}" -f $k) 'Green'
        }
        elseif ($Esperado[$k] -eq 'opcional') {
            Write-Cor ("    AVISO   {0}  (opcional)" -f $k) 'Yellow'
        }
        else {
            Write-Cor ("    FALTA   {0}" -f $k) 'Red'
            $faltando += $k
        }
    }
    Write-Host ''
    if ($faltando.Count -eq 0) {
        Write-Ok 'tudo no lugar.'
        Write-Registro -Chave $Chave -Texto 'Verificacao de arquivos: tudo no lugar'
        return $true
    }
    Write-Erro ("faltam {0} item(ns). Refaca a copia e ejete com seguranca antes de tirar o cabo." -f $faltando.Count)
    Write-Registro -Chave $Chave -Texto ("Verificacao de arquivos: faltando {0}" -f ($faltando -join ', '))
    return $false
}

function Copy-Pasta {
    <# Copia uma pasta com robocopy e informa se deu certo. #>
    param(
        [Parameter(Mandatory)] [string] $Origem,
        [Parameter(Mandatory)] [string] $Destino,
        [string] $Rotulo = ''
    )
    if (-not (Test-Path -LiteralPath $Origem)) {
        Write-Erro ("origem nao encontrada: {0}" -f $Origem)
        return $false
    }
    if ($Rotulo) { Write-Host ("  Copiando {0} ..." -f $Rotulo) }
    & robocopy $Origem $Destino /E /R:2 /W:2 /NP /NFL /NDL | Out-Null
    $rc = $LASTEXITCODE
    if ($rc -ge 8) {
        Write-Erro ("robocopy falhou em {0} (codigo {1})." -f $Rotulo, $rc)
        return $false
    }
    Write-Ok ("{0} copiado." -f $Rotulo)
    return $true
}

function Get-HashArquivo {
    <# SHA256 de um arquivo, para conferir BIOS, keys e firmware. #>
    param([Parameter(Mandatory)] [string] $Caminho)
    if (-not (Test-Path -LiteralPath $Caminho)) {
        Write-Erro ("arquivo nao encontrado: {0}" -f $Caminho)
        return $null
    }
    $h = Get-FileHash -LiteralPath $Caminho -Algorithm SHA256
    $tam = (Get-Item -LiteralPath $Caminho).Length
    Write-Host ("    arquivo : {0}" -f (Split-Path -Leaf $Caminho))
    Write-Host ("    tamanho : {0:N0} bytes" -f $tam)
    Write-Host ("    SHA256  : {0}" -f $h.Hash.ToLower())
    return $h.Hash.ToLower()
}

# ---------------------------------------------------------------------------
# Ferramentas de PC: ADB (Meta Quest)
# ---------------------------------------------------------------------------

function Get-Adb {
    <# Procura o adb.exe nos lugares conhecidos. Retorna o caminho ou $null. #>
    param([switch] $Silencioso)

    if ($script:Adb -and (Test-Path -LiteralPath $script:Adb)) { return $script:Adb }

    $candidatos = @(
        (Join-Path $env:LOCALAPPDATA 'Programs\SideQuest\resources\app.asar.unpacked\build\adb\adb.exe'),
        (Join-Path ${env:ProgramFiles} 'SideQuest\resources\app.asar.unpacked\build\adb\adb.exe'),
        (Join-Path $env:LOCALAPPDATA 'Android\Sdk\platform-tools\adb.exe'),
        (Join-Path $env:USERPROFILE 'AppData\Local\Android\Sdk\platform-tools\adb.exe'),
        'C:\platform-tools\adb.exe',
        (Join-Path $env:USERPROFILE 'Downloads\platform-tools\adb.exe')
    )
    foreach ($c in $candidatos) {
        if ($c -and (Test-Path -LiteralPath $c)) {
            $script:Adb = $c
            if (-not $Silencioso) { Write-Ok ("adb encontrado: {0}" -f $c) }
            return $c
        }
    }
    $noPath = Get-Command adb.exe -ErrorAction SilentlyContinue
    if ($noPath) {
        $script:Adb = $noPath.Source
        if (-not $Silencioso) { Write-Ok ("adb encontrado no PATH: {0}" -f $noPath.Source) }
        return $noPath.Source
    }
    if (-not $Silencioso) {
        Write-Aviso 'adb.exe nao encontrado.'
        Write-Host '    - Instale o SideQuest (ele traz o adb):  winget install SideQuest.SideQuest'
        Write-Host '    - Ou baixe o platform-tools do Android e extraia em C:\platform-tools'
    }
    return $null
}

function Invoke-Adb {
    <# Roda o adb e devolve a saida como texto. #>
    param(
        [Parameter(Mandatory)] [string[]] $Argumentos,
        [switch] $Silencioso
    )
    $exe = Get-Adb -Silencioso
    if (-not $exe) {
        if (-not $Silencioso) { Write-Erro 'adb nao disponivel.' }
        return $null
    }
    try {
        $saida = & $exe @Argumentos 2>&1 | Out-String
        if (-not $Silencioso -and $saida.Trim()) { Write-Host $saida.Trim() }
        return $saida
    }
    catch {
        if (-not $Silencioso) { Write-Erro ("falha ao rodar o adb: {0}" -f $_.Exception.Message) }
        return $null
    }
}

function Test-QuestConectado {
    <# Diz se ha um dispositivo autorizado no adb. #>
    $saida = Invoke-Adb -Argumentos @('devices') -Silencioso
    if (-not $saida) { return 'sem-adb' }
    $linhas = $saida -split "`r?`n" | Where-Object { $_ -and $_ -notmatch '^List of devices' -and $_ -notmatch '^\*' }
    if (-not $linhas) { return 'nenhum' }
    foreach ($l in $linhas) {
        if ($l -match 'unauthorized') { return 'nao-autorizado' }
        if ($l -match '\sdevice\s*$' -or $l -match '\sdevice$') { return 'ok' }
        if ($l -match 'offline') { return 'offline' }
    }
    return 'nenhum'
}

function Show-DiagnosticoAdb {
    Write-Host ''
    Write-Cor '  DIAGNOSTICO DA CONEXAO ADB' 'White'
    Write-Host '  --------------------------'
    $exe = Get-Adb
    if (-not $exe) { return }
    Write-Host ''
    Write-Host '  adb devices:'
    [void](Invoke-Adb -Argumentos @('devices'))
    $estado = Test-QuestConectado
    Write-Host ''
    switch ($estado) {
        'ok' {
            Write-Ok 'headset conectado e autorizado.'
            Write-Host ''
            Write-Host '  Modelo e versao:'
            [void](Invoke-Adb -Argumentos @('shell', 'getprop', 'ro.product.model'))
            [void](Invoke-Adb -Argumentos @('shell', 'getprop', 'ro.build.version.release'))
        }
        'nao-autorizado' {
            Write-Aviso 'o headset aparece, mas nao autorizou o PC.'
            Write-Host '    Coloque o headset na cabeca: deve haver a janela "Permitir depuracao USB?".'
            Write-Host '    Marque "Sempre permitir" e confirme. Depois rode o diagnostico de novo.'
        }
        'offline' {
            Write-Aviso 'dispositivo offline. Desconecte e reconecte o cabo; se insistir: adb kill-server'
        }
        'nenhum' {
            Write-Aviso 'nenhum dispositivo. Confira, nesta ordem:'
            Write-Host '    1. Modo Desenvolvedor ligado no app Meta Horizon do celular.'
            Write-Host '    2. Cabo USB-C de DADOS (o de carga puro nao funciona).'
            Write-Host '    3. Headset ligado e desbloqueado (nao em repouso).'
            Write-Host '    4. Troque a porta USB; evite hub.'
        }
        'sem-adb' { Write-Erro 'adb nao disponivel.' }
    }
}

# ---------------------------------------------------------------------------
# Dados dos guias
#   N = numero do passo   T = titulo   F = acao fisica   L = linhas do texto
#   A = acao automatizada que o motor executa depois de mostrar o texto
# ---------------------------------------------------------------------------

$script:Guias = [ordered]@{

    '3ds' = @{
        Nome    = 'New Nintendo 3DS XL - boot9strap + Luma3DS'
        Chave   = '3ds'
        Fonte   = 'https://3ds.hacks.guide'
        Passos  = @(
            @{ N=1; T='O que e e o que nao e este desbloqueio'; L=@(
                'Voce vai instalar boot9strap + Luma3DS: CFW permanente que roda homebrew,',
                'backups dos SEUS cartuchos, emuladores, temas, regiao livre e Pretendo Network.',
                'NAO cobre pirataria. Dump dos seus jogos e cartoes: use o GodMode9.',
                'Reversivel: o guia tem a secao "Como desfazer" (menu do guia).',
                'Risco: baixo se voce fizer o backup da NAND no final e nao pular passos.') },
            @{ N=2; T='Confirmar o modelo do console'; F=$true; L=@(
                'ACAO FISICA: vire o console e leia a etiqueta na traseira.',
                '  RED-001 / RED-002 = New 3DS XL (este guia).',
                '  KTR / SPR / CTR / FTR / JAN = outro modelo: o metodo muda (veja o passo 3).',
                'Anote tambem a regiao impressa: USA, EUR, JPN ou KOR.') },
            @{ N=3; T='Descobrir a versao do firmware e a regiao'; F=$true; L=@(
                'ACAO FISICA no console: menu HOME -> Configuracoes da Consola (icone de chave).',
                'A versao aparece no canto inferior direito, ex.: 11.17.0-50U.',
                '  A letra final e a regiao: U = USA, E = EUR, J = JPN, K = KOR.',
                'Anote os dois numeros: a versao e a letra. Eles decidem o metodo.') },
            @{ N=4; T='Escolher o metodo (super-skaterhax ou MSET9)'; L=@(
                'Regra atual do 3ds.hacks.guide para New 3DS/2DS:',
                '  11.15 a 11.17 e regiao USA/EUR/KOR  -> super-skaterhax (mais rapido).',
                '  11.4 a 11.17, qualquer regiao        -> MSET9 (funciona tambem em JPN).',
                '  abaixo de 11.4                       -> atualize o console primeiro.',
                'Old 3DS / 2DS em 1.0 a 11.14: safecerthax (o guia tem a secao separada).') },
            @{ N=5; T='Carregar o console e deixar o carregador por perto'; F=$true; L=@(
                'ACAO FISICA: ligue o carregador. Bateria baixa durante a gravacao e a',
                'principal causa de brick. Deixe acima de 50% e o carregador conectado.',
                'Se a bateria estiver estufada (tampa levantando), troque antes de continuar.') },
            @{ N=6; T='Desligar o console e preparar a abertura'; F=$true; L=@(
                'ACAO FISICA: desligue o console por completo (nao e repouso).',
                'Separe uma chave Phillips pequena (PH00) e, se tiver, uma palheta de plastico.',
                'Trabalhe numa mesa clara: os parafusos sao minusculos.') },
            @{ N=7; T='Abrir a tampa e tirar o microSD'; F=$true; L=@(
                'ACAO FISICA, na traseira do New 3DS XL:',
                '  +--------------------------------------------------------+',
                '  :        [ etiqueta RED-001 ]                            :',
                '  :   (o)                                            (o)   :  <- 2 parafusos',
                '  +---^----------------------------------------------^-----+',
                'Solte os 2 parafusos (eles ficam presos na tampa), levante pelo entalhe,',
                'empurre o microSD para dentro ate soltar e puxe. Anote a orientacao.') },
            @{ N=8; T='Backup completo do cartao no PC'; A='backup-3ds'; L=@(
                'Coloque o microSD num adaptador/leitor e conecte ao PC.',
                'Vou copiar tudo para a Area de Trabalho. Guarde essa pasta: ela restaura',
                'o cartao exatamente como estava hoje.') },
            @{ N=9; T='Conferir FAT32, tamanho e espaco livre'; A='fs-3ds'; L=@(
                'O 3DS exige FAT32. Cartoes acima de 32 GB vem em exFAT de fabrica.',
                'Separe pelo menos 1,3 GB livres para o backup da NAND no fim (2 GB e melhor).') },
            @{ N=10; T='Teste rapido de velocidade e saude do cartao'; L=@(
                'Cartao falsificado ou gasto e a causa silenciosa de metade dos problemas.',
                'Se o cartao e novo, de marca desconhecida ou veio de marketplace, teste com',
                'o H2testw (grava e le o cartao inteiro):  https://www.heise.de/download/product/h2testw-50539',
                'Resultado esperado: "Test finished without errors".') },
            @{ N=11; T='Baixar os arquivos do metodo escolhido'; A='link-3ds'; L=@(
                'Siga a pagina do SEU metodo no 3ds.hacks.guide e baixe o que ela pede.',
                'Em geral: boot9strap, SafeB9SInstaller, Luma3DS e o pacote do exploit.',
                'Baixe sempre das paginas oficiais linkadas pelo guia, nao de blogs.') },
            @{ N=12; T='Copiar os arquivos para a raiz do cartao'; L=@(
                'Extraia os ZIPs e coloque o conteudo na RAIZ do cartao (nao dentro de pastas),',
                'exatamente como a pagina do metodo manda. Nao renomeie nada.',
                'Erro classico: criar pasta dentro de pasta com o mesmo nome.') },
            @{ N=13; T='Criar a pasta luma\payloads'; A='pastas-3ds'; L=@(
                'O Luma procura os payloads em luma\payloads. Vou criar a estrutura.') },
            @{ N=14; T='Conferir os arquivos na raiz do cartao'; A='conferir-3ds'; L=@(
                'Vou verificar se os arquivos essenciais estao onde o console espera.') },
            @{ N=15; T='Ejetar o cartao e recolocar no console'; F=$true; L=@(
                'ACAO FISICA: ejete a unidade no Windows (bandeja -> Remover hardware com',
                'seguranca) e so depois tire o cartao do leitor.',
                'Recoloque o microSD no console na mesma orientacao, feche a tampa e',
                'aparafuse. Ligue o console.') },
            @{ N=16; T='Rodar o exploit no console'; F=$true; L=@(
                'ACAO FISICA, conforme o metodo:',
                '  super-skaterhax: abra o Navegador de Internet -> va ao endereco indicado',
                '    pela pagina do metodo. A tela vai piscar e abrir o SafeB9SInstaller.',
                '  MSET9: Configuracoes -> Gestao de Dados -> Perfil -> Nintendo DS,',
                '    seguindo a ordem exata de botoes que a pagina mostra.',
                'Se travar: segure POWER 10 s, ligue de novo e repita. O cartao nao foi alterado.') },
            @{ N=17; T='Instalar o boot9strap no SafeB9SInstaller'; F=$true; L=@(
                'ACAO FISICA: na tela do SafeB9SInstaller, aperte os botoes na ordem que a',
                'propria tela pede (normalmente A para comecar e depois a sequencia mostrada).',
                'NAO desligue e NAO aperte mais nada durante a gravacao.',
                'Ao terminar, aperte A para reiniciar. O console abre a configuracao do Luma.') },
            @{ N=18; T='Configuracao inicial do Luma3DS'; F=$true; L=@(
                'ACAO FISICA: na tela azul do Luma, deixe marcado apenas o que o guia pede',
                '(em geral "Show NAND or user string in System Settings").',
                'Aperte START para salvar e reiniciar.') },
            @{ N=19; T='Entrar no Rosalina e conferir'; F=$true; L=@(
                'ACAO FISICA: com o console ligado, aperte L + Down + Select juntos.',
                'Abre o menu Rosalina (a prova de que a CFW esta ativa).',
                'Em "System Configuration" confirme a versao do Luma. B volta, B fecha.') },
            @{ N=20; T='Finalizing Setup: baixar o finalize.romfs'; L=@(
                'Siga a pagina "Finalizing Setup" do 3ds.hacks.guide.',
                'Ela instala o FBI, o Anemone, o Universal-Updater e o essencial de homebrew',
                'por meio de um unico arquivo (finalize.romfs) rodado pelo Homebrew Launcher.') },
            @{ N=21; T='Rodar o Finalizing Setup no console'; F=$true; L=@(
                'ACAO FISICA: abra o Homebrew Launcher e rode o "Finalize Setup".',
                'Espere terminar sem apertar nada. O console reinicia.') },
            @{ N=22; T='Backup da NAND com o GodMode9'; F=$true; L=@(
                'ESTE PASSO E O SEU SEGURO CONTRA BRICK. Nao pule.',
                'ACAO FISICA: desligue; ligue segurando START para abrir o GodMode9.',
                '  H:/ -> SysNAND -> ... conforme a pagina "Dumping the NAND" do guia,',
                '  ou use o atalho do menu do GodMode9 para "SysNAND backup".',
                'O arquivo sai em gm9/backups no cartao. Leva alguns minutos.') },
            @{ N=23; T='Copiar o backup da NAND para o PC'; A='copiar-nand'; L=@(
                'Agora tire o cartao, ponha no PC e copie gm9/backups para fora do cartao.',
                'Um backup de NAND que fica so no cartao nao serve de backup.') },
            @{ N=24; T='Universal-Updater: instalar o essencial'; F=$true; L=@(
                'ACAO FISICA no console: abra o Universal-Updater (icone novo no HOME).',
                'Sugestoes: GodMode9 (atualizar), Checkpoint (saves), Anemone (temas),',
                'FBI, Luma Updater, TWiLight Menu++ (DS/GBA).') },
            @{ N=25; T='Ligar o game patching do Luma'; F=$true; L=@(
                'ACAO FISICA: desligue; ligue segurando SELECT para abrir a config do Luma.',
                'Marque "Enable game patching". START para salvar.',
                'Isso e o que permite traducoes, mods e o Pretendo.') },
            @{ N=26; T='Pretendo Network (online depois do fim do Nintendo Network)'; L=@(
                'O Pretendo substitui os servicos online encerrados da Nintendo.',
                'Instale pelo Universal-Updater ("Pretendo Network Installer") e siga as',
                'instrucoes dele no console. Precisa do game patching do passo 25.') },
            @{ N=27; T='Backup de saves com o Checkpoint'; F=$true; L=@(
                'ACAO FISICA: abra o Checkpoint, escolha o jogo, "Backup".',
                'Os saves vao para 3ds/Checkpoint no cartao. Copie essa pasta para o PC',
                'de vez em quando (ha uma ferramenta no menu deste guia para isso).') },
            @{ N=28; T='Migrar para um cartao maior (se quiser)'; L=@(
                'Com o console DESLIGADO, copie TODO o conteudo do cartao antigo para o novo',
                '(ja em FAT32), mantendo a estrutura. Nunca misture arquivos de dois cartoes.',
                'O console reconhece o cartao novo sem reinstalar nada.') },
            @{ N=29; T='Boas praticas para nao quebrar a CFW'; L=@(
                '1. Nunca aceite atualizacao de sistema vinda de fonte estranha; use o Luma Updater.',
                '2. Nao tire o cartao com o console ligado.',
                '3. Um homebrew novo por vez; se travar, segure POWER 10 s.',
                '4. Guarde o backup da NAND e o backup do cartao em lugares diferentes.') },
            @{ N=30; T='Verificacao final'; L=@(
                '[ ] Rosalina abre com L + Down + Select.',
                '[ ] Configuracoes da Consola mostra a string do Luma.',
                '[ ] Backup da NAND copiado para o PC.',
                '[ ] Um homebrew abre pelo HOME.',
                '[ ] Um backup de cartucho (.3ds/.cia) roda, se voce dumpou algum.') }
        )
        Erros = @(
            'Navegador nao abre o exploit -> limpe o historico/cookies do navegador do 3DS e tente de novo.',
            'MSET9 nao aparece -> a pasta "Nintendo 3DS" precisa existir no cartao; ligue o console uma vez com o cartao.',
            'SafeB9SInstaller diz "No *.firm found" -> boot9strap.firm nao esta na raiz, ou o nome esta errado.',
            'Tela preta ao ligar -> segure POWER 10 s. Se persistir, ligue segurando START (GodMode9) e confira o cartao.',
            '"An error has occurred" ao ligar -> cartao mal encaixado ou fora de FAT32.',
            'Cartao nao e lido pelo PC -> teste outro adaptador antes de culpar o cartao.'
        )
        Desfazer = @(
            'Para voltar ao firmware de fabrica: siga a pagina "Uninstall CFW" do 3ds.hacks.guide,',
            'que usa o GodMode9 para remover o boot9strap. Faca o backup da NAND antes.',
            'Para so limpar o cartao: apague luma, boot9strap.firm, gm9 e as pastas de homebrew.',
            'Restaurar a NAND do backup desfaz qualquer alteracao de software do console.'
        )
        Links = @(
            'https://3ds.hacks.guide/get-started',
            'https://3ds.hacks.guide/finalizing-setup',
            'https://3ds.hacks.guide/godmode9-usage',
            'https://www.heise.de/download/product/h2testw-50539'
        )
    }

    'quest' = @{
        Nome    = 'Meta Quest 3S - Modo Desenvolvedor + sideload'
        Chave   = 'quest'
        Fonte   = 'https://developers.meta.com/horizon/documentation/native/android/mobile-device-setup/'
        Passos  = @(
            @{ N=1; T='O que e e o que nao e este desbloqueio'; L=@(
                'Voce vai ativar o Modo Desenvolvedor OFICIAL da Meta e liberar o sideload',
                '(instalar apps de fora da loja) por SideQuest/ADB.',
                'Nao perde garantia, nao apaga dados, e 100% reversivel.',
                'NAO existe root/jailbreak publico para o Quest 3S. Site que promete isso e golpe.',
                'Requisito duro: conta Meta de MAIOR de 18 anos, nao gerenciada por responsavel.') },
            @{ N=2; T='Conhecer o headset: botoes e portas'; F=$true; L=@(
                'ACAO FISICA: pegue o headset com as lentes voltadas para voce.',
                '  lado ESQUERDO: botao POWER + LED de status, e a porta USB-C.',
                '  embaixo a esquerda: botao de ACAO (passthrough).  embaixo a direita: volume.',
                'LED: branco = ligado, laranja = carregando, verde = cheio, azul = ligando.',
                'Localize com o dedo o POWER e a porta USB-C: voce vai usar os dois.') },
            @{ N=3; T='Carregar, ligar e atualizar o Horizon OS'; F=$true; L=@(
                'ACAO FISICA: carregue ate o LED ficar verde (ou pelo menos 50%).',
                'Carregue tambem os controles (pilhas AA).',
                'Segure POWER 2 s para ligar, coloque na cabeca e ajuste a faixa.',
                'Botao Meta -> relogio/bateria -> Configuracoes -> Sistema -> Atualizacao',
                'de software. Deixe atualizar tudo antes de continuar.') },
            @{ N=4; T='Conta Meta e app Meta Horizon no celular'; L=@(
                'Instale o app "Meta Horizon" no celular e entre com a MESMA conta do headset.',
                'Pareie o headset no app (Menu -> Dispositivos). Sem o pareamento, o passo 7',
                'nao tem onde ser feito.') },
            @{ N=5; T='Criar a organizacao de desenvolvedor'; L=@(
                'No PC ou no celular, abra developers.meta.com e entre com a sua conta Meta.',
                'Crie uma "organizacao" (nome livre, pode ser o seu proprio nome) e aceite os termos.',
                'E de graca e serve so para liberar o Modo Desenvolvedor.') },
            @{ N=6; T='Verificar a conta (SMS ou cartao)'; L=@(
                'A Meta exige verificacao da conta de desenvolvedor: numero de telefone por SMS',
                'ou cartao de credito (sem cobranca).',
                'Sem a verificacao, a chave do Modo Desenvolvedor NAO aparece no app do celular.') },
            @{ N=7; T='Ativar o Modo Desenvolvedor no app do celular'; F=$true; L=@(
                'ACAO FISICA no celular, com o headset LIGADO e proximo:',
                '  app Meta Horizon -> Menu -> Dispositivos -> escolha o Quest 3S',
                '  -> Configuracoes do headset -> Modo Desenvolvedor -> ligue a chave.',
                'Reinicie o headset depois de ligar (POWER -> Reiniciar).') },
            @{ N=8; T='PC: instalar o SideQuest e o driver ADB'; A='adb-instalar'; L=@(
                'O SideQuest e a forma mais simples de instalar APKs, e ja traz o adb.',
                'Vou tentar instalar pelo winget e depois localizar o adb.exe.') },
            @{ N=9; T='Conectar o cabo USB-C'; F=$true; L=@(
                'ACAO FISICA: use um cabo USB-C de DADOS (o da caixa serve).',
                'Ponta no headset (lado esquerdo), outra ponta numa porta USB do PC',
                '(de preferencia USB 3.0, a azul). Evite hub.',
                'Cabo "so carga" nao funciona e e o erro mais comum aqui.') },
            @{ N=10; T='Aceitar "Permitir depuracao USB" no headset'; F=$true; L=@(
                'ACAO FISICA: coloque o headset na cabeca. Vai aparecer a janela',
                '"Permitir depuracao USB?".',
                'Marque "Sempre permitir neste computador" e confirme.',
                'Se nao aparecer: desconecte e reconecte o cabo com o headset na cabeca.') },
            @{ N=11; T='Ajustes do menu Desenvolvedor no headset'; F=$true; L=@(
                'ACAO FISICA no headset: Configuracoes -> Sistema -> Desenvolvedor.',
                'Ligue: "Fontes desconhecidas" (ou equivalente) para abrir apps sideloaded.',
                'Deixe o resto no padrao por enquanto.') },
            @{ N=12; T='Verificar a conexao no SideQuest / ADB'; A='adb-diag'; L=@(
                'Vou rodar o diagnostico: adb devices, modelo e versao do sistema.') },
            @{ N=13; T='Instalar o primeiro app (teste)'; L=@(
                'No SideQuest, procure um app gratuito e clique em instalar.',
                'Ou, pelo adb:  adb install "C:\caminho\app.apk"',
                'Resultado esperado: a palavra Success.') },
            @{ N=14; T='Encontrar os apps instalados'; F=$true; L=@(
                'ACAO FISICA no headset: biblioteca de apps -> filtro/aba',
                '"Fontes desconhecidas". E ali que os apps de sideload aparecem,',
                'nao junto com os da loja.') },
            @{ N=15; T='(Opcional) ADB sem fio pelo Wi-Fi'; A='adb-wifi'; L=@(
                'Com o cabo ligado e o headset na mesma rede do PC, da para liberar o adb',
                'por Wi-Fi e trabalhar sem cabo. Vou configurar isso agora.') },
            @{ N=16; T='Backup inicial'; A='quest-backup'; L=@(
                'Vale baixar agora as capturas, os videos e a lista de apps instalados.',
                'Serve de referencia se voce precisar refazer tudo depois.') },
            @{ N=17; T='Ajustes de conforto e desempenho via ADB'; A='quest-tweaks'; L=@(
                'Ajustes reversiveis: taxa de atualizacao, resolucao de textura, nivel de',
                'CPU/GPU e limites do Guardian. Todos voltam ao padrao com um reinicio',
                'ou com o comando inverso. Vou mostrar e aplicar sob confirmacao.') },
            @{ N=18; T='Verificacao final e boas praticas'; L=@(
                '[ ] adb devices mostra o headset como "device".',
                '[ ] Um app de sideload abre pela aba Fontes desconhecidas.',
                '[ ] Capturas e lista de apps salvas no PC.',
                'Boas praticas: instale APK so de fonte conhecida (GitHub do projeto, SideQuest);',
                'um app novo por vez; se algo quebrar, desinstale pelo adb.') }
        )
        Erros = @(
            'A chave do Modo Desenvolvedor nao aparece -> organizacao nao criada ou conta nao verificada (passos 5 e 6).',
            'Conta de menor de idade -> a Meta nao abre excecao; use uma conta adulta como principal do headset.',
            'adb devices vazio -> cabo so-carga, porta USB ruim, headset em repouso ou Modo Desenvolvedor desligado.',
            'unauthorized -> falta aceitar "Permitir depuracao USB" DENTRO do headset.',
            'offline -> adb kill-server, depois reconecte o cabo.',
            'App instalado nao aparece -> procure na aba "Fontes desconhecidas" da biblioteca.'
        )
        Desfazer = @(
            'Desligar o Modo Desenvolvedor: app Meta Horizon -> Dispositivos -> o headset ->',
            'Configuracoes -> Modo Desenvolvedor -> desligar. Nada e apagado.',
            'Remover um app de sideload: adb uninstall <pacote>  (ha ferramenta no menu).',
            'Desfazer os tweaks do passo 17: reinicie o headset ou aplique o valor padrao.',
            'Revogar a autorizacao do PC: no headset, Configuracoes -> Desenvolvedor ->',
            'revogar autorizacoes de depuracao USB.'
        )
        Links = @(
            'https://developers.meta.com/horizon/documentation/native/android/mobile-device-setup/',
            'https://developers.meta.com/horizon/documentation/android-apps/enable-developer-mode/',
            'https://sidequestvr.com/'
        )
    }

    'quest-emu' = @{
        Nome    = 'Meta Quest 3S - emuladores, jogos e apps'
        Chave   = 'quest-emu'
        Fonte   = 'https://github.com/PSP-Archive/ARK-4/wiki'
        Passos  = @(
            @{ N=1; T='Pre-requisito: Modo Desenvolvedor pronto'; A='adb-diag'; L=@(
                'Este guia e a PARTE 2. Faca antes o guia "quest" (Modo Desenvolvedor + ADB).',
                'Vou conferir agora se o headset responde ao adb.') },
            @{ N=2; T='Como o Quest roda emulador (entenda antes de instalar)'; L=@(
                'O Horizon OS e Android por baixo, entao APK de Android roda nele.',
                'Dois tipos de app:',
                '  - 2D/Android comum: abre numa janela flutuante. Maioria dos emuladores.',
                '  - nativo de VR: roda em tela cheia imersiva. Ex.: CitraVR.',
                'Apps 2D ficam escondidos na aba "Fontes desconhecidas" - o passo 3 resolve.') },
            @{ N=3; T='Lightning Launcher (ver e organizar tudo)'; L=@(
                'Launcher alternativo que mostra apps de loja e de sideload juntos, com grupos.',
                'Instale pelo SideQuest ou pelo GitHub do projeto:',
                '  https://github.com/threethan/LightningLauncher',
                'Depois de instalar, abra uma vez e escolha "definir como inicio" se quiser.') },
            @{ N=4; T='Estrutura de pastas no headset'; A='quest-pastas'; L=@(
                'Vou criar /sdcard/Emuladores com subpastas por console (ROMs, BIOS, Saves).',
                'Manter tudo num lugar evita perder save quando um app e reinstalado.') },
            @{ N=5; T='CitraVR - Nintendo 3DS em VR'; L=@(
                'Emulador de 3DS nativo de VR: as duas telas do 3DS viram paineis flutuantes.',
                'Projeto: https://github.com/amwatson/CitraVR',
                'Instale o APK, abra uma vez e aponte a pasta de jogos para',
                '/sdcard/Emuladores/3DS. Formatos: .3ds, .cia, .cci.') },
            @{ N=6; T='melonDS - Nintendo DS'; L=@(
                'https://github.com/rafaelvcaetano/melonDS-android',
                'Precisa de BIOS/firmware do DS (bios7.bin, bios9.bin, firmware.bin) extraidos',
                'do SEU console. Coloque em /sdcard/Emuladores/NDS/BIOS.') },
            @{ N=7; T='NetherSX2 - PlayStation 2'; L=@(
                'https://github.com/Trixarian/NetherSX2-classic',
                'Precisa da BIOS do SEU PS2. Coloque em /sdcard/Emuladores/PS2/BIOS.',
                'Formatos de jogo: .iso, .chd (o .chd ocupa bem menos).') },
            @{ N=8; T='Xbox original: X1 BOX / xemu'; L=@(
                'Estado honesto: emulacao de Xbox no Android ainda e instavel.',
                '  https://github.com/izzy2lost/xemu/releases',
                '  https://github.com/WinDroidEmulation/X1-BOX',
                'Precisa do MCPX ROM e da BIOS do SEU console. Expectativa: poucos jogos rodam bem.') },
            @{ N=9; T='Xbox moderno: Cloud Gaming (sem emular)'; L=@(
                'Para jogos de Xbox One/Series, o caminho que funciona de verdade e o streaming',
                'oficial: abra o navegador do Quest em xbox.com/play com Game Pass Ultimate.',
                'Nao e emulacao e nao precisa de BIOS.') },
            @{ N=10; T='Eden - Nintendo Switch'; L=@(
                'O projeto Yuzu acabou; o sucessor em uso hoje e o Eden.',
                '  https://eden-emu.dev/downloads',
                'Precisa das keys (prod.keys) e do firmware do SEU Switch.',
                'Expectativa: o Quest 3S roda alguns jogos 2D/leves; os pesados nao.') },
            @{ N=11; T='RetroArch - tudo que e retro num app'; L=@(
                'Um app, varios nucleos: SNES, Mega Drive, PS1, N64, GBA, arcade.',
                'Baixe o APK Android (arm64) em https://www.retroarch.com/?page=platforms',
                'Depois: Load Core -> baixe os nucleos; ROMs em /sdcard/Emuladores/<console>.') },
            @{ N=12; T='PPSSPP - PSP'; L=@(
                'https://www.ppsspp.org/download/',
                'Roda muito bem no Quest 3S. ISO/CSO em /sdcard/Emuladores/PSP.',
                'Dica: resolucao interna 2x ou 3x ja fica nitido sem perder fluidez.') },
            @{ N=13; T='Dolphin - GameCube e Wii'; L=@(
                'https://dolphin-emu.org/download/',
                'GameCube roda bem; Wii depende do jogo e do controle.',
                'ROMs em /sdcard/Emuladores/GameCube e /sdcard/Emuladores/Wii.') },
            @{ N=14; T='Enviar jogos do PC para o headset'; A='quest-push'; L=@(
                'Vou enviar uma pasta do PC para /sdcard/Emuladores no headset, conferindo',
                'antes se cabe no espaco livre.') },
            @{ N=15; T='Conferir hashes de BIOS e keys'; A='hash'; L=@(
                'BIOS ou keys erradas sao a causa numero 1 de "nao abre nenhum jogo".',
                'Vou calcular o SHA256 de um arquivo seu para voce comparar com a referencia',
                'do projeto do emulador.') },
            @{ N=16; T='Converter ISO para CHD (economiza muito espaco)'; L=@(
                'O chdman (vem no pacote do MAME) comprime ISO de PS1/PS2/Dreamcast sem perda:',
                '  chdman createcd -i jogo.iso -o jogo.chd',
                'Reducao tipica: 30% a 60%. NetherSX2 e RetroArch leem .chd direto.') },
            @{ N=17; T='Controles: o que funciona'; F=$true; L=@(
                'ACAO FISICA: os controles Touch funcionam nos emuladores como gamepad,',
                'mas sem D-pad real. Para jogo retro, um gamepad Bluetooth e muito melhor.',
                'Pareie em Configuracoes -> Dispositivos -> Bluetooth.',
                'Testados pela comunidade: 8BitDo (modo Android), Xbox Series, DualSense.') },
            @{ N=18; T='Streaming do PC: Sunshine + Moonlight'; L=@(
                'Para jogar PC no headset com baixa latencia, sem emular:',
                '  PC:      https://github.com/LizardByte/Sunshine',
                '  Headset: Moonlight (APK Android)',
                'Use cabo de rede no PC e 5 GHz/6 GHz no headset.') },
            @{ N=19; T='Backup automatico dos saves'; A='quest-saves'; L=@(
                'Vou puxar as pastas de save do headset para o PC, e mostrar como agendar',
                'isso no Agendador de Tarefas do Windows.') },
            @{ N=20; T='Icones e atalhos organizados'; L=@(
                'No Lightning Launcher: crie grupos ("Emuladores", "Video", "Ferramentas"),',
                'arraste os apps e troque os icones.',
                'Daijisho (frontend de ROMs) tambem funciona, se voce quiser capas e listas.') },
            @{ N=21; T='Stremio - video'; L=@(
                'https://www.stremio.com/downloads  (APK Android)',
                'Instale pelo SideQuest/adb e abra pela aba Fontes desconhecidas.',
                'Entre na conta, escolha os addons e use o navegador do Quest se a janela',
                'ficar pequena demais.') },
            @{ N=22; T='Perfis de desempenho'; A='quest-perf'; L=@(
                'Tres perfis prontos (bateria, equilibrado, maximo) que mudam taxa de',
                'atualizacao, resolucao de textura e nivel de CPU/GPU. Tudo reversivel.') },
            @{ N=23; T='Listar e desinstalar pacotes'; A='quest-pacotes'; L=@(
                'Vou listar os apps de sideload instalados e permitir desinstalar pelo nome',
                'do pacote.') },
            @{ N=24; T='Quando algo nao abre: ordem de diagnostico'; L=@(
                '1. O app aparece na aba "Fontes desconhecidas"? Se nao, nao instalou.',
                '2. BIOS/keys no lugar e com o hash certo? (passo 15)',
                '3. A ROM esta na pasta que o emulador aponta nas configuracoes dele?',
                '4. Formato suportado? (.chd nem sempre, .iso quase sempre)',
                '5. Espaco livre no headset? adb shell df /sdcard') },
            @{ N=25; T='Boas praticas'; L=@(
                'Um app novo por vez, para saber o que quebrou.',
                'APK so de fonte conhecida: GitHub do projeto, site oficial, SideQuest.',
                'Saves no PC de vez em quando (passo 19).',
                'Jogos, BIOS e keys vem dos SEUS proprios consoles e midias.') },
            @{ N=26; T='Verificacao final'; L=@(
                '[ ] Lightning Launcher mostrando tudo junto.',
                '[ ] Um emulador abrindo um jogo seu de verdade.',
                '[ ] /sdcard/Emuladores organizado por console.',
                '[ ] Saves copiados para o PC.',
                '[ ] Stremio abrindo, se voce quis video.') }
        )
        Erros = @(
            'adb install falha com INSTALL_FAILED_INSUFFICIENT_STORAGE -> libere espaco: adb shell df /sdcard',
            'App instala mas nao aparece -> aba "Fontes desconhecidas", ou use o Lightning Launcher.',
            'Emulador abre e fecha na hora -> falta BIOS/keys, ou o APK e de arquitetura errada (precisa arm64).',
            'Jogo abre sem som ou sem imagem -> troque o nucleo/driver grafico nas opcoes do emulador (Vulkan x OpenGL).',
            'Push muito lento -> use cabo USB 3.0 direto no PC; ADB sem fio e bem mais lento para arquivos grandes.',
            'Nada roda depois de atualizar o Horizon OS -> reinstale o app; a Meta as vezes revoga permissoes.'
        )
        Desfazer = @(
            'Desinstalar um app: adb uninstall <pacote>  (ferramenta no menu deste guia).',
            'Apagar os arquivos: adb shell rm -r /sdcard/Emuladores  (APAGA ROMs e saves - copie antes).',
            'Voltar o launcher padrao: Configuracoes -> Apps -> Lightning Launcher -> limpar',
            'padroes, ou desinstalar o launcher.',
            'Desfazer perfis de desempenho: aplique o perfil "equilibrado" ou reinicie o headset.'
        )
        Links = @(
            'https://github.com/threethan/LightningLauncher',
            'https://github.com/amwatson/CitraVR',
            'https://github.com/rafaelvcaetano/melonDS-android',
            'https://github.com/Trixarian/NetherSX2-classic',
            'https://github.com/izzy2lost/xemu/releases',
            'https://eden-emu.dev/downloads',
            'https://www.retroarch.com/?page=platforms',
            'https://www.ppsspp.org/download/',
            'https://dolphin-emu.org/download/',
            'https://github.com/LizardByte/Sunshine',
            'https://www.stremio.com/downloads'
        )
    }

    'psp' = @{
        Nome    = 'PSP - CFW ARK-4 + cIPL permanente'
        Chave   = 'psp'
        Fonte   = 'https://github.com/PSP-Archive/ARK-4/wiki'
        Passos  = @(
            @{ N=1; T='O que e e o que nao e este desbloqueio'; L=@(
                'Voce vai instalar a CFW ARK-4 por cima do firmware oficial 6.61.',
                'Com ela: homebrew, emuladores, backups dos SEUS UMDs em ISO/CSO, jogos de',
                'PS1 em EBOOT, plugins, temas e overclock.',
                'Duas etapas: TEMPORARIA (ARK Loader, risco zero) e depois PERMANENTE (cIPL).',
                'Versao recomendada: ARK-4 v4.20.69 r206, ultima estavel (maio/2026).',
                'O ARK-5 e o sucessor em desenvolvimento, com lancamentos pre-release.') },
            @{ N=2; T='VIRE O PSP: identificar o modelo'; F=$true; A='psp-modelo'; L=@(
                'ACAO FISICA: vire o console de costas e leia a etiqueta impressa.',
                '  +-------------------------------------------------------------+',
                '  :                  [ tampa da bateria ]                       :',
                '  :        etiqueta:  PSP-XXXX  /  Model No.                    :  <- leia AQUI',
                '  +-------------------------------------------------------------+',
                'Sem etiqueta, pelo formato: 1000 = grosso; 2000/3000 = fino; Go = tela',
                'deslizante sem UMD; Street (E1000) = fosco, sem Wi-Fi.') },
            @{ N=3; T='Risco de brick do SEU modelo'; A='psp-risco'; L=@(
                'So a etapa PERMANENTE (cIPL) grava na NAND. A temporaria nao grava nada.',
                'Recuperacao por bateria Pandora:',
                '  PSP-1000                           -> recuperavel.',
                '  PSP-2000 placa TA-085 ou anterior  -> recuperavel.',
                '  2000 TA-088v3, 3000, Go, E1000     -> NAO recuperavel por Pandora.',
                'Regras de ouro: bateria cheia + carregador na tomada + nao apertar nada.') },
            @{ N=4; T='Ver a versao do firmware'; F=$true; L=@(
                'ACAO FISICA no PSP: ligue, va em Configuracoes -> Configuracoes do Sistema',
                '-> Informacoes do Sistema. Leia "Software do sistema".',
                '  6.61         -> alvo, pule o passo 11.',
                '  6.60         -> serve, mas o ideal e subir para 6.61.',
                '  menor que 6.60 -> atualize no passo 11.',
                '  ja mostra ARK/PRO/ME/LME/Infinity -> ja tem CFW; veja os erros no menu.') },
            @{ N=5; T='Bateria, carregador e cartao'; F=$true; L=@(
                'ACAO FISICA: carregue ate o LED laranja apagar e deixe o carregador na tomada.',
                'Bateria encaixada e tampa fechada. Bateria estufada: troque antes.',
                'Cartao: Memory Stick PRO Duo (ou microSD com adaptador) em FAT32.',
                'PSP Go: memoria interna de 16 GB (raiz ef0:) e, se quiser, cartao M2.',
                'O slot do cartao fica na lateral ESQUERDA, atras de uma tampinha.') },
            @{ N=6; T='Conectar o PSP ao PC em modo USB'; F=$true; L=@(
                'ACAO FISICA: cabo MINI-USB (tipo B) na parte de cima do console, ao lado do',
                'botao de WLAN. PSP Go usa o conector multiuso proprietario.',
                'No XMB: Configuracoes -> Conexao USB -> X.',
                'Se o PC nao ve nada, o cabo e "so carga": troque o cabo.') },
            @{ N=7; T='Detectar a unidade do cartao'; A='unidade-psp'; L=@(
                'Vou procurar a unidade do PSP pela pasta PSP na raiz.') },
            @{ N=8; T='Backup completo do cartao'; A='backup-psp'; L=@(
                'robocopy somente le o cartao. Guarde a pasta: ela devolve o cartao ao',
                'estado de hoje.') },
            @{ N=9; T='Conferir FAT32 e espaco livre'; A='fs-psp'; L=@(
                'FAT32 obrigatorio. 100 MB livres bastam para a CFW; jogos de UMD ocupam',
                'de 300 MB a 1,8 GB cada.') },
            @{ N=10; T='Criar a estrutura de pastas'; A='pastas-psp'; L=@(
                'ISO (jogos), PSP\GAME (homebrew e PS1), PSP\SAVEDATA (saves e o ARK),',
                'PSP\CHEATS, MUSIC, PICTURE, VIDEO, SEPLUGINS.') },
            @{ N=11; T='Atualizar para o firmware oficial 6.61'; A='psp-update'; L=@(
                'Pule se ja esta em 6.61.',
                'O atualizador oficial e um EBOOT.PBP de ~30 MB. A Sony encerrou as paginas',
                'de download do PSP; hoje ele vem de acervos de preservacao - confira tamanho',
                'e hash. Caminho final: <cartao>\PSP\GAME\UPDATE\EBOOT.PBP',
                'ATENCAO: desligar o console durante a atualizacao oficial BRICKA o PSP.') },
            @{ N=12; T='Baixar o ARK-4 (ou ARK-5)'; A='link-psp'; L=@(
                'RECOMENDADO: ARK-4 v4.20.69 r206 (ultima estavel; repo arquivado em ago/2026,',
                'ou seja, nao muda mais):  https://github.com/PSP-Archive/ARK-4/releases',
                'ALTERNATIVA: ARK-5, sucessor ativo, releases pre-release:',
                '  https://github.com/PSP-Arkfive/ARK-5   e   .../FasterARK',
                'Do ARK4.zip importam: ARK_01234, ARK_Loader, ARK_cIPL e DC-ARK.') },
            @{ N=13; T='Copiar o ARK-4 para o cartao'; A='copiar-ark'; L=@(
                'Destinos:  PSP\SAVEDATA\ARK_01234 ,  PSP\GAME\ARK_Loader ,  PSP\GAME\ARK_cIPL',
                'Vou copiar a partir da pasta que voce extraiu do ZIP.') },
            @{ N=14; T='Conferir se os arquivos chegaram'; A='conferir-ark'; L=@(
                'Erro classico: criar ARK_Loader dentro de ARK_Loader. O EBOOT.PBP tem que',
                'estar DIRETO dentro da pasta.') },
            @{ N=15; T='Ejetar com seguranca e sair do modo USB'; F=$true; L=@(
                'ACAO FISICA: no PC, ejete a unidade pela bandeja (Remover hardware com',
                'seguranca) e espere a confirmacao - e isso que garante que a copia foi',
                'realmente gravada, e nao so no cache.',
                'No PSP, aperte O para sair da tela "Conexao USB" e tire o cabo.',
                'Deixe o carregador ligado.') },
            @{ N=16; T='Rodar o ARK Loader (CFW temporaria)'; F=$true; L=@(
                'Hora da verdade - e a parte SEM RISCO: nada e gravado na NAND.',
                'ACAO FISICA no XMB: Jogo -> Memory Stick -> "ARK Loader" -> X.',
                'A tela fica preta 1 a 3 s e o console reinicia sozinho. Isso e o esperado.',
                'Se nao aparecer o item: confira PSP\GAME\ARK_Loader\EBOOT.PBP (passo 14).',
                'Se der "Dados corrompidos": copia incompleta ou cartao tirado sem ejetar.') },
            @{ N=17; T='Confirmar "ARK-4 Live"'; F=$true; L=@(
                'ACAO FISICA: Configuracoes -> Configuracoes do Sistema -> Informacoes do',
                'Sistema. A linha "Software do sistema" deve mostrar algo como:',
                '    6.61 ARK-4 Live',
                'Teste extra: aperte SELECT no XMB - deve abrir o menu VSH do ARK.',
                'Nesta fase, ao desligar a CFW sai. Isso e normal.') },
            @{ N=18; T='Decidir: ficar na temporaria ou ir de cIPL'; A='psp-decidir'; L=@(
                'OPCAO A - temporaria: risco zero, mas roda o ARK Loader cada vez que ligar.',
                'OPCAO B - cIPL permanente: liga ja com CFW; grava na NAND.',
                'Checklist obrigatorio para a B: passo 17 confirmado, bateria cheia,',
                'carregador na tomada, e voce nao vai apertar nada durante a gravacao.') },
            @{ N=19; T='Instalar o cIPL (permanente)'; F=$true; L=@(
                'ACAO FISICA, com a CFW temporaria ATIVA agora:',
                '  1. Confirme que SELECT abre o menu VSH.',
                '  2. Confirme o carregador na tomada.',
                '  3. XMB -> Jogo -> Memory Stick -> "ARK cIPL Flasher" -> X.',
                '  4. Leia o aviso e confirme (normalmente X).',
                '  5. NAO aperte nada, NAO desligue, NAO tire o cabo. Sao poucos segundos.',
                '  6. Reinicie quando pedir.',
                'Se este console ja teve Infinity, rode o DC-ARK ANTES do cIPL.') },
            @{ N=20; T='Confirmar "ARK 4.20.XX cIPL"'; F=$true; L=@(
                'ACAO FISICA, com o console recem-reiniciado e SEM rodar o ARK Loader:',
                'Informacoes do Sistema deve mostrar:    ARK 4.20.XX cIPL',
                'Se mostrar so 6.61, a gravacao nao pegou - o console continua normal e',
                'voce pode tentar de novo (passo 19). Nada foi perdido.',
                'Teste final: desligue de vez, ligue e veja se continua com CFW.') },
            @{ N=21; T='Configurar o ARK (menu VSH / SELECT)'; F=$true; L=@(
                'ACAO FISICA: SELECT no XMB ou dentro do jogo abre o menu do ARK.',
                '  CPU Clock (XMB): padrao. CPU Clock (jogo): 333/166 ajuda nos jogos que engasgam.',
                '  UMD ISO Mode: Inferno (melhor compatibilidade).',
                '  Plugins: um por vez. Se travar ao ligar, foi o ultimo.',
                'Recovery Menu: desligue e ligue segurando R - da para desativar todos os plugins.') },
            @{ N=22; T='Colocar jogos, homebrew e PS1'; A='psp-jogos'; L=@(
                '  ISO/CSO dos SEUS UMDs   -> <cartao>\ISO',
                '  homebrew e emuladores   -> <cartao>\PSP\GAME  (uma pasta por programa)',
                '  jogos de PS1 (EBOOT.PBP)-> <cartao>\PSP\GAME',
                '  cheats                  -> <cartao>\PSP\CHEATS',
                'Dump dos seus UMDs: use o dumper do ARK ou o homebrew UMD Dumper.',
                'Emuladores que valem: SNES9x TYL, PicoDrive, gpSP, NesterJ, MAME4ALL, RetroArch.') },
            @{ N=23; T='Backup dos saves'; A='saves-psp'; L=@(
                'Os saves ficam em PSP\SAVEDATA, uma pasta por jogo.',
                'Ao restaurar, nao sobrescreva ARK_01234 com versao antiga: copie de volta',
                'apenas as pastas dos jogos.') },
            @{ N=24; T='Verificacao final e boas praticas'; L=@(
                '[ ] Informacoes do Sistema mostra ARK (Live ou cIPL).',
                '[ ] Desliga e liga mantendo a CFW (se fez o cIPL).',
                '[ ] Um homebrew abre por Jogo -> Memory Stick.',
                '[ ] Um ISO/CSO abre pela pasta ISO.',
                '[ ] Backup do cartao e dos saves no PC.',
                'Guarde uma copia do ARK4.zip usado: o repositorio foi arquivado.') }
        )
        Erros = @(
            '"ARK Loader" nao aparece -> confira PSP\GAME\ARK_Loader\EBOOT.PBP e o FAT32.',
            '"Dados corrompidos" -> arquivo truncado: copie de novo e ejete com seguranca.',
            'Tela preta ao abrir o ARK Loader -> firmware fora de 6.60/6.61, ou falta ARK_01234. Segure POWER 10 s.',
            'cIPL nao pega -> a CFW temporaria nao estava ativa na hora, ou ha Infinity antigo (rode o DC-ARK).',
            'Trava no XMB apos plugin -> ligue segurando R (Recovery Menu) e desative os plugins.',
            'PC nao ve o cartao -> cabo so-carga. Troque o cabo antes de mexer em driver.',
            'Cartao acima de 32 GB sem FAT32 -> format X: /FS:FAT32 /Q como administrador, ou formate pelo PSP.',
            'Console nao liga depois do cIPL -> 1000/2000 TA-085 ou anterior: Pandora. 3000/Go/E1000: sem recuperacao por Pandora.'
        )
        Desfazer = @(
            'So usou a temporaria: nada a desfazer, desligue o console. Para limpar o cartao,',
            'apague PSP\GAME\ARK_Loader, PSP\GAME\ARK_cIPL e PSP\SAVEDATA\ARK_01234.',
            'Instalou o cIPL: ligue o console e rode o DC-ARK (PSP\GAME\DC-ARK, vem no pacote',
            'do ARK-4). Ele remove o cIPL e devolve o boot original. Reinicie e confira que',
            'Informacoes do Sistema mostra apenas 6.61.',
            'Formatar o Memory Stick NAO remove o cIPL: ele esta na NAND, nao no cartao.',
            'Restaurar o cartao: copie de volta a pasta de backup do passo 8.'
        )
        Links = @(
            'https://github.com/PSP-Archive/ARK-4/releases',
            'https://github.com/PSP-Archive/ARK-4/wiki',
            'https://github.com/PSP-Arkfive/ARK-5',
            'https://github.com/PSP-Arkfive/FasterARK'
        )
    }
}

# ---------------------------------------------------------------------------
# Acoes automatizadas dos passos
# ---------------------------------------------------------------------------

function Invoke-Acao {
    param(
        [Parameter(Mandatory)] [string]    $Acao,
        [Parameter(Mandatory)] [hashtable] $G
    )
    $chave = [string]$G['Chave']

    switch ($Acao) {

        # ---------------- 3DS ----------------
        'backup-3ds' {
            $u = Get-UnidadeAlvo -Marcadores @('Nintendo 3DS') -Descricao 'o cartao do 3DS'
            if ($u) { [void](Backup-Unidade -Letra $u -Prefixo 'Backup_3DS' -Chave $chave) }
        }
        'fs-3ds' {
            $u = Get-UnidadeAlvo -Marcadores @('Nintendo 3DS') -Descricao 'o cartao do 3DS'
            if ($u) {
                $i = Test-SistemaArquivos -Letra $u -MinimoLivreGB 1.3
                Write-Registro -Chave $chave -Texto ("Cartao {0}: FS={1} total={2}GB livre={3}GB" -f $u, $i.Sistema, $i.TotalGB, $i.LivreGB)
                if (Test-Path -LiteralPath ("{0}:\Nintendo 3DS" -f $u)) { Write-Ok 'pasta "Nintendo 3DS" encontrada.' }
                else { Write-Aviso 'pasta "Nintendo 3DS" ausente. Ligue o console uma vez com o cartao (o MSET9 precisa dela).' }
            }
        }
        'pastas-3ds' {
            $u = Get-UnidadeAlvo -Marcadores @('Nintendo 3DS') -Descricao 'o cartao do 3DS'
            if ($u) { [void](New-EstruturaPastas -Letra $u -Chave $chave -Pastas @('luma', 'luma\payloads', '3ds', 'cias', 'gm9')) }
        }
        'conferir-3ds' {
            $u = Get-UnidadeAlvo -Marcadores @('Nintendo 3DS') -Descricao 'o cartao do 3DS'
            if ($u) {
                $esp = @{
                    'boot.firm'           = 'obrigatorio'
                    'boot.3dsx'           = 'obrigatorio'
                    'luma\payloads'       = 'obrigatorio'
                    'boot9strap'          = 'opcional'
                    'gm9'                 = 'opcional'
                    'Nintendo 3DS'        = 'opcional'
                }
                [void](Test-ArquivosEsperados -Letra $u -Esperado $esp -Chave $chave)
                Write-Host ''
                Write-Cor '  Observacao: a lista exata depende do metodo (super-skaterhax ou MSET9).' 'DarkGray'
                Write-Cor '  Compare com a pagina do SEU metodo no 3ds.hacks.guide.' 'DarkGray'
            }
        }
        'copiar-nand' {
            $u = Get-UnidadeAlvo -Marcadores @('Nintendo 3DS', 'gm9') -Descricao 'o cartao do 3DS'
            if ($u) {
                $orig = "{0}:\gm9\backups" -f $u
                if (-not (Test-Path -LiteralPath $orig)) {
                    Write-Erro 'nao achei gm9\backups no cartao. Faca o backup da NAND no console (passo 22).'
                }
                else {
                    $dest = Join-Path ([Environment]::GetFolderPath('Desktop')) ('Backup_NAND_3DS_' + (Get-Date -Format 'yyyy-MM-dd_HHmm'))
                    if (Copy-Pasta -Origem $orig -Destino $dest -Rotulo 'backup da NAND') {
                        Write-Ok ("NAND copiada para: {0}" -f $dest)
                        Get-ChildItem -LiteralPath $dest | Select-Object Name, Length | Format-Table | Out-Host
                        Write-Registro -Chave $chave -Texto ("Backup de NAND copiado para {0}" -f $dest)
                    }
                }
            }
        }
        'link-3ds' { Open-Links -Urls @('https://3ds.hacks.guide/get-started') }

        # ---------------- Quest ----------------
        'adb-instalar' {
            if (Read-SimNao 'Tentar instalar o SideQuest pelo winget agora?') {
                if (Get-Command winget -ErrorAction SilentlyContinue) {
                    & winget install --id SideQuest.SideQuest --accept-source-agreements --accept-package-agreements | Out-Host
                }
                else {
                    Write-Aviso 'winget nao encontrado. Baixe manualmente em https://sidequestvr.com/'
                }
            }
            Write-Host ''
            [void](Get-Adb)
        }
        'adb-diag' { Show-DiagnosticoAdb }
        'adb-wifi' {
            $est = Test-QuestConectado
            if ($est -ne 'ok') {
                Write-Aviso 'conecte o headset pelo cabo e autorize a depuracao antes de liberar o Wi-Fi.'
            }
            else {
                $ip = (Read-Host '  IP do headset na rede (Configuracoes -> Wi-Fi -> a rede -> Avancado), ou ENTER para tentar descobrir').Trim()
                if (-not $ip) {
                    $s = Invoke-Adb -Argumentos @('shell', 'ip', 'route') -Silencioso
                    if ($s -and $s -match '(\d+\.\d+\.\d+\.\d+)\s*$') { $ip = $Matches[1] }
                    elseif ($s -and $s -match 'src\s+(\d+\.\d+\.\d+\.\d+)') { $ip = $Matches[1] }
                }
                if (-not $ip) { Write-Erro 'nao descobri o IP. Pegue nas configuracoes de Wi-Fi do headset.' }
                else {
                    Write-Host ("  Usando IP: {0}" -f $ip)
                    [void](Invoke-Adb -Argumentos @('tcpip', '5555'))
                    Start-Sleep -Seconds 2
                    [void](Invoke-Adb -Argumentos @('connect', ("{0}:5555" -f $ip)))
                    Write-Host ''
                    Write-Cor '  Agora pode tirar o cabo. Para voltar ao cabo: adb usb' 'DarkGray'
                    Write-Registro -Chave $chave -Texto ("ADB sem fio habilitado em {0}:5555" -f $ip)
                }
            }
        }
        'quest-backup' {
            if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; break }
            $dest = Join-Path ([Environment]::GetFolderPath('Desktop')) ('Backup_Quest_' + (Get-Date -Format 'yyyy-MM-dd_HHmm'))
            $null = New-Item -ItemType Directory -Path $dest -Force
            Write-Host '  Baixando capturas e videos (pode demorar)...'
            [void](Invoke-Adb -Argumentos @('pull', '/sdcard/Oculus/Screenshots', $dest) -Silencioso)
            [void](Invoke-Adb -Argumentos @('pull', '/sdcard/Oculus/VideoShots', $dest) -Silencioso)
            $lista = Invoke-Adb -Argumentos @('shell', 'pm', 'list', 'packages', '-3') -Silencioso
            if ($lista) { Set-Content -LiteralPath (Join-Path $dest 'apps-instalados.txt') -Value $lista -Encoding UTF8 }
            Write-Ok ("backup inicial em: {0}" -f $dest)
            Write-Registro -Chave $chave -Texto ("Backup inicial do Quest em {0}" -f $dest)
        }
        'quest-tweaks' { Invoke-QuestTweaks -Chave $chave }
        'quest-perf'   { Invoke-QuestPerfil -Chave $chave }
        'quest-pastas' {
            if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; break }
            $base = '/sdcard/Emuladores'
            $subs = @('3DS', 'NDS', 'NDS/BIOS', 'PS2', 'PS2/BIOS', 'PS1', 'Switch', 'Switch/keys',
                      'PSP', 'GameCube', 'Wii', 'SNES', 'MegaDrive', 'GBA', 'NES', 'Arcade', 'Saves')
            foreach ($s in $subs) {
                [void](Invoke-Adb -Argumentos @('shell', 'mkdir', '-p', ("{0}/{1}" -f $base, $s)) -Silencioso)
            }
            Write-Ok ("estrutura criada em {0}" -f $base)
            [void](Invoke-Adb -Argumentos @('shell', 'ls', $base))
            Write-Registro -Chave $chave -Texto 'Estrutura /sdcard/Emuladores criada'
        }
        'quest-push' {
            if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; break }
            $orig = (Read-Host '  Pasta do PC a enviar (ex.: D:\ROMs\SNES)').Trim('"', ' ')
            if (-not $orig -or -not (Test-Path -LiteralPath $orig)) { Write-Erro 'pasta nao encontrada.'; break }
            $tam = (Get-ChildItem -LiteralPath $orig -Recurse -File -ErrorAction SilentlyContinue |
                    Measure-Object -Property Length -Sum).Sum
            if (-not $tam) { $tam = 0 }
            $tamMb = [math]::Round($tam / 1MB, 1)
            Write-Host ("  Tamanho a enviar: {0} MB" -f $tamMb)

            $df = Invoke-Adb -Argumentos @('shell', 'df', '/sdcard') -Silencioso
            $livreMb = $null
            if ($df) {
                foreach ($l in ($df -split "`r?`n")) {
                    if ($l -match '^\S+\s+(\d+)\s+(\d+)\s+(\d+)') { $livreMb = [math]::Round([double]$Matches[3] / 1024, 1) }
                }
            }
            if ($null -ne $livreMb) {
                Write-Host ("  Espaco livre no headset: {0} MB" -f $livreMb)
                if ($tamMb -gt $livreMb) {
                    Write-Erro 'nao cabe. Libere espaco no headset ou envie menos arquivos.'
                    break
                }
            }
            else { Write-Cor '  (nao consegui ler o espaco livre; seguindo em frente)' 'DarkGray' }

            $destino = (Read-Host '  Destino no headset [/sdcard/Emuladores]').Trim()
            if (-not $destino) { $destino = '/sdcard/Emuladores' }
            if (-not (Read-SimNao ("Enviar {0} para {1}?" -f $orig, $destino))) { break }
            [void](Invoke-Adb -Argumentos @('push', $orig, $destino))
            Write-Registro -Chave $chave -Texto ("Push de {0} para {1} ({2} MB)" -f $orig, $destino, $tamMb)
        }
        'quest-saves' {
            if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; break }
            $dest = Join-Path ([Environment]::GetFolderPath('Desktop')) ('Saves_Quest_' + (Get-Date -Format 'yyyy-MM-dd_HHmm'))
            $null = New-Item -ItemType Directory -Path $dest -Force
            foreach ($p in @('/sdcard/Emuladores/Saves', '/sdcard/Android/data', '/sdcard/RetroArch/saves')) {
                Write-Host ("  Puxando {0} ..." -f $p)
                [void](Invoke-Adb -Argumentos @('pull', $p, $dest) -Silencioso)
            }
            Write-Ok ("saves em: {0}" -f $dest)
            Write-Host ''
            Write-Cor '  Para agendar isso toda semana, rode num Prompt como administrador:' 'DarkGray'
            Write-Host ('    schtasks /create /tn "Backup saves Quest" /tr "powershell -File ""{0}"" -Guia quest-emu -Passo 19" /sc weekly /d SUN /st 20:00' -f (Join-Path $script:Base 'Guias-Desbloqueio.ps1'))
            Write-Registro -Chave $chave -Texto ("Saves do Quest copiados para {0}" -f $dest)
        }
        'quest-pacotes' {
            if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; break }
            Write-Host '  Apps de sideload instalados:'
            Write-Host ''
            $lista = Invoke-Adb -Argumentos @('shell', 'pm', 'list', 'packages', '-3') -Silencioso
            if (-not $lista) { Write-Aviso 'nao consegui listar.'; break }
            $pkgs = @($lista -split "`r?`n" | Where-Object { $_ -match 'package:' } | ForEach-Object { ($_ -replace 'package:', '').Trim() } | Sort-Object)
            $i = 1
            foreach ($p in $pkgs) { Write-Host ("   [{0,2}] {1}" -f $i, $p); $i++ }
            Write-Host ''
            $r = (Read-Host '  Numero para DESINSTALAR, ou ENTER para sair').Trim()
            if (-not $r) { break }
            if ($r -notmatch '^\d+$') { Write-Erro 'numero invalido.'; break }
            $idx = [int]$r - 1
            if ($idx -lt 0 -or $idx -ge $pkgs.Count) { Write-Erro 'fora da lista.'; break }
            $alvo = $pkgs[$idx]
            Write-Aviso ("isto desinstala {0} e pode apagar os dados dele." -f $alvo)
            if (Read-SimNao ("Desinstalar {0}?" -f $alvo) $false) {
                [void](Invoke-Adb -Argumentos @('uninstall', $alvo))
                Write-Registro -Chave $chave -Texto ("Desinstalado: {0}" -f $alvo)
            }
        }
        'hash' {
            $c = (Read-Host '  Caminho do arquivo (BIOS, keys, firmware)').Trim('"', ' ')
            if ($c) { [void](Get-HashArquivo -Caminho $c) }
            Write-Host ''
            Write-Cor '  Compare o SHA256 com o que o projeto do emulador publica.' 'DarkGray'
            Write-Cor '  Hash diferente = arquivo errado ou corrompido: nao insista, troque o arquivo.' 'DarkGray'
        }

        # ---------------- PSP ----------------
        'psp-modelo' {
            Write-Host ''
            Write-Host '   [1] PSP-1000 (Fat)     [2] PSP-2000 (Slim)     [3] PSP-3000'
            Write-Host '   [4] PSP Go (N1000)     [5] PSP Street (E1000)  [6] nao sei'
            Write-Host ''
            $r = (Read-Host '  Modelo').Trim()
            $map = @{ '1' = '1000'; '2' = '2000'; '3' = '3000'; '4' = 'GO'; '5' = 'E1000' }
            if ($map.ContainsKey($r)) {
                $script:Modelo = $map[$r]
                $raiz = 'ms0'
                if ($script:Modelo -eq 'GO') { $raiz = 'ef0' }
                Write-Ok ("modelo {0} (raiz {1}:)" -f $script:Modelo, $raiz)
                Write-Registro -Chave $chave -Texto ("Modelo informado: {0}" -f $script:Modelo)
            }
            else {
                Write-Cor '  Sem problema: o ARK-4 e o cIPL funcionam nos cinco modelos.' 'DarkGray'
                Write-Cor '  O que muda e so a chance de recuperacao em caso de brick (passo 3).' 'DarkGray'
            }
        }
        'psp-risco' {
            if (-not $script:Modelo) { Write-Cor '  (modelo nao informado - leia os dois casos acima)' 'DarkGray'; break }
            Write-Host ''
            switch ($script:Modelo) {
                '1000'  { Write-Ok 'PSP-1000: risco baixo E com rede de seguranca (bateria Pandora).' }
                '2000'  { Write-Aviso 'PSP-2000: recuperavel por Pandora apenas se a placa for TA-085 ou anterior.' }
                default { Write-Aviso ("{0}: SEM recuperacao por Pandora. Siga o passo 5 a risca." -f $script:Modelo) }
            }
        }
        'unidade-psp' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP' -Forcar
            if ($u) { Write-Registro -Chave $chave -Texto ("Unidade do PSP: {0}:" -f $u) }
        }
        'backup-psp' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) { [void](Backup-Unidade -Letra $u -Prefixo 'Backup_PSP' -Chave $chave) }
        }
        'fs-psp' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) {
                $i = Test-SistemaArquivos -Letra $u -MinimoLivreGB 0.1
                Write-Registro -Chave $chave -Texto ("Cartao {0}: FS={1} total={2}GB livre={3}GB" -f $u, $i.Sistema, $i.TotalGB, $i.LivreGB)
            }
        }
        'pastas-psp' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) {
                [void](New-EstruturaPastas -Letra $u -Chave $chave -Pastas @(
                    'ISO', 'PSP', 'PSP\GAME', 'PSP\SAVEDATA', 'PSP\CHEATS',
                    'MUSIC', 'PICTURE', 'VIDEO', 'SEPLUGINS'))
            }
        }
        'psp-update' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) {
                $pasta = "{0}:\PSP\GAME\UPDATE" -f $u
                if (-not (Test-Path -LiteralPath $pasta)) { $null = New-Item -ItemType Directory -Path $pasta -Force }
                Write-Ok ("pasta pronta: {0}" -f $pasta)
                $eboot = Join-Path $pasta 'EBOOT.PBP'
                if (Test-Path -LiteralPath $eboot) {
                    $mb = [math]::Round((Get-Item -LiteralPath $eboot).Length / 1MB, 1)
                    Write-Ok ("EBOOT.PBP ja esta la ({0} MB)." -f $mb)
                    if ($mb -lt 20) { Write-Aviso 'tamanho abaixo do esperado (~30 MB). Pode estar incompleto.' }
                    [void](Get-HashArquivo -Caminho $eboot)
                }
                else {
                    Write-Aviso 'falta copiar o atualizador para dentro dessa pasta, com o nome EXATO EBOOT.PBP.'
                }
                if (Read-SimNao 'Abrir a pasta no Explorer?') { Start-Process explorer.exe $pasta }
            }
        }
        'link-psp' { Open-Links -Urls @('https://github.com/PSP-Archive/ARK-4/releases') }
        'copiar-ark' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if (-not $u) { break }
            $orig = (Read-Host '  Pasta extraida do ARK4.zip (ENTER para copiar a mao)').Trim('"', ' ')
            if (-not $orig) {
                Write-Host ''
                Write-Host '  A mao, no Explorer:'
                Write-Host ("    ARK_01234  -> {0}:\PSP\SAVEDATA\" -f $u)
                Write-Host ("    ARK_Loader -> {0}:\PSP\GAME\" -f $u)
                Write-Host ("    ARK_cIPL   -> {0}:\PSP\GAME\" -f $u)
                if (Read-SimNao 'Abrir as pastas de destino?') {
                    Start-Process explorer.exe ("{0}:\PSP\SAVEDATA" -f $u)
                    Start-Process explorer.exe ("{0}:\PSP\GAME" -f $u)
                }
                break
            }
            if (-not (Test-Path -LiteralPath $orig)) { Write-Erro 'pasta nao encontrada.'; break }
            $src = $orig
            if (Test-Path -LiteralPath (Join-Path $orig 'PSP\ARK_01234')) { $src = Join-Path $orig 'PSP' }
            if (-not (Test-Path -LiteralPath (Join-Path $src 'ARK_01234'))) {
                Write-Erro 'nao achei ARK_01234 ai dentro. Confira se extraiu o ZIP inteiro.'
                break
            }
            foreach ($d in @('PSP\SAVEDATA', 'PSP\GAME')) {
                $full = Join-Path ("{0}:\" -f $u) $d
                if (-not (Test-Path -LiteralPath $full)) { $null = New-Item -ItemType Directory -Path $full -Force }
            }
            [void](Copy-Pasta -Origem (Join-Path $src 'ARK_01234') -Destino ("{0}:\PSP\SAVEDATA\ARK_01234" -f $u) -Rotulo 'ARK_01234')
            foreach ($n in @('ARK_Loader', 'ARK_cIPL', 'DC-ARK')) {
                $o = Join-Path $src $n
                if (Test-Path -LiteralPath $o) {
                    [void](Copy-Pasta -Origem $o -Destino ("{0}:\PSP\GAME\{1}" -f $u, $n) -Rotulo $n)
                }
            }
            Write-Registro -Chave $chave -Texto ("ARK copiado de {0} para {1}:" -f $src, $u)
        }
        'conferir-ark' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) {
                $esp = @{
                    'PSP\SAVEDATA\ARK_01234'       = 'obrigatorio'
                    'PSP\GAME\ARK_Loader'          = 'obrigatorio'
                    'PSP\GAME\ARK_Loader\EBOOT.PBP'= 'obrigatorio'
                    'PSP\GAME\ARK_cIPL'            = 'opcional'
                    'PSP\GAME\DC-ARK'              = 'opcional'
                }
                [void](Test-ArquivosEsperados -Letra $u -Esperado $esp -Chave $chave)
            }
        }
        'psp-decidir' {
            Write-Host ''
            if (Read-SimNao 'Quer instalar o cIPL permanente agora (passo 19)?' $false) {
                Write-Registro -Chave $chave -Texto 'Usuario optou pelo cIPL permanente'
                Write-Ok 'siga para o passo 19.'
            }
            else {
                Write-Registro -Chave $chave -Texto 'Usuario optou por ficar na CFW temporaria'
                Write-Ok 'ficando na CFW temporaria. Pode fazer o cIPL depois: menu -> ir para o passo 19.'
                Write-Cor '  Sugestao: pule para o passo 21 (configuracao do ARK).' 'DarkGray'
            }
        }
        'psp-jogos' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) {
                $iso = "{0}:\ISO" -f $u
                if (-not (Test-Path -LiteralPath $iso)) { $null = New-Item -ItemType Directory -Path $iso -Force }
                Write-Ok ("pasta de jogos: {0}" -f $iso)
                $n = @(Get-ChildItem -LiteralPath $iso -File -ErrorAction SilentlyContinue).Count
                Write-Host ("  Arquivos ja presentes: {0}" -f $n)
                if (Read-SimNao 'Abrir a pasta ISO no Explorer?') { Start-Process explorer.exe $iso }
            }
        }
        'saves-psp' {
            $u = Get-UnidadeAlvo -Marcadores @('PSP', 'ISO') -Descricao 'o cartao do PSP'
            if ($u) {
                $orig = "{0}:\PSP\SAVEDATA" -f $u
                if (-not (Test-Path -LiteralPath $orig)) { Write-Erro 'nao achei PSP\SAVEDATA no cartao.'; break }
                $dest = Join-Path ([Environment]::GetFolderPath('Desktop')) ('Saves_PSP_' + (Get-Date -Format 'yyyy-MM-dd_HHmm'))
                if (Copy-Pasta -Origem $orig -Destino $dest -Rotulo 'saves do PSP') {
                    Write-Ok ("saves em: {0}" -f $dest)
                    Write-Registro -Chave $chave -Texto ("Saves do PSP copiados para {0}" -f $dest)
                }
            }
        }

        default { Write-Cor ("  (acao '{0}' nao implementada)" -f $Acao) 'DarkGray' }
    }
}

function Invoke-QuestTweaks {
    param([Parameter(Mandatory)] [string] $Chave)
    if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; return }
    Write-Host ''
    Write-Host '  Ajustes reversiveis (voltam ao padrao reiniciando o headset):'
    Write-Host '   [1] Taxa de atualizacao 90 Hz'
    Write-Host '   [2] Resolucao de textura 1.3x (mais nitido, custa desempenho)'
    Write-Host '   [3] CPU/GPU nivel 4 (maximo; esquenta e gasta bateria)'
    Write-Host '   [4] Guardian desligado (SO em espaco livre e seguro)'
    Write-Host '   [5] Voltar tudo ao padrao'
    Write-Host '   [0] Sair'
    Write-Host ''
    $r = (Read-Host '  Escolha').Trim()
    switch ($r) {
        '1' { [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.refreshRate', '90')); Write-Ok '90 Hz aplicado.' }
        '2' { [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.textureWidth', '1824'))
              [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.textureHeight', '1920')); Write-Ok 'textura 1.3x aplicada.' }
        '3' { [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.cpuLevel', '4'))
              [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.gpuLevel', '4')); Write-Ok 'CPU/GPU 4 aplicado.' }
        '4' { Write-Aviso 'sem Guardian voce pode bater em moveis e paredes. Use so em area livre.'
              if (Read-SimNao 'Desligar mesmo?' $false) {
                  [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.guardian_pause', '1')); Write-Ok 'Guardian pausado.'
              } }
        '5' { foreach ($p in @('debug.oculus.refreshRate', 'debug.oculus.textureWidth', 'debug.oculus.textureHeight',
                               'debug.oculus.cpuLevel', 'debug.oculus.gpuLevel', 'debug.oculus.guardian_pause')) {
                  [void](Invoke-Adb -Argumentos @('shell', 'setprop', $p, '0') -Silencioso)
              }
              Write-Ok 'valores zerados. Reinicie o headset para garantir o padrao.' }
        default { }
    }
    if ($r -in @('1', '2', '3', '4', '5')) { Write-Registro -Chave $Chave -Texto ("Tweak aplicado: opcao {0}" -f $r) }
}

function Invoke-QuestPerfil {
    param([Parameter(Mandatory)] [string] $Chave)
    if ((Test-QuestConectado) -ne 'ok') { Write-Aviso 'headset nao conectado.'; return }
    Write-Host ''
    Write-Host '   [1] Bateria     (72 Hz, textura padrao, CPU/GPU 2)'
    Write-Host '   [2] Equilibrado (90 Hz, textura padrao, CPU/GPU 3)'
    Write-Host '   [3] Maximo      (90 Hz, textura 1.3x,   CPU/GPU 4)'
    Write-Host '   [0] Sair'
    Write-Host ''
    $r = (Read-Host '  Perfil').Trim()
    $perfis = @{
        '1' = @{ hz = '72'; tw = '0';    th = '0';    cpu = '2'; gpu = '2' }
        '2' = @{ hz = '90'; tw = '0';    th = '0';    cpu = '3'; gpu = '3' }
        '3' = @{ hz = '90'; tw = '1824'; th = '1920'; cpu = '4'; gpu = '4' }
    }
    if (-not $perfis.ContainsKey($r)) { return }
    $p = $perfis[$r]
    [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.refreshRate', $p['hz']) -Silencioso)
    [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.textureWidth', $p['tw']) -Silencioso)
    [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.textureHeight', $p['th']) -Silencioso)
    [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.cpuLevel', $p['cpu']) -Silencioso)
    [void](Invoke-Adb -Argumentos @('shell', 'setprop', 'debug.oculus.gpuLevel', $p['gpu']) -Silencioso)
    Write-Ok ("perfil {0} aplicado. Reiniciar o headset volta ao padrao." -f $r)
    Write-Registro -Chave $Chave -Texto ("Perfil de desempenho {0} aplicado" -f $r)
}

function Open-Links {
    param([Parameter(Mandatory)] [string[]] $Urls)
    foreach ($u in $Urls) {
        if (Read-SimNao ("Abrir {0} no navegador?" -f $u)) {
            try { Start-Process $u }
            catch { Write-Erro ("nao consegui abrir: {0}" -f $_.Exception.Message) }
        }
    }
}

# ---------------------------------------------------------------------------
# Motor: mostrar passo, navegar, menus
# ---------------------------------------------------------------------------

function Show-Passo {
    param(
        [Parameter(Mandatory)] [hashtable] $G,
        [Parameter(Mandatory)] [hashtable] $P
    )
    $total = @($G['Passos']).Count
    Clear-Host
    Write-Titulo ("PASSO {0} de {1}  -  {2}" -f $P['N'], $total, $P['T'])

    if ($P.ContainsKey('F') -and $P['F']) {
        Write-Cor '  >>> ESTE PASSO TEM ACAO FISICA NO APARELHO <<<' 'Magenta'
        Write-Host ''
    }
    foreach ($l in @($P['L'])) { Write-Host ("  {0}" -f $l) }

    if ($P.ContainsKey('A')) {
        Write-Host ''
        Write-Cor '  --- parte automatica ---' 'DarkCyan'
        try { Invoke-Acao -Acao ([string]$P['A']) -G $G }
        catch { Write-Erro ("a parte automatica falhou: {0}" -f $_.Exception.Message) }
    }
}

function Show-Lista {
    param([Parameter(Mandatory)] [hashtable] $G)
    Clear-Host
    Write-Titulo ("PASSOS - {0}" -f $G['Nome'])
    foreach ($p in @($G['Passos'])) {
        $marca = '  '
        if ($p.ContainsKey('F') -and $p['F']) { $marca = ' *' }
        Write-Host ("  {0,2}{1}  {2}" -f $p['N'], $marca, $p['T'])
    }
    Write-Host ''
    Write-Cor '  (* = tem acao fisica no aparelho)' 'DarkGray'
    Wait-Tecla
}

function Show-Texto {
    param(
        [Parameter(Mandatory)] [string]   $Titulo,
        [Parameter(Mandatory)] [string[]] $Linhas
    )
    Clear-Host
    Write-Titulo $Titulo
    foreach ($l in $Linhas) { Write-Host ("  {0}" -f $l) }
    Wait-Tecla
}

function Show-Registro {
    param([Parameter(Mandatory)] [string] $Chave)
    Clear-Host
    $arq = Get-CaminhoRegistro -Chave $Chave
    Write-Titulo ("REGISTRO - {0}" -f $arq)
    if (Test-Path -LiteralPath $arq) { Get-Content -LiteralPath $arq -Encoding UTF8 | ForEach-Object { Write-Host ("  {0}" -f $_) } }
    else { Write-Host '  Ainda nao ha registro.' }
    Wait-Tecla
}

function Invoke-Guia {
    param(
        [Parameter(Mandatory)] [string] $Chave,
        [int] $Inicio = 0
    )
    $G = $script:Guias[$Chave]
    $passos = @($G['Passos'])
    $total = $passos.Count
    $script:GuiaAtual = $Chave

    $salvo = Get-Progresso -Chave $Chave
    $atual = $Inicio
    if ($atual -lt 1) {
        $atual = 1
        if ($salvo -ge 1 -and $salvo -lt $total) {
            Write-Host ''
            Write-Cor ("  Progresso salvo: voce parou no passo {0} de {1}." -f $salvo, $total) 'Yellow'
            if (Read-SimNao ("Continuar do passo {0}?" -f ($salvo + 1))) { $atual = $salvo + 1 }
        }
    }

    while ($true) {
        if ($atual -lt 1) { $atual = 1 }
        if ($atual -gt $total) { Show-Conclusao -G $G; return }

        $p = $passos | Where-Object { [int]$_['N'] -eq $atual } | Select-Object -First 1
        if (-not $p) { Write-Erro ("passo {0} nao existe." -f $atual); return }

        Show-Passo -G $G -P $p
        Save-Progresso -Chave $Chave -Numero $atual
        Write-Registro -Chave $Chave -Texto ("Passo {0}/{1}: {2}" -f $atual, $total, $p['T'])

        Write-Host ''
        Write-Cor (' ' + ('-' * 90)) 'DarkGray'
        Write-Host ("  Passo {0} de {1} registrado." -f $atual, $total)
        Write-Host '  [S] proximo   [A] anterior   [R] repetir   [N] ir para o numero'
        Write-Host '  [E] erros     [D] desfazer   [L] links     [G] registro   [M] menu   [Q] sair'
        Write-Host ''
        $r = (Read-Host '  Escolha').Trim().ToUpper()
        if ($r -eq '') { $r = 'S' }

        switch ($r) {
            'S' { $atual++ }
            'A' { if ($atual -gt 1) { $atual-- } }
            'R' { }
            'N' {
                $n = (Read-Host ("  Numero do passo (1-{0})" -f $total)).Trim()
                if ($n -match '^\d+$') {
                    $ni = [int]$n
                    if ($ni -ge 1 -and $ni -le $total) { $atual = $ni }
                    else { Write-Erro 'fora da faixa.'; Start-Sleep -Seconds 1 }
                }
            }
            'E' { Show-Texto -Titulo 'ERROS COMUNS E COMO CORRIGIR' -Linhas @($G['Erros']) }
            'D' { Show-Texto -Titulo 'COMO DESFAZER' -Linhas @($G['Desfazer']) }
            'L' { Open-Links -Urls @($G['Links']) }
            'G' { Show-Registro -Chave $Chave }
            'M' { return }
            'Q' { exit 0 }
            default { }
        }
    }
}

function Show-Conclusao {
    param([Parameter(Mandatory)] [hashtable] $G)
    Clear-Host
    Write-Titulo ("CONCLUIDO - {0}" -f $G['Nome'])
    Write-Ok 'voce chegou ao fim do guia.'
    Write-Host ''
    Write-Host '  Guarde, na mesma pasta deste script:'
    Write-Host ("    {0}" -f (Get-CaminhoProgresso -Chave ([string]$G['Chave'])))
    Write-Host ("    {0}" -f (Get-CaminhoRegistro -Chave ([string]$G['Chave'])))
    Write-Host ''
    Write-Host '  Se algo nao ficou certo, volte ao guia e use [E] erros ou [D] desfazer.'
    Wait-Tecla
}

function Show-MenuGuia {
    param([Parameter(Mandatory)] [string] $Chave)
    $G = $script:Guias[$Chave]
    while ($true) {
        Clear-Host
        Write-Titulo $G['Nome']
        $total = @($G['Passos']).Count
        $salvo = Get-Progresso -Chave $Chave
        if ($salvo -ge 1) { Write-Cor ("  Progresso salvo: passo {0} de {1}." -f $salvo, $total) 'Yellow'; Write-Host '' }
        Write-Host '   [1] Comecar / continuar'
        Write-Host '   [2] Lista de passos'
        Write-Host '   [3] Ir para um passo'
        Write-Host '   [4] Erros comuns'
        Write-Host '   [5] Como desfazer'
        Write-Host '   [6] Links oficiais'
        Write-Host '   [7] Ver o registro'
        Write-Host '   [8] Apagar o progresso salvo'
        Write-Host '   [0] Voltar'
        Write-Host ''
        $r = (Read-Host '  Escolha').Trim()
        switch ($r) {
            '1' { Invoke-Guia -Chave $Chave }
            '2' { Show-Lista -G $G }
            '3' {
                $n = (Read-Host ("  Numero do passo (1-{0})" -f $total)).Trim()
                if ($n -match '^\d+$') {
                    $ni = [int]$n
                    if ($ni -ge 1 -and $ni -le $total) { Invoke-Guia -Chave $Chave -Inicio $ni }
                }
            }
            '4' { Show-Texto -Titulo 'ERROS COMUNS E COMO CORRIGIR' -Linhas @($G['Erros']) }
            '5' { Show-Texto -Titulo 'COMO DESFAZER' -Linhas @($G['Desfazer']) }
            '6' { Open-Links -Urls @($G['Links']) }
            '7' { Show-Registro -Chave $Chave }
            '8' { Clear-Progresso -Chave $Chave; Wait-Tecla }
            '0' { return }
            default { }
        }
    }
}

function Show-MenuPrincipal {
    while ($true) {
        Clear-Host
        Write-Titulo 'GUIAS INTERATIVOS DE DESBLOQUEIO'
        Write-Host '  Cada guia conduz passo a passo, pede confirmacao em toda acao fisica,'
        Write-Host '  salva o progresso e faz no PC a parte que da para automatizar.'
        Write-Host ''
        Write-Host '   [1] New Nintendo 3DS XL  - boot9strap + Luma3DS           (30 passos)'
        Write-Host '   [2] Meta Quest 3S        - Modo Desenvolvedor + sideload  (18 passos)'
        Write-Host '   [3] Meta Quest 3S        - emuladores, jogos e apps       (26 passos)'
        Write-Host '   [4] PSP                  - CFW ARK-4 + cIPL permanente    (24 passos)'
        Write-Host ''
        Write-Host '   [5] Ferramentas de PC (sem seguir guia)'
        Write-Host '   [6] Autoverificacao do script'
        Write-Host '   [0] Sair'
        Write-Host ''
        Write-Cor '  Ordem sugerida para o Quest: faca o [2] antes do [3].' 'DarkGray'
        Write-Host ''
        $r = (Read-Host '  Escolha').Trim()
        switch ($r) {
            '1' { Show-MenuGuia -Chave '3ds' }
            '2' { Show-MenuGuia -Chave 'quest' }
            '3' { Show-MenuGuia -Chave 'quest-emu' }
            '4' { Show-MenuGuia -Chave 'psp' }
            '5' { Show-Ferramentas }
            '6' { [void](Invoke-SelfTest); Wait-Tecla }
            '0' { return }
            default { }
        }
    }
}

function Show-Ferramentas {
    while ($true) {
        Clear-Host
        Write-Titulo 'FERRAMENTAS DE PC'
        Write-Host '   [1] Listar unidades e escolher a do console'
        Write-Host '   [2] Conferir sistema de arquivos e espaco'
        Write-Host '   [3] Backup completo de uma unidade'
        Write-Host '   [4] Criar estrutura de pastas do PSP'
        Write-Host '   [5] Criar estrutura de pastas do 3DS'
        Write-Host '   [6] SHA256 de um arquivo (BIOS, keys, firmware)'
        Write-Host '   [7] Diagnostico ADB (Meta Quest)'
        Write-Host '   [8] Abrir a unidade escolhida no Explorer'
        Write-Host '   [0] Voltar'
        Write-Host ''
        $r = (Read-Host '  Escolha').Trim()
        switch ($r) {
            '1' { [void](Get-UnidadeAlvo -Marcadores @('PSP', 'Nintendo 3DS', 'ISO') -Forcar); Wait-Tecla }
            '2' { $u = Get-UnidadeAlvo; if ($u) { [void](Test-SistemaArquivos -Letra $u) }; Wait-Tecla }
            '3' { $u = Get-UnidadeAlvo; if ($u) { [void](Backup-Unidade -Letra $u -Prefixo 'Backup_Console' -Chave 'geral') }; Wait-Tecla }
            '4' { $u = Get-UnidadeAlvo -Marcadores @('PSP')
                  if ($u) { [void](New-EstruturaPastas -Letra $u -Chave 'geral' -Pastas @('ISO','PSP','PSP\GAME','PSP\SAVEDATA','PSP\CHEATS','MUSIC','PICTURE','VIDEO','SEPLUGINS')) }
                  Wait-Tecla }
            '5' { $u = Get-UnidadeAlvo -Marcadores @('Nintendo 3DS')
                  if ($u) { [void](New-EstruturaPastas -Letra $u -Chave 'geral' -Pastas @('luma','luma\payloads','3ds','cias','gm9')) }
                  Wait-Tecla }
            '6' { $c = (Read-Host '  Caminho do arquivo').Trim('"', ' '); if ($c) { [void](Get-HashArquivo -Caminho $c) }; Wait-Tecla }
            '7' { Show-DiagnosticoAdb; Wait-Tecla }
            '8' { if (-not $script:Unidade) { [void](Get-UnidadeAlvo) }
                  if ($script:Unidade) { Start-Process explorer.exe ("{0}:\" -f $script:Unidade) }
                  Wait-Tecla }
            '0' { return }
            default { }
        }
    }
}

# ---------------------------------------------------------------------------
# Autoverificacao
# ---------------------------------------------------------------------------

function Invoke-SelfTest {
    Clear-Host
    Write-Titulo 'AUTOVERIFICACAO DO SCRIPT'

    function Test-Item {
        param([string] $Nome, [bool] $Ok, [string] $Detalhe = '')
        $script:stTestes++
        if ($Ok) { Write-Cor ("  PASS  {0}" -f $Nome) 'Green' }
        else {
            Write-Cor ("  FAIL  {0}{1}" -f $Nome, $(if ($Detalhe) { " - $Detalhe" } else { '' })) 'Red'
            $script:stFalhas++
        }
    }

    $script:stTestes = 0
    $script:stFalhas = 0

    # 1. versao do PowerShell
    Test-Item 'PowerShell 5.1 ou maior' ($PSVersionTable.PSVersion.Major -ge 5) ("versao {0}" -f $PSVersionTable.PSVersion)

    # 2. funcoes essenciais existem
    foreach ($f in @('Write-Cor','Write-Titulo','Wait-Tecla','Read-SimNao','Save-Progresso','Get-Progresso',
                     'Get-UnidadesCandidatas','Get-UnidadeAlvo','Test-SistemaArquivos','Backup-Unidade',
                     'New-EstruturaPastas','Test-ArquivosEsperados','Copy-Pasta','Get-HashArquivo',
                     'Get-Adb','Invoke-Adb','Test-QuestConectado','Show-DiagnosticoAdb','Invoke-Acao',
                     'Invoke-QuestTweaks','Invoke-QuestPerfil','Open-Links','Show-Passo','Invoke-Guia',
                     'Show-MenuGuia','Show-MenuPrincipal','Show-Ferramentas')) {
        Test-Item ("funcao {0}" -f $f) ([bool](Get-Command $f -ErrorAction SilentlyContinue))
    }

    # 3. estrutura dos guias
    $esperado = @{ '3ds' = 30; 'quest' = 18; 'quest-emu' = 26; 'psp' = 24 }
    foreach ($k in $esperado.Keys) {
        $ok = $script:Guias.Contains($k)
        Test-Item ("guia '{0}' existe" -f $k) $ok
        if (-not $ok) { continue }
        $G = $script:Guias[$k]
        $passos = @($G['Passos'])
        Test-Item ("guia '{0}' tem {1} passos" -f $k, $esperado[$k]) ($passos.Count -eq $esperado[$k]) ("achei {0}" -f $passos.Count)

        # numeracao 1..N sem buraco e sem repetido
        $nums = @($passos | ForEach-Object { [int]$_['N'] } | Sort-Object)
        $seq = @(1..$esperado[$k])
        Test-Item ("guia '{0}' numerado 1..{1}" -f $k, $esperado[$k]) (-not (Compare-Object $nums $seq))

        # todo passo tem titulo e texto
        $semTitulo = @($passos | Where-Object { -not $_.ContainsKey('T') -or -not $_['T'] }).Count
        Test-Item ("guia '{0}' todos com titulo" -f $k) ($semTitulo -eq 0) ("{0} sem titulo" -f $semTitulo)
        $semTexto = @($passos | Where-Object { -not $_.ContainsKey('L') -or @($_['L']).Count -eq 0 }).Count
        Test-Item ("guia '{0}' todos com texto" -f $k) ($semTexto -eq 0) ("{0} sem texto" -f $semTexto)

        # secoes auxiliares
        foreach ($s in @('Erros', 'Desfazer', 'Links', 'Nome', 'Chave')) {
            Test-Item ("guia '{0}' tem secao {1}" -f $k, $s) ($G.ContainsKey($s) -and $G[$s])
        }
    }

    # 4. toda acao citada nos passos tem tratamento no dispatcher
    $acoesConhecidas = @(
        'backup-3ds','fs-3ds','pastas-3ds','conferir-3ds','copiar-nand','link-3ds',
        'adb-instalar','adb-diag','adb-wifi','quest-backup','quest-tweaks','quest-perf',
        'quest-pastas','quest-push','quest-saves','quest-pacotes','hash',
        'psp-modelo','psp-risco','unidade-psp','backup-psp','fs-psp','pastas-psp',
        'psp-update','link-psp','copiar-ark','conferir-ark','psp-decidir','psp-jogos','saves-psp'
    )
    $usadas = New-Object System.Collections.ArrayList
    foreach ($k in $script:Guias.Keys) {
        foreach ($p in @($script:Guias[$k]['Passos'])) {
            if ($p.ContainsKey('A')) { [void]$usadas.Add([string]$p['A']) }
        }
    }
    $desconhecidas = @($usadas | Where-Object { $acoesConhecidas -notcontains $_ } | Sort-Object -Unique)
    Test-Item 'todas as acoes dos passos sao conhecidas' ($desconhecidas.Count -eq 0) ("desconhecidas: {0}" -f ($desconhecidas -join ', '))

    # 5. escrita no disco (progresso e registro) num arquivo de teste
    try {
        Save-Progresso -Chave 'selftest' -Numero 7
        $lido = Get-Progresso -Chave 'selftest'
        Test-Item 'salvar e ler o progresso' ($lido -eq 7) ("li {0}" -f $lido)
        Write-Registro -Chave 'selftest' -Texto 'autoverificacao'
        Test-Item 'escrever no registro' (Test-Path -LiteralPath (Get-CaminhoRegistro -Chave 'selftest'))
    }
    catch {
        Test-Item 'salvar e ler o progresso' $false $_.Exception.Message
    }
    finally {
        foreach ($f in @((Get-CaminhoProgresso -Chave 'selftest'), (Get-CaminhoRegistro -Chave 'selftest'))) {
            if (Test-Path -LiteralPath $f) { Remove-Item -LiteralPath $f -Force -ErrorAction SilentlyContinue }
        }
    }

    # 6. ferramentas externas (aviso, nao falha)
    Write-Host ''
    foreach ($exe in @('robocopy', 'winget', 'explorer')) {
        if (Get-Command $exe -ErrorAction SilentlyContinue) { Write-Cor ("  info  {0} disponivel" -f $exe) 'DarkGray' }
        else { Write-Cor ("  info  {0} NAO encontrado (so faz falta nas acoes que o usam)" -f $exe) 'Yellow' }
    }
    if (Get-Adb -Silencioso) { Write-Cor '  info  adb disponivel' 'DarkGray' }
    else { Write-Cor '  info  adb NAO encontrado (so faz falta nos guias do Quest)' 'Yellow' }

    Write-Host ''
    if ($script:stFalhas -eq 0) {
        Write-Cor ("  RESULTADO: {0} verificacoes, 0 falha." -f $script:stTestes) 'Green'
    }
    else {
        Write-Cor ("  RESULTADO: {0} verificacoes, {1} FALHA(S)." -f $script:stTestes, $script:stFalhas) 'Red'
    }
    return ($script:stFalhas -eq 0)
}

# ---------------------------------------------------------------------------
# Entrada
# ---------------------------------------------------------------------------

if ($Listar) {
    foreach ($k in $script:Guias.Keys) {
        $G = $script:Guias[$k]
        Write-Host ''
        Write-Host ("=== {0}  ({1})" -f $G['Nome'], $k)
        foreach ($p in @($G['Passos'])) {
            $marca = ' '
            if ($p.ContainsKey('F') -and $p['F']) { $marca = '*' }
            Write-Host ("  {0,2}{1} {2}" -f $p['N'], $marca, $p['T'])
        }
    }
    Write-Host ''
    Write-Host '(* = acao fisica no aparelho)'
    exit 0
}

if ($SelfTest) {
    $ok = Invoke-SelfTest
    if ($ok) { exit 0 } else { exit 1 }
}

if ($Guia) {
    if ($Passo -gt 0) { Invoke-Guia -Chave $Guia -Inicio $Passo }
    else { Show-MenuGuia -Chave $Guia }
    exit 0
}

Show-MenuPrincipal
Write-Host ''
Write-Cor '  Ate logo. O progresso ficou salvo nos arquivos progresso-*.json.' 'DarkGray'
