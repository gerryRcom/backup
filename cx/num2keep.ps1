# Run against a backup target folder to keep things tidy
$targetFolder = "C:\DATA\Target"
$num2keep = 5

Get-ChildItem $targetFolder| Sort-Object LastWriteTime -Desc | Select-Object -Skip $num2keep | Remove-Item