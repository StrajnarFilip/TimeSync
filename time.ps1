Start-Transcript -Path "$PSScriptRoot\transcript.txt"

while ($true) {
    try {
        $rawJson = $(Invoke-WebRequest -Uri "https://worldtimeapi.org/api/timezone/Europe/London" -UseBasicParsing).Content
        $datetimeString = [System.Text.Json.JsonDocument]::Parse($rawJson).RootElement.GetProperty("datetime").GetString()
        $accurateDateTime = ([System.DateTime]::Parse($datetimeString))
        Set-Date -Date $accurateDateTime
        Add-Content -Value $accurateDateTime -Path "$PSScriptRoot\log.txt"
    }
    catch {}
    Start-Sleep -Seconds 60
}
