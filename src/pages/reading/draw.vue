<template>
  <view class="draw-container mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.4;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.3;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
    <!-- 页面内容 -->
    <view class="header">
      <view class="reading-info">
        <text class="reading-type">{{readingType}}</text>
        <text class="reading-question">{{question}}</text>
      </view>
    </view>
    
    <view class="content">
      <!-- 洗牌阶段 -->
      <view class="stage shuffle" v-if="currentStage === 'shuffle'">
        <view class="deck-container">
          <view class="deck" :class="{'shuffling': isShuffling}">
            <view class="card-back card-1"></view>
            <view class="card-back card-2"></view>
            <view class="card-back card-3"></view>
            <view class="card-back card-4"></view>
            <view class="card-back card-5"></view>
            <view class="card-back card-6"></view>
            <view class="card-back card-7"></view>
            <view class="card-back card-8"></view>
            <view class="mystic-glow"></view>
            <view class="mystic-glow glow-2"></view>
            <view class="mystic-particles"></view>
          </view>
        </view>
        
        <view class="stage-info">
          <text class="stage-title">洗牌中...</text>
          <text class="stage-description">请集中注意力想着您的问题</text>
          <view class="progress-bar">
            <view class="progress-fill" :style="{width: shuffleProgress + '%'}"></view>
          </view>
        </view>
      </view>
      
      <!-- 抽牌阶段 -->
      <view class="stage draw" v-if="currentStage === 'draw'">
        <view class="spread-container" :class="'spread-' + cardCount">
          <view 
            class="tarot-card" 
            v-for="(card, index) in cards" 
            :key="index"
            :class="{'flipped': card.flipped}"
            @tap="flipCard(index)"
          >
            <view class="tarot-card-inner">
              <view class="tarot-card-front"></view>
              <view class="tarot-card-back">
                <image :src="card.image" mode="aspectFill" class="tarot-card-image"></image>
                <view class="card-name">{{card.name}}</view>
              </view>
            </view>
          </view>
        </view>
        
        <view class="stage-info">
          <text class="stage-title">请抽取{{cardCount}}张牌</text>
          <text class="stage-description">点击卡牌翻开查看</text>
          <button class="btn-flip-all" @tap="flipAllCards" v-if="!allCardsFlipped">一键翻开全部</button>
        </view>
      </view>
      
      <!-- 解读阶段 -->
      <view class="stage interpret" v-if="currentStage === 'interpret'">
        <view class="interpretation-container">
          <view class="interpretation-header">
            <text class="interpretation-title">塔罗解读</text>
          </view>
          
          <view class="card-interpretations">
            <view class="card-interpretation" v-for="(card, index) in cards" :key="index">
              <view class="interpretation-card">
                <image :src="card.image" mode="aspectFill" class="interpretation-image"></image>
                <view class="interpretation-card-name">{{card.name}}</view>
              </view>
              <view class="interpretation-content">
                <text class="interpretation-card-keywords">{{card.keywords}}</text>
                <text class="interpretation-card-meaning">{{card.meaning}}</text>
              </view>
            </view>
          </view>
          
          <view class="overall-interpretation">
            <text class="overall-title">综合解读</text>
            <text class="overall-text">{{overallInterpretation}}</text>
          </view>
        </view>
      </view>
    </view>
    
    <view class="footer">
      <button class="btn btn-primary" v-if="currentStage === 'draw' && allCardsFlipped" @tap="showInterpretation">查看解读</button>
      <view class="btn-group" v-if="currentStage === 'interpret'">
        <button class="btn btn-secondary" @tap="saveReading">保存解读</button>
        <button class="btn btn-outline" @tap="returnToHome">返回首页</button>
      </view>
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
      currentStage: 'shuffle',  // shuffle, draw, interpret
      isShuffling: true,
      shuffleProgress: 0,
      shuffleTimer: null,
      cards: [],
      positions: [],
      overallInterpretation: '',
      savedReadingId: null
    }
  },
  computed: {
    allCardsFlipped() {
      return this.cards.length > 0 && this.cards.every(card => card.flipped);
    }
  },
  onLoad(options) {
    // 获取路由参数
    if (options.type) {
      this.readingType = decodeURIComponent(options.type);
    }
    if (options.cards) {
      this.cardCount = parseInt(options.cards);
    }
    if (options.question) {
      this.question = decodeURIComponent(options.question);
    }
    
    // 设置牌位名称
    this.setPositions();
    
    // 开始洗牌动画并自动进入下一阶段
    this.startShuffleAnimation();
  },
  methods: {
    setPositions() {
      // 不再设置牌位名称
      this.positions = [];
    },
    startShuffleAnimation() {
      // 设置进度条增长
      this.shuffleTimer = setInterval(() => {
        this.shuffleProgress += 1.67; // 6秒完成
        if (this.shuffleProgress >= 100) {
          clearInterval(this.shuffleTimer);
          // 自动进入抽牌阶段
          this.startDrawing();
        }
      }, 100);
    },
    startDrawing() {
      // 关闭定时器，以防万一
      if (this.shuffleTimer) {
        clearInterval(this.shuffleTimer);
      }
      
      this.currentStage = 'draw';
      
      // 生成卡牌
      this.generateCards();
    },
    generateCards() {
      // 所有塔罗牌数据
      const majorArcana = [
        { 
          id: 0, 
          name: '愚者', 
          image: '/static/images/tarot/major/00-the-fool.png',
          keywords: '新开始、无畏、冒险',
          meaning: '代表新的旅程，以开放的心态探索可能性，没有心理负担和限制。提示您放开思想，接受新的冒险。'
        },
        { 
          id: 1, 
          name: '魔术师', 
          image: '/static/images/tarot/major/01-the-magician.png',
          keywords: '创造力、表达、实现',
          meaning: '表示您拥有实现目标所需的一切工具和资源。是创造和展示才能的好时机，专注于表达您的创造力。'
        },
        { 
          id: 2, 
          name: '女祭司', 
          image: '/static/images/tarot/major/02-the-high-priestess.png',
          keywords: '直觉、神秘、内在智慧',
          meaning: '建议您聆听内心的声音，相信直觉。暗示有尚未揭示的答案，需要更深入地探索和耐心等待。'
        },
        { 
          id: 3, 
          name: '女皇', 
          image: '/static/images/tarot/major/03-the-empress.png',
          keywords: '丰盛、滋养、创造力',
          meaning: '象征丰盛与成长的时期。建议您关注滋养自己和他人，表达创造力，享受生活的美好与舒适。'
        },
        { 
          id: 4, 
          name: '皇帝', 
          image: '/static/images/tarot/major/04-the-emperor.png',
          keywords: '权威、结构、控制',
          meaning: '代表建立秩序与结构的需要。提示您运用逻辑思考，设立明确边界，发挥领导能力解决问题。'
        },
        { 
          id: 5, 
          name: '教皇', 
          image: '/static/images/tarot/major/05-the-hierophant.png',
          keywords: '传统、精神指导、信仰',
          meaning: '与传统、规则和精神指导有关。建议您寻求值得信赖的指导或遵循既定的规则，尊重传统的价值。'
        },
        { 
          id: 6, 
          name: '恋人', 
          image: '/static/images/tarot/major/06-the-lovers.png',
          keywords: '选择、和谐、关系',
          meaning: '象征重要的选择，以及关系中的和谐与连接。提示您面对选择时，应遵循内心真正的渴望。'
        },
        { 
          id: 7, 
          name: '战车', 
          image: '/static/images/tarot/major/07-the-chariot.png',
          keywords: '意志力、决心、成功',
          meaning: '表示通过意志力和决心获得成功。鼓励您保持专注，坚持不懈地追求目标，克服障碍。'
        },
        { 
          id: 8, 
          name: '力量', 
          image: '/static/images/tarot/major/08-strength.png',
          keywords: '内在力量、勇气、耐心',
          meaning: '代表内在的力量和勇气，而非外在的力量。提示您通过耐心和坚韧来驾驭情绪和挑战。'
        },
        { 
          id: 9, 
          name: '隐士', 
          image: '/static/images/tarot/major/09-the-hermit.png',
          keywords: '内省、孤独、指引',
          meaning: '建议您花时间独处，进行内省和自我发现。通过冥想或反思寻找内心的智慧和方向。'
        },
        { 
          id: 10, 
          name: '命运之轮', 
          image: '/static/images/tarot/major/10-wheel-of-fortune.png',
          keywords: '命运、转变、循环',
          meaning: '象征生活的循环和变化。提醒您接受变化的必然性，理解命运的起伏，把握机会。'
        },
        { 
          id: 11, 
          name: '正义', 
          image: '/static/images/tarot/major/11-justice.png',
          keywords: '公正、真相、因果',
          meaning: '与真相、公正和因果关系有关。提示您做出公平决定，承担责任，接受自己行为的后果。'
        },
        { 
          id: 12, 
          name: '倒吊人', 
          image: '/static/images/tarot/major/12-the-hanged-man.png',
          keywords: '牺牲、新视角、暂停',
          meaning: '建议您暂停行动，以新的视角看待问题。有时短暂的牺牲和放手会带来更深的理解。'
        },
        { 
          id: 13, 
          name: '死神', 
          image: '/static/images/tarot/major/13-death.png',
          keywords: '转变、结束、重生',
          meaning: '象征深刻的变化和转变，而非物理死亡。提示某个阶段的结束和新开始的必要性。'
        },
        { 
          id: 14, 
          name: '节制', 
          image: '/static/images/tarot/major/14-temperance.png',
          keywords: '平衡、和谐、适度',
          meaning: '与平衡、和谐和适度有关。建议您寻找中庸之道，调和不同的元素，保持耐心。'
        },
        { 
          id: 15, 
          name: '恶魔', 
          image: '/static/images/tarot/major/15-the-devil.png',
          keywords: '束缚、物质主义、阴影面',
          meaning: '揭示自我限制的束缚和物质世界的诱惑。提醒您面对自己的阴影面，认识到自己有能力打破束缚。'
        },
        { 
          id: 16, 
          name: '塔', 
          image: '/static/images/tarot/major/16-the-tower.png',
          keywords: '突变、崩塌、启示',
          meaning: '预示突然的变化和不稳定。虽然可能带来挑战，但这种打破旧结构的过程对于真正的成长是必要的。'
        },
        { 
          id: 17, 
          name: '星星', 
          image: '/static/images/tarot/major/17-the-star.png',
          keywords: '希望、灵感、平静',
          meaning: '带来希望、灵感和平静的能量。困难之后的光明，提示您保持信念，相信更美好的未来。'
        },
        { 
          id: 18, 
          name: '月亮', 
          image: '/static/images/tarot/major/18-the-moon.png',
          keywords: '幻觉、直觉、不确定性',
          meaning: '与幻觉、不确定和潜意识有关。提示您关注直觉，但也要警惕自己的恐惧和幻想。'
        },
        { 
          id: 19, 
          name: '太阳', 
          image: '/static/images/tarot/major/19-the-sun.png',
          keywords: '快乐、活力、成功',
          meaning: '象征光明、活力和成功。非常积极的牌，预示喜悦、幸福和丰盛的时期。'
        },
        { 
          id: 20, 
          name: '审判', 
          image: '/static/images/tarot/major/20-judgement.png',
          keywords: '更新、觉醒、重生',
          meaning: '代表灵性觉醒和重生。建议您反思过去，接受内在的呼唤，为人生的新阶段做好准备。'
        },
        { 
          id: 21, 
          name: '世界', 
          image: '/static/images/tarot/major/21-the-world.png',
          keywords: '完成、统一、成就',
          meaning: '象征周期的完成和成就。表示您已经达到目标，获得圆满，准备好开始新的旅程。'
        }
      ];
      
      const minorArcana = [
        // 权杖牌(Wands)
        {
          name: '权杖王牌',
          image: '/static/images/tarot/minor/ace-of-wands.png',
          keywords: '创造力、灵感、新的开始',
          meaning: '代表创造力的爆发和新的开始。充满激情和能量的种子，预示事业、项目或冒险的开始。'
        },
        {
          name: '权杖二',
          image: '/static/images/tarot/minor/2-of-wands.png',
          keywords: '规划、未来视野、进展',
          meaning: '与规划未来和扩大视野有关。表示您站在十字路口，需要在更广阔的范围内思考和规划。'
        },
        {
          name: '权杖三',
          image: '/static/images/tarot/minor/3-of-wands.png',
          keywords: '远见、扩张、领导力',
          meaning: '象征远见和扩张。您的努力开始显现成果，可以期待成长和新的机会。'
        },
        {
          name: '权杖四',
          image: '/static/images/tarot/minor/4-of-wands.png',
          keywords: '庆祝、和谐、团队合作',
          meaning: '代表庆祝和社区的和谐。是喜悦、成就和稳定的标志，可能与家庭或重要里程碑相关。'
        },
        
        // 圣杯牌(Cups)
        {
          name: '圣杯王牌',
          image: '/static/images/tarot/minor/ace-of-cups.png',
          keywords: '情感、爱、直觉',
          meaning: '象征情感丰富和新感情的开始。预示爱情、友谊或创意灵感的新篇章。'
        },
        {
          name: '圣杯二',
          image: '/static/images/tarot/minor/2-of-cups.png',
          keywords: '伙伴关系、吸引力、和谐',
          meaning: '与重要的伙伴关系和联系有关。可能预示新恋情、友谊或业务合作的和谐发展。'
        },
        {
          name: '圣杯三',
          image: '/static/images/tarot/minor/3-of-cups.png',
          keywords: '庆祝、友谊、共同体',
          meaning: '代表团聚、友谊和庆祝。是社交欢乐和集体成就的标志。'
        },
        {
          name: '圣杯四',
          image: '/static/images/tarot/minor/4-of-cups.png',
          keywords: '沉思、不满、重新评估',
          meaning: '暗示对现状的不满或情感倦怠。提示您重新评估和欣赏已有的东西，同时对新机会保持开放。'
        },
        
        // 宝剑牌(Swords)
        {
          name: '宝剑王牌',
          image: '/static/images/tarot/minor/ace-of-swords.png',
          keywords: '清晰、真相、突破',
          meaning: '象征思想的清晰和新的洞察力。预示突破、理性思考和真相的揭示。'
        },
        {
          name: '宝剑二',
          image: '/static/images/tarot/minor/2-of-swords.png',
          keywords: '选择、僵局、平衡',
          meaning: '表示面临困难的选择或僵局。建议寻求平衡，看清全局，做出明智决定。'
        },
        {
          name: '宝剑三',
          image: '/static/images/tarot/minor/3-of-swords.png',
          keywords: '心痛、悲伤、真相',
          meaning: '代表心痛和失落。虽然痛苦，但这种体验带来成长和对真相的认识。'
        },
        {
          name: '宝剑四',
          image: '/static/images/tarot/minor/4-of-swords.png',
          keywords: '休息、冥想、恢复',
          meaning: '建议您休息和恢复。在压力或挑战之后，需要时间冥想和重新获得力量。'
        },
        
        // 金币牌(Pentacles)
        {
          name: '金币王牌',
          image: '/static/images/tarot/minor/ace-of-pentacles.png',
          keywords: '物质机会、繁荣、新开始',
          meaning: '象征物质世界的新机会。可能预示新工作、投资或财务机会的开始。'
        },
        {
          name: '金币二',
          image: '/static/images/tarot/minor/2-of-pentacles.png',
          keywords: '平衡、适应性、优先次序',
          meaning: '与平衡多重责任和适应变化有关。建议灵活处理日常挑战，合理安排优先级。'
        },
        {
          name: '金币三',
          image: '/static/images/tarot/minor/3-of-pentacles.png',
          keywords: '合作、技能、成就',
          meaning: '代表团队合作和技能的认可。预示通过合作和专业技能获得成就。'
        },
        {
          name: '金币四',
          image: '/static/images/tarot/minor/4-of-pentacles.png',
          keywords: '安全、控制、节俭',
          meaning: '暗示对物质安全的关注，可能过于控制或保守。建议平衡安全需求与慷慨和风险接受。'
        }
      ];
      
      // 合并所有牌
      const allCards = [...majorArcana, ...minorArcana];
      
      // 随机选择卡牌
      const selectedCards = [];
      const usedIndexes = new Set();
      
      while (selectedCards.length < this.cardCount) {
        const randomIndex = Math.floor(Math.random() * allCards.length);
        
        if (!usedIndexes.has(randomIndex)) {
          const card = {...allCards[randomIndex]};
          card.flipped = false;
          selectedCards.push(card);
          usedIndexes.add(randomIndex);
        }
      }
      
      this.cards = selectedCards;
      
      // 生成综合解读
      this.generateOverallInterpretation();
    },
    flipCard(index) {
      if (this.currentStage === 'draw' && !this.cards[index].flipped) {
        this.cards[index].flipped = true;
        
        // 添加卡牌翻开时的振动反馈
        if (uni.vibrateShort) {
          uni.vibrateShort();
        }
      }
    },
    flipAllCards() {
      // 一键翻开所有卡牌
      if (this.currentStage === 'draw') {
        // 使用延迟依次翻开每张牌，产生顺序翻开的效果
        this.cards.forEach((card, index) => {
          setTimeout(() => {
            if (!card.flipped) {
              this.cards[index].flipped = true;
            }
          }, index * 300); // 每隔300毫秒翻开一张牌
        });
        
        // 添加翻开所有卡牌时的振动反馈
        if (uni.vibrateLong) {
          uni.vibrateLong();
        }
      }
    },
    showInterpretation() {
      this.currentStage = 'interpret';
    },
    generateOverallInterpretation() {
      // 根据卡牌生成综合解读
      const interpretations = [
        '这组牌显示您正处于重要的转变期。过去的经验为您提供了成长的基础，而现在是推动变化的好时机。',
        '您目前面临的挑战需要耐心和毅力。虽然道路可能曲折，但这些卡牌预示最终会有积极的结果。',
        '您的问题涉及到内心和外部世界的平衡。这些卡牌建议您需要同时关注实际行动和精神需求。',
        '这组牌面表明您的直觉在当前情况中尤为重要。不要忽视内心的声音，它们将指引您做出最佳决策。',
        '卡牌显示您拥有所需的一切资源来实现目标。关键是明确您的意图并采取有条理的行动步骤。'
      ];
      
      // 随机选择一个解读
      const randomIndex = Math.floor(Math.random() * interpretations.length);
      this.overallInterpretation = interpretations[randomIndex];
    },
    saveReading() {
      // 模拟保存解读
      uni.showLoading({
        title: '保存中...'
      });
      
      setTimeout(() => {
        uni.hideLoading();
        
        uni.showToast({
          title: '解读已保存',
          icon: 'success'
        });
        
        // 生成唯一ID
        this.savedReadingId = Date.now().toString();
        
        // 返回首页
        setTimeout(() => {
          uni.switchTab({
            url: '/pages/index/index'
          });
        }, 1500);
      }, 2000);
    },
    returnToHome() {
      // 直接返回首页，不保存解读
      uni.switchTab({
        url: '/pages/index/index'
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.draw-container {
  min-height: 100vh;
  padding: 40rpx 30rpx;
  box-sizing: border-box;
  position: relative;
  display: flex;
  flex-direction: column;
}

.header {
  margin-bottom: 30rpx;
  
  .reading-info {
    text-align: center;
    
    .reading-type {
      font-size: 36rpx;
      font-weight: 600;
      display: block;
      margin-bottom: 10rpx;
    }
    
    .reading-question {
      font-size: 28rpx;
      color: $color-text-secondary;
      display: block;
    }
  }
}

.content {
  flex: 1;
  display: flex;
  flex-direction: column;
  margin-bottom: 40rpx;
}

.stage {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  
  .stage-info {
    text-align: center;
    margin: 40rpx 0;
    
    .stage-title {
      font-size: 32rpx;
      font-weight: 600;
      display: block;
      margin-bottom: 10rpx;
    }
    
    .stage-description {
      font-size: 28rpx;
      color: $color-text-secondary;
      margin-bottom: 20rpx;
      display: block;
    }
    
    .progress-bar {
      width: 300rpx;
      height: 10rpx;
      background: rgba($color-primary, 0.2);
      border-radius: 10rpx;
      margin: 20rpx auto 0;
      overflow: hidden;
      
      .progress-fill {
        height: 100%;
        background: $color-primary;
        border-radius: 10rpx;
        transition: width 0.1s linear;
      }
    }
  }
}

.deck-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 400rpx;
  perspective: 1200rpx;
  
  .deck {
    position: relative;
    width: 240rpx;
    height: 360rpx;
    transform-style: preserve-3d;
    
    &.shuffling {
      animation: deck-float 5s infinite ease-in-out;
      
      .card-back {
        animation: card-shuffle 3s infinite;
        
        &.card-1 {
          animation-delay: 0s;
          animation-duration: 2.5s;
        }
        
        &.card-2 {
          animation-delay: 0.2s;
          animation-duration: 2.8s;
        }
        
        &.card-3 {
          animation-delay: 0.4s;
          animation-duration: 3.1s;
        }
        
        &.card-4 {
          animation-delay: 0.6s;
          animation-duration: 2.7s;
        }
        
        &.card-5 {
          animation-delay: 0.8s;
          animation-duration: 2.9s;
        }
        
        &.card-6 {
          animation-delay: 1s;
          animation-duration: 3.3s;
        }

        &.card-7 {
          animation-delay: 0.5s;
          animation-duration: 3.0s;
        }
        
        &.card-8 {
          animation-delay: 1.2s;
          animation-duration: 2.6s;
        }
      }
      
      .mystic-glow {
        animation: glow-pulse 2s infinite;
        
        &.glow-2 {
          animation: glow-pulse 3s infinite reverse;
          background: radial-gradient(circle, rgba(255, 215, 0, 0.5) 0%, rgba(255, 215, 0, 0) 70%);
          top: -30rpx;
          left: 30rpx;
        }
      }

      .mystic-particles {
        position: absolute;
        width: 400rpx;
        height: 400rpx;
        top: -20rpx;
        left: -80rpx;
        z-index: 5;
        pointer-events: none;
        background-image: 
          radial-gradient(circle, rgba(255, 255, 255, 0.8) 1px, transparent 1px),
          radial-gradient(circle, rgba(255, 255, 255, 0.5) 1px, transparent 1px),
          radial-gradient(circle, rgba(255, 255, 255, 0.3) 1px, transparent 1px);
        background-size: 12px 12px, 8px 8px, 6px 6px;
        animation: particles-float 6s infinite linear;
      }
    }
    
    .card-back {
      position: absolute;
      width: 100%;
      height: 100%;
      background: url('/static/images/tarot/back/card-back.png') no-repeat center/cover;
      border-radius: 12rpx;
      box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.3);
      transform-origin: center bottom;
      
      &.card-1 {
        transform: translateZ(0px);
      }
      
      &.card-2 {
        transform: translateZ(2px);
      }
      
      &.card-3 {
        transform: translateZ(4px);
      }
      
      &.card-4 {
        transform: translateZ(6px);
      }
      
      &.card-5 {
        transform: translateZ(8px);
      }
      
      &.card-6 {
        transform: translateZ(10px);
      }

      &.card-7 {
        transform: translateZ(12px);
      }
      
      &.card-8 {
        transform: translateZ(14px);
      }
    }
    
    .mystic-glow {
      position: absolute;
      width: 300rpx;
      height: 300rpx;
      background: radial-gradient(circle, rgba(147, 112, 219, 0.6) 0%, rgba(147, 112, 219, 0) 70%);
      border-radius: 50%;
      z-index: -1;
      left: -30rpx;
      top: 30rpx;
      filter: blur(15px);
    }
  }
}

@keyframes deck-float {
  0% { transform: translateY(0) rotate(0deg); }
  25% { transform: translateY(-20rpx) rotate(2deg); }
  50% { transform: translateY(10rpx) rotate(-2deg); }
  75% { transform: translateY(-10rpx) rotate(1deg); }
  100% { transform: translateY(0) rotate(0deg); }
}

@keyframes card-shuffle {
  0% { 
    transform: translateX(0) translateY(0) rotateZ(0deg); 
    box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.3);
  }
  20% { 
    transform: translateX(-30rpx) translateY(-20rpx) rotateZ(-10deg) rotateY(5deg); 
    box-shadow: -8rpx 8rpx 16rpx rgba(0, 0, 0, 0.4);
  }
  40% { 
    transform: translateX(40rpx) translateY(-30rpx) rotateZ(12deg) rotateX(-5deg); 
    box-shadow: 8rpx 8rpx 16rpx rgba(0, 0, 0, 0.4);
  }
  60% { 
    transform: translateX(-20rpx) translateY(20rpx) rotateZ(-8deg) rotateY(-5deg); 
    box-shadow: -6rpx 6rpx 12rpx rgba(0, 0, 0, 0.3);
  }
  80% { 
    transform: translateX(30rpx) translateY(10rpx) rotateZ(6deg) rotateX(5deg); 
    box-shadow: 6rpx 4rpx 12rpx rgba(0, 0, 0, 0.3);
  }
  100% { 
    transform: translateX(0) translateY(0) rotateZ(0deg); 
    box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.3);
  }
}

