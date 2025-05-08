<template>
  <view class="prepare-container mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.6;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.5;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    <view class="mystic-star" style="top: 40%; left: 25%;">✧</view>
    <view class="mystic-star" style="bottom: 40%; right: 15%;">✦</view>
    
    <!-- 页面内容 -->
    <view class="header">
      <view class="back-button" @tap="goBack">
        <text class="icon">←</text>
      </view>
      <view class="page-title">准备占卜</view>
    </view>
    
    <view class="content">
      <!-- 选择牌阵部分 -->
      <view class="reading-types" v-if="!readingType">
        <view class="section-title">
          <text class="title mystic">选择牌阵</text>
          <text class="subtitle">每种牌阵适合不同的问题类型</text>
        </view>
        
        <view class="spread-list">
          <view class="spread-item card" 
                v-for="(item, index) in readingTypes" 
                :key="index" 
                @tap="selectReadingType(item)">
            <view class="spread-image-container">
              <image class="spread-image" :src="item.image" mode="aspectFit"></image>
              <view class="image-glow"></view>
            </view>
            <view class="spread-info">
              <text class="spread-name mystic">{{item.name}}</text>
              <text class="spread-desc">{{item.description}}</text>
              <text class="spread-cards">{{item.cards}}张牌</text>
            </view>
          </view>
        </view>
      </view>
      
      <view class="reading-info card" v-else>
        <view class="reading-title">
          <text class="title mystic">{{readingType}}</text>
          <text class="card-count">{{cardCount}}张牌</text>
        </view>
        
        <view class="reading-description">
          <text>{{getReadingDescription()}}</text>
        </view>
        
        <view class="reading-image">
          <image :src="getReadingImage()" mode="aspectFit" class="spread-diagram"></image>
     
        </view>
        
        <view class="change-type">
          <text @tap="changeReadingType" class="change-link">✧ 更换牌阵</text>
        </view>
      </view>
      
      <view class="question-section card" v-if="readingType">
        <view class="subtitle mystic">请输入您想要解答的问题</view>
        <textarea class="question-input" v-model="question" placeholder="例如：我的事业发展如何？" placeholder-class="placeholder"></textarea>
        
        <view class="tips">
          <text class="tip-title">✦ 提示：</text>
          <text class="tip-text">提问具体且开放性的问题，会得到更准确的指引。</text>
        </view>
      </view>
    </view>
    
    <view class="footer">
      <button v-if="readingType" class="btn btn-primary start-button" @tap="startReading" :disabled="!canStart">
        <text class="btn-icon">✦</text>
        <text>开始抽牌</text>
      </button>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      readingType: '',
      cardCount: 1,
      question: '',
      readingTypes: [
        {
          name: '时间之箭',
          description: '揭示过去、现在和未来的发展脉络，帮助理解事件走向',
          cards: 3,
          image: '/static/images/spread/single.png'
        },
        {
          name: '是非问题',
          description: '通过两张牌的对比，为是与否的决策提供清晰指引',
          cards: 2,
          image: '/static/images/spread/three.png'
        },
        {
          name: '圣三角',
          description: '从问题本质、挑战和解决方案三个维度全面分析',
          cards: 3,
          image: '/static/images/spread/three.png'
        },
        {
          name: '钻石展开法',
          description: '深度剖析事件的起因、影响和最终走向，洞察完整发展',
          cards: 5,
          image: '/static/images/spread/cross.png'
        },
        {
          name: '恋人金字塔',
          description: '探索双方感受和共同基础，预测恋情可能的发展方向',
          cards: 6,
          image: '/static/images/spread/relationship.png'
        },
        {
          name: '自我探索',
          description: '照见真实的自己，探索内在动力和潜在的成长方向',
          cards: 4,
          image: '/static/images/spread/three.png'
        },
        {
          name: '吉普赛十字',
          description: '分析双方在关系中的位置，揭示关系核心和可能走向',
          cards: 5,
          image: '/static/images/spread/cross.png'
        },
        {
          name: '二选一',
          description: '对比分析两种选择的本质和可能结果，辅助重要决策',
          cards: 5,
          image: '/static/images/spread/cross.png'
        },
        {
          name: '关系发展',
          description: '深入理解双方真实想法与期望，预测关系潜在发展',
          cards: 6,
          image: '/static/images/spread/relationship.png'
        },
        {
          name: '六芒星',
          description: '全面解析复杂事业和项目，探究多种影响因素和长期走向',
          cards: 7,
          image: '/static/images/spread/relationship.png'
        },
        {
          name: '凯尔特十字',
          description: '古老强大的综合牌阵，多维度深入剖析重大问题和人生方向',
          cards: 10,
          image: '/static/images/spread/cross.png'
        }
      ]
    }
  },
  computed: {
    canStart() {
      return this.question.trim().length > 0;
    }
  },
  onLoad(options) {
    // 获取路由参数
    if (options.type) {
      this.readingType = options.type;
    }
    if (options.cards) {
      this.cardCount = parseInt(options.cards);
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    getReadingDescription() {
      // 查找当前选择的牌阵
      const selectedReading = this.readingTypes.find(item => item.name === this.readingType);
      if (selectedReading) {
        return selectedReading.description + '\n\n请选择一种占卜方式，每种方式适合不同的问题和情境。';
      }
      
      return '请选择一种占卜方式，每种方式适合不同的问题和情境。';
    },
    getReadingImage() {
      // 查找当前选择的牌阵
      const selectedReading = this.readingTypes.find(item => item.name === this.readingType);
      if (selectedReading) {
        return selectedReading.image;
      }
      
      return '/static/images/spread/default.png';
    },
    selectReadingType(type) {
      this.readingType = type.name;
      this.cardCount = type.cards;
    },
    changeReadingType() {
      this.readingType = '';
      this.cardCount = 1;
    },
    startReading() {
      if (!this.canStart) return;
      
      // 跳转到抽牌页面
      uni.navigateTo({
        url: `/pages/reading/draw?type=${encodeURIComponent(this.readingType)}&cards=${this.cardCount}&question=${encodeURIComponent(this.question)}`
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.prepare-container {
  min-height: 100vh;
  padding: 40rpx 30rpx;
  box-sizing: border-box;
  position: relative;
  display: flex;
  flex-direction: column;
}

.header {
  display: flex;
  align-items: center;
  margin-bottom: 40rpx;
  
  .back-button {
    width: 60rpx;
    height: 60rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    
    .icon {
      font-size: 40rpx;
      color: $color-text;
    }
  }
  
  .page-title {
    font-size: 36rpx;
    font-weight: 600;
    color: $color-text;
    margin-left: 20rpx;
  }
}

.content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.section-title {
  margin-bottom: 30rpx;
  
  .title {
    font-size: 36rpx;
    font-weight: 600;
    display: block;
    margin-bottom: 10rpx;
    color: $color-text;
  }
  
  .subtitle {
    font-size: 28rpx;
    color: $accent-silver;
  }
}

.spread-list {
  .spread-item {
    display: flex;
    padding: 20rpx;
    margin-bottom: 30rpx;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
    
    &:hover, &:active {
      transform: translateY(-5rpx);
      box-shadow: 0 15rpx 30rpx rgba(0, 0, 0, 0.2);
    }
    
    &::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 4rpx;
      height: 100%;
      background: linear-gradient(to bottom, $color-primary, $color-accent);
    }
    
    .spread-image-container {
      width: 120rpx;
      height: 120rpx;
      position: relative;
      margin-right: 20rpx;
      
      .spread-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
        z-index: 1;
        position: relative;
      }
      
      .image-glow {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        border-radius: 10rpx;
        background: radial-gradient(circle at center, rgba($color-primary, 0.2) 0%, transparent 70%);
        z-index: 0;
      }
    }
    
    .spread-info {
      flex: 1;
      
      .spread-name {
        font-size: 30rpx;
        font-weight: 600;
        margin-bottom: 10rpx;
        display: block;
      }
      
      .spread-desc {
        font-size: 26rpx;
        color: $color-text-secondary;
        margin-bottom: 15rpx;
        display: block;
        line-height: 1.4;
      }
      
      .spread-cards {
        font-size: 24rpx;
        color: $color-accent;
        background-color: rgba($color-accent, 0.1);
        padding: 6rpx 15rpx;
        border-radius: 20rpx;
        display: inline-block;
      }
    }
  }
}

.reading-info {
  padding: 30rpx;
  margin-bottom: 30rpx;
  position: relative;
  overflow: hidden;
  
  &::after {
    content: '';
    position: absolute;
    top: -50rpx;
    right: -50rpx;
    width: 100rpx;
    height: 100rpx;
    background: radial-gradient(circle, rgba($color-primary, 0.2), transparent 70%);
    border-radius: 50%;
  }
  
  .reading-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20rpx;
    padding-bottom: 15rpx;
    border-bottom: 1px solid rgba($color-primary, 0.1);
    
    .title {
      font-size: 34rpx;
      font-weight: 600;
    }
    
    .card-count {
      font-size: 26rpx;
      color: $color-accent;
      background-color: rgba($color-accent, 0.1);
      padding: 6rpx 15rpx;
      border-radius: 20rpx;
    }
  }
  
  .reading-description {
    font-size: 28rpx;
    color: $color-text-secondary;
    line-height: 1.6;
    margin-bottom: 30rpx;
    white-space: pre-line;
  }
  
  .reading-image {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20rpx 0 30rpx;
    position: relative;
    height: 220rpx;
    
    .spread-diagram {
      width: 100%;
      height: 200rpx;
      object-fit: contain;
      position: relative;
      z-index: 1;
    }
    
    .image-glow {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 70%;
      height: 70%;
      border-radius: 50%;
      background: radial-gradient(circle, rgba($color-primary, 0.2), transparent 70%);
      z-index: 0;
    }
  }
  
  .change-type {
    text-align: center;
    margin-top: 20rpx;
    
    .change-link {
      font-size: 28rpx;
      color: $color-primary;
      text-decoration: underline;
      display: inline-block;
      padding: 10rpx 20rpx;
      border-radius: 30rpx;
      transition: all 0.3s ease;
      
      &:hover, &:active {
        background-color: rgba($color-primary, 0.1);
      }
    }
  }
}

.question-section {
  padding: 30rpx;
  margin-bottom: 30rpx;
  
  .subtitle {
    font-size: 30rpx;
    margin-bottom: 20rpx;
    display: block;
    font-weight: 600;
  }
  
  .question-input {
    width: 100%;
    height: 180rpx;
    background-color: rgba($color-bg, 0.5);
    border-radius: 12rpx;
    padding: 20rpx;
    font-size: 28rpx;
    color: $color-text;
    margin-bottom: 20rpx;
    border: 1px solid rgba($color-primary, 0.2);
    box-sizing: border-box;
  }
  
  .placeholder {
    color: rgba($color-text, 0.5);
  }
  
  .tips {
    background-color: rgba($color-primary, 0.05);
    padding: 15rpx 20rpx;
    border-radius: 10rpx;
    
    .tip-title {
      font-size: 26rpx;
      font-weight: 600;
      color: $color-primary;
      margin-right: 10rpx;
    }
    
    .tip-text {
      font-size: 26rpx;
      color: $color-text-secondary;
      line-height: 1.5;
    }
  }
}

.footer {
  padding: 20rpx 0;
  
  .start-button {
    width: 100%;
    height: 90rpx;
    border-radius: 45rpx;
    font-size: 32rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    
    .btn-icon {
      margin-right: 10rpx;
      font-size: 24rpx;
    }
    
    &:disabled {
      opacity: 0.7;
      background-color: rgba($color-primary, 0.5);
    }
  }
}

.mystic {
  background: linear-gradient(to right, $color-primary, $color-accent);
  -webkit-background-clip: text;
  color: transparent;
}

// 神秘背景元素
.mystic-circle {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba($color-primary, 0.3);
  z-index: 0;
}

.mystic-star {
  position: absolute;
  font-size: 40rpx;
  color: rgba($color-primary, 0.4);
  z-index: 0;
  animation: twinkle 3s infinite alternate;
}

@keyframes twinkle {
  0% {
    opacity: 0.3;
  }
  100% {
    opacity: 0.8;
  }
}
</style> 