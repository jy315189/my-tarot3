<template>
  <view class="learn-basics mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.4;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.3;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
    <view class="container">
      <view class="header">
        <view class="back-btn" @tap="goBack">
          <text class="back-icon">←</text>
          <text class="back-text">返回</text>
        </view>
        <text class="title">塔罗基础知识</text>
        <text class="subtitle">掌握塔罗牌的基本结构与象征体系</text>
      </view>
      
      <view class="content">
        <view class="content-tabs">
          <view 
            v-for="(tab, index) in tabs" 
            :key="index" 
            class="tab" 
            :class="{ active: activeTabIndex === index }"
            @tap="activeTabIndex = index"
          >
            {{tab.name}}
          </view>
        </view>
        
        <view class="tab-content">
          <!-- 塔罗牌组成 -->
          <view v-if="activeTabIndex === 0" class="section">
            <view class="section-header">
              <text class="section-title">塔罗牌的组成</text>
            </view>
            
            <text class="paragraph">标准的塔罗牌一共有78张，分为两大部分：大阿卡纳牌(Major Arcana)和小阿卡纳牌(Minor Arcana)。</text>
            
            <view class="card-group">
              <view class="group-title">大阿卡纳（22张）</view>
              <text class="paragraph">大阿卡纳由22张牌组成，从0号"愚者"到21号"世界"，每张牌都代表人生旅途中的重大原型和主题。大阿卡纳牌在占卜中通常指示重大的转折点或深层的精神课题。</text>
              <image src="/static/images/learn/major-arcana.png" mode="aspectFit" class="group-image"></image>
            </view>
            
            <view class="card-group">
              <view class="group-title">小阿卡纳（56张）</view>
              <text class="paragraph">小阿卡纳包含56张牌，分为四组套牌，每组14张：权杖(Wands)、圣杯(Cups)、宝剑(Swords)和星币(Pentacles)。每组有10张数字牌（A到10）和4张宫廷牌（侍从、骑士、王后和国王）。小阿卡纳牌通常反映日常生活的具体情况和挑战。</text>
              
              <view class="minor-suits">
                <view class="suit">
                  <image src="/static/images/learn/wands.png" mode="aspectFit" class="suit-image"></image>
                  <text class="suit-name">权杖</text>
                  <text class="suit-desc">代表火元素，象征创造、激情、行动与精神</text>
                </view>
                
                <view class="suit">
                  <image src="/static/images/learn/cups.png" mode="aspectFit" class="suit-image"></image>
                  <text class="suit-name">圣杯</text>
                  <text class="suit-desc">代表水元素，象征情感、关系、直觉与爱</text>
                </view>
                
                <view class="suit">
                  <image src="/static/images/learn/swords.png" mode="aspectFit" class="suit-image"></image>
                  <text class="suit-name">宝剑</text>
                  <text class="suit-desc">代表风元素，象征思想、沟通、冲突与真理</text>
                </view>
                
                <view class="suit">
                  <image src="/static/images/learn/pentacles.png" mode="aspectFit" class="suit-image"></image>
                  <text class="suit-name">星币</text>
                  <text class="suit-desc">代表土元素，象征物质、工作、财富与健康</text>
                </view>
              </view>
            </view>
          </view>
          
          <!-- 牌面解读 -->
          <view v-if="activeTabIndex === 1" class="section">
            <view class="section-header">
              <text class="section-title">基础解读原则</text>
            </view>
            
            <text class="paragraph">塔罗牌的解读不仅仅是记忆每张牌的含义，更是理解牌面的象征、直觉的应用以及牌与牌之间的关系。以下是解读塔罗牌的基本原则：</text>
            
            <view class="principle">
              <view class="principle-title">
                <text class="principle-number">1</text>
                <text class="principle-name">象征语言</text>
              </view>
              <text class="principle-desc">塔罗牌使用象征语言传达信息。每张牌上的元素、颜色、数字和人物都有特定的象征意义。例如，剑代表思维和挑战，红色象征激情和活力，数字3通常与创造和表达相关。</text>
            </view>
            
            <view class="principle">
              <view class="principle-title">
                <text class="principle-number">2</text>
                <text class="principle-name">正逆位解读</text>
              </view>
              <text class="principle-desc">塔罗牌可以以正位或逆位出现。正位通常表示该牌的能量以外在、积极或直接的方式表现；逆位则可能表示能量受阻、内在化或需要更加关注的方面。</text>
            </view>
            
            <view class="principle">
              <view class="principle-title">
                <text class="principle-number">3</text>
                <text class="principle-name">直觉连接</text>
              </view>
              <text class="principle-desc">除了标准含义外，塔罗解读也依赖读者的直觉。牌面可能触发的个人联想和感受常常提供重要线索。学习信任你的直觉反应，尤其是当你对某张牌有强烈感受时。</text>
            </view>
            
            <view class="principle">
              <view class="principle-title">
                <text class="principle-number">4</text>
                <text class="principle-name">牌阵关系</text>
              </view>
              <text class="principle-desc">在牌阵中，牌与牌之间的关系至关重要。相邻的牌会相互影响，共同讲述一个完整的故事。注意牌阵中的模式，如多张相同花色的牌或多张大阿卡纳牌的出现。</text>
            </view>
            
            <view class="principle">
              <view class="principle-title">
                <text class="principle-number">5</text>
                <text class="principle-name">情境考量</text>
              </view>
              <text class="principle-desc">塔罗牌解读必须考虑提问者的具体情况和问题。同一张牌在不同情境中可能有不同的解读。例如，"死亡"牌在职业阅读中可能表示职业转变，而在关系阅读中则可能表示关系阶段的结束。</text>
            </view>
          </view>
          
          <!-- 准备工作 -->
          <view v-if="activeTabIndex === 2" class="section">
            <view class="section-header">
              <text class="section-title">塔罗占卜的准备</text>
            </view>
            
            <text class="paragraph">进行塔罗牌占卜前的准备工作对于获得清晰、有洞察力的解读非常重要。合适的环境、心态和手续能够增强你与牌的连接。</text>
            
            <view class="prep-step">
              <view class="step-number">01</view>
              <view class="step-content">
                <text class="step-title">选择合适的环境</text>
                <text class="step-desc">选择一个安静、不受干扰的空间进行塔罗牌阅读。适当的照明和舒适的桌面也很重要。有些读者喜欢点蜡烛或熏香来创造神圣的氛围，但这不是必须的。最重要的是你感到放松和专注。</text>
              </view>
            </view>
            
            <view class="prep-step">
              <view class="step-number">02</view>
              <view class="step-content">
                <text class="step-title">调整心态</text>
                <text class="step-desc">在开始前花几分钟冥想或深呼吸，清空杂念。避免在情绪极度波动或疲惫时进行占卜。抱持开放、接纳的态度，无论牌面显示什么信息都愿意倾听和思考。</text>
              </view>
            </view>
            
            <view class="prep-step">
              <view class="step-number">03</view>
              <view class="step-content">
                <text class="step-title">牌组准备</text>
                <text class="step-desc">许多塔罗实践者认为新的塔罗牌组需要"净化"和"充能"。你可以轻轻敲击牌组以清除之前的能量，或将牌组放在月光下过夜。定期洗牌也是保持牌组能量清新的好方法。</text>
              </view>
            </view>
            
            <view class="prep-step">
              <view class="step-number">04</view>
              <view class="step-content">
                <text class="step-title">洗牌和切牌</text>
                <text class="step-desc">洗牌时集中注意力在你的问题上。有多种洗牌方式：传统的扑克牌洗法、在桌面上混合牌面，或一张一张地交错排列。洗完后，可以将牌组切成几堆再重新组合，这有助于进一步随机化牌序。</text>
              </view>
            </view>
            
            <view class="prep-step">
              <view class="step-number">05</view>
              <view class="step-content">
                <text class="step-title">明确问题</text>
                <text class="step-desc">提出清晰、具体且开放式的问题。避免简单的是/否问题，而是提问"如何"、"为什么"或"什么"类型的问题。例如，不要问"我会得到这份工作吗？"，而是问"我需要了解关于这个工作机会的什么？"</text>
              </view>
            </view>
          </view>
        </view>
        
        <view class="navigation-buttons">
          <button class="btn btn-outline" @tap="prevTab" :disabled="activeTabIndex === 0">上一节</button>
          <button class="btn btn-primary" @tap="nextTab" :disabled="activeTabIndex === tabs.length - 1">下一节</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'LearnBasics',
  data() {
    return {
      activeTabIndex: 0,
      tabs: [
        { name: '牌组构成' },
        { name: '解读原则' },
        { name: '准备工作' }
      ]
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    prevTab() {
      if (this.activeTabIndex > 0) {
        this.activeTabIndex--;
      }
    },
    nextTab() {
      if (this.activeTabIndex < this.tabs.length - 1) {
        this.activeTabIndex++;
      }
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.learn-basics {
  min-height: 100vh;
  padding: 40rpx 30rpx;
  box-sizing: border-box;
  position: relative;
}

.container {
  position: relative;
  z-index: 1;
}

.header {
  margin-bottom: 40rpx;
  
  .back-btn {
    display: flex;
    align-items: center;
    font-size: 32rpx;
    color: $color-text;
    margin-bottom: 20rpx;
    
    .back-icon {
      margin-right: 10rpx;
      font-size: 36rpx;
    }
  }
  
  .title {
    font-size: 40rpx;
    font-weight: 600;
    color: $color-text;
    margin-bottom: 10rpx;
    display: block;
  }
  
  .subtitle {
    font-size: 28rpx;
    color: $color-text-secondary;
  }
}

.content-tabs {
  display: flex;
  margin-bottom: 30rpx;
  background-color: rgba($color-bg-card, 0.5);
  border-radius: 40rpx;
  padding: 6rpx;
  
  .tab {
    flex: 1;
    text-align: center;
    padding: 16rpx 0;
    font-size: 28rpx;
    color: $color-text-secondary;
    border-radius: 40rpx;
    
    &.active {
      background-color: $color-primary;
      color: white;
    }
  }
}

.tab-content {
  background-color: rgba($color-bg-card, 0.7);
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 30rpx;
}

.paragraph {
  font-size: 28rpx;
  color: $color-text;
  line-height: 1.6;
  margin-bottom: 20rpx;
  display: block;
}

.section-header {
  margin-bottom: 20rpx;
  
  .section-title {
    font-size: 32rpx;
    font-weight: 600;
    color: $color-text;
    border-left: 6rpx solid $color-accent;
    padding-left: 16rpx;
  }
}

.card-group {
  margin-bottom: 30rpx;
  
  .group-title {
    font-size: 30rpx;
    font-weight: 600;
    color: $color-text;
    margin-bottom: 16rpx;
    background-color: rgba($color-primary, 0.1);
    padding: 10rpx 20rpx;
    border-radius: 8rpx;
  }
  
  .group-image {
    width: 100%;
    height: 300rpx;
    object-fit: contain;
    margin-top: 20rpx;
  }
}

.minor-suits {
  display: flex;
  flex-wrap: wrap;
  margin-top: 20rpx;
  
  .suit {
    width: 50%;
    padding: 10rpx;
    box-sizing: border-box;
    margin-bottom: 20rpx;
    
    .suit-image {
      width: 100%;
      height: 200rpx;
      object-fit: contain;
      margin-bottom: 10rpx;
    }
    
    .suit-name {
      font-size: 28rpx;
      font-weight: 600;
      color: $color-text;
      display: block;
      margin-bottom: 5rpx;
    }
    
    .suit-desc {
      font-size: 24rpx;
      color: $color-text-secondary;
      line-height: 1.4;
    }
  }
}

.principle {
  margin-bottom: 30rpx;
  background-color: rgba($color-bg, 0.3);
  border-radius: 12rpx;
  padding: 20rpx;
  
  .principle-title {
    display: flex;
    align-items: center;
    margin-bottom: 10rpx;
    
    .principle-number {
      width: 44rpx;
      height: 44rpx;
      border-radius: 22rpx;
      background-color: $color-accent;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 24rpx;
      font-weight: 600;
      margin-right: 16rpx;
    }
    
    .principle-name {
      font-size: 30rpx;
      font-weight: 600;
      color: $color-text;
    }
  }
  
  .principle-desc {
    font-size: 26rpx;
    color: $color-text;
    line-height: 1.6;
  }
}

.prep-step {
  display: flex;
  margin-bottom: 30rpx;
  
  .step-number {
    font-size: 36rpx;
    font-weight: 600;
    color: rgba($color-primary, 0.6);
    margin-right: 20rpx;
    flex-shrink: 0;
  }
  
  .step-content {
    flex: 1;
    
    .step-title {
      font-size: 28rpx;
      font-weight: 600;
      color: $color-text;
      margin-bottom: 8rpx;
      display: block;
    }
    
    .step-desc {
      font-size: 26rpx;
      color: $color-text;
      line-height: 1.6;
    }
  }
}

.navigation-buttons {
  display: flex;
  justify-content: space-between;
  
  .btn {
    min-width: 200rpx;
    padding: 16rpx 30rpx;
    font-size: 28rpx;
    border-radius: 40rpx;
    
    &.btn-outline {
      border: 1px solid $color-primary;
      color: $color-primary;
      background-color: transparent;
      
      &:disabled {
        opacity: 0.5;
        border-color: $color-text-secondary;
        color: $color-text-secondary;
      }
    }
    
    &.btn-primary {
      background-color: $color-primary;
      color: white;
      border: none;
      
      &:disabled {
        opacity: 0.5;
        background-color: $color-text-secondary;
      }
    }
  }
}

/* 神秘背景元素样式 */
.mystic-circle {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba($color-primary, 0.3);
}

.mystic-star {
  position: absolute;
  font-size: 40rpx;
  color: rgba($color-primary, 0.4);
}
</style> 