@keyframes glow-pulse {
  0% { opacity: 0.4; transform: scale(0.8); }
  50% { opacity: 0.8; transform: scale(1.2); }
  100% { opacity: 0.4; transform: scale(0.8); }
}

@keyframes particles-float {
  0% {
    background-position: 0 0, 0 0, 0 0;
    opacity: 0.5;
  }
  25% {
    opacity: 0.8;
  }
  50% {
    background-position: -50px 50px, -25px 25px, -10px 10px;
    opacity: 0.5;
  }
  75% {
    opacity: 0.9;
  }
  100% {
    background-position: -100px 100px, -50px 50px, -20px 20px;
    opacity: 0.5;
  }
}

.spread-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  width: 100%;
  min-height: 400rpx;
  
  &.spread-1 {
    .tarot-card {
      margin: 20rpx;
    }
  }
  
  &.spread-3 {
    .tarot-card {
      margin: 20rpx;
    }
  }
  
  &.spread-5, &.spread-7 {
    .tarot-card {
      margin: 15rpx;
    }
  }
}

.tarot-card {
  width: 200rpx;
  height: 340rpx;
  perspective: 1000rpx;
  
  &-inner {
    position: relative;
    width: 100%;
    height: 100%;
    transition: transform 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    transform-style: preserve-3d;
  }
  
  &.flipped .tarot-card-inner {
    transform: rotateY(180deg);
  }
  
  &-front, &-back {
    position: absolute;
    width: 100%;
    height: 100%;
    backface-visibility: hidden;
    border-radius: 12rpx;
    box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.3);
  }
  
  &-front {
    background: url('/static/images/tarot/back/card-back.png') no-repeat center/cover;
    &::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, rgba(255,255,255,0) 50%, rgba(255,255,255,0.1) 100%);
      border-radius: 12rpx;
    }
  }
  
  &-back {
    transform: rotateY(180deg);
    display: flex;
    flex-direction: column;
    align-items: center;
    overflow: hidden;
  }
  
  &-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .card-name {
    position: absolute;
    bottom: 10rpx;
    font-size: 24rpx;
    font-weight: 600;
    color: white;
    text-shadow: 0 0 4rpx rgba(0, 0, 0, 0.8);
    text-align: center;
    width: 100%;
    background: rgba(0, 0, 0, 0.4);
    padding: 5rpx 0;
  }
}

