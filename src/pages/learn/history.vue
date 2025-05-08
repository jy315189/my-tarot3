<template>
  <view class="learn-history mystic-bg">
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
        <text class="title">塔罗牌历史文化</text>
        <text class="subtitle">探索塔罗的起源与演变</text>
      </view>

      <!-- 内容区域 -->
      <view class="content">
        <!-- 内容标签切换 -->
        <view class="content-tabs">
          <view 
            v-for="(tab, index) in tabs" 
            :key="index" 
            class="tab" 
            :class="{ active: activeTabIndex === index }"
            @tap="activeTabIndex = index"
          >
            {{tab.name}}
          </view>
        </view>
        
        <view class="tab-content">
          <!-- 历史画廊 -->
          <view class="history-gallery">
            <scroll-view class="gallery-scroll" scroll-x="true" show-scrollbar="false">
              <view class="gallery-item">
                <image src="/static/images/tarot/history/visconti-sforza.jpg" mode="aspectFill" class="gallery-image"></image>
                <text class="gallery-caption">维斯康蒂-斯福尔扎塔罗牌</text>
              </view>
              <view class="gallery-item">
                <image src="/static/images/tarot/history/visconti-magician.jpg" mode="aspectFill" class="gallery-image"></image>
                <text class="gallery-caption">魔术师牌(1450年)</text>
              </view>
              <view class="gallery-item">
                <image src="/static/images/tarot/history/cary-sheet.jpg" mode="aspectFill" class="gallery-image"></image>
                <text class="gallery-caption">凯里集成页(约1500年)</text>
              </view>
              <view class="gallery-item">
                <image src="/static/images/tarot/history/fool-vergnano.jpg" mode="aspectFill" class="gallery-image"></image>
                <text class="gallery-caption">愚者牌(维尔加诺塔罗)</text>
              </view>
              <view class="gallery-item">
                <image src="/static/images/tarot/history/major-arcana-collection.jpg" mode="aspectFill" class="gallery-image"></image>
                <text class="gallery-caption">大阿卡纳牌组合</text>
              </view>
            </scroll-view>
          </view>

          <!-- 起源与早期历史 -->
          <view v-if="activeTabIndex === 0" class="section">
            <view class="section-header">
              <text class="section-title">起源与发展</text>
            </view>
            <view class="section-content">
              <view class="image-text-flex">
                <view class="text-block">
                  <text class="paragraph">塔罗牌(Tarot)源自15世纪中期的意大利北部，最初是一种纸牌游戏，而非占卜工具。塔罗牌具有丰富的历史，经历了从娱乐工具到神秘学应用的转变，反映了欧洲文化、艺术和精神观念的演变。</text>
                  <text class="paragraph">塔罗牌的称谓发音为/ˈtæroʊ/，最初被称为"trionfi"，后来被称为"tarocchi"或"tarocks"。它是一副由78张牌组成的牌组，包括22张特殊的"大阿尔卡纳"(Major Arcana)和56张"小阿尔卡纳"(Minor Arcana)。</text>
                </view>
                <image class="side-image" src="/static/images/tarot/history/fool-vergnano.jpg" mode="aspectFit"></image>
              </view>
            </view>

            <view class="section-header">
              <text class="section-title">早期历史</text>
            </view>
            <view class="section-content">
              <view class="image-text-flex reverse">
                <view class="text-block">
                  <text class="paragraph">纸牌在欧洲的历史可以追溯到14世纪，最早的记录来自1367年的瑞士伯尔尼。学者们认为，早期的欧洲纸牌可能基于14世纪或更早的埃及马穆鲁克纸牌(Egyptian Mamluk deck)，这种纸牌随着纸张从亚洲传入西欧而出现。</text>
                  <text class="paragraph">塔罗牌最早出现于意大利北部的费拉拉(Ferrara)和米兰(Milan)，当时在标准的意大利纸牌（棍棒、钱币、圣杯和宝剑四种花色）基础上，增加了"愚人"和21张"王牌"（当时称为"trionfi"）。</text>
                  <text class="paragraph">第一批有记录的塔罗牌出现于1440年至1450年间的米兰、费拉拉、佛罗伦萨和博洛尼亚，当时额外的王牌牌面带有寓意性的图案。这些新牌组被称为"carte da trionfi"，即"胜利牌"，额外的牌被简称为"trionfi"，在英语中演变为"trumps"（王牌）。</text>
                </view>
                <image class="side-image" src="/static/images/tarot/history/cary-sheet.jpg" mode="aspectFit"></image>
              </view>
            </view>

            <view class="section-header">
              <text class="section-title">最古老的塔罗牌</text>
            </view>
            <view class="section-content">
              <view class="full-width-image-container">
                <image class="history-image" src="/static/images/tarot/history/visconti-magician.jpg" mode="aspectFit"></image>
              </view>
              <view class="image-text-flex">
                <view class="text-block full-width">
                  <text class="paragraph">现存最古老的塔罗牌是维斯康蒂-斯福尔扎塔罗牌(Visconti-Sforza Tarot)，约有15副，绘制于15世纪中期，为米兰公国的统治者所用。这些手绘牌组艺术价值极高，反映了文艺复兴时期的艺术风格和贵族审美。</text>
                  <text class="paragraph">由于早期的塔罗牌是手绘的，因此数量相对较少。直到印刷机的发明，才使得大规模生产牌组成为可能。塔罗牌从意大利向外扩张，首先是法国和瑞士，这一过程发生在意大利战争期间。在这两个国家最著名的版本是马赛塔罗牌(Tarot of Marseilles)，源自米兰。</text>
                </view>
              </view>
            </view>
          </view>

          <!-- 区域变种与名称 -->
          <view v-if="activeTabIndex === 1" class="section">
            <view class="section-header">
              <text class="section-title">传播与区域变异</text>
            </view>
            <view class="section-content">
              <view class="regional-variations">
                <image src="/static/images/tarot/history/wurttembergischer-tarock.jpg" mode="aspectFit" class="variations-image"></image>
                <text class="variations-caption">德国维滕贝格塔罗牌</text>
              </view>
              <text class="paragraph">虽然塔罗牌的组成基本一致，但其排序和命名在不同地区有所不同。塔罗学者迈克尔·杜梅特(Michael Dummett)将它们分为三类：博洛尼亚和佛罗伦萨类型、费拉拉类型和米兰类型。这些不同版本的塔罗牌向不同的方向传播，形成了各自的传统。</text>
              <text class="paragraph">在佛罗伦萨，后来出现了一种名为"Minchiate"的扩展牌组，包含97张牌，增加了占星符号和四元素等额外内容。</text>
              <text class="paragraph">18世纪是塔罗牌最大的复兴时期，它成为欧洲最流行的纸牌游戏之一，除爱尔兰、英国、伊比利亚半岛和奥斯曼巴尔干地区外，几乎遍布欧洲各地。</text>
            </view>

            <view class="section-header">
              <text class="section-title">名称的起源</text>
            </view>
            <view class="section-content">
              <view class="image-text-flex">
                <view class="text-block">
                  <text class="paragraph">"tarot"一词和德语"Tarock"源自意大利语"Tarocchi"，其确切起源尚不明确，虽然在15世纪末到16世纪初，"taroch"曾作为"愚蠢"的同义词使用。在15世纪，这种牌组仅被称为"Trionfi"。新名称首次出现于1502年左右的布雷西亚(Brescia)，当时称为"Tarocho"。</text>
                  <text class="paragraph">16世纪，一种与标准牌组一起玩的新游戏"Trionfa"迅速流行起来，与此同时，原有游戏被重新命名为"tarocchi"。在现代意大利语中，单数形式是"Tarocco"，作为名词，也指一种血橙品种。</text>
                </view>
                <image class="side-image" src="/static/images/tarot/major/05-the-hierophant.png" mode="aspectFit"></image>
              </view>
            </view>

            <view class="section-header">
              <text class="section-title">塔罗牌游戏</text>
            </view>
            <view class="section-content">
              <view class="full-width-image-container">
                <image src="/static/images/tarot/history/tarot-players.jpg" mode="aspectFill" class="history-image"></image>
                <text class="image-caption">塔罗牌游戏玩家</text>
              </view>
              <text class="paragraph">塔罗牌的原始目的是用来玩游戏。1425年之前，马蒂亚诺·达·托尔托纳(Martiano da Tortona)的手稿中提供了类似塔罗牌的简要游戏规则。随后两个世纪，游戏规则的描述都相当模糊，直到1637年才有第一个法国变种的完整规则描述。</text>
              <text class="paragraph">塔罗牌游戏有许多地区变种。Tarocchini在博洛尼亚幸存下来，皮埃蒙特和西西里地区也仍有其他变种，但总体而言，这种游戏在意大利的流行程度不如其他地方。</text>
              <text class="paragraph">今天，塔罗牌游戏在法国有强大的社区，中欧的前奥匈帝国边界内地区也广泛流行塔罗克(tarock)、塔罗克(tarok)或塔罗克(tarokk)等地区塔罗牌游戏。</text>
            </view>
          </view>

          <!-- 神秘学与现代影响 -->
          <view v-if="activeTabIndex === 2" class="section">
            <view class="section-header">
              <text class="section-title">占卜用途的兴起</text>
            </view>
            <view class="section-content">
              <view class="full-width-image-container">
                <image src="/static/images/tarot/history/oudlers1910.png" mode="aspectFit" class="history-image"></image>
                <text class="image-caption">1910年的"Oudlers"塔罗牌</text>
              </view>
              
              <view class="info-box">
                <text class="info-title">历史趣闻</text>
                <text class="info-content">尽管许多神秘学家声称塔罗牌有着古老的埃及起源，但历史学家认为，这是"有史以来最成功的宣传活动之一"，因为没有任何历史证据支持这些说法。</text>
              </view>
              <text class="paragraph">塔罗牌用于占卜的最早证据来自1750年左右的一份匿名手稿，记录了博洛尼亚塔罗牌(Tarocco Bolognese)的基本占卜含义。</text>
              <text class="paragraph">神秘学塔罗的普及始于18世纪末的法国，由安东尼·考特(Antoine Court)和让-巴蒂斯特·艾利特(Jean-Baptiste Alliette，又称Etteilla)在巴黎使用马赛塔罗牌(Tarot of Marseilles)推广。</text>
              <text class="paragraph">1900年左右，法国塔罗牌玩家放弃了马赛塔罗牌，转而使用塔罗新牌(Tarot Nouveau)，这导致马赛塔罗牌现在主要被占卜师使用。</text>
              <text class="paragraph">艾利特(Etteilla)于1789年左右首次制作了专为神秘学目的设计的定制塔罗牌组。根据未经证实的信念，这些牌源自"托特之书"(Book of Thoth)，艾利特的塔罗牌包含与古埃及相关的主题。</text>
            </view>

            <view class="section-header">
              <text class="section-title">现代神秘学塔罗</text>
            </view>
            <view class="section-content">
              <view class="full-width-image-container">
                <image src="/static/images/tarot/history/major-arcana-collection.jpg" mode="aspectFill" class="history-image"></image>
                <text class="image-caption">现代塔罗牌大阿卡纳组合</text>
              </view>
              <text class="paragraph">在神秘学传统中，塔罗牌被称为"奥秘"(arcana)，愚人牌和21张王牌被称为"大奥秘"(Major Arcana)，花色牌被称为"小奥秘"(Minor Arcana)。这些术语最早由让-巴蒂斯特·皮图瓦(Jean-Baptiste Pitois，又称Paul Christian)使用，在塔罗牌游戏中从未使用过这些术语。</text>
              <text class="paragraph">神秘学塔罗最常用的三种牌组是马赛塔罗牌(Tarot of Marseilles，一种游戏牌组)、韦特-史密斯塔罗牌(Rider-Waite Tarot)和托特塔罗牌(Thoth Tarot)。</text>
              <text class="paragraph">虽然早期的法国神秘学家声称塔罗牌与古埃及、卡巴拉、印度密宗或易经有深奥联系，但学术研究表明，塔罗牌起源于15世纪中期的意大利北部，没有历史证据表明在18世纪晚期之前有任何重要的塔罗牌占卜用途。</text>
            </view>

            <view class="section-header">
              <text class="section-title">文化影响</text>
            </view>
            <view class="section-content">
              <view class="image-text-flex">
                <view class="text-block">
                  <text class="paragraph">尽管塔罗牌的神秘学历史被夸大，但它在现代文化中仍然占有重要地位。塔罗牌的象征主义已渗透到文学、电影、音乐和视觉艺术中，成为流行文化的一部分。</text>
                  <text class="paragraph">许多艺术家和设计师创作了自己的塔罗牌变体，将传统象征与现代美学融合，使塔罗牌成为艺术表达的媒介。从萨尔瓦多·达利到H.R.吉格，许多著名艺术家都制作过塔罗牌组。</text>
                  <text class="paragraph">今天，塔罗牌不仅被视为占卜工具，也被视为心理探索、创意灵感和个人成长的工具。荣格心理学将塔罗牌的意象视为集体无意识中原型的表现，为现代塔罗解读提供了心理学视角。</text>
                </view>
                <image class="side-image" src="/static/images/tarot/major/19-the-sun.png" mode="aspectFit"></image>
              </view>
              
              <view class="tarot-quote">
                <text class="quote-text">"塔罗牌不是命运的决定者，而是灵魂的映射。它们不告诉你未来会怎样，而是帮助你理解当下。"</text>
                <text class="quote-author">— 现代塔罗解读</text>
              </view>
            </view>
          </view>

        </view>
        
        <view class="navigation-buttons">
          <button class="btn btn-outline" @tap="prevTab" :disabled="activeTabIndex === 0">上一节</button>
          <button class="btn btn-primary" @tap="activeTabIndex === tabs.length - 1 ? finishLearning() : nextTab()">
            {{ activeTabIndex === tabs.length - 1 ? '完成学习' : '下一节' }}
          </button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'TarotHistory',
  data() {
    return {
      pageTitle: '塔罗牌历史文化',
      activeTabIndex: 0,
      tabs: [
        { name: '起源历史' },
        { name: '区域变体' },
        { name: '神秘学演变' }
      ]
    }
  },
  onLoad() {
    // 页面加载时的逻辑
    uni.setNavigationBarTitle({
      title: this.pageTitle
    });
  },
  methods: {
    // 页面方法
    goBack() {
      uni.navigateBack();
    },
    prevTab() {
      if (this.activeTabIndex > 0) {
        this.activeTabIndex--;
      }
    },
    nextTab() {
      if (this.activeTabIndex < this.tabs.length - 1) {
        this.activeTabIndex++;
      }
    },
    finishLearning() {
      // 完成学习，回到学习首页
      uni.navigateTo({
        url: '/pages/learn/index'
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.learn-history {
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
    
    .back-text {
      color: $color-text;
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

.content {
  margin-bottom: 40rpx;
}

.tab-content {
  background-color: rgba($color-bg-card, 0.7);
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 30rpx;
}

/* 历史画廊 */
.history-gallery {
  margin-bottom: 30rpx;
  
  .gallery-scroll {
    white-space: nowrap;
    height: 340rpx;
  }
  
  .gallery-item {
    display: inline-block;
    margin-right: 16rpx;
    width: 260rpx;
    height: 340rpx;
    position: relative;
    border-radius: 12rpx;
    overflow: hidden;
    box-shadow: 0 6rpx 16rpx rgba(0, 0, 0, 0.3);
    
    &:last-child {
      margin-right: 30rpx;
    }
  }
  
  .gallery-image {
    width: 100%;
    height: 280rpx;
    object-fit: cover;
  }
  
  .gallery-caption {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(0, 0, 0, 0.7);
    color: #e0e0e0;
    padding: 10rpx;
    font-size: 22rpx;
    text-align: center;
    height: 60rpx;
    line-height: 60rpx;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
  }
}

.section {
  margin-bottom: 40rpx;
  
  .section-header {
    margin-bottom: 20rpx;
    
    .section-title {
      font-size: 32rpx;
      font-weight: 600;
      color: $color-text;
      border-left: 6rpx solid $color-accent;
      padding-left: 16rpx;
    }
  }
  
  .section-content {
    .paragraph {
      font-size: 28rpx;
      color: $color-text;
      line-height: 1.6;
      margin-bottom: 20rpx;
      display: block;
      text-align: justify;
    }
    
    .history-image {
      width: 100%;
      height: 340rpx;
      border-radius: 10rpx;
      margin-bottom: 16rpx;
      object-fit: contain;
    }
  }
}

.image-text-flex {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-bottom: 16rpx;
  
  &.reverse {
    flex-direction: row-reverse;
  }
  
  .text-block {
    flex: 1;
    padding-right: 20rpx;
    
    &.full-width {
      padding-right: 0;
    }
  }
  
  .side-image {
    width: 200rpx;
    height: 320rpx;
    border-radius: 6rpx;
    object-fit: contain;
  }
}

.regional-variations {
  margin-bottom: 20rpx;
  
  .variations-image {
    width: 100%;
    height: 300rpx;
    object-fit: contain;
    border-radius: 8rpx;
    margin-bottom: 8rpx;
  }
  
  .variations-caption {
    font-size: 24rpx;
    color: $color-text-secondary;
    text-align: center;
    display: block;
  }
}

.image-caption {
  font-size: 24rpx;
  color: $color-text-secondary;
  text-align: center;
  display: block;
  margin-top: -10rpx;
  margin-bottom: 16rpx;
}

.cards-display {
  display: flex;
  justify-content: space-around;
  margin: 20rpx 0;
  
  .card-image {
    width: 160rpx;
    height: 260rpx;
    border-radius: 8rpx;
    margin: 0 10rpx;
    object-fit: contain;
  }
}

.info-box {
  background-color: rgba($color-primary, 0.1);
  border-left: 6rpx solid $color-accent;
  padding: 16rpx;
  margin-bottom: 20rpx;
  border-radius: 6rpx;
  
  .info-title {
    font-size: 30rpx;
    color: $color-text;
    font-weight: bold;
    margin-bottom: 8rpx;
    display: block;
  }
  
  .info-content {
    font-size: 26rpx;
    line-height: 1.5;
    color: $color-text;
    font-style: italic;
  }
}

.tarot-quote {
  margin: 30rpx 0 10rpx;
  padding: 20rpx;
  border-radius: 10rpx;
  background-color: rgba($color-bg, 0.3);
  text-align: center;
  
  .quote-text {
    font-size: 28rpx;
    line-height: 1.7;
    color: $color-accent;
    font-style: italic;
    margin-bottom: 10rpx;
    display: block;
  }
  
  .quote-author {
    font-size: 24rpx;
    color: $color-text-secondary;
  }
}

.full-width-image-container {
  margin-bottom: 16rpx;
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

/* 添加content-tabs样式，与basics.vue保持一致 */
.content-tabs {
  display: flex;
  margin-bottom: 30rpx;
  background-color: rgba($color-bg-card, 0.5);
  border-radius: 40rpx;
  padding: 6rpx;
  
  .tab {
    flex: 1;
    text-align: center;
    padding: 16rpx 0;
    font-size: 28rpx;
    color: $color-text-secondary;
    border-radius: 40rpx;
    
    &.active {
      background-color: $color-primary;
      color: white;
    }
  }
}

.navigation-buttons {
  display: flex;
  justify-content: space-between;
  
  .btn {
    min-width: 200rpx;
    padding: 16rpx 30rpx;
    font-size: 28rpx;
    border-radius: 40rpx;
    
    &.btn-outline {
      border: 1px solid $color-primary;
      color: $color-primary;
      background-color: transparent;
      
      &:disabled {
        opacity: 0.5;
        border-color: $color-text-secondary;
        color: $color-text-secondary;
      }
    }
    
    &.btn-primary {
      background-color: $color-primary;
      color: white;
      border: none;
      
      &:disabled {
        opacity: 0.5;
        background-color: $color-text-secondary;
      }
    }
  }
}
</style> 