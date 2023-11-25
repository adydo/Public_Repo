
param(
    [Parameter()] 
    [String]$path
)

#$path = "c:\temp\test.csv"

$sito = "https://api.country.is/"
$geo_track = @()


Import-Csv $path | Foreach-Object { 

     $ip = $_.PSObject.Properties.Value
     $uri = $sito + $ip
     Start-Sleep -m 500
try{
     $response = Invoke-RestMethod $uri 
}
catch{
    $response.ip = $ip
    $response.country = 'Not Available' 
}

     $geo_track += [PSCustomObject]@{
            IP = $response.ip
            Country = $response.country
     }
}

$geo_track | Format-Table