.interpretation-container {
  width: 100%;
  
  .interpretation-header {
    margin-bottom: 30rpx;
    
    .interpretation-title {
      font-size: 32rpx;
      font-weight: 600;
      text-align: center;
    }
  }
  
  .card-interpretations {
    margin-bottom: 40rpx;
  }
  
  .card-interpretation {
    display: flex;
    background-color: rgba($color-bg-card, 0.7);
    border-radius: 12rpx;
    padding: 20rpx;
    margin-bottom: 20rpx;
    
    .interpretation-card {
      width: 120rpx;
      height: 200rpx;
      margin-right: 20rpx;
      position: relative;
      border-radius: 8rpx;
      overflow: hidden;
      
      .interpretation-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
      
      .interpretation-card-name {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        font-size: 22rpx;
        font-weight: 600;
        color: white;
        text-shadow: 0 0 4rpx rgba(0, 0, 0, 0.8);
        background: rgba(0, 0, 0, 0.4);
        padding: 4rpx 0;
        text-align: center;
      }
    }
    
    .interpretation-content {
      flex: 1;
      
      .interpretation-card-keywords {
        font-size: 24rpx;
        color: $color-text-secondary;
        margin-bottom: 10rpx;
      }
      
      .interpretation-card-meaning {
        font-size: 26rpx;
        line-height: 1.5;
      }
    }
  }
  
  .overall-interpretation {
    background-color: rgba($color-primary, 0.1);
    border-radius: 12rpx;
    padding: 20rpx;
    
    .overall-title {
      font-size: 28rpx;
      font-weight: 600;
      color: $color-primary;
      margin-bottom: 15rpx;
      display: block;
    }
    
    .overall-text {
      font-size: 26rpx;
      line-height: 1.6;
    }
  }
}

