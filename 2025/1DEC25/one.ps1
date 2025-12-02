if ($args.Count -ne 1)
{
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <sample.txt> for day1"
    exit
}

$start = 50
$zeroCount = 0
$currentIndex = 0
$step = -1

[Int[]]$circularList = 0..99

$left = "L"
$right = "R"

$lines = 0
$path = $args[0]

$file = Get-Content -Path $path
$lines = (Get-Content -Path $path).Count

# loop lines in file
$currentIndex = $start
for ($i = 0; $i -lt $lines; $i++) {
    if ($file[$i].ToLower().Contains($left.ToLower())) {
        $number = $file[$i] -replace "[^0-9]", ""
        $currentIndex = $circularList[(($currentIndex - $number + 1) + ($circularList.Count + $step)) % $circularList.Count]
        if ($currentIndex -eq 0) {
            $zeroCount = $zeroCount + 1
        }

    }
    elseif ($file[$i].ToLower().Contains($right.ToLower())) {
        $number = $file[$i] -replace "[^0-9]", ""
        $currentIndex = $circularList[(($currentIndex + $number) + $circularList.Count) % $circularList.Count]
        if ($currentIndex -eq 0) {
            $zeroCount = $zeroCount + 1
        }
    }
    else {
        Write-Host "Invalid Entry, fix and try again!"
        break
    }

}

Write-Host "Total zeroes: $zeroCount"