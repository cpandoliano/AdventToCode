$freshIdHashSet = [System.Collections.Generic.HashSet[System.Int64]]::new()
#$numberRange = 
435767821168977
435767821168988
534942781913367
534257831069231
[System.Int64] $start = 435767821168977
[System.Int64] $end = 435767821168988
$start = $start -as [System.Int64]
$end = $end -as [System.Int64]
[System.Linq.Enumerable]::Range($start, $end)
if ($freshIdHashSet.Add($numberRange) -eq "True") {
    #Write-Host $numberRange
    Write-Host "yes"
    $freshIds += 1
}
# $freshIdHashSet = [System.Collections.Generic.HashSet[System.Int64]]::new()
# [System.Int64]$freshIds = 0
# foreach($range in $ingredientRange) {
#     $start, $end = $range.Split("-")
#     $start = $start -as [System.Int64]
#     $end = $end -as [System.Int64]
#     #foreach($x in $start..$end) {
#     for ($x = $start; $x -le $end; $x++) {
#         #if ($id -ge $start -and $id -le $end) {
#         if ($freshIdHashSet.Add($x) -eq "True") {
#             Write-Host $x
#             $freshIds += 1
#         }
#     }
# }
# Write-Host $freshIds