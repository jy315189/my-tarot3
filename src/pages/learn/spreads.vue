<template>
  <view class="learn-spreads mystic-bg">
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
        <text class="title">塔罗牌阵</text>
        <text class="subtitle">了解不同牌阵的含义与用法</text>
      </view>
      
      <view class="content">
        <view class="spread-list">
          <view class="spread-item" v-for="(spread, index) in spreads" :key="index" @tap="showSpreadDetail(spread)">
            <image :src="spread.image" mode="aspectFill" class="spread-image"></image>
            <view class="spread-info">
              <text class="spread-name">{{spread.name}}</text>
              <text class="spread-desc">{{spread.description}}</text>
              <view class="spread-stats">
                <view class="stat">
                  <text class="stat-label">难度</text>
                  <view class="difficulty">
                    <text v-for="n in 5" :key="n" class="star" :class="{ active: n <= spread.difficulty }">★</text>
                  </view>
                </view>
                <view class="stat">
                  <text class="stat-label">卡牌数</text>
                  <text class="stat-value">{{spread.cardCount}}</text>
                </view>
              </view>
            </view>
          </view>
        </view>
      </view>
    </view>
    
    <!-- 牌阵详情弹窗 -->
    <view class="spread-detail" v-if="activeSpread" @tap.stop="hideSpreadDetail">
      <view class="detail-content" @tap.stop>
        <view class="detail-header">
          <text class="detail-title">{{activeSpread.name}}</text>
          <text class="detail-close" @tap="hideSpreadDetail">×</text>
        </view>
        
        <view class="detail-body">
          <image :src="activeSpread.image" mode="aspectFit" class="detail-image"></image>
          <text class="detail-description">{{activeSpread.description}}</text>
          
          <view class="position-list">
            <text class="positions-title">牌位解释</text>
            <view class="position-item" v-for="(position, idx) in activeSpread.positions" :key="idx">
              <view class="position-number">{{idx + 1}}</view>
              <view class="position-info">
                <text class="position-name">{{position.name}}</text>
                <text class="position-desc">{{position.meaning}}</text>
              </view>
            </view>
          </view>
          
          <view class="detail-section">
            <text class="section-title">适用场景</text>
            <text class="section-content">{{activeSpread.suitableFor}}</text>
          </view>
          
          <view class="detail-section">
            <text class="section-title">解读技巧</text>
            <text class="section-content">{{activeSpread.tips}}</text>
          </view>
        </view>
        
        <view class="detail-footer">
          <button class="btn btn-primary" @tap="startReading">使用此牌阵占卜</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'LearnSpreads',
  data() {
    return {
      activeSpread: null,
      spreads: [
        {
          id: 1,
          name: '单卡占卜',
          description: '最基础的塔罗牌阵，只需一张牌就能快速获得指引。适合日常简单问题或每日指引。',
          image: '/static/images/spread/single.png',
          difficulty: 1,
          cardCount: 1,
          suitableFor: '日常决策、简单问题、每日指引、初学者练习',
          tips: '专注于你的问题，深入理解这张牌在当前情境中的意义。关注牌面元素的细节和象征意义，思考它如何与你的具体情况产生共鸣。',
          positions: [
            {
              name: '核心信息',
              meaning: '代表问题的核心答案或关键信息，直接回应提问者的疑问。'
            }
          ]
        },
        {
          id: 2,
          name: '三卡展开',
          description: '经典的三卡牌阵，代表过去、现在和未来，呈现问题的时间线和发展趋势。',
          image: '/static/images/spread/three-card.png',
          difficulty: 2,
          cardCount: 3,
          suitableFor: '了解情况发展、寻求简单建议、分析问题的不同阶段',
          tips: '注意三张牌之间的关联和流动，它们共同讲述一个故事。从过去学习教训，理解现状，预见未来可能的发展。',
          positions: [
            {
              name: '过去',
              meaning: '代表过去的影响因素，或已经发生的事件对当前情况的影响。'
            },
            {
              name: '现在',
              meaning: '表示当前所处的状态和面临的挑战或机遇。'
            },
            {
              name: '未来',
              meaning: '显示情况可能的发展方向或结果，提供前进的指引。'
            }
          ]
        },
        {
          id: 3,
          name: '凯尔特十字',
          description: '最著名的塔罗牌阵之一，通过十字形布局深入分析问题的多个方面和潜在影响。',
          image: '/static/images/spread/cross.png',
          difficulty: 4,
          cardCount: 10,
          suitableFor: '复杂问题分析、全面了解情况、深度自我探索',
          tips: '中央十字部分是核心，展示当前情况的本质和走向。下方的牌显示心理状态，上方的牌代表可能结果，左侧是过去，右侧是未来。最后一列从下往上阅读，显示情况的演变。',
          positions: [
            {
              name: '当前状况',
              meaning: '代表目前面临的核心问题或情况。'
            },
            {
              name: '挑战',
              meaning: '横跨第一张牌，表示阻碍或需要克服的障碍。'
            },
            {
              name: '过去基础',
              meaning: '过去对当前情况的影响，通常是刚刚发生的事件。'
            },
            {
              name: '过去影响',
              meaning: '更远的过去，形成现在问题的根源。'
            },
            {
              name: '潜在结果',
              meaning: '如果继续当前道路，最可能的结果。'
            },
            {
              name: '近期未来',
              meaning: '即将发生的事情，通常在几周内。'
            },
            {
              name: '自我认知',
              meaning: '提问者对自己和情况的看法与态度。'
            },
            {
              name: '外部影响',
              meaning: '环境因素和他人对情况的影响。'
            },
            {
              name: '希望和恐惧',
              meaning: '提问者内心的期望和担忧。'
            },
            {
              name: '最终结果',
              meaning: '综合所有因素后的最终可能结果。'
            }
          ]
        },
        {
          id: 4,
          name: '关系解读',
          description: '专为分析两人关系设计的牌阵，帮助理解双方想法、共同点和关系发展方向。',
          image: '/static/images/spread/relationship.png',
          difficulty: 3,
          cardCount: 7,
          suitableFor: '恋爱关系分析、友谊评估、工作伙伴关系、家庭关系',
          tips: '关注双方各自的牌与中间共同牌的关系，寻找和谐点和冲突源。前三张牌代表两个人和他们的连接，后四张展示关系动态和可能的发展。',
          positions: [
            {
              name: '你的想法',
              meaning: '代表你对这段关系的看法、态度和感受。'
            },
            {
              name: '对方想法',
              meaning: '显示对方如何看待这段关系、他们的期望和感受。'
            },
            {
              name: '关系连接',
              meaning: '两人之间的纽带、共同点或核心动力。'
            },
            {
              name: '关系挑战',
              meaning: '当前关系面临的主要问题或需要克服的障碍。'
            },
            {
              name: '过去影响',
              meaning: '过去的经历如何影响当前关系状态。'
            },
            {
              name: '近期发展',
              meaning: '关系在短期内的可能变化和发展方向。'
            },
            {
              name: '长期前景',
              meaning: '如果保持当前路径，关系的长期走向和潜力。'
            }
          ]
        },
        {
          id: 5,
          name: '时间展开',
          description: '按时间顺序展开的牌阵，提供更具体的时间线指引，适合规划和长期决策。',
          image: '/static/images/spread/timeline.png',
          difficulty: 3,
          cardCount: 5,
          suitableFor: '规划未来、了解事件时间线、评估长期项目',
          tips: '将每张牌视为特定时间点的快照，注意卡牌之间的演变和连续性。如果出现困难牌，思考那个时期可能需要做的准备和调整。',
          positions: [
            {
              name: '现在',
              meaning: '当前状况和起点。'
            },
            {
              name: '一个月内',
              meaning: '短期内可能出现的变化和机会。'
            },
            {
              name: '三个月内',
              meaning: '中期发展和需要关注的事项。'
            },
            {
              name: '六个月内',
              meaning: '较长期的趋势和转变。'
            },
            {
              name: '一年内',
              meaning: '长期结果和到达点。'
            }
          ]
        }
      ]
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    showSpreadDetail(spread) {
      this.activeSpread = spread;
    },
    hideSpreadDetail() {
      this.activeSpread = null;
    },
    startReading() {
      if (this.activeSpread) {
        uni.navigateTo({
          url: `/pages/reading/prepare?spreadId=${this.activeSpread.id}&spreadName=${encodeURIComponent(this.activeSpread.name)}&cardCount=${this.activeSpread.cardCount}`
        });
      }
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.learn-spreads {
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

.spread-list {
  .spread-item {
    background-color: rgba($color-bg-card, 0.7);
    border-radius: 16rpx;
    margin-bottom: 30rpx;
    overflow: hidden;
    display: flex;
    box-shadow: $soft-shadow;
    
    .spread-image {
      width: 200rpx;
      height: 200rpx;
      object-fit: cover;
    }
    
    .spread-info {
      flex: 1;
      padding: 20rpx;
      
      .spread-name {
        font-size: 32rpx;
        font-weight: 600;
        color: $color-text;
        margin-bottom: 10rpx;
        display: block;
      }
      
      .spread-desc {
        font-size: 24rpx;
        color: $color-text-secondary;
        line-height: 1.4;
        margin-bottom: 15rpx;
        display: block;
      }
      
      .spread-stats {
        display: flex;
        
        .stat {
          margin-right: 30rpx;
          display: flex;
          align-items: center;
          
          .stat-label {
            font-size: 22rpx;
            color: $color-text-secondary;
            margin-right: 10rpx;
          }
          
          .difficulty {
            display: flex;
            
            .star {
              font-size: 22rpx;
              color: rgba($color-text, 0.3);
              margin-right: 2rpx;
              
              &.active {
                color: $color-accent;
              }
            }
          }
          
          .stat-value {
            font-size: 22rpx;
            color: $color-accent;
          }
        }
      }
    }
  }
}

/* 弹窗样式 */
.spread-detail {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba($color-bg, 0.8);
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: center;
  
  .detail-content {
    width: 90%;
    max-height: 90vh;
    background-color: $color-bg-card;
    border-radius: 20rpx;
    display: flex;
    flex-direction: column;
    box-shadow: $deep-shadow;
    
    .detail-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 30rpx;
      border-bottom: 1rpx solid rgba($color-text, 0.1);
      
      .detail-title {
        font-size: 36rpx;
        font-weight: 600;
        color: $color-text;
      }
      
      .detail-close {
        font-size: 40rpx;
        color: $color-text-secondary;
      }
    }
    
    .detail-body {
      padding: 30rpx;
      flex: 1;
      overflow-y: auto;
      
      .detail-image {
        width: 100%;
        height: 350rpx;
        object-fit: contain;
        margin-bottom: 30rpx;
        background-color: rgba($color-bg, 0.3);
        border-radius: 12rpx;
      }
      
      .detail-description {
        font-size: 28rpx;
        color: $color-text;
        line-height: 1.6;
        margin-bottom: 30rpx;
        display: block;
      }
      
      .position-list {
        margin-bottom: 30rpx;
        
        .positions-title {
          font-size: 32rpx;
          font-weight: 600;
          color: $color-text;
          margin-bottom: 20rpx;
          display: block;
        }
        
        .position-item {
          display: flex;
          margin-bottom: 20rpx;
          
          .position-number {
            width: 50rpx;
            height: 50rpx;
            border-radius: 25rpx;
            background-color: $color-primary;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26rpx;
            margin-right: 20rpx;
            flex-shrink: 0;
          }
          
          .position-info {
            flex: 1;
            
            .position-name {
              font-size: 28rpx;
              font-weight: 600;
              color: $color-text;
              margin-bottom: 5rpx;
              display: block;
            }
            
            .position-desc {
              font-size: 26rpx;
              color: $color-text-secondary;
              line-height: 1.4;
            }
          }
        }
      }
      
      .detail-section {
        margin-bottom: 25rpx;
        
        .section-title {
          font-size: 32rpx;
          font-weight: 600;
          color: $color-text;
          margin-bottom: 15rpx;
          display: block;
        }
        
        .section-content {
          font-size: 28rpx;
          color: $color-text;
          line-height: 1.6;
        }
      }
    }
    
    .detail-footer {
      padding: 20rpx 30rpx;
      border-top: 1rpx solid rgba($color-text, 0.1);
      
      .btn {
        width: 100%;
        height: 90rpx;
        line-height: 90rpx;
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