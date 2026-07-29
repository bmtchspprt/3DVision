param(
  [string]$ResFile = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\3DVisionGui.g.resources"
)

$reader = New-Object System.Resources.ResourceReader($ResFile)
$enum = $reader.GetEnumerator()
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  $val = $enum.Value
  $type = if ($null -eq $val) { 'null' } else { $val.GetType().FullName }
  $extra = ''
  if ($val -is [byte[]]) { $extra = " len=$($val.Length) head=$($val[0..3] -join ',')" }
  Write-Output "$key | $type$extra"
}
$reader.Close()
