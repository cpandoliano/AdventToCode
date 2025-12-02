function findInvalidId {
    param ( 
        [int64] $start,
        [int64] $end,
        [string] $regex
    )

    $invalidIdTotal = 0
    for ($j = $startRange; $j -le $endRange; $j++) {
        if ($j -match $regex) {
            $invalidIdTotal += $j
        }
    }
    return $invalidIdTotal
}


if ($args.Count -ne 1) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <sample.txt | input.txt> for day2"
    exit
}

$elfId = @()
$lineCount = 0

[int64]$startRange = 0
[int64]$endRange = 0

$partOneRegEx = "\b(\d+)\1\b"
$partTwoRegEx = "\b(\d+)\1+\b"

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

    $one = findInvalidId -start $startRange -end $endRange -regex $partOneRegEx
    $partOneInvalidIdTotal += $one
    
    $two = findInvalidId -start $startRange -end $endRange -regex $partTwoRegEx
    $partTwoInvalidIdTotal += $two
    
}

Write-Host "Part 1 Invalid ID totals: $partOneInvalidIdTotal"
Write-Host "Part 2 Invalid ID totals: $partTwoInvalidIdTotal"
