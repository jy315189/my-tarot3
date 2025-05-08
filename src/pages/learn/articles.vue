<template>
  <view class="learn-articles mystic-bg">
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
        <text class="title">塔罗专题文章</text>
        <text class="subtitle">探索塔罗牌的深层知识与应用</text>
      </view>
      
      <view class="content">
        <!-- 分类筛选 -->
        <view class="category-filter">
          <text 
            v-for="(cat, idx) in categories" 
            :key="idx"
            class="filter-item"
            :class="{ active: selectedCategory === cat }"
            @tap="filterByCategory(cat)"
          >
            {{ cat }}
          </text>
        </view>
        
        <view class="article-list">
          <view class="article-item" v-for="(article, index) in filteredArticles" :key="index" @tap="showArticleDetail(article)">
            <view class="article-date">
              <text class="date-day">{{ formatDay(article.date) }}</text>
              <text class="date-month">{{ formatMonth(article.date) }}</text>
            </view>
            <image :src="article.image" mode="aspectFill" class="article-image"></image>
            <view class="article-info">
              <text class="article-title">{{article.title}}</text>
              <text class="article-desc">{{article.summary}}</text>
              <view class="article-meta">
                <text class="meta-category">{{article.category}}</text>
                <text class="meta-read">阅读全文</text>
              </view>
            </view>
          </view>
        </view>
        
        <!-- 没有文章时的提示 -->
        <view class="empty-state" v-if="filteredArticles.length === 0">
          <text class="empty-icon">📝</text>
          <text class="empty-text">暂无该分类的文章</text>
          <text class="empty-action" @tap="resetFilter">查看所有文章</text>
        </view>
      </view>
    </view>
    
    <!-- 文章详情弹窗 -->
    <view class="article-detail" v-if="activeArticle" @tap.stop="hideArticleDetail">
      <view class="detail-content" @tap.stop>
        <view class="detail-header">
          <text class="detail-title">{{activeArticle.title}}</text>
          <text class="detail-close" @tap="hideArticleDetail">×</text>
        </view>
        
        <view class="detail-body">
          <image :src="activeArticle.image" mode="aspectFill" class="detail-image"></image>
          <view class="detail-info">
            <text class="detail-date">{{formatFullDate(activeArticle.date)}}</text>
            <text class="detail-category">{{activeArticle.category}}</text>
          </view>
          <text class="detail-summary">{{activeArticle.summary}}</text>
          
          <view class="detail-content-text">
            <text v-for="(paragraph, idx) in activeArticle.content" :key="idx" class="paragraph">{{paragraph}}</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'LearnArticles',
  data() {
    return {
      activeArticle: null,
      selectedCategory: '全部',
      categories: ['全部', '历史文化', '心理学', '实用指南', '牌面解析', '灵性成长'],
      articles: [
        {
          id: 1,
          title: '塔罗牌的历史起源与演变',
          summary: '探索塔罗牌从15世纪欧洲游戏到现代占卜工具的完整历史旅程。',
          image: '/static/images/articles/history.png',
          date: '2023-05-15',
          category: '历史文化',
          content: [
            '塔罗牌的起源可以追溯到15世纪的欧洲，最初它仅仅是一种娱乐性的纸牌游戏，被称为"Tarocchi"。这种游戏在意大利贵族中尤为流行，随后传播到法国和其他欧洲国家。',
            '直到18世纪晚期，塔罗牌才开始与神秘学和占卜联系起来。法国神秘学家安托万·库尔·德·热贝林(Antoine Court de Gébelin)在他的著作中首次提出塔罗牌蕴含古埃及智慧的理论，尽管这一说法缺乏历史证据。',
            '19世纪，随着神秘主义的兴起，英国神秘学团体"黄金黎明"(Golden Dawn)对塔罗牌进行了系统性的研究，建立了塔罗牌与卡巴拉、占星术和其他神秘学体系的联系。',
            '20世纪初，亚瑟·爱德华·韦特(Arthur Edward Waite)与画家帕梅拉·科尔曼·史密斯(Pamela Colman Smith)合作创作了如今最为人熟知的韦特-史密斯(Rider-Waite-Smith)塔罗牌，这套牌成为了现代塔罗牌的基础。',
            '今天，塔罗牌已经从简单的游戏发展成为一种强大的自我探索、心理分析和个人成长的工具。不同文化和思想流派也创造了各种风格独特的塔罗牌版本，使这一古老传统在现代社会中继续焕发生机。'
          ]
        },
        {
          id: 2,
          title: '塔罗牌与心理学：荣格视角解析',
          summary: '从荣格心理学角度理解塔罗牌如何反映人类集体潜意识与原型象征。',
          image: '/static/images/articles/psychology.png',
          date: '2023-06-20',
          category: '心理学',
          content: [
            '瑞士心理学家卡尔·荣格(Carl Jung)虽然没有直接研究塔罗牌，但他提出的集体潜意识和原型理论为我们理解塔罗牌提供了全新视角。塔罗牌中的形象可以被视为人类集体潜意识中的原型象征。',
            '大阿卡纳牌如"愚者"、"魔术师"、"女祭司"等，与荣格所描述的原型惊人地吻合。例如，"愚者"代表了纯真与新开始，可以视为"自我"原型的一个方面；而"魔术师"则体现了"阿尼玛/阿尼姆斯"的创造力面向。',
            '荣格认为，心理成长的过程是个体整合各种原型并达到"自性化"(individuation)的过程。从这个角度看，塔罗牌占卜可以视为一种投射技术，帮助人们接触自己的潜意识，并在卡牌象征中看到自己内心的映射。',
            '当我们在塔罗牌阅读中看到特定牌面时，我们的潜意识正在与这些象征建立联系，这些联系可能揭示我们尚未意识到的内在矛盾、渴望或潜力。',
            '因此，从心理学角度看，塔罗牌的价值不在于预测未来，而在于它作为一面镜子，映射出我们内心深处的风景，帮助我们更深入地了解自己，促进心理的整合与成长。'
          ]
        },
        {
          id: 3,
          title: '塔罗牌与现代生活：自我反思的工具',
          summary: '探讨如何将塔罗牌作为日常生活中的自我反思和决策辅助工具。',
          image: '/static/images/articles/daily.png',
          date: '2023-07-10',
          category: '实用指南',
          content: [
            '在当今快节奏的生活中，塔罗牌已经超越了传统占卜的范畴，成为许多人进行自我反思和决策分析的有效工具。每天抽一张牌作为日常反思，或者在面临重要决定时进行专门的牌阵解读，都可以带来新的视角。',
            '塔罗牌的象征性语言提供了一种与我们通常线性思维不同的思考方式。当我们面对复杂问题时，理性分析有时会陷入循环，而塔罗牌的象征和直觉性解读则可能激发创造性思维，帮助我们跳出固有思维模式。',
            '例如，在职业决策中，传统的利弊分析固然重要，但通过塔罗牌，我们可能会发现自己对某个选择的隐藏情感反应，或者之前忽略的可能性。这不是放弃理性思考，而是将直觉和象征思维纳入决策过程。',
            '在人际关系中，塔罗牌可以帮助我们理解关系中的隐藏动态和未表达的需求。例如，当"倒吊人"出现在关系牌阵中，它可能提示我们需要改变视角，或者某段关系需要暂停和反思。',
            '将塔罗牌整合入日常生活的关键在于将其视为反思工具而非命运预言。最终，塔罗牌的价值在于它帮助我们提出更好的问题，而不是给出确定的答案；在于它启发我们探索自己内心的多样性，而不是外部世界的确定性。'
          ]
        },
        {
          id: 4,
          title: '大阿卡纳的冥想之旅：愚者到世界',
          summary: '通过大阿卡纳牌的22张牌面进行一场精神冥想之旅，体验成长与转变。',
          image: '/static/images/articles/journey.png',
          date: '2023-08-05',
          category: '灵性成长',
          content: [
            '大阿卡纳的22张牌可以被视为一个完整的心灵旅程，从"愚者"的纯真与开始，到"世界"的完满与成就。这一旅程映射了人类经验的整个光谱，为深度冥想提供了丰富的框架。',
            '冥想之旅可以从一张牌开始，专注于其象征，让牌面图像在你的意识中扩展，并注意你的情感和身体反应。例如，当冥想"魔术师"牌时，可以思考自己的创造能力和转化能力，感受手中的能量流动。',
            '另一种方式是按顺序进行，将大阿卡纳视为灵魂成长的阶段。例如，从"愚者"到"魔术师"再到"女祭司"的过渡，可以视为从纯粹的潜能，到积极行动，再到内在智慧的发展过程。',
            '在实践中，你可以每天选择一张牌进行10-15分钟的冥想，记录你的感受和见解。随着时间推移，你会发现自己与牌面能量的联系越来越深，冥想体验也越来越丰富。',
            '这种冥想实践不仅帮助你更深入地理解塔罗牌的含义，还能促进自我意识的提升，帮助你连接内在的智慧和创造力，实现个人的整合与成长。'
          ]
        },
        {
          id: 5,
          title: '塔罗牌面详解：高塔的多层含义',
          summary: '深入剖析高塔牌的象征意义、历史变迁和现代解读方式。',
          image: '/static/images/articles/tower.png',
          date: '2023-09-18',
          category: '牌面解析',
          content: [
            '高塔牌（The Tower）是大阿卡纳中最令人印象深刻也最具挑战性的牌面之一。它通常描绘一座被闪电击中的高塔，人们从塔顶坠落。这一强烈的形象象征着突然的变化、混乱和旧结构的崩塌。',
            '从历史上看，高塔牌的解释经历了显著变化。在早期的塔罗传统中，它与巴别塔的故事相联系，象征着人类骄傲和神圣惩罚。随着塔罗解读的世俗化，高塔更多地被理解为生活中不可避免的变革和启示时刻。',
            '在心理学层面，高塔代表那些挑战我们自我认同和信念系统的经历。当我们建立的思想、关系或生活结构不再服务于我们的成长时，高塔能量就会出现，迫使我们放下不再有用的框架。虽然这个过程可能令人不适，但它为真实性和新观点开辟了空间。',
            '在解读实践中，高塔牌的出现通常表明一个重大的生活转变点。它不仅仅预示着挑战，也代表解放和真相的显现。例如，在事业阅读中，高塔可能意味着职业转变；在关系阅读中，它可能表示一段关系中隐藏问题的爆发。',
            '面对高塔能量，关键在于接受变化的必然性，并寻找利用这种能量进行积极转变的方式。正如闪电不仅摧毁也照亮，高塔时刻既是结束，也是新开始的机会。'
          ]
        }
      ]
    }
  },
  computed: {
    filteredArticles() {
      if (this.selectedCategory === '全部') {
        return this.articles;
      } else {
        return this.articles.filter(article => article.category === this.selectedCategory);
      }
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    showArticleDetail(article) {
      this.activeArticle = article;
    },
    hideArticleDetail() {
      this.activeArticle = null;
    },
    filterByCategory(category) {
      this.selectedCategory = category;
    },
    resetFilter() {
      this.selectedCategory = '全部';
    },
    formatDay(dateString) {
      const date = new Date(dateString);
      return date.getDate();
    },
    formatMonth(dateString) {
      const date = new Date(dateString);
      const months = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
      return months[date.getMonth()];
    },
    formatFullDate(dateString) {
      const date = new Date(dateString);
      return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`;
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.learn-articles {
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

/* 分类筛选 */
.category-filter {
  display: flex;
  overflow-x: auto;
  margin-bottom: 30rpx;
  padding-bottom: 10rpx;
  white-space: nowrap;
  
  .filter-item {
    display: inline-block;
    padding: 10rpx 20rpx;
    margin-right: 15rpx;
    font-size: 26rpx;
    color: $color-text-secondary;
    background-color: rgba($color-bg-card, 0.5);
    border-radius: 30rpx;
    
    &.active {
      background-color: $color-primary;
      color: white;
    }
    
    &:last-child {
      margin-right: 0;
    }
  }
}

.article-list {
  .article-item {
    background-color: rgba($color-bg-card, 0.7);
    border-radius: 16rpx;
    margin-bottom: 30rpx;
    overflow: hidden;
    display: flex;
    box-shadow: $soft-shadow;
    position: relative;
    
    .article-date {
      position: absolute;
      top: 15rpx;
      left: 15rpx;
      background-color: rgba($color-primary, 0.8);
      color: white;
      border-radius: 8rpx;
      padding: 10rpx;
      display: flex;
      flex-direction: column;
      align-items: center;
      width: 60rpx;
      z-index: 2;
      
      .date-day {
        font-size: 26rpx;
        font-weight: bold;
      }
      
      .date-month {
        font-size: 20rpx;
      }
    }
    
    .article-image {
      width: 200rpx;
      height: 200rpx;
      object-fit: cover;
    }
    
    .article-info {
      flex: 1;
      padding: 20rpx;
      
      .article-title {
        font-size: 32rpx;
        font-weight: 600;
        color: $color-text;
        margin-bottom: 10rpx;
        display: block;
      }
      
      .article-desc {
        font-size: 24rpx;
        color: $color-text-secondary;
        line-height: 1.4;
        margin-bottom: 15rpx;
        display: block;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      
      .article-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        
        .meta-category {
          font-size: 22rpx;
          color: $color-accent;
          padding: 4rpx 10rpx;
          border-radius: 4rpx;
          background-color: rgba($color-accent, 0.1);
        }
        
        .meta-read {
          font-size: 22rpx;
          color: $color-primary;
          display: flex;
          align-items: center;
          
          &::after {
            content: '→';
            margin-left: 5rpx;
          }
        }
      }
    }
  }
}

/* 空状态 */
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 80rpx 0;
  
  .empty-icon {
    font-size: 80rpx;
    margin-bottom: 20rpx;
  }
  
  .empty-text {
    font-size: 30rpx;
    color: $color-text-secondary;
    margin-bottom: 20rpx;
  }
  
  .empty-action {
    font-size: 28rpx;
    color: $color-primary;
    padding: 10rpx 30rpx;
    border: 1px solid $color-primary;
    border-radius: 30rpx;
  }
}

/* 文章详情弹窗样式 */
.article-detail {
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
        object-fit: cover;
        margin-bottom: 30rpx;
        border-radius: 12rpx;
      }
      
      .detail-info {
        display: flex;
        margin-bottom: 20rpx;
        
        .detail-date {
          font-size: 26rpx;
          color: $color-text-secondary;
          margin-right: 20rpx;
        }
        
        .detail-category {
          font-size: 26rpx;
          color: $color-accent;
        }
      }
      
      .detail-summary {
        font-size: 30rpx;
        font-weight: 600;
        color: $color-text;
        line-height: 1.6;
        margin-bottom: 30rpx;
        display: block;
      }
      
      .detail-content-text {
        .paragraph {
          font-size: 28rpx;
          color: $color-text;
          line-height: 1.8;
          margin-bottom: 20rpx;
          display: block;
          text-align: justify;
        }
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