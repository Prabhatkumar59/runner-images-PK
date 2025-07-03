####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

# Skip install and test on Windows Server 2025
$osVersion = (Get-CimInstance Win32_OperatingSystem).Version
if ($osVersion -like "10.0.25*") {
    Write-Host "Skipping Cosmos DB Emulator install on Windows Server 2025 – not supported."
    return
}

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
