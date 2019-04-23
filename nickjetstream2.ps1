#先手动把jetstream 2的网页结果保存为html，再用此脚本转为excel。

$c1 = cat '.\JetStream 2.html' |  Select-String "benchmark-name"
$c2 = cat '.\JetStream 2.html' |  Select-String 'h4 class="score"'
$i=0
$j=0
$lie1=@()
$lie2=@()
$reg1 = ">[A-Za-z0-9.-]+</a>"
$reg2 = ">[0-9.]+</h4><p>"

foreach($line in $c1){
	if($line -match $reg1){
	$matches[0] -match "[A-Za-z0-9.-]+" > $null
	#Write-output $matches[0] >>t1.txt
	$lie1 += $matches[0]
	#$temp =echo $c2 | Select-String $matches[0]
	#$temp -match $reg2
	#$matches[0]
	#$matches[0]>>test1.csv;
	#echo ",">>test1.csv
	$i++;
	}

}
#$i
#$lie1
foreach($line in $c2){
	if($line -match $reg2){
	$matches[0] -match "[0-9.]+" > $null
	$lie2 += $matches[0]
	#Write-output $matches[0]>>t2.txt
	$j++;
	}
}
#$j


$xl = new-object -comobject excel.application
$xl.Visible = $true
$wb = $xl.Workbooks.Add()
$ws = $wb.Worksheets.Item(1)
$row = 1
foreach ($line in $lie1)
{
	$ws.Cells.Item($row,1) = $line;
	$row++
}
$row = 1
foreach ($line in $lie2)
{
	$ws.Cells.Item($row,2) = $line;
	$row++
}



#$a = Get-Content t1.txt 

#Write-Host $a
#$b = Get-Content t2.txt
#Write-Host $b
#$c = $a + $b
#Write-Host $c