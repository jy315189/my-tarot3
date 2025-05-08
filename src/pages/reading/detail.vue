<template>
  <view class="detail-container mystic-bg">
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
      <view class="page-title">占卜详情</view>
      <view class="share-button" @tap="shareReading">
        <text class="icon">⋮</text>
      </view>
    </view>
    
    <view class="content">
      <view class="reading-header card">
        <view class="reading-type">{{readingData.type}}</view>
        <view class="reading-question">{{readingData.question}}</view>
        <view class="reading-date">{{formatDate(readingData.date)}}</view>
      </view>
      
      <view class="card-list">
        <view class="card-item card" v-for="(card, index) in readingData.cards" :key="index">
          <view class="card-visual">
            <image :src="card.image" mode="aspectFit" class="card-image"></image>
          </view>
          <view class="card-info">
            <view class="card-header">
              <text class="card-name">{{card.name}}</text>
              <text class="card-position">{{card.position}}</text>
            </view>
            <text class="card-keywords">{{card.keywords}}</text>
            <text class="card-meaning">{{card.meaning}}</text>
          </view>
        </view>
      </view>
      
      <view class="interpretation card">
        <view class="interpretation-title">综合解读</view>
        <view class="interpretation-content">{{readingData.interpretation}}</view>
      </view>
    </view>
    
    <view class="footer">
      <button class="btn btn-primary" @tap="newReading">开始新的占卜</button>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      id: '',
      readingData: null,
      allReadings: [
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
  onLoad(options) {
    if (options.id) {
      this.id = options.id;
      this.loadReadingData();
    }
  },
  methods: {
    loadReadingData() {
      // 从模拟数据中获取占卜记录
      const reading = this.allReadings.find(item => item.id === this.id);
      if (reading) {
        this.readingData = reading;
      } else {
        // 没有找到对应的记录
        uni.showToast({
          title: '记录不存在',
          icon: 'none'
        });
        setTimeout(() => {
          uni.navigateBack();
        }, 1500);
      }
    },
    goBack() {
      uni.navigateBack();
    },
    formatDate(date) {
      const d = new Date(date);
      return `${d.getFullYear()}年${d.getMonth() + 1}月${d.getDate()}日`;
    },
    shareReading() {
      uni.showActionSheet({
        itemList: ['保存到相册', '分享到微信', '分享到朋友圈'],
        success: (res) => {
          uni.showToast({
            title: '分享成功',
            icon: 'success'
          });
        }
      });
    },
    newReading() {
      uni.navigateTo({
        url: '/pages/reading/prepare'
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.detail-container {
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
  
  .back-button, .share-button {
    width: 60rpx;
    height: 60rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    
    .icon {
      font-size: 36rpx;
      color: $color-text;
    }
  }
  
  .page-title {
    flex: 1;
    text-align: center;
    font-size: 36rpx;
    font-weight: 600;
  }
}

.content {
  flex: 1;
  margin-bottom: 40rpx;
}

.reading-header {
  text-align: center;
  padding: 30rpx;
  margin-bottom: 30rpx;
  
  .reading-type {
    font-size: 32rpx;
    font-weight: 600;
    margin-bottom: 15rpx;
  }
  
  .reading-question {
    font-size: 28rpx;
    margin-bottom: 20rpx;
  }
  
  .reading-date {
    font-size: 24rpx;
    color: $accent-silver;
  }
}

.card-list {
  margin-bottom: 30rpx;
}

.card-item {
  display: flex;
  padding: 20rpx;
  margin-bottom: 20rpx;
  
  &:last-child {
    margin-bottom: 0;
  }
  
  .card-visual {
    width: 120rpx;
    height: 200rpx;
    margin-right: 20rpx;
    
    .card-image {
      width: 100%;
      height: 100%;
      object-fit: contain;
      border-radius: 8rpx;
    }
  }
  
  .card-info {
    flex: 1;
    
    .card-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10rpx;
      
      .card-name {
        font-weight: 600;
        font-size: 28rpx;
      }
      
      .card-position {
        font-size: 24rpx;
        color: $color-primary;
      }
    }
    
    .card-keywords {
      font-size: 24rpx;
      color: $color-text-secondary;
      margin-bottom: 10rpx;
      display: block;
    }
    
    .card-meaning {
      font-size: 26rpx;
      line-height: 1.5;
    }
  }
}

.interpretation {
  padding: 30rpx;
  
  .interpretation-title {
    font-size: 30rpx;
    font-weight: 600;
    margin-bottom: 20rpx;
    text-align: center;
  }
  
  .interpretation-content {
    font-size: 28rpx;
    line-height: 1.6;
  }
}

.footer {
  padding: 20rpx 0;
  
  .btn {
    width: 100%;
    height: 90rpx;
    font-size: 32rpx;
  }
}
</style> 