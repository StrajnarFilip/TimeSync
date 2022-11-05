Start-Transcript -Path "$PSScriptRoot\transcript.txt"

while ($true) {
    try {
        $rawJson = $(Invoke-WebRequest -Uri "https://clock.zone/_/_offset" -UseBasicParsing).Content
        $unixEpoch = [System.Text.Json.JsonDocument]::Parse($rawJson).RootElement.GetProperty("val").GetInt64()
        $accurateDateTime = ([System.DateTimeOffset]::FromUnixTimeMilliseconds($unixEpoch)).LocalDateTime
        Set-Date -Date $accurateDateTime
    }
    catch {}
    Start-Sleep -Seconds 60
}