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
          name: '时间之箭',
          description: '简单而有效的牌阵，帮助回答各种简单问题，呈现过去、现在和未来的时间线。',
          image: '/static/images/spread/single.png',
          difficulty: 1,
          cardCount: 3,
          suitableFor: '日常决策、简单问题、了解事件发展、新手入门',
          tips: '专注于你的问题，观察牌之间的联系，理解事件如何从过去发展到未来。',
          positions: [
            {
              name: '过去',
              meaning: '代表影响当前情况的过去事件或因素。'
            },
            {
              name: '现在',
              meaning: '显示当前所处的状态和面临的情况。'
            },
            {
              name: '未来',
              meaning: '指示可能的发展方向和结果。'
            }
          ]
        },
        {
          id: 2,
          name: '是非问题',
          description: '专门设计用来回答是非类问题的简单牌阵，通过两张牌对比提供清晰答案。',
          image: '/static/images/spread/three-card.png',
          difficulty: 1,
          cardCount: 2,
          suitableFor: '简单的是非问题、二选一决策、需要明确方向的情况',
          tips: '清晰明确地提出你的是非问题，留意两张牌的对比和互动，寻找答案的倾向性。',
          positions: [
            {
              name: '是/积极面',
              meaning: '代表选择"是"或积极方向的能量和可能结果。'
            },
            {
              name: '否/消极面',
              meaning: '代表选择"否"或消极方向的能量和可能结果。'
            }
          ]
        },
        {
          id: 3,
          name: '圣三角',
          description: '三张牌形成的三角形布局，从不同维度回答问题，提供深入的洞察。',
          image: '/static/images/spread/three-card.png',
          difficulty: 2,
          cardCount: 3,
          suitableFor: '多维度分析问题、寻求全面的解决方案、平衡不同因素',
          tips: '将三个牌位视为相互关联的整体，共同创造出一个平衡的答案。留意三角形的能量流动。',
          positions: [
            {
              name: '问题本质',
              meaning: '代表当前问题的核心或本质所在。'
            },
            {
              name: '挑战或阻碍',
              meaning: '显示需要克服的障碍或注意的问题。'
            },
            {
              name: '解决方案',
              meaning: '提供可能的解决途径或建议的行动。'
            }
          ]
        },
        {
          id: 4,
          name: '钻石展开法',
          description: '钻石形状的布局，专注于事件的发展走向，帮助理解事件的完整脉络。',
          image: '/static/images/spread/cross.png',
          difficulty: 3,
          cardCount: 5,
          suitableFor: '分析事件发展、了解项目走向、评估长期计划',
          tips: '从中心点开始阅读，向外扩展。注意事件如何从起因发展到结果，以及内外因素的影响。',
          positions: [
            {
              name: '当前状况',
              meaning: '事件的现状或核心问题。'
            },
            {
              name: '起因',
              meaning: '导致当前状况的原因或起点。'
            },
            {
              name: '近期发展',
              meaning: '即将到来的变化或短期发展。'
            },
            {
              name: '外部影响',
              meaning: '环境因素或他人对事件的影响。'
            },
            {
              name: '最终走向',
              meaning: '事件可能的结果或长期发展方向。'
            }
          ]
        },
        {
          id: 5,
          name: '恋人金字塔',
          description: '金字塔形布局，专为恋情分析设计，帮助理解爱情关系的各个层面。',
          image: '/static/images/spread/relationship.png',
          difficulty: 3,
          cardCount: 6,
          suitableFor: '分析恋爱关系、了解爱情走向、评估感情发展可能性',
          tips: '从底部向顶部阅读，底部是基础，顶部是结果。注意牌与牌之间的关系，寻找爱情的整体走向。',
          positions: [
            {
              name: '关系基础',
              meaning: '你们关系的基础或起点。'
            },
            {
              name: '你的感受',
              meaning: '你对这段关系的真实感受和想法。'
            },
            {
              name: '对方感受',
              meaning: '对方对这段关系的真实感受和想法。'
            },
            {
              name: '共同点',
              meaning: '你们之间的联系或共同目标。'
            },
            {
              name: '挑战',
              meaning: '关系中面临的困难或需要克服的障碍。'
            },
            {
              name: '恋情走向',
              meaning: '关系的可能发展方向和结果。'
            }
          ]
        },
        {
          id: 6,
          name: '自我探索',
          description: '帮助认清自己在当前处境中的位置，加深自我认知和理解。',
          image: '/static/images/spread/timeline.png',
          difficulty: 2,
          cardCount: 4,
          suitableFor: '自我反思、处境分析、个人成长、明确方向',
          tips: '保持开放的心态，不带判断地接受卡牌的反馈。这个牌阵是关于你自己的内在旅程。',
          positions: [
            {
              name: '真实的我',
              meaning: '你当前的真实状态和内在感受。'
            },
            {
              name: '外在形象',
              meaning: '你向他人展示的一面或他人对你的看法。'
            },
            {
              name: '内在动力',
              meaning: '驱动你的内在力量或潜意识欲望。'
            },
            {
              name: '成长方向',
              meaning: '你需要发展的方向或内在潜力。'
            }
          ]
        },
        {
          id: 7,
          name: '吉普赛十字',
          description: '传统的十字形布局，专注于人际关系的分析，揭示关系的多个维度。',
          image: '/static/images/spread/cross.png',
          difficulty: 3,
          cardCount: 5,
          suitableFor: '分析各类人际关系、了解关系动态、解决关系冲突',
          tips: '从中心向外阅读，中心代表关系的核心。注意牌与牌的互动和相互影响，它们一起描绘了关系的全貌。',
          positions: [
            {
              name: '关系核心',
              meaning: '关系的本质或当前状态。'
            },
            {
              name: '你的立场',
              meaning: '你在关系中的位置和态度。'
            },
            {
              name: '对方立场',
              meaning: '对方在关系中的位置和态度。'
            },
            {
              name: '关系基础',
              meaning: '支撑关系的基础或过去的影响。'
            },
            {
              name: '关系走向',
              meaning: '关系的发展方向和可能的结果。'
            }
          ]
        },
        {
          id: 8,
          name: '二选一',
          description: '帮助在多个选择间做决定的牌阵，比较不同选项的结果和影响。',
          image: '/static/images/spread/timeline.png',
          difficulty: 2,
          cardCount: 5,
          suitableFor: '做出选择、比较不同方案、评估各种可能性',
          tips: '清晰地定义你的两个选择，然后比较每个选项的牌面，寻找对你更有利的方向。',
          positions: [
            {
              name: '当前状况',
              meaning: '你现在面临的情况和需要做决定的背景。'
            },
            {
              name: '选择A',
              meaning: '第一个选择的本质或特点。'
            },
            {
              name: '选择A结果',
              meaning: '选择A可能带来的结果或影响。'
            },
            {
              name: '选择B',
              meaning: '第二个选择的本质或特点。'
            },
            {
              name: '选择B结果',
              meaning: '选择B可能带来的结果或影响。'
            }
          ]
        },
        {
          id: 9,
          name: '关系发展',
          description: '深入分析两人关系的牌阵，揭示双方的想法、期望以及关系的潜在发展。',
          image: '/static/images/spread/relationship.png',
          difficulty: 3,
          cardCount: 6,
          suitableFor: '深入了解关系、分析双方想法差异、预测关系发展',
          tips: '将牌阵分为左右两部分，分别代表你和对方，中间部分则是关系本身。注意寻找双方牌面的和谐或冲突点。',
          positions: [
            {
              name: '你的真实想法',
              meaning: '你对关系的真实想法和感受。'
            },
            {
              name: '你的期望',
              meaning: '你希望从这段关系中得到什么。'
            },
            {
              name: '对方真实想法',
              meaning: '对方对关系的真实想法和感受。'
            },
            {
              name: '对方的期望',
              meaning: '对方希望从这段关系中得到什么。'
            },
            {
              name: '共同基础',
              meaning: '你们关系的基础或共同点。'
            },
            {
              name: '关系发展',
              meaning: '关系的潜在发展方向和可能性。'
            }
          ]
        },
        {
          id: 10,
          name: '六芒星',
          description: '强大的六角星形布局，全面分析事业和事件的各个方面，适合复杂问题。',
          image: '/static/images/spread/relationship.png',
          difficulty: 4,
          cardCount: 7,
          suitableFor: '事业分析、复杂事件评估、全面了解情况、长期规划',
          tips: '从中心开始阅读，然后按顺时针方向阅读周围的牌。注意牌之间的相互关系和整体星形的能量流动。',
          positions: [
            {
              name: '核心情况',
              meaning: '当前情况的核心或问题的本质。'
            },
            {
              name: '过去基础',
              meaning: '过去的影响或情况的起源。'
            },
            {
              name: '内在态度',
              meaning: '你对情况的内在态度或潜意识影响。'
            },
            {
              name: '目标或期望',
              meaning: '你希望达成的目标或最佳结果。'
            },
            {
              name: '外部影响',
              meaning: '环境因素或他人的影响。'
            },
            {
              name: '近期发展',
              meaning: '情况的近期变化或短期结果。'
            },
            {
              name: '最终结果',
              meaning: '情况的长期走向或最终结果。'
            }
          ]
        },
        {
          id: 11,
          name: '凯尔特十字',
          description: '最著名的塔罗牌阵之一，通过十字形布局深入分析问题的多个方面和潜在影响。这是一个古老而强大的牌阵。',
          image: '/static/images/spread/cross.png',
          difficulty: 5,
          cardCount: 10,
          suitableFor: '复杂问题分析、全面了解情况、深度自我探索、重大决策',
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