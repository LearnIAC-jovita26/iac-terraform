# sjekk.ps1 - kjører de samme sjekkene som pipelinen, i fast rekkefølge.
# Stopper ved første feil.
$ErrorActionPreference = "Stop"
Push-Location (Join-Path $PSScriptRoot "modules/network")

function Kjor {
    param([string]$Navn, [scriptblock]$Kommando)
    Write-Host "==> $Navn" -ForegroundColor Cyan
    & $Kommando
    if ($LASTEXITCODE -ne 0) {
        Write-Host "FEILET: $Navn" -ForegroundColor Red
        Pop-Location
        exit 1
    }
}

Kjor "terraform fmt"      { terraform fmt -check -recursive }
Kjor "terraform init"     { terraform init -backend=false -input=false }
Kjor "terraform validate" { terraform validate }
Kjor "tflint"             { tflint --init; tflint }
Kjor "checkov"            { checkov --config-file .checkov.yaml }
Kjor "terraform test"     { terraform test }

Pop-Location
Write-Host "OK: alle sjekker er grønne" -ForegroundColor Green
exit 0
