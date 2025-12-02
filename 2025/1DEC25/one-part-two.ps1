function goLeft {
    param (
        [array] $list, # circularList
        [int] $count, # number of times to turn the dial
        [int] $index # current index of the circularList we are at
    )

    $currentIndex = $index
    $zeroCount = 0 # total number of zeroes spotted
    $step = -1 # -1 to step backwards in the circularList

    for ($i = 0; $i -lt $count; $i++) {
        # go backwards by 1 number of times $count
        $currentIndex = $circularList[(($currentIndex + 1 + $step) + ($circularList.Count + $step)) % $circularList.Count]
        if ($currentIndex -eq 0) {
            $zeroCount = $zeroCount + 1

        }
    }
    return $zeroCount, $currentIndex
}

function goRight {
    param (
        [array] $list, # circularList
        [int] $count, # number of times to turn the dial
        [int] $index # current index of the circularList we are at
    )

    $currentIndex = $index
    $zeroCount = 0 # total number of zeroes spotted

    for ($i = 0; $i -lt $count; $i++) {
        # go forward by 1 number of times $count
        $currentIndex = $circularList[(($currentIndex + 1) + $circularList.Count) % $circularList.Count]
        if ($currentIndex -eq 0) {
            $zeroCount = $zeroCount + 1
        }
    }
    return $zeroCount, $currentIndex
}


$start = 50
$zeroCount = 0 # final zero count
$zeroReturn = 0 # [Int[]]Array[totalZeroesFound, currentIndex]
$index = 0 # index of the circularList
$step = -1

$left = "L"
$right = "R"

$lines = 0
$path = ".\input.txt"

$file = Get-Content -Path $path
$lines = (Get-Content -Path $path).Count

[Int32[]]$circularList = 0..99

# loop lines in file
$index = $start


for ($i = 0; $i -lt $lines; $i++) {
    if ($file[$i].ToLower().Contains($left.ToLower())) {
        # "L#"
        # This splits the <letter><number> expression and only leaves the number
        $number = $file[$i] -replace "[^0-9]", ""
        # Cast the number "string" to an "int"
        $intNumber = [int]$number

        $zeroReturn = goLeft -list $circularList -count $intNumber -index $index
        $zeroCount = $zeroCount + $zeroReturn[0]
    }
    elseif ($file[$i].ToLower().Contains($right.ToLower())) {
        # "R#"
        # This splits the <letter><number> expression and only leaves the number
        $number = $file[$i] -replace "[^0-9]", ""

        # Cast the number "string" to an "int"
        $intNumber = [int]$number

        $zeroReturn = goRight -list $circularList -count $intNumber -index $index
        $zeroCount = $zeroCount + $zeroReturn[0]
    }
    else {
        Write-Host "Invalid Entry, fix and try again!"
        break
    }

    # make sure to setup the currentIndex for the next loop
    $index = $zeroReturn[1]

}

Write-Host "Total zeroes: $zeroCount"
