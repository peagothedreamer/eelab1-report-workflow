$ErrorActionPreference = 'Stop'

# Inject fonts into every directory that contains config.cls, create working
# subdirectories, and check the toolchain.

$root = $PSScriptRoot
$fontSrc = Join-Path $env:WINDIR 'Fonts'
$boldSrc = Join-Path $root 'assets/fonts/simsunBold.otf'
$systemFonts = @('simsun.ttc', 'simkai.ttf')

if (-not (Test-Path $boldSrc)) {
    throw "Missing $boldSrc"
}

$targets = Get-ChildItem -Path $root -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'config.cls') }

if (-not $targets) {
    throw "No directory with config.cls found under $root"
}

foreach ($target in $targets) {
    $fontDir = Join-Path $target.FullName 'local-fonts'
    New-Item -ItemType Directory -Force -Path $fontDir | Out-Null

    foreach ($font in $systemFonts) {
        $src = Join-Path $fontSrc $font
        if (Test-Path $src) {
            Copy-Item $src (Join-Path $fontDir $font) -Force
        }
        else {
            Write-Warning "System font not found: $src"
        }
    }
    Copy-Item $boldSrc (Join-Path $fontDir 'simsunBold.otf') -Force

    foreach ($sub in @('data/raw', 'data/processed', 'figures', 'src', 'Rst')) {
        New-Item -ItemType Directory -Force -Path (Join-Path $target.FullName $sub) | Out-Null
    }
    Write-Host "fonts -> $($target.Name)"
}

if (Get-Command latexmk -ErrorAction SilentlyContinue) {
    Write-Host "latexmk: $((Get-Command latexmk).Source)"
}
else {
    Write-Warning "latexmk not in PATH. Add TeX Live bin/windows to PATH."
}

if (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Host "python: $((Get-Command python).Source)"
}
else {
    Write-Warning "python not in PATH (only needed for data processing)."
}

Write-Host "Done."
