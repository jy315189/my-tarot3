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
          <image :src="activeSpread.image" mode="aspectFit" class="detail-image" @tap="showFullscreenImage"></image>
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
    
    <!-- 全屏图片查看器 -->
    <view class="fullscreen-image-viewer" v-if="isFullscreenImageVisible" @tap="hideFullscreenImage">
      <image :src="getFullscreenImageUrl()" mode="aspectFit" class="fullscreen-image"></image>
      <view class="fullscreen-close">×</view>
      <view class="image-hint">点击任意位置关闭</view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'LearnSpreads',
  data() {
    return {
      activeSpread: null,
      isFullscreenImageVisible: false,
      spreads: [
        {
          id: 1,
          name: '时间之箭',
          description: '简单而有效的牌阵，可以回答一些简单的问题，呈现过去、现在和未来的时间线。',
          image: '/static/images/spread/Time Arrow.png',
          difficulty: 1,
          cardCount: 3,
          suitableFor: '日常决策、简单问题、了解事件发展、新手入门',
          tips: '改变未来最好的时间在于过去，如果发现占卜的未来塔罗牌含义不理想，可以想想过去塔罗牌所表示的问题加以改正。',
          positions: [
            {
              name: '过去',
              meaning: '表示过去的事件或影响因素。'
            },
            {
              name: '现在',
              meaning: '表示现在的状态和面临的情况。'
            },
            {
              name: '未来',
              meaning: '表示未来可能的发展方向。'
            }
          ]
        },
        {
          id: 2,
          name: '是非问题',
          description: '专门设计用来回答是非类问题的牌阵，通过三张牌的组合提供答案。',
          image: '/static/images/spread/YesNo Questions.png',
          difficulty: 1,
          cardCount: 3,
          suitableFor: '会不会，能不能，行不行，爱不爱之类的主题',
          tips: '正位表示你需要继续发扬的，逆位表示你需要改正的。判断标准：三张全正位表示是，两正一逆表示可能性高，一正两逆表示可能性低，三张全逆位表示否。',
          positions: [
            {
              name: '第一张牌',
              meaning: '影响结果的第一个因素。'
            },
            {
              name: '第二张牌',
              meaning: '影响结果的第二个因素。'
            },
            {
              name: '第三张牌',
              meaning: '影响结果的第三个因素。'
            }
          ]
        },
        {
          id: 3,
          name: '圣三角',
          description: '三张牌形成的三角形布局，可以回答一些简单问题，提供深入的洞察。',
          image: '/static/images/spread/Sacred Triangle.png',
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
          description: '钻石形状的布局，可以回答一些事件走向类的问题，帮助理解事件的完整脉络。',
          image: '/static/images/spread/Diamond Spread.png',
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
          description: '金字塔形布局，可以回答一些恋爱走向问题，专为恋情分析设计，帮助理解爱情关系。',
          image: '/static/images/spread/Lovers Pyramid.png',
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
          description: '在某些处境下认清自己，探索内在动力和潜在的成长方向。',
          image: '/static/images/spread/Self-Exploration.png',
          difficulty: 2,
          cardCount: 4,
          suitableFor: '自我认知、个人成长、内在探索、寻找人生方向',
          tips: '安静地与自己对话，让牌面揭示你内心真实的想法和感受。注重直觉的指引，不要急于判断。',
          positions: [
            {
              name: '真实自我',
              meaning: '代表你内心深处的真实自我或本质。'
            },
            {
              name: '动力来源',
              meaning: '显示驱使你前进的内在动力或欲望。'
            },
            {
              name: '成长挑战',
              meaning: '指出阻碍你成长的内在障碍或限制。'
            },
            {
              name: '潜在方向',
              meaning: '揭示你潜在的成长方向或未开发的可能性。'
            }
          ]
        },
        {
          id: 7,
          name: '吉普赛十字',
          description: '十字形布局，可以回答关系走向问题，揭示关系的核心和可能的发展。',
          image: '/static/images/spread/Gypsy Cross.png',
          difficulty: 3,
          cardCount: 5,
          suitableFor: '关系分析、情感问题、人际互动、冲突解决',
          tips: '以中心牌为核心，上下左右四张牌展示关系的动态和走向。关注牌与牌之间的互动和能量流动。',
          positions: [
            {
              name: '关系核心',
              meaning: '代表关系的本质或当前状态。'
            },
            {
              name: '你的立场',
              meaning: '显示你在关系中的态度和行为。'
            },
            {
              name: '对方立场',
              meaning: '显示对方在关系中的态度和行为。'
            },
            {
              name: '潜在挑战',
              meaning: '指出关系中的障碍或需要解决的问题。'
            },
            {
              name: '关系走向',
              meaning: '揭示关系可能的发展方向和结果。'
            }
          ]
        },
        {
          id: 8,
          name: '二选一',
          description: '可以回答并比较一些多种选择问题，对比分析两种选择的本质和可能结果。',
          image: '/static/images/spread/Choose One of Two.png',
          difficulty: 2,
          cardCount: 5,
          suitableFor: '重要决策、选择比较、利弊分析、职业选择、人生岔路',
          tips: '清晰区分两个选择的牌组，分别分析每个选择的本质和结果，然后进行对比。关注两组牌之间的对话和中间牌的指引。',
          positions: [
            {
              name: '选择一本质',
              meaning: '代表第一个选择的本质或内在特点。'
            },
            {
              name: '选择一结果',
              meaning: '显示选择第一个选项可能导致的结果。'
            },
            {
              name: '决策指引',
              meaning: '提供在两个选择之间的平衡点或综合考量。'
            },
            {
              name: '选择二本质',
              meaning: '代表第二个选择的本质或内在特点。'
            },
            {
              name: '选择二结果',
              meaning: '显示选择第二个选项可能导致的结果。'
            }
          ]
        },
        {
          id: 9,
          name: '关系发展',
          description: '可以回答一些双方想法与期望，深入理解关系动态和未来发展。',
          image: '/static/images/spread/Relationship Development.png',
          difficulty: 3,
          cardCount: 6,
          suitableFor: '深入分析关系、理解双方期望、预测关系发展、解决关系问题',
          tips: '关注双方想法和期望之间的相似性和差异性，理解这些因素如何影响关系的整体发展。',
          positions: [
            {
              name: '你的真实想法',
              meaning: '代表你对这段关系的真实想法和感受。'
            },
            {
              name: '对方的真实想法',
              meaning: '显示对方对这段关系的真实想法和感受。'
            },
            {
              name: '你的期望',
              meaning: '代表你对这段关系的期望和希望。'
            },
            {
              name: '对方的期望',
              meaning: '显示对方对这段关系的期望和希望。'
            },
            {
              name: '现有困难',
              meaning: '指出关系中存在的问题或挑战。'
            },
            {
              name: '未来发展',
              meaning: '预示关系可能的发展方向和结果。'
            }
          ]
        },
        {
          id: 10,
          name: '六芒星',
          description: '强大的六角星形布局，可以回答一些事业事件走向类的问题，适合复杂问题分析。',
          image: '/static/images/spread/Six-Pointed Star.png',
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
          description: '古老的牌阵，多维度深入分析问题的各个方面和潜在影响。',
          image: '/static/images/spread/Celtic Cross.png',
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
              name: '希望与恐惧',
              meaning: '提问者对结果的希望或恐惧。'
            },
            {
              name: '最终结果',
              meaning: '问题的最终结果或长期影响。'
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
          url: `/pages/reading/prepare?type=${encodeURIComponent(this.activeSpread.name)}&cards=${this.activeSpread.cardCount}`
        });
      }
    },
    showFullscreenImage() {
      this.isFullscreenImageVisible = true;
    },
    hideFullscreenImage() {
      this.isFullscreenImageVisible = false;
    },
    getFullscreenImageUrl() {
      if (!this.activeSpread) return '';
      
      // 获取当前图片路径
      const currentImgPath = this.activeSpread.image;
      
      // 构建高清图片路径 - 使用bak2中的高清图
      const filename = currentImgPath.split('/').pop();
      const hdImagePath = `/static/images/spread/bak2/${filename}`;
      
      return hdImagePath;
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

/* 全屏图片查看器样式 */
.fullscreen-image-viewer {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.9);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  animation: fade-in 0.3s ease;
}

.fullscreen-image {
  max-width: 100%;
  max-height: 90vh;
  object-fit: contain;
  animation: scale-in 0.3s ease;
}

.fullscreen-close {
  position: absolute;
  top: 30rpx;
  right: 30rpx;
  width: 70rpx;
  height: 70rpx;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.2);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 50rpx;
  font-weight: 200;
}

.image-hint {
  position: absolute;
  bottom: 50rpx;
  color: rgba(255, 255, 255, 0.7);
  font-size: 24rpx;
}

@keyframes fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes scale-in {
  from {
    transform: scale(0.95);
  }
  to {
    transform: scale(1);
  }
}

/* 添加图片点击效果 */
.detail-image {
  cursor: pointer;
  transition: transform 0.3s ease;
  
  &:hover {
    transform: scale(1.02);
  }
  
  &:active {
    transform: scale(0.98);
  }
}
</style> 