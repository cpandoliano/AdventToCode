function PrintGrid {
    param (
        $grid,
        $size
    )
    
    foreach ($item in $grid) {
        Write-Host $grid[$g]
        Write-Host "`n" # Inserts a new line
    }
}

if ($args.Count -ne 1) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <sample.txt | input.txt> for day4"
    exit
}

function CheckRollsOfPaper {
    param (
        $paperRoll,
        [int]$yc,
        [int]$zc
    )
    $access = 0
    if ($yc -ge 0 -and $yc -le $paperRoll.GetUpperBound(0) -and `
        $zc -ge 0 -and $zc -le $paperRoll.GetUpperBound(1)) {
        if ($paperRoll[$yc, $zc] -eq "@") {
             $access += 1
             return $access
        }    
    }
    
    return $access
}

# just read in the data as a double array for now...

$inputRow = "..@....@@.@.@@@@.@..@@@.@..@@.@@..@@..@@@@.@..@.@@@@@.@@@@..@@@.@@.@@@.@..@@@@@@.@@.@@@@.@@.@@.@..@.@@@@...@@@@@.@.@.@@@@@@@...@.@@@@@.@@"
$sampleRow = "..@@.@@@@."

#sample.txt 10 x 10
#input.txt 137 x 137

Write-Host "input row $($inputRow.Length) sampleRow $($sampleRow.Length)"

$file = Get-Content -Path $args[0]

$x = 0
$at = 0

$size = $file.Count
#Write-Host $($size)
$grid = [string[,]]::new($size, $size)

#Write-Host $($file.Count)
for ($i = 0; $i -lt $size; $i++) {
    for ($j = 0; $j -lt $size; $j++) {
        $grid[$i,$j] = $file[$i][$j]
	#Write-Host $file[$i][$j]

    }
}

# loop every index
for ($y = 0; $y -lt $size; $y++) {
    for ($z = 0; $z -lt $size; $z++) {
	#Write-Host $grid[$y,$z]
#exit
        if ($grid[$y,$z] -eq "@") {
            # (x-1, y-1)
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y - 1) -zc $($z - 1)
            # (x-1, y))
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y - 1) -zc $($z)
            # (x-1, y+1)
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y - 1) -zc $($z + 1)
            # (x, y-1))
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y) -zc $($z - 1)
            # (x, y+1),
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y) -zc $($z + 1)
            # (x+1, y-1)
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y + 1) -zc $($z - 1)
            # (x+1, y),
            $at += CheckRollsOfPaper -paperRoll $grid -yc $($y + 1) -zc $($z)
            # (x+1, y+1)
    	    $at += CheckRollsOfPaper -paperRoll $grid -yc $($y + 1) -zc $($z + 1)
    	    #Write-Host "at is $at"
            if ($at -le 3) {
                $x += 1
                #$grid[$y,$z] = "x"
               
            }

            $at = 0
        }
    }
}

# look for @ in all directions
# if @ count is -le 3 x += 1
# if @ count is -gt 3 continue
# 


Write-Host "X is $($x)"
#PrintGrid -grid $grid -size $size