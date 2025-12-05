if ($args.Count -ne 1) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <sample.txt | input.txt> for day5"
    exit
}


$ingredientRange = @()
[System.Int64[]]$ingredientIds = @()

$startOfIds = 0

$file = Get-Content -Path $args[0]

#Write-Host $fileLength

# fill in arrays
for ($i = 0; $i -lt $file.Count; $i++) {
    if ($file[$i] -eq "") {
        # read the ranges up to the ""
        $startOfIds = $i + 1
        break
    }
    $ingredientRange += $file[$i]
}

# the rest go into the id array
for ($j = $startOfIds; $j -lt $file.Count; $j++) {
    $ingredientIds += [System.Int64]::Parse($file[$j])
}

[System.Int64]$start = 0
[System.Int64]$end = 0
[System.Int64]$fresh = 0

$idHashSet = [System.Collections.Generic.HashSet[System.Int64]]::new()
# foreach range
foreach($range in $ingredientRange) {
    $start, $end = $range.Split("-")
    $start = [System.Int64]::Parse($start)
    $end = [System.Int64]::Parse($end)
    foreach($id in $ingredientIds) {
        if ($id -ge $start -and $id -le $end) {
            if ($idHashSet.Add($id) -eq "True") {
                $fresh += 1
            }
        }
    }

}
#Write-Host $fresh

$freshIdHashSet = [System.Collections.Generic.HashSet[System.Int64]]::new()
[System.Int64]$freshIds = 0
foreach($range in $ingredientRange) {
    $start, $end = $range.Split("-")
    $start = $start -as [System.Int64]
    $end = $end -as [System.Int64]
    #foreach($x in $start..$end) {
    for ($x = $start; $x -le $end; $x++) {
        #if ($id -ge $start -and $id -le $end) {
        if ($freshIdHashSet.Add($x) -eq "True") {
            Write-Host $x
            $freshIds += 1
        }
    }
}
Write-Host $freshIds
#$freshIdHashSet