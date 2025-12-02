function InvalidIdPartOne {
    param ( 
        [int64] $start,
        [int64] $end
    )

    $invalidIdTotal = 0
    for ($j = $startRange; $j -le $endRange; $j++) {
        if ($j -match "\b(\d+)\1\b") {
            $invalidIdTotal += $j
        }
    }
    return $invalidIdTotal
}
function InvalidIdPartTwo {
    param ( 
        [int64] $start,
        [int64] $end
    )

    $invalidIdTotal = 0
    for ($j = $startRange; $j -le $endRange; $j++) {
        if ($j -match "\b(\d+)\1+\b") {
            $invalidIdTotal += $j
        }
    }
    return $invalidIdTotal
}

$elfId = @()
$lineCount = 0

[int64]$startRange = 0
[int64]$endRange = 0

$partOneInvalidIdTotal = 0
$partTwoInvalidIdTotal = 0

# split the comma separated values
Get-Content -Path $args[0] | ForEach-Object {
    $idNum = $_.Split(',') 
    if ($idNum.Contains("\n")) {
        continue
    }
    $elfId += $idNum
}

# get the lineCount of the Array
$lineCount = $elfId.Count


# loop the range
for ($i = 0; $i -lt $lineCount; $i++) {
    # set the startRange and endRange
    $startRange, $endRange = $elfId[$i].Split("-")

    # skip the empty lines
    if ($endRange -eq $null) {
        continue
    }

    $one = invalidIdPartOne -start $startRange -end $endRange
    $partOneInvalidIdTotal += $one
    
    $two = invalidIdPartTwo -start $startRange -end $endRange
    $partTwoInvalidIdTotal += $two
    
}

Write-Host "Part 1 Invalid ID totals: $partOneInvalidIdTotal"
Write-Host "Part 2 Invalid ID totals: $partTwoInvalidIdTotal"

# find repeat

