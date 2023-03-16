# Copy newest file from src to dest folder after nightly backup
$sourcePath = "C:\DATA\Share\"
$destPath = "C:\DATA\Target\"

$sourceFile = Get-ChildItem -File $sourcePath | Sort-Object LastWriteTime -Desc | Select-Object -First 1
Copy-Item $sourcePath$sourceFile $destPath