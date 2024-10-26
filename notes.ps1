##Lops
##For loop
#For each
#while
#switch
<#
for (init; conditon; ++/-- )
{
do something
}
#>

for ($a=0; $a -lt 5; $a++)
{
Write-Host "$a"
}

$a= Read-Host "Enter the service names"
$b= $a.split(",")
for ($i=0; $i -lt $b.Count; $i ++ )
{
get-service -Name $b[$i] | Select-Object Name, status
}


<#
$a= Read-Host "Enter the service names"
$b= $a.split(",")
foreach ($i in $b)
{
get-service -Name $i | Select-Object Name, status
}
#>
$serverlist = get-content "C:\temp\ServerList.txt"
foreach ($i in $serverlist)
{
get-service -Name *vss* -ComputerName $i | Select-Object Name, status
}



function get-myservice {
get-service | select Name, Status
}


function get-mylogs {
param(
$logname =''
)
Get-EventLog -LogName $logname -EntryType Error -Newest 10 | select id,Source,Message | Format-List
}



function get-mylogs {
param(
$logname =''
)
If ($logname -eq 'Sys')
{
Get-EventLog -LogName system -EntryType Error -Newest 10 | select id,Source,Message | Format-List
}

elseif ($logname -eq 'App')
{
Get-EventLog -LogName application -EntryType Error -Newest 10 | select id,Source,Message | Format-List
}
}



function get-mylogs {
param(
[parameter]
$logname =''
)
If ($logname -eq 'Sys')
{
Get-EventLog -LogName system -EntryType Error -Newest 10 | select id,Source,Message | Format-List
}

elseif ($logname -eq 'App')
{
Get-EventLog -LogName application -EntryType Error -Newest 10 | select id,Source,Message | Format-List
}
}



function get-mylogsv2 {
    [CmdletBinding()]
    param(
    [Parameter(mandatory)]
    $logname
    )
    If ($logname -eq 'Sys')
    {
    Write-Verbose "User entered value is $logname"
    Get-EventLog -LogName system -EntryType Error -Newest 10 | select id,Source,Message | Format-List
    }
    
    elseif ($logname -eq 'App')
    {
        Write-Verbose "User entered value is $logname"
    Get-EventLog -LogName application -EntryType Error -Newest 10 | select id,Source,Message | Format-List
    }
    }


function get-mylogs {
param(
$logname =''
)
Get-EventLog -LogName $logname -EntryType Error -Newest 10 | select id,Source,Message | Format-List
}



function get-myservicev2
{
[CmdletBinding()]
$a='vss1'
<#
try{
#do something
}
catch{
#do something
}
#>
try {
Write-Verbose "The service name is $a"
get-service -name $a -ErrorAction stop
}
catch {
Write-Warning "The Service name entered is $a"
Write-Verbose "The service name is $a"
Write-Host "Please enter a valid service" -ForegroundColor Red
}
}


function Test-PingHosts {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InputFile,   # Path to a text file with hostnames/IPs (one per line)
        
        [Parameter(Mandatory=$true)]
        [string]$ReportFile   # Path where the report will be saved
    )

    if (-not (Test-Path $InputFile)) {
        Write-Error "Input file not found: $InputFile"
        return
    }

    # Initialize report
    "=Ping Report - $(Get-Date)" | Out-File $ReportFile
    "========================== Ping Report ==========================" | Out-File $ReportFile
    "================== Date: $(Get-Date) ==========================" | Out-File $ReportFile -Append

    # Read hosts from input file
    $hostnames = Get-Content $InputFile
    foreach ($hostname in $hostnames) {
        # Test ping
        $pingResult = Test-Connection -ComputerName $hostname -Count 1 -Quiet
        if ($pingResult -eq $true) {
            "$hostname is Online" | Out-File $ReportFile -Append
        } else {
            "$hostname is Offline" | Out-File $ReportFile -Append
        }
    }

    Write-Host "Ping report saved to $ReportFile"
}


# Example usage:
#Test-PingHosts -InputFile "C:\temp\hosts.txt" -ReportFile "C:\temp\PingReport.txt"
