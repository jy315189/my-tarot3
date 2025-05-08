<template>
  <view class="history-container mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.4;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.3;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
    <!-- 页面内容 -->
    <view class="header">
      <view class="back-button" @tap="goBack">
        <text class="icon">←</text>
      </view>
      <view class="page-title">历史记录</view>
    </view>
    
    <view class="content">
      <view class="history-list" v-if="readingHistory.length > 0">
        <view class="history-item card" v-for="(item, index) in readingHistory" :key="index" @tap="viewReadingDetail(item)">
          <view class="history-date">
            <text class="day">{{formatDay(item.date)}}</text>
            <text class="month">{{formatMonth(item.date)}}</text>
          </view>
          <view class="history-info">
            <text class="history-name">{{item.type}}</text>
            <text class="history-question">{{item.question}}</text>
          </view>
          <view class="history-icon">
            <text class="text-primary">✧</text>
          </view>
        </view>
      </view>
      
      <view class="empty-history card" v-else>
        <image class="empty-icon" src="/static/images/empty-readings.png" mode="aspectFit"></image>
        <text class="empty-text">暂无占卜历史记录</text>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      readingHistory: [
        {
          id: '1',
          type: '单牌占卜',
          question: '今天我适合做重要决定吗？',
          date: new Date(2023, 6, 15),
          cards: [
            { 
              name: '女祭司', 
              image: '/static/images/tarot/major/02-the-high-priestess.png',
              position: '核心答案',
              keywords: '直觉、神秘、内在智慧',
              meaning: '建议您聆听内心的声音，相信直觉。暗示有尚未揭示的答案，需要更深入地探索和耐心等待。'
            }
          ],
          interpretation: '女祭司牌提示您，今天不是做出重要决定的好时机。您需要更多的信息和内在的指引。建议您花时间冥想和反思，让内在智慧指引您找到正确的时机。'
        },
        {
          id: '2',
          type: '三牌展开',
          question: '我的事业发展方向如何？',
          date: new Date(2023, 6, 12),
          cards: [
            { 
              name: '魔术师', 
              image: '/static/images/tarot/major/01-the-magician.png',
              position: '过去',
              keywords: '创造力、表达、实现',
              meaning: '表示您拥有实现目标所需的一切工具和资源。是创造和展示才能的好时机，专注于表达您的创造力。'
            },
            { 
              name: '皇帝', 
              image: '/static/images/tarot/major/04-the-emperor.png',
              position: '现在',
              keywords: '权威、结构、控制',
              meaning: '代表建立秩序与结构的需要。提示您运用逻辑思考，设立明确边界，发挥领导能力解决问题。'
            },
            { 
              name: '星星', 
              image: '/static/images/cards/star.jpg',
              position: '未来',
              keywords: '希望、灵感、平静',
              meaning: '象征希望和灵感的时期。暗示您在经历挑战后将找到平静和新的方向，是追求梦想和理想的时刻。'
            }
          ],
          interpretation: '您过去已经展示了创造力和实现能力，现在正处于需要建立结构和秩序的阶段。未来充满希望和机遇，建议您坚持当前的努力，同时保持开放的心态迎接新的灵感和可能性。'
        },
        {
          id: '3',
          type: '关系解读',
          question: '我们的关系未来会如何发展？',
          date: new Date(2023, 6, 8),
          cards: [
            { 
              name: '愚者', 
              image: '/static/images/tarot/major/00-the-fool.png',
              position: '你的想法',
              keywords: '新开始、无畏、冒险',
              meaning: '代表新的旅程，以开放的心态探索可能性，没有心理负担和限制。提示您放开思想，接受新的冒险。'
            },
            { 
              name: '女皇', 
              image: '/static/images/tarot/major/03-the-empress.png',
              position: '对方想法',
              keywords: '丰盛、滋养、创造力',
              meaning: '象征丰盛与成长的时期。建议您关注滋养自己和他人，表达创造力，享受生活的美好与舒适。'
            }
          ],
          interpretation: '您对关系持有冒险和新鲜的态度，而对方则更注重稳定和成长。这种互补可以是一种优势，但也需要互相理解和尊重各自的需求。建议双方找到平衡点，既保持关系的新鲜感，又给予彼此足够的安全感和滋养。'
        }
      ]
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    // 格式化日期
    formatDay(date) {
      return new Date(date).getDate();
    },
    formatMonth(date) {
      const months = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
      return months[new Date(date).getMonth()];
    },
    // 查看历史记录详情
    viewReadingDetail(item) {
      uni.navigateTo({
        url: `/pages/reading/detail?id=${item.id}`
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.history-container {
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
}

.history-list {
  .history-item {
    display: flex;
    align-items: center;
    padding: 30rpx;
    margin-bottom: 20rpx;
    
    &:last-child {
      margin-bottom: 0;
    }
  }
  
  .history-date {
    width: 100rpx;
    text-align: center;
    margin-right: 20rpx;
    
    .day {
      font-size: 38rpx;
      font-weight: bold;
      display: block;
    }
    
    .month {
      font-size: 24rpx;
      color: $accent-silver;
      display: block;
    }
  }
  
  .history-info {
    flex: 1;
    
    .history-name {
      font-weight: 600;
      font-size: 28rpx;
      display: block;
      margin-bottom: 8rpx;
    }
    
    .history-question {
      font-size: 26rpx;
      color: $accent-silver;
      display: block;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      max-width: 400rpx;
    }
  }
  
  .history-icon {
    font-size: 36rpx;
  }
}

.empty-history {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60rpx;
  
  .empty-icon {
    width: 200rpx;
    height: 200rpx;
    margin-bottom: 30rpx;
    opacity: 0.5;
  }
  
  .empty-text {
    font-size: 28rpx;
    color: $accent-silver;
  }
}
</style> 