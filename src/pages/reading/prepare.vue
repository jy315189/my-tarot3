<template>
  <view class="prepare-container mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.6;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.5;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
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
          <text class="title">选择牌阵</text>
          <text class="subtitle">每种牌阵适合不同的问题类型</text>
        </view>
        
        <view class="spread-list">
          <view class="spread-item card" 
                v-for="(item, index) in readingTypes" 
                :key="index" 
                @tap="selectReadingType(item)">
            <view class="spread-image-container">
              <image class="spread-image" :src="item.image" mode="aspectFit"></image>
            </view>
            <view class="spread-info">
              <text class="spread-name">{{item.name}}</text>
              <text class="spread-desc">{{item.description}}</text>
              <text class="spread-cards">{{item.cards}}张牌</text>
            </view>
          </view>
        </view>
      </view>
      
      <view class="reading-info card" v-else>
        <view class="reading-title">
          <text class="title">{{readingType}}</text>
          <text class="card-count">{{cardCount}}张牌</text>
        </view>
        
        <view class="reading-description">
          <text>{{getReadingDescription()}}</text>
        </view>
        
        <view class="reading-image">
          <image :src="getReadingImage()" mode="aspectFit" class="spread-image"></image>
        </view>
        
        <view class="change-type">
          <text @tap="changeReadingType">更换牌阵</text>
        </view>
      </view>
      
      <view class="question-section card" v-if="readingType">
        <view class="subtitle">请输入您想要解答的问题</view>
        <textarea class="question-input" v-model="question" placeholder="例如：我的事业发展如何？" placeholder-class="placeholder"></textarea>
        
        <view class="tips">
          <text class="tip-title">提示：</text>
          <text class="tip-text">提问具体且开放性的问题，会得到更准确的指引。</text>
        </view>
      </view>
    </view>
    
    <view class="footer">
      <button v-if="readingType" class="btn btn-primary start-button" @tap="startReading" :disabled="!canStart">开始抽牌</button>
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
          name: '单牌占卜',
          description: '解答简单问题',
          cards: 1,
          image: '/static/images/spread/single.png'
        },
        {
          name: '三牌展开',
          description: '过去、现在、未来',
          cards: 3,
          image: '/static/images/spread/three.png'
        },
        {
          name: '凯尔特十字',
          description: '全面分析情况',
          cards: 5,
          image: '/static/images/spread/cross.png'
        },
        {
          name: '关系解读',
          description: '分析感情和关系',
          cards: 7,
          image: '/static/images/spread/relationship.png'
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
      const descriptions = {
        '单牌占卜': '抽取一张牌，快速了解问题的核心答案。适合简单明确的问题。',
        '三牌展开': '分别代表过去、现在和未来，帮助理解事情的发展脉络和趋势。',
        '凯尔特十字': '五张牌分析问题的各个方面，包括障碍、环境、期望和结果。',
        '关系解读': '七张牌深入分析两人关系，探索双方内在想法和关系未来。'
      };
      
      return descriptions[this.readingType] || '请选择一种占卜方式，每种方式适合不同的问题和情境。';
    },
    getReadingImage() {
      const images = {
        '单牌占卜': '/static/images/spread/single.png',
        '三牌展开': '/static/images/spread/three.png',
        '凯尔特十字': '/static/images/spread/cross.png',
        '关系解读': '/static/images/spread/relationship.png'
      };
      
      return images[this.readingType] || '/static/images/spread/default.png';
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
    flex: 1;
    text-align: center;
    font-size: 36rpx;
    font-weight: 600;
    margin-right: 60rpx; // 平衡左侧按钮宽度
  }
}

.content {
  flex: 1;
  display: flex;
  flex-direction: column;
  margin-bottom: 40rpx;
}

.section-title {
  margin-bottom: 30rpx;
  
  .title {
    font-size: 32rpx;
    font-weight: 600;
    display: block;
    margin-bottom: 10rpx;
  }
  
  .subtitle {
    font-size: 26rpx;
    color: $color-text-secondary;
  }
}

.spread-list {
  .spread-item {
    display: flex;
    padding: 20rpx;
    margin-bottom: 20rpx;
    cursor: pointer;
    transition: transform 0.3s ease;
    
    &:active {
      transform: scale(0.98);
    }
    
    .spread-image-container {
      width: 120rpx;
      height: 120rpx;
      margin-right: 20rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      
      .spread-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
      }
    }
    
    .spread-info {
      flex: 1;
      
      .spread-name {
        font-weight: 600;
        font-size: 28rpx;
        display: block;
        margin-bottom: 10rpx;
      }
      
      .spread-desc {
        font-size: 26rpx;
        color: $color-text-secondary;
        display: block;
        margin-bottom: 15rpx;
      }
      
      .spread-cards {
        background: rgba($color-primary, 0.15);
        color: $color-primary;
        font-size: 24rpx;
        padding: 6rpx 20rpx;
        border-radius: 30rpx;
        display: inline-block;
      }
    }
  }
}

.reading-info {
  margin-bottom: 40rpx;
  
  .reading-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20rpx;
    
    .title {
      font-size: 32rpx;
      font-weight: 600;
    }
    
    .card-count {
      font-size: 24rpx;
      background: rgba($color-primary, 0.15);
      color: $color-primary;
      padding: 6rpx 20rpx;
      border-radius: 30rpx;
    }
  }
  
  .reading-description {
    font-size: 28rpx;
    line-height: 1.6;
    margin-bottom: 30rpx;
    color: $color-text-secondary;
  }
  
  .reading-image {
    display: flex;
    justify-content: center;
    margin-top: 20rpx;
    
    .spread-image {
      width: 100%;
      height: 300rpx;
      object-fit: contain;
    }
  }
  
  .change-type {
    text-align: center;
    margin-top: 20rpx;
    
    text {
      font-size: 26rpx;
      color: $color-primary;
      text-decoration: underline;
      cursor: pointer;
    }
  }
}

.question-section {
  .subtitle {
    font-size: 32rpx;
    font-weight: 500;
    margin-bottom: 30rpx;
  }
  
  .question-input {
    width: 100%;
    height: 200rpx;
    background-color: rgba($color-bg, 0.5);
    border-radius: 12rpx;
    padding: 20rpx;
    font-size: 28rpx;
    color: $color-text;
    margin-bottom: 20rpx;
  }
  
  .placeholder {
    color: rgba($color-text, 0.5);
  }
  
  .tips {
    background-color: rgba($color-primary, 0.1);
    padding: 20rpx;
    border-radius: 12rpx;
    
    .tip-title {
      font-weight: 600;
      font-size: 26rpx;
      color: $color-primary;
      margin-right: 10rpx;
    }
    
    .tip-text {
      font-size: 26rpx;
      color: $color-text-secondary;
    }
  }
}

.footer {
  padding: 20rpx 0;
  
  .start-button {
    width: 100%;
    height: 90rpx;
    font-size: 32rpx;
    
    &[disabled] {
      opacity: 0.6;
      background: rgba($color-primary, 0.5);
    }
  }
}
</style> 