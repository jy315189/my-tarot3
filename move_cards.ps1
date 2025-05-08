# 确保目标目录存在
$majorDir = "static\images\tarot\major"
$minorDir = "static\images\tarot\minor"
$defaultDir = "static\images\tarot\default"

# 创建目录（如果不存在）
if (-not (Test-Path $majorDir)) {
    New-Item -ItemType Directory -Path $majorDir -Force
}
if (-not (Test-Path $minorDir)) {
    New-Item -ItemType Directory -Path $minorDir -Force
}

# 移动大阿卡纳牌
$majorArcana = @{
    "The Fool.png" = "00-the-fool.png"
    "The Magician.png" = "01-the-magician.png"
    "The High Priestess.png" = "02-the-high-priestess.png"
    "The Empress.png" = "03-the-empress.png"
    "The Emperor.png" = "04-the-emperor.png"
    "The Hierophant.png" = "05-the-hierophant.png"
    "The Lovers.png" = "06-the-lovers.png"
    "The Chariot.png" = "07-the-chariot.png"
    "Strength.png" = "08-strength.png"
    "The Hermit.png" = "09-the-hermit.png"
    "Wheel of Fortune.png" = "10-wheel-of-fortune.png"
    "Justice.png" = "11-justice.png"
    "The Hanged Man.png" = "12-the-hanged-man.png"
    "Death.png" = "13-death.png"
    "Temperance.png" = "14-temperance.png"
    "The Devil.png" = "15-the-devil.png"
    "The Tower.png" = "16-the-tower.png"
    "The Star.png" = "17-the-star.png"
    "The Moon.png" = "18-the-moon.png"
    "The Sun.png" = "19-the-sun.png"
    "Judgement.png" = "20-judgement.png"
    "The World.png" = "21-the-world.png"
}

# 定义小阿卡纳牌套牌
$minorSuits = @("Wands", "Cups", "Swords", "Pentacles")

# 复制大阿卡纳牌
foreach ($card in $majorArcana.Keys) {
    $srcPath = Join-Path $defaultDir $card
    $destPath = Join-Path $majorDir $majorArcana[$card]
    if (Test-Path $srcPath) {
        Write-Host "Copy $card to $($majorArcana[$card])"
        Copy-Item -Path $srcPath -Destination $destPath -Force
    } else {
        Write-Host "File not found: $srcPath"
    }
}

# 复制小阿卡纳牌
foreach ($suit in $minorSuits) {
    # 复制数字牌 (Ace-10)
    Copy-Item -Path "$defaultDir\Ace of $suit.png" -Destination "$minorDir\ace-of-$(${suit}.ToLower()).png" -Force
    for ($i = 2; $i -le 10; $i++) {
        Copy-Item -Path "$defaultDir\$i of $suit.png" -Destination "$minorDir\$i-of-$(${suit}.ToLower()).png" -Force
    }
    
    # 复制宫廷牌 (Page, Knight, Queen, King)
    Copy-Item -Path "$defaultDir\Page of $suit.png" -Destination "$minorDir\page-of-$(${suit}.ToLower()).png" -Force
    Copy-Item -Path "$defaultDir\Knight of $suit.png" -Destination "$minorDir\knight-of-$(${suit}.ToLower()).png" -Force
    Copy-Item -Path "$defaultDir\Queen of $suit.png" -Destination "$minorDir\queen-of-$(${suit}.ToLower()).png" -Force
    Copy-Item -Path "$defaultDir\King of $suit.png" -Destination "$minorDir\king-of-$(${suit}.ToLower()).png" -Force
}

Write-Host "All cards have been successfully copied!" 