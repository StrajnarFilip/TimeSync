Start-Transcript -Path "$PSScriptRoot\transcript.txt"

while ($true) {
    try {
        $RawJson = (Invoke-WebRequest "https://clock.zone/_/_offset").Content
        $Timestamp = [System.Text.Json.JsonDocument]::Parse($RawJson).RootElement.GetProperty("val").GetInt64()
        $DateTimeFresh = [System.DateTime]::new(1970, 1, 1, 0, 0, 0, 0, [System.DateTimeKind]::Utc);
        $DateTimeNow = $DateTimeFresh.AddMilliseconds($Timestamp)
        Set-Date -Date $DateTimeNow.ToLocalTime()
    }
    catch {
    }
    Start-Sleep -Seconds 60
}
