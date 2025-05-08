<template>
  <view class="card-library mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.4;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.3;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
    <view class="container">
      <view class="header">
        <text class="title">塔罗牌库</text>
        <text class="subtitle">探索78张塔罗牌的奥秘</text>
      </view>
      
      <view class="search-bar">
        <input type="text" placeholder="搜索塔罗牌..." v-model="searchQuery" />
        <button class="search-btn" @tap="searchCards">搜索</button>
      </view>
      
      <view class="category-tabs">
        <view 
          class="tab" 
          :class="{ active: activeCategory === 'all' }" 
          @tap="setCategory('all')"
        >全部</view>
        <view 
          class="tab" 
          :class="{ active: activeCategory === 'major' }" 
          @tap="setCategory('major')"
        >大阿卡纳</view>
        <view 
          class="tab" 
          :class="{ active: activeCategory === 'minor' }" 
          @tap="setCategory('minor')"
        >小阿卡纳</view>
      </view>
      
      <view class="content">
        <!-- 大阿卡纳卡片 -->
        <view v-if="activeCategory === 'all' || activeCategory === 'major'" class="card-section">
          <view class="section-header" v-if="activeCategory === 'all'">
            <text class="section-title">大阿卡纳</text>
            <text class="section-subtitle">代表人生的重大阶段和力量</text>
          </view>
          
          <view class="card-grid">
            <view 
              class="card-item" 
              v-for="(card, index) in filteredMajorArcana" 
              :key="'major-'+index"
              @tap="navigateToDetail(card)"
            >
              <image :src="card.image" mode="aspectFill" class="card-image" />
              <view class="card-info">
                <text class="card-name">{{card.name}}</text>
                <text class="card-number">{{card.number}}</text>
              </view>
            </view>
          </view>
        </view>
        
        <!-- 小阿卡纳卡片 -->
        <view v-if="activeCategory === 'all' || activeCategory === 'minor'" class="card-section">
          <view class="section-header" v-if="activeCategory === 'all'">
            <text class="section-title">小阿卡纳</text>
            <text class="section-subtitle">代表日常生活的方方面面</text>
          </view>
          
          <!-- 权杖牌 -->
          <view class="suit-section" v-if="filteredMinorArcana.wands.length > 0">
            <text class="suit-title">权杖</text>
            <view class="card-grid">
              <view 
                class="card-item" 
                v-for="(card, index) in filteredMinorArcana.wands" 
                :key="'wands-'+index"
                @tap="navigateToDetail(card)"
              >
                <image :src="card.image" mode="aspectFill" class="card-image" />
                <view class="card-info">
                  <text class="card-name">{{card.name}}</text>
                </view>
              </view>
            </view>
          </view>
          
          <!-- 圣杯牌 -->
          <view class="suit-section" v-if="filteredMinorArcana.cups.length > 0">
            <text class="suit-title">圣杯</text>
            <view class="card-grid">
              <view 
                class="card-item" 
                v-for="(card, index) in filteredMinorArcana.cups" 
                :key="'cups-'+index"
                @tap="navigateToDetail(card)"
              >
                <image :src="card.image" mode="aspectFill" class="card-image" />
                <view class="card-info">
                  <text class="card-name">{{card.name}}</text>
                </view>
              </view>
            </view>
          </view>
          
          <!-- 宝剑牌 -->
          <view class="suit-section" v-if="filteredMinorArcana.swords.length > 0">
            <text class="suit-title">宝剑</text>
            <view class="card-grid">
              <view 
                class="card-item" 
                v-for="(card, index) in filteredMinorArcana.swords" 
                :key="'swords-'+index"
                @tap="navigateToDetail(card)"
              >
                <image :src="card.image" mode="aspectFill" class="card-image" />
                <view class="card-info">
                  <text class="card-name">{{card.name}}</text>
                </view>
              </view>
            </view>
          </view>
          
          <!-- 金币牌 -->
          <view class="suit-section" v-if="filteredMinorArcana.pentacles.length > 0">
            <text class="suit-title">金币</text>
            <view class="card-grid">
              <view 
                class="card-item" 
                v-for="(card, index) in filteredMinorArcana.pentacles" 
                :key="'pentacles-'+index"
                @tap="navigateToDetail(card)"
              >
                <image :src="card.image" mode="aspectFill" class="card-image" />
                <view class="card-info">
                  <text class="card-name">{{card.name}}</text>
                </view>
              </view>
            </view>
          </view>
        </view>
        
        <!-- 无结果提示 -->
        <view class="no-results" v-if="!hasResults">
          <text>没有找到匹配的卡牌</text>
          <button class="reset-btn" @tap="resetSearch">重置搜索</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'CardLibrary',
  data() {
    return {
      searchQuery: '',
      activeCategory: 'all',
      majorArcana: [
        { 
          id: 0, 
          name: '愚者', 
          number: '0',
          image: '/static/images/tarot/major/00-the-fool.png',
          keywords: '新开始、无畏、冒险',
          meaning: '代表新的旅程，以开放的心态探索可能性，没有心理负担和限制。提示您放开思想，接受新的冒险。',
          reversed: '鲁莽、忽视风险、不负责任',
          element: '风',
          astrology: '天王星',
          category: 'major'
        },
        { 
          id: 1, 
          name: '魔术师', 
          number: 'I',
          image: '/static/images/tarot/major/01-the-magician.png',
          keywords: '创造力、表达、实现',
          meaning: '表示您拥有实现目标所需的一切工具和资源。是创造和展示才能的好时机，专注于表达您的创造力。',
          reversed: '操纵、欺骗、未开发的才能',
          element: '水/气',
          astrology: '水星',
          category: 'major'
        },
        { 
          id: 2, 
          name: '女祭司', 
          number: 'II',
          image: '/static/images/tarot/major/02-the-high-priestess.png',
          keywords: '直觉、神秘、内在智慧',
          meaning: '建议您聆听内心的声音，相信直觉。暗示有尚未揭示的答案，需要更深入地探索和耐心等待。',
          reversed: '忽视直觉、表面信息、隐藏的动机',
          element: '水',
          astrology: '月亮',
          category: 'major'
        },
        // 添加剩余大阿卡纳牌...
        { 
          id: 3, 
          name: '女皇', 
          number: 'III',
          image: '/static/images/tarot/major/03-the-empress.png',
          keywords: '丰盛、滋养、创造力',
          meaning: '象征丰盛与成长的时期。建议您关注滋养自己和他人，表达创造力，享受生活的美好与舒适。',
          reversed: '依赖、过度保护、创造力阻塞',
          element: '土',
          astrology: '金星',
          category: 'major'
        },
        { 
          id: 4, 
          name: '皇帝', 
          number: 'IV',
          image: '/static/images/tarot/major/04-the-emperor.png',
          keywords: '权威、结构、控制',
          meaning: '代表建立秩序与结构的需要。提示您运用逻辑思考，设立明确边界，发挥领导能力解决问题。',
          reversed: '专制、僵化、控制欲过强',
          element: '火',
          astrology: '白羊座',
          category: 'major'
        },
        // 其余大阿卡纳牌数据...
      ],
      minorArcana: {
        wands: [
          {
            name: '权杖王牌',
            suit: '权杖',
            number: '1',
            image: '/static/images/tarot/minor/ace-of-wands.png',
            keywords: '创造力、灵感、新的开始',
            meaning: '代表创造力的爆发和新的开始。充满激情和能量的种子，预示事业、项目或冒险的开始。',
            reversed: '创意受阻、缺乏激情、错失机会',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖二',
            suit: '权杖',
            number: '2',
            image: '/static/images/tarot/minor/2-of-wands.png',
            keywords: '规划、未来视野、进展',
            meaning: '与规划未来和扩大视野有关。表示您站在十字路口，需要在更广阔的范围内思考和规划。',
            reversed: '恐惧未知、缺乏计划、决策困难',
            element: '火',
            category: 'minor'
          },
          // 添加剩余权杖牌...
        ],
        cups: [
          {
            name: '圣杯王牌',
            suit: '圣杯',
            number: '1',
            image: '/static/images/tarot/minor/ace-of-cups.png',
            keywords: '情感、爱、直觉',
            meaning: '象征情感丰富和新感情的开始。预示爱情、友谊或创意灵感的新篇章。',
            reversed: '情感封闭、爱的阻碍、创意受阻',
            element: '水',
            category: 'minor'
          },
          // 添加剩余圣杯牌...
        ],
        swords: [
          {
            name: '宝剑王牌',
            suit: '宝剑',
            number: '1',
            image: '/static/images/tarot/minor/ace-of-swords.png',
            keywords: '清晰、真相、突破',
            meaning: '象征思想的清晰和新的洞察力。预示突破、理性思考和真相的揭示。',
            reversed: '混乱思维、虚假信息、沟通不良',
            element: '风',
            category: 'minor'
          },
          // 添加剩余宝剑牌...
        ],
        pentacles: [
          {
            name: '金币王牌',
            suit: '金币',
            number: '1',
            image: '/static/images/tarot/minor/ace-of-pentacles.png',
            keywords: '物质机会、繁荣、新开始',
            meaning: '象征物质世界的新机会。可能预示新工作、投资或财务机会的开始。',
            reversed: '错失机会、物质损失、贪婪',
            element: '土',
            category: 'minor'
          },
          // 添加剩余金币牌...
        ]
      }
    }
  },
  computed: {
    filteredMajorArcana() {
      if (!this.searchQuery) {
        return this.majorArcana;
      }
      
      const query = this.searchQuery.toLowerCase();
      return this.majorArcana.filter(card => 
        card.name.toLowerCase().includes(query) || 
        card.keywords.toLowerCase().includes(query) ||
        card.meaning.toLowerCase().includes(query)
      );
    },
    filteredMinorArcana() {
      if (!this.searchQuery) {
        return this.minorArcana;
      }
      
      const query = this.searchQuery.toLowerCase();
      const filtered = {
        wands: this.minorArcana.wands.filter(card => 
          card.name.toLowerCase().includes(query) || 
          card.keywords.toLowerCase().includes(query) ||
          card.meaning.toLowerCase().includes(query)
        ),
        cups: this.minorArcana.cups.filter(card => 
          card.name.toLowerCase().includes(query) || 
          card.keywords.toLowerCase().includes(query) ||
          card.meaning.toLowerCase().includes(query)
        ),
        swords: this.minorArcana.swords.filter(card => 
          card.name.toLowerCase().includes(query) || 
          card.keywords.toLowerCase().includes(query) ||
          card.meaning.toLowerCase().includes(query)
        ),
        pentacles: this.minorArcana.pentacles.filter(card => 
          card.name.toLowerCase().includes(query) || 
          card.keywords.toLowerCase().includes(query) ||
          card.meaning.toLowerCase().includes(query)
        )
      };
      
      return filtered;
    },
    hasResults() {
      if (this.activeCategory === 'all') {
        return this.filteredMajorArcana.length > 0 || 
               this.filteredMinorArcana.wands.length > 0 ||
               this.filteredMinorArcana.cups.length > 0 ||
               this.filteredMinorArcana.swords.length > 0 ||
               this.filteredMinorArcana.pentacles.length > 0;
      } else if (this.activeCategory === 'major') {
        return this.filteredMajorArcana.length > 0;
      } else {
        return this.filteredMinorArcana.wands.length > 0 ||
               this.filteredMinorArcana.cups.length > 0 ||
               this.filteredMinorArcana.swords.length > 0 ||
               this.filteredMinorArcana.pentacles.length > 0;
      }
    }
  },
  methods: {
    setCategory(category) {
      this.activeCategory = category;
    },
    searchCards() {
      // 搜索功能已通过计算属性实现
    },
    resetSearch() {
      this.searchQuery = '';
    },
    navigateToDetail(card) {
      // 将卡牌信息序列化为查询参数
      const cardData = encodeURIComponent(JSON.stringify(card));
      uni.navigateTo({
        url: `/pages/cards/detail?card=${cardData}`
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.card-library {
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
  text-align: center;
  margin-bottom: 40rpx;
  
  .title {
    font-size: 40rpx;
    font-weight: 600;
    color: $color-text;
    margin-bottom: 10rpx;
  }
  
  .subtitle {
    font-size: 28rpx;
    color: $color-text-secondary;
  }
}

.search-bar {
  display: flex;
  margin-bottom: 30rpx;
  
  input {
    flex: 1;
    height: 80rpx;
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 10rpx;
    padding: 0 20rpx;
    font-size: 28rpx;
  }
  
  .search-btn {
    width: 120rpx;
    height: 80rpx;
    background-color: $color-primary;
    color: white;
    font-size: 28rpx;
    border-radius: 10rpx;
    margin-left: 10rpx;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

.category-tabs {
  display: flex;
  margin-bottom: 30rpx;
  border-radius: 10rpx;
  overflow: hidden;
  background-color: rgba(255, 255, 255, 0.2);
  
  .tab {
    flex: 1;
    height: 80rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28rpx;
    color: $color-text;
    
    &.active {
      background-color: $color-primary;
      color: white;
    }
  }
}

.content {
  padding-bottom: 30rpx;
}

.card-section {
  margin-bottom: 40rpx;
}

.section-header {
  margin-bottom: 20rpx;
  
  .section-title {
    font-size: 34rpx;
    font-weight: 600;
    color: $color-text;
    margin-bottom: 5rpx;
    display: block;
  }
  
  .section-subtitle {
    font-size: 24rpx;
    color: $color-text-secondary;
  }
}

.suit-section {
  margin-bottom: 30rpx;
  
  .suit-title {
    font-size: 30rpx;
    font-weight: 600;
    color: $color-primary;
    margin-bottom: 15rpx;
    display: block;
  }
}

.card-grid {
  display: flex;
  flex-wrap: wrap;
  margin: 0 -10rpx;
}

.card-item {
  width: calc(33.333% - 20rpx);
  margin: 10rpx;
  border-radius: 12rpx;
  overflow: hidden;
  box-shadow: 0 4rpx 8rpx rgba(0, 0, 0, 0.1);
  background-color: white;
  position: relative;
  
  &::before {
    content: '';
    display: block;
    padding-top: 160%;  // 宽高比例 5:8
  }
  
  .card-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .card-info {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(0, 0, 0, 0.6);
    padding: 10rpx;
    
    .card-name {
      font-size: 24rpx;
      color: white;
      display: block;
      text-align: center;
    }
    
    .card-number {
      font-size: 20rpx;
      color: rgba(255, 255, 255, 0.8);
      display: block;
      text-align: center;
    }
  }
}

.no-results {
  padding: 60rpx 0;
  text-align: center;
  
  text {
    display: block;
    font-size: 30rpx;
    color: $color-text-secondary;
    margin-bottom: 20rpx;
  }
  
  .reset-btn {
    display: inline-block;
    padding: 20rpx 40rpx;
    background-color: $color-primary;
    color: white;
    font-size: 28rpx;
    border-radius: 8rpx;
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