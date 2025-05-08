<template>
  <view class="learn-index mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.4;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.3;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
    <view class="container">
      <view class="header">
        <text class="title">塔罗学习中心</text>
        <text class="subtitle">探索塔罗的神秘世界</text>
      </view>
      
      <view class="content">
        <view class="sections">
          <!-- 基础知识 -->
          <view class="section-card" @tap="navigateTo('/pages/learn/basics')">
            <view class="section-icon">
              <text class="icon">🔮</text>
            </view>
            <view class="section-info">
              <text class="section-title">塔罗基础知识</text>
              <text class="section-desc">了解塔罗牌的基本结构、分类和含义，掌握阅读的基本原则</text>
            </view>
            <text class="section-arrow">→</text>
          </view>
          
          <!-- 历史文化 -->
          <view class="section-card" @tap="navigateTo('/pages/learn/history')">
            <view class="section-icon">
              <text class="icon">📜</text>
            </view>
            <view class="section-info">
              <text class="section-title">塔罗历史文化</text>
              <text class="section-desc">探索塔罗牌从15世纪到现代的演变历程和文化意义</text>
            </view>
            <text class="section-arrow">→</text>
          </view>
          
          <!-- 牌阵介绍 -->
          <view class="section-card" @tap="navigateTo('/pages/learn/spreads')">
            <view class="section-icon">
              <text class="icon">🃏</text>
            </view>
            <view class="section-info">
              <text class="section-title">塔罗牌阵介绍</text>
              <text class="section-desc">掌握不同场景下的经典牌阵布局，从单卡到复杂牌阵全覆盖</text>
            </view>
            <text class="section-arrow">→</text>
          </view>
          
          <!-- 专题文章 -->
          <view class="section-card" @tap="navigateTo('/pages/learn/articles')">
            <view class="section-icon">
              <text class="icon">📚</text>
            </view>
            <view class="section-info">
              <text class="section-title">塔罗专题文章</text>
              <text class="section-desc">深入探讨塔罗与心理学、灵性、生活哲学等领域的结合</text>
            </view>
            <text class="section-arrow">→</text>
          </view>
        </view>
        
        <!-- 每日小提示 -->
        <view class="daily-tip">
          <view class="tip-header">
            <text class="tip-title">每日小提示</text>
            <text class="tip-date">{{formattedDate}}</text>
          </view>
          <text class="tip-content">{{dailyTip}}</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'LearnIndex',
  data() {
    return {
      dailyTips: [
        '塔罗牌阅读中，牌面朝向（正位/逆位）会改变卡牌的解读，通常逆位表示能量受阻或内在化。',
        '解读塔罗时，要注意卡牌之间的关系和故事流，而不仅是单独看每张牌的含义。',
        '在进行塔罗牌阅读前，确保你的心态平和，环境安静，这样更有助于直觉的发挥。',
        '塔罗牌的小阿卡纳（56张）代表日常生活中的具体事件和情况。',
        '大阿卡纳（22张）代表人生旅程中的重大主题和转折点。',
        '当你在牌阵中看到多张宫廷牌时，可能暗示着你正在处理的情况涉及多人关系或复杂的人际互动。',
        '塔罗牌中的剑牌组通常与思想、沟通、冲突和智慧相关。',
        '星币（或钱币）牌组与物质世界、财富和身体健康有关。',
        '圣杯牌组象征情感、关系和精神层面的体验。',
        '权杖牌组代表激情、创造力、行动和成长。'
      ],
      currentTipIndex: 0
    }
  },
  computed: {
    dailyTip() {
      // 根据今天的日期选择一个固定的提示，确保同一天看到相同提示
      const today = new Date();
      const dayOfYear = Math.floor((today - new Date(today.getFullYear(), 0, 0)) / (1000 * 60 * 60 * 24));
      const index = dayOfYear % this.dailyTips.length;
      return this.dailyTips[index];
    },
    formattedDate() {
      const today = new Date();
      return today.getFullYear() + '年' + (today.getMonth() + 1) + '月' + today.getDate() + '日';
    }
  },
  methods: {
    navigateTo(url) {
      uni.navigateTo({
        url: url
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.learn-index {
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
  text-align: center;
  
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

.sections {
  .section-card {
    background-color: rgba($color-bg-card, 0.7);
    border-radius: 16rpx;
    margin-bottom: 30rpx;
    padding: 24rpx;
    display: flex;
    align-items: center;
    box-shadow: $soft-shadow;
    
    .section-icon {
      width: 80rpx;
      height: 80rpx;
      border-radius: 40rpx;
      background-color: rgba($color-primary, 0.1);
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 20rpx;
      
      .icon {
        font-size: 40rpx;
      }
    }
    
    .section-info {
      flex: 1;
      
      .section-title {
        font-size: 32rpx;
        font-weight: 600;
        color: $color-text;
        margin-bottom: 8rpx;
        display: block;
      }
      
      .section-desc {
        font-size: 24rpx;
        color: $color-text-secondary;
        line-height: 1.4;
      }
    }
    
    .section-arrow {
      font-size: 36rpx;
      color: $color-text-secondary;
      margin-left: 20rpx;
    }
  }
}

.daily-tip {
  background-color: rgba($color-accent, 0.1);
  border-radius: 16rpx;
  padding: 24rpx;
  margin-bottom: 30rpx;
  
  .tip-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16rpx;
    
    .tip-title {
      font-size: 28rpx;
      font-weight: 600;
      color: $color-accent;
    }
    
    .tip-date {
      font-size: 24rpx;
      color: $color-text-secondary;
    }
  }
  
  .tip-content {
    font-size: 26rpx;
    color: $color-text;
    line-height: 1.6;
    font-style: italic;
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