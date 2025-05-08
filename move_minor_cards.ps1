# 确保目标目录存在
$minorDir = "static\images\tarot\minor"
$defaultDir = "static\images\tarot\default"

# 创建目录（如果不存在）
if (-not (Test-Path $minorDir)) {
    New-Item -ItemType Directory -Path $minorDir -Force
}

# 定义小阿卡纳牌套牌
$minorSuits = @("Wands", "Cups", "Swords", "Pentacles")

foreach ($suit in $minorSuits) {
    $suitLower = $suit.ToLower()
    
    # ACE
    $srcPath = "$defaultDir\Ace of $suit.png"
    $destPath = "$minorDir\ace-of-$suitLower.png"
    if (Test-Path $srcPath) {
        Write-Host "Copying $srcPath to $destPath"
        Copy-Item -Path $srcPath -Destination $destPath -Force
    } else {
        Write-Host "Missing file: $srcPath"
    }
    
    # 数字牌 (Two-Ten)
    $numbers = @("Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")
    $numbersMap = @{
        "Two" = "2"
        "Three" = "3" 
        "Four" = "4"
        "Five" = "5"
        "Six" = "6"
        "Seven" = "7"
        "Eight" = "8"
        "Nine" = "9"
        "Ten" = "10"
    }
    
    foreach ($number in $numbers) {
        $srcPath = "$defaultDir\$number of $suit.png"
        $numValue = $numbersMap[$number]
        $destPath = "$minorDir\$numValue-of-$suitLower.png"
        if (Test-Path $srcPath) {
            Write-Host "Copying $srcPath to $destPath"
            Copy-Item -Path $srcPath -Destination $destPath -Force
        } else {
            Write-Host "Missing file: $srcPath"
        }
    }
    
    # 宫廷牌 (Page, Knight, Queen, King)
    $courts = @("Page", "Knight", "Queen", "King")
    foreach ($court in $courts) {
        $srcPath = "$defaultDir\$court of $suit.png"
        $destPath = "$minorDir\$($court.ToLower())-of-$suitLower.png"
        if (Test-Path $srcPath) {
            Write-Host "Copying $srcPath to $destPath"
            Copy-Item -Path $srcPath -Destination $destPath -Force
        } else {
            Write-Host "Missing file: $srcPath"
        }
    }
}

Write-Host "All minor arcana cards have been successfully copied!" 