.footer {
  padding: 20rpx 0;
  display: flex;
  justify-content: center;
  
  .btn {
    width: 100%;
    height: 90rpx;
    font-size: 32rpx;
  }
  
  .btn-group {
    display: flex;
    width: 100%;
    gap: 20rpx;
    
    .btn {
      flex: 1;
    }
  }
  
  .btn-outline {
    background-color: transparent;
    border: 1px solid $color-primary;
    color: $color-primary;
  }
}

.btn-flip-all {
  margin-top: 20rpx;
  font-size: 28rpx;
  color: white;
  background: linear-gradient(135deg, $color-primary, $color-accent);
  padding: 10rpx 30rpx;
  border-radius: 30rpx;
  box-shadow: 0 4rpx 12rpx rgba($color-primary, 0.4);
  border: none;
  position: relative;
  overflow: hidden;
  
  &::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent, rgba(255,255,255,0.2), transparent);
    transform: rotate(45deg);
    animation: btn-shine 3s infinite;
  }
  
  &:active {
    transform: translateY(2rpx);
    box-shadow: 0 2rpx 6rpx rgba($color-primary, 0.4);
  }
}

@keyframes btn-shine {
  0% { 
    left: -100%; 
  }
  20% { 
    left: 100%; 
  }
  100% { 
    left: 100%; 
  }
}
</style> 