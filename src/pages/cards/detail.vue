<template>
  <view class="card-detail mystic-bg">
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
      </view>
      
      <view class="content" v-if="card">
        <view class="card-section">
          <view class="card-image-container">
            <image :src="card.image" mode="aspectFill" class="card-image" />
          </view>
          <view class="card-info">
            <view class="card-title">
              <text class="card-name">{{card.name}}</text>
              <text class="card-number" v-if="card.number">{{card.number}}</text>
            </view>
            <text class="card-suit" v-if="card.suit">{{card.suit}}</text>
            
            <view class="card-attributes" v-if="card.element || card.astrology">
              <view class="attribute" v-if="card.element">
                <text class="attribute-label">元素:</text>
                <text class="attribute-value">{{card.element}}</text>
              </view>
              <view class="attribute" v-if="card.astrology">
                <text class="attribute-label">占星:</text>
                <text class="attribute-value">{{card.astrology}}</text>
              </view>
            </view>
          </view>
        </view>
        
        <view class="meaning-section">
          <view class="section-title">
            <text>关键词</text>
          </view>
          <view class="keywords">
            <text>{{card.keywords}}</text>
          </view>
          
          <view class="section-title">
            <text>正位解读</text>
          </view>
          <view class="meaning-text">
            <text>{{card.meaning}}</text>
          </view>
          
          <view class="section-title">
            <text>逆位解读</text>
          </view>
          <view class="meaning-text">
            <text>{{card.reversed || '暂无逆位解读'}}</text>
          </view>
        </view>
        
        <view class="additional-info">
          <view class="section-title">
            <text>卡牌象征</text>
          </view>
          <view class="symbolism">
            <text>{{getSymbolism()}}</text>
          </view>
          
          <view class="section-title">
            <text>牌面建议</text>
          </view>
          <view class="advice">
            <text>{{getAdvice()}}</text>
          </view>
        </view>
      </view>
      
      <view class="footer">
        <button class="btn" @tap="shareCard">分享卡牌</button>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'CardDetail',
  data() {
    return {
      card: null
    }
  },
  onLoad(option) {
    if (option.card) {
      try {
        this.card = JSON.parse(decodeURIComponent(option.card));
      } catch (e) {
        console.error('解析卡牌数据失败:', e);
        uni.showToast({
          title: '加载卡牌失败',
          icon: 'none'
        });
      }
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    getSymbolism() {
      const symbolisms = {
        '愚者': '愚者卡牌展示一个年轻人站在悬崖边，背上背着少量行李，手中拿着一朵白玫瑰，象征纯洁与新的开始。他看向天空，象征着他对未来的乐观态度，而他的狗则代表着直觉和忠诚，提醒他小心脚下的悬崖。',
        '魔术师': '魔术师站在桌前，举起魔杖，这是他的意志象征。桌面上摆放着代表四元素的物品（圣杯、宝剑、权杖和金币），象征他掌握了创造所需的所有工具。他头顶上方的∞符号代表无限可能和永恒。',
        '女祭司': '女祭司坐在两根柱子之间，代表光明与黑暗、阴与阳的平衡。她的面纱象征神秘和隐藏的知识，而她脚下的新月象征直觉和潜意识。她膝上的卷轴包含神圣的智慧，只有准备好的人才能阅读。',
        // 可以根据需要添加更多卡牌的象征解释
      };
      
      if (this.card && symbolisms[this.card.name]) {
        return symbolisms[this.card.name];
      }
      
      // 生成通用象征解释
      if (this.card.category === 'major') {
        return `这张大阿卡纳牌象征着生命中的重要力量和阶段。在牌面中，画面的各个元素都有其特定的象征意义，共同构成了这张牌所代表的精神和心理状态。`;
      } else {
        return `作为${this.card.suit}牌组中的一员，这张牌反映了日常生活中的具体情境和能量。牌面上的符号和颜色都经过精心设计，帮助我们理解其深层含义。`;
      }
    },
    getAdvice() {
      const advices = {
        '愚者': '保持开放的心态，不要害怕踏上新的旅程。信任你的直觉，但也要关注现实和细节。这是一个适合冒险和尝试新事物的时期，不要被过去的经验或他人的看法所局限。',
        '魔术师': '现在是行动的时刻。你拥有实现目标所需的一切资源和技能，需要做的就是充分利用它们。专注于你的意图，相信自己的能力，通过集中精力和意志力将想法转化为现实。',
        '女祭司': '聆听你的内心声音，相信你的直觉。这是一个思考和内省的时期，而不是匆忙行动的时候。耐心等待更多信息的揭示，深入挖掘问题的核心，而不是满足于表面的解释。',
        // 可以根据需要添加更多卡牌的建议
      };
      
      if (this.card && advices[this.card.name]) {
        return advices[this.card.name];
      }
      
      // 生成通用建议
      return `这张牌提醒你关注${this.card.keywords}的能量。当这张牌出现在你的阅读中时，可以考虑如何在当前情况中应用其智慧。反思它带给你的信息，并在日常生活中实践其教导。`;
    },
    shareCard() {
      uni.showToast({
        title: '分享功能开发中',
        icon: 'none'
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.card-detail {
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
  margin-bottom: 30rpx;
  
  .back-btn {
    display: flex;
    align-items: center;
    font-size: 32rpx;
    color: $color-text;
    
    .back-icon {
      margin-right: 10rpx;
      font-size: 36rpx;
    }
  }
}

.content {
  margin-bottom: 40rpx;
}

.card-section {
  display: flex;
  margin-bottom: 40rpx;
  
  .card-image-container {
    width: 240rpx;
    height: 400rpx;
    border-radius: 16rpx;
    overflow: hidden;
    box-shadow: 0 8rpx 20rpx rgba(0, 0, 0, 0.3);
    border: 2rpx solid rgba(255, 255, 255, 0.2);
    position: relative;
    
    &::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
      pointer-events: none;
    }
    
    .card-image {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s ease;
      
      &:hover {
        transform: scale(1.05);
      }
    }
  }
  
  .card-info {
    flex: 1;
    padding-left: 30rpx;
    
    .card-title {
      margin-bottom: 20rpx;
      
      .card-name {
        font-size: 44rpx;
        font-weight: 600;
        color: $color-text;
        margin-right: 15rpx;
        background: linear-gradient(to right, $color-primary, $color-accent);
        -webkit-background-clip: text;
        color: transparent;
        display: inline-block;
        text-shadow: 0 2rpx 4rpx rgba(0,0,0,0.1);
      }
      
      .card-number {
        font-size: 32rpx;
        color: $color-primary;
        opacity: 0.9;
      }
    }
    
    .card-suit {
      font-size: 30rpx;
      color: $color-text-secondary;
      margin-bottom: 20rpx;
      display: block;
      font-style: italic;
    }
    
    .card-attributes {
      margin-top: 25rpx;
      background: rgba(255,255,255,0.1);
      padding: 16rpx;
      border-radius: 12rpx;
      
      .attribute {
        display: flex;
        margin-bottom: 10rpx;
        
        .attribute-label {
          font-size: 28rpx;
          color: $color-text-secondary;
          width: 100rpx;
        }
        
        .attribute-value {
          font-size: 28rpx;
          color: $color-primary;
          font-weight: 500;
        }
      }
    }
  }
}

.meaning-section, .additional-info {
  background: rgba(255,255,255,0.08);
  border-radius: 16rpx;
  padding: 25rpx;
  margin-bottom: 30rpx;
  box-shadow: 0 4rpx 12rpx rgba(0,0,0,0.1);
  border: 1rpx solid rgba(255,255,255,0.1);
}

.section-title {
  margin-bottom: 15rpx;
  
  text {
    font-size: 32rpx;
    font-weight: 600;
    color: $color-text;
    position: relative;
    padding-left: 20rpx;
    display: inline-block;
    
    &::before {
      content: '';
      position: absolute;
      left: 0;
      top: 50%;
      transform: translateY(-50%);
      width: 8rpx;
      height: 30rpx;
      background: $color-primary;
      border-radius: 4rpx;
    }
  }
}

.keywords {
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 25rpx;
  
  text {
    background: rgba($color-primary, 0.15);
    color: $color-primary;
    padding: 8rpx 16rpx;
    border-radius: 30rpx;
    font-size: 26rpx;
    margin-right: 12rpx;
    margin-bottom: 12rpx;
  }
}

.meaning-text {
  margin-bottom: 25rpx;
  
  text {
    font-size: 28rpx;
    color: $color-text;
    line-height: 1.6;
  }
}

.symbolism, .advice {
  text {
    font-size: 28rpx;
    color: $color-text;
    line-height: 1.6;
  }
}

.footer {
  display: flex;
  justify-content: center;
  
  .btn {
    width: 80%;
    height: 90rpx;
    line-height: 90rpx;
    background: linear-gradient(to right, $color-primary, $color-accent);
    color: white;
    font-size: 32rpx;
    border-radius: 45rpx;
    box-shadow: 0 6rpx 12rpx rgba($color-primary, 0.3);
    text-align: center;
    letter-spacing: 2rpx;
    transition: all 0.3s ease;
    
    &:active {
      transform: translateY(2rpx);
      box-shadow: 0 2rpx 6rpx rgba($color-primary, 0.3);
    }
  }
}

/* 神秘背景元素样式 */
.mystic-circle {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba($color-primary, 0.3);
  animation: rotate 60s linear infinite;
}

.mystic-star {
  position: absolute;
  font-size: 40rpx;
  color: rgba($color-primary, 0.4);
  animation: pulse 4s ease-in-out infinite;
}

@keyframes rotate {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes pulse {
  0%, 100% {
    opacity: 0.4;
  }
  50% {
    opacity: 0.8;
  }
}
</style> 