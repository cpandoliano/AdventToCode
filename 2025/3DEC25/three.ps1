if ($args.Count -ne 1) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <sample.txt | input.txt> for day2"
    exit
}

$bunchOfBanks = @() # [222, 222, 222,]
$totalMaxJoltage = 0

$tenth = 0
$oneth = 0
# read in file input into array of bunchOfBanks

# split each bank [2,2,2]

# find the two highest numbers as close to 99 as possible
# function FindHighestBankJoltage -> [int]maxJoltage
# loop through each bank find the two highest tenth decimal and oneth decimal
# add them together totalMaxJoltage


$bunchOfBanks = Get-Content -Path $args[0]

for ($i = 0; $i -lt $bunchOfBanks.Count; $i++) {
    # Write-Host $($bunchOfBanks[$i])
    for ($j = 0; $j -lt 1; $j++) { #$bunchOfBanks[$i]
        # Write-Host $($bunchOfBanks[$i][$j])
        # first number checks if higher than tenth, unless tenth is 9
        #if ($bunchOfBanks[$i][$j] -gt $tenth ?  $tenth = $bunchOfBanks[$i][$j] :  )
        if ($bunchOfBanks[$i][$j] -gt $tenth) {
            
            # first number goes into the $tenth spot
            $tenth = $bunchOfBanks[$i][$j]
        }
        else{
            $oneth = $bunchOfBanks[$i][$j]
        }
        Write-Host $($tenth)
        
        # second number checks if higher than the tenth spot, unless tenth is 9
        
        # if tenth is already 9, second number goes into oneth
        # repeat filling in tenth and oneth, unless they are already both 9
    }
    Write-Host "$($tenth + $oneth + $tenth + $oneth)"

}
