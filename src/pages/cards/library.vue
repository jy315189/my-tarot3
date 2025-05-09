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
          <view class="suit-section">
            <view class="suit-header" @tap="toggleSuit('wands')">
            <text class="suit-title">权杖</text>
              <text class="toggle-icon">{{ suitExpanded.wands ? '−' : '+' }}</text>
            </view>
            <view class="card-grid" v-if="suitExpanded.wands">
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
          <view class="suit-section">
            <view class="suit-header" @tap="toggleSuit('cups')">
            <text class="suit-title">圣杯</text>
              <text class="toggle-icon">{{ suitExpanded.cups ? '−' : '+' }}</text>
            </view>
            <view class="card-grid" v-if="suitExpanded.cups">
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
          <view class="suit-section">
            <view class="suit-header" @tap="toggleSuit('swords')">
            <text class="suit-title">宝剑</text>
              <text class="toggle-icon">{{ suitExpanded.swords ? '−' : '+' }}</text>
            </view>
            <view class="card-grid" v-if="suitExpanded.swords">
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
          <view class="suit-section">
            <view class="suit-header" @tap="toggleSuit('pentacles')">
            <text class="suit-title">金币</text>
              <text class="toggle-icon">{{ suitExpanded.pentacles ? '−' : '+' }}</text>
            </view>
            <view class="card-grid" v-if="suitExpanded.pentacles">
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
      suitExpanded: {
        wands: true,
        cups: false,
        swords: false,
        pentacles: false
      },
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
        { 
          id: 5, 
          name: '教皇', 
          number: 'V',
          image: '/static/images/tarot/major/05-the-hierophant.png',
          keywords: '传统、精神指导、信仰',
          meaning: '与传统、规则和精神指导有关。建议您寻求值得信赖的指导或遵循既定的规则，尊重传统的价值。',
          reversed: '叛逆、不合常规、盲目追随',
          element: '土',
          astrology: '金牛座',
          category: 'major'
        },
        { 
          id: 6, 
          name: '恋人', 
          number: 'VI',
          image: '/static/images/tarot/major/06-the-lovers.png',
          keywords: '选择、和谐、关系',
          meaning: '象征重要的选择，以及关系中的和谐与连接。提示您面对选择时，应遵循内心真正的渴望。',
          reversed: '不和谐、价值观冲突、不平衡的关系',
          element: '风',
          astrology: '双子座',
          category: 'major'
        },
        { 
          id: 7, 
          name: '战车', 
          number: 'VII',
          image: '/static/images/tarot/major/07-the-chariot.png',
          keywords: '意志力、决心、成功',
          meaning: '表示通过意志力和决心获得成功。鼓励您保持专注，坚持不懈地追求目标，克服障碍。',
          reversed: '缺乏方向、失控、挫折',
          element: '水',
          astrology: '巨蟹座',
          category: 'major'
        },
        { 
          id: 8, 
          name: '力量', 
          number: 'VIII',
          image: '/static/images/tarot/major/08-strength.png',
          keywords: '内在力量、勇气、耐心',
          meaning: '代表内在的力量和勇气，而非外在的力量。提示您通过耐心和坚韧来驾驭情绪和挑战。',
          reversed: '自我怀疑、软弱、缺乏毅力',
          element: '火',
          astrology: '狮子座',
          category: 'major'
        },
        { 
          id: 9, 
          name: '隐士', 
          number: 'IX',
          image: '/static/images/tarot/major/09-the-hermit.png',
          keywords: '内省、孤独、指引',
          meaning: '建议您花时间独处，进行内省和自我发现。通过冥想或反思寻找内心的智慧和方向。',
          reversed: '孤立、退缩、逃避现实',
          element: '土',
          astrology: '处女座',
          category: 'major'
        },
        { 
          id: 10, 
          name: '命运之轮', 
          number: 'X',
          image: '/static/images/tarot/major/10-wheel-of-fortune.png',
          keywords: '命运、转变、机会',
          meaning: '象征命运的转变和人生的周期性变化。提示您要接受变化，把握机会，保持乐观的态度。',
          reversed: '不好的运气、抵抗变化、失去控制',
          element: '火',
          astrology: '木星',
          category: 'major'
        },
        { 
          id: 11, 
          name: '正义', 
          number: 'XI',
          image: '/static/images/tarot/major/11-justice.png',
          keywords: '公正、真相、平衡',
          meaning: '代表因果关系和对行为负责。提示您追求公正与平衡，寻求真相，并为自己的决定负责。',
          reversed: '不公正、不平衡、拒绝承担责任',
          element: '风',
          astrology: '天秤座',
          category: 'major'
        },
        { 
          id: 12, 
          name: '吊人', 
          number: 'XII',
          image: '/static/images/tarot/major/12-the-hanged-man.png',
          keywords: '牺牲、新视角、等待',
          meaning: '建议您以新的角度看待问题，有时需要牺牲或放弃才能获得更高的智慧和新的理解。',
          reversed: '拖延、抵抗、毫无意义的牺牲',
          element: '水',
          astrology: '海王星',
          category: 'major'
        },
        { 
          id: 13, 
          name: '死神', 
          number: 'XIII',
          image: '/static/images/tarot/major/13-death.png',
          keywords: '结束、转变、重生',
          meaning: '象征重大转变和结束，但不一定是负面的。提示您需要放下过去，接受改变，为新的开始腾出空间。',
          reversed: '抗拒变化、停滞、无法释怀',
          element: '水',
          astrology: '天蝎座',
          category: 'major'
        },
        { 
          id: 14, 
          name: '节制', 
          number: 'XIV',
          image: '/static/images/tarot/major/14-temperance.png',
          keywords: '平衡、调和、适度',
          meaning: '建议您保持平衡和节制。寻求不同元素和方面的调和，避免极端，追求中庸之道。',
          reversed: '不平衡、过度、不和谐',
          element: '火',
          astrology: '射手座',
          category: 'major'
        },
        { 
          id: 15, 
          name: '恶魔', 
          number: 'XV',
          image: '/static/images/tarot/major/15-the-devil.png',
          keywords: '束缚、物质主义、欲望',
          meaning: '警示您关注限制自己的束缚，特别是物质欲望和低层次的执着。提醒您意识到这些约束，才能解脱。',
          reversed: '解放、摆脱束缚、重获控制',
          element: '土',
          astrology: '摩羯座',
          category: 'major'
        },
        { 
          id: 16, 
          name: '塔', 
          number: 'XVI',
          image: '/static/images/tarot/major/16-the-tower.png',
          keywords: '突变、动荡、启示',
          meaning: '预示突然的变化和动荡，打破陈旧的结构和错误的信念。虽然令人震惊，但为真相和新的基础铺平道路。',
          reversed: '拒绝改变、延迟的灾难、恐惧改变',
          element: '火',
          astrology: '火星',
          category: 'major'
        },
        { 
          id: 17, 
          name: '星星', 
          number: 'XVII',
          image: '/static/images/tarot/major/17-the-star.png',
          keywords: '希望、灵感、宁静',
          meaning: '象征希望和灵感的重现，特别是在困难时期之后。提示您保持信念，相信未来会更好。',
          reversed: '绝望、失去信念、失望',
          element: '风',
          astrology: '水瓶座',
          category: 'major'
        },
        { 
          id: 18, 
          name: '月亮', 
          number: 'XVIII',
          image: '/static/images/tarot/major/18-the-moon.png',
          keywords: '直觉、幻觉、潜意识',
          meaning: '提示您关注潜意识和直觉，但也警惕幻觉和错误的认知。建议您在黑暗中寻找真相，不要被表象所蒙蔽。',
          reversed: '混乱、恐惧、误解',
          element: '水',
          astrology: '双鱼座',
          category: 'major'
        },
        { 
          id: 19, 
          name: '太阳', 
          number: 'XIX',
          image: '/static/images/tarot/major/19-the-sun.png',
          keywords: '成功、喜悦、活力',
          meaning: '象征成功和喜悦的时期。提示您享受生活的光明面，充满活力和乐观，从成功中获得满足感。',
          reversed: '过度自信、缺乏活力、暂时的失败',
          element: '火',
          astrology: '太阳',
          category: 'major'
        },
        { 
          id: 20, 
          name: '审判', 
          number: 'XX',
          image: '/static/images/tarot/major/20-judgement.png',
          keywords: '重生、反思、觉醒',
          meaning: '代表觉醒和对过去的清算。建议您接受内在的召唤，从内心深处开始重生和转变。',
          reversed: '自我怀疑、错失机会、拒绝接受真相',
          element: '火',
          astrology: '冥王星',
          category: 'major'
        },
        { 
          id: 21, 
          name: '世界', 
          number: 'XXI',
          image: '/static/images/tarot/major/21-the-world.png',
          keywords: '完成、整合、旅程',
          meaning: '象征周期的完成和成就。提示您已经达成了目标，经历了完整的旅程，准备好迎接新的开始。',
          reversed: '未完成、缺乏收尾、缺少进展',
          element: '土',
          astrology: '土星',
          category: 'major'
        }
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
          {
            name: '权杖三',
            suit: '权杖',
            number: '3',
            image: '/static/images/tarot/minor/3-of-wands.png',
            keywords: '展望、扩张、机会',
            meaning: '象征看到早期努力的成果，并为更大的成功做准备。建议拓展视野，寻找新的机会和合作伙伴。',
            reversed: '错失机会、延误、阻碍',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖四',
            suit: '权杖',
            number: '4',
            image: '/static/images/tarot/minor/4-of-wands.png',
            keywords: '庆典、和谐、家庭',
            meaning: '代表庆祝成就和和谐的家庭生活。提示您欣赏已经取得的成果，享受与亲友共度的时光。',
            reversed: '缺乏和谐、不稳定家庭、庆祝受阻',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖五',
            suit: '权杖',
            number: '5',
            image: '/static/images/tarot/minor/5-of-wands.png',
            keywords: '竞争、冲突、挑战',
            meaning: '表示相互竞争和不协调的能量。建议正视冲突，通过健康的竞争和辩论来达成更好的结果。',
            reversed: '避免冲突、和解、内在斗争',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖六',
            suit: '权杖',
            number: '6',
            image: '/static/images/tarot/minor/6-of-wands.png',
            keywords: '胜利、认可、成功',
            meaning: '象征胜利和公开的认可。提示您享受成功的时刻，接受赞美，同时保持谦虚和感恩之心。',
            reversed: '过度自信、傲慢、失败',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖七',
            suit: '权杖',
            number: '7',
            image: '/static/images/tarot/minor/7-of-wands.png',
            keywords: '防御、坚持、挑战',
            meaning: '代表防守自己的立场并迎接挑战。提示您坚持自己的信念，勇敢面对反对，捍卫自己的成果。',
            reversed: '让步、逃避、压力过大',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖八',
            suit: '权杖',
            number: '8',
            image: '/static/images/tarot/minor/8-of-wands.png',
            keywords: '速度、行动、突破',
            meaning: '象征快速行动和突破。提示事件将迅速发展，建议您准备好迎接变化，抓住一闪而过的机会。',
            reversed: '延误、挫折、内部冲突',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖九',
            suit: '权杖',
            number: '9',
            image: '/static/images/tarot/minor/9-of-wands.png',
            keywords: '坚韧、毅力、最后一搏',
            meaning: '代表经历挑战后的坚持与毅力。提示您尽管疲惫，仍要继续坚持，因为成功就在眼前。',
            reversed: '精疲力尽、放弃、防御过度',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖十',
            suit: '权杖',
            number: '10',
            image: '/static/images/tarot/minor/10-of-wands.png',
            keywords: '负担、压力、责任',
            meaning: '象征责任的重担和压力。提醒您评估自己的承诺，考虑是否需要分担责任或放下一些不必要的负担。',
            reversed: '筋疲力尽、逃避责任、负担减轻',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖侍者',
            suit: '权杖',
            number: '侍者',
            image: '/static/images/tarot/minor/page-of-wands.png',
            keywords: '探索、热情、发现',
            meaning: '代表对新想法和可能性的热情探索。提示您以开放的心态迎接新信息，准备好踏上探索之旅。',
            reversed: '不切实际、缺乏方向、三心二意',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖骑士',
            suit: '权杖',
            number: '骑士',
            image: '/static/images/tarot/minor/knight-of-wands.png',
            keywords: '行动、冒险、冲动',
            meaning: '象征充满活力的行动和冒险精神。提示您充满热情地追求目标，但要注意可能的冲动倾向。',
            reversed: '鲁莽、急躁、精力不集中',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖王后',
            suit: '权杖',
            number: '王后',
            image: '/static/images/tarot/minor/queen-of-wands.png',
            keywords: '热情、自信、活力',
            meaning: '代表热情、自信和充满魅力的能量。提示您以乐观和活力面对生活，相信自己的能力。',
            reversed: '要求过高、专横、情绪不稳',
            element: '火',
            category: 'minor'
          },
          {
            name: '权杖国王',
            suit: '权杖',
            number: '国王',
            image: '/static/images/tarot/minor/king-of-wands.png',
            keywords: '权威、领导、远见',
            meaning: '象征创造性的领导力和远见卓识。提示您以热情和自信领导他人，同时保持诚实和正直。',
            reversed: '专制、自负、不可靠',
            element: '火',
            category: 'minor'
          }
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
          {
            name: '圣杯二',
            suit: '圣杯',
            number: '2',
            image: '/static/images/tarot/minor/2-of-cups.png',
            keywords: '和谐、伙伴关系、吸引力',
            meaning: '代表两个人之间和谐的连接和伙伴关系。提示您注重关系中的平等和相互尊重。',
            reversed: '失衡关系、沟通不良、分离',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯三',
            suit: '圣杯',
            number: '3',
            image: '/static/images/tarot/minor/3-of-cups.png',
            keywords: '庆祝、友谊、欢乐',
            meaning: '象征与他人共同庆祝和享受欢乐的时光。提示您珍视友谊，参与社交活动，分享快乐。',
            reversed: '过度放纵、排他性、社交疲劳',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯四',
            suit: '圣杯',
            number: '4',
            image: '/static/images/tarot/minor/4-of-cups.png',
            keywords: '沉思、评估、不满',
            meaning: '代表情感上的停滞和对现状的评估。提示您可能忽略了眼前的机会，需要重新评估自己的态度。',
            reversed: '新机会、接受变化、行动',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯五',
            suit: '圣杯',
            number: '5',
            image: '/static/images/tarot/minor/5-of-cups.png',
            keywords: '失望、悲伤、遗憾',
            meaning: '象征对失去的事物感到悲伤和遗憾。提醒您虽有损失，但仍有一些杯子竖立，建议将注意力转向剩下的祝福。',
            reversed: '接受损失、前进、找到希望',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯六',
            suit: '圣杯',
            number: '6',
            image: '/static/images/tarot/minor/6-of-cups.png',
            keywords: '怀旧、童真、礼物',
            meaning: '代表对过去的美好回忆和单纯的快乐。提示您从童年或过去的经历中获取力量和慰藉。',
            reversed: '活在过去、停滞不前、理想化过去',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯七',
            suit: '圣杯',
            number: '7',
            image: '/static/images/tarot/minor/7-of-cups.png',
            keywords: '选择、幻想、愿景',
            meaning: '象征面对多种选择时的迷惑或沉迷于幻想。提醒您分清现实与幻想，做出明智而实际的选择。',
            reversed: '现实意识、明确选择、克服诱惑',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯八',
            suit: '圣杯',
            number: '8',
            image: '/static/images/tarot/minor/8-of-cups.png',
            keywords: '放弃、前进、寻求',
            meaning: '代表离开不再满足的情况，寻求更深层次的意义和满足。提示您有勇气离开舒适区，追求真正想要的。',
            reversed: '恐惧离开、安于现状、回归',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯九',
            suit: '圣杯',
            number: '9',
            image: '/static/images/tarot/minor/9-of-cups.png',
            keywords: '满足、幸福、愿望实现',
            meaning: '象征情感上的满足和愿望的实现。提示您欣赏已经拥有的，享受生活的美好，表达感恩之情。',
            reversed: '自满、物质主义、表面满足',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯十',
            suit: '圣杯',
            number: '10',
            image: '/static/images/tarot/minor/10-of-cups.png',
            keywords: '完美和谐、家庭幸福、情感圆满',
            meaning: '代表家庭幸福和情感上的圆满。提示您珍视家庭和亲密关系，共同创造和谐美满的生活。',
            reversed: '破裂的家庭、不和谐、失去连接',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯侍者',
            suit: '圣杯',
            number: '侍者',
            image: '/static/images/tarot/minor/page-of-cups.png',
            keywords: '直觉、灵感、感性',
            meaning: '象征情感上的新消息和创意灵感。提示您保持好奇心和想象力，对情感体验持开放态度。',
            reversed: '情感不成熟、幻灭、创意受阻',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯骑士',
            suit: '圣杯',
            number: '骑士',
            image: '/static/images/tarot/minor/knight-of-cups.png',
            keywords: '浪漫、魅力、行动',
            meaning: '代表浪漫的追求和富有创意的行动。提示您以热情和奉献精神追求情感目标，表达爱意。',
            reversed: '情绪化、不切实际、失望',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯王后',
            suit: '圣杯',
            number: '王后',
            image: '/static/images/tarot/minor/queen-of-cups.png',
            keywords: '同情、关爱、直觉',
            meaning: '象征情感的智慧和直觉的力量。提示您关注内心的声音，以同理心和关爱对待他人。',
            reversed: '情感依赖、情绪化、直觉失准',
            element: '水',
            category: 'minor'
          },
          {
            name: '圣杯国王',
            suit: '圣杯',
            number: '国王',
            image: '/static/images/tarot/minor/king-of-cups.png',
            keywords: '情感掌控、平衡、智慧',
            meaning: '代表情感上的成熟和掌控。提示您在表达感情的同时保持理性，平衡情感和智慧。',
            reversed: '情感操控、冷漠、情感不稳定',
            element: '水',
            category: 'minor'
          }
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
          {
            name: '宝剑二',
            suit: '宝剑',
            number: '2',
            image: '/static/images/tarot/minor/2-of-swords.png',
            keywords: '决策困难、平衡、僵局',
            meaning: '代表面临困难选择时的犹豫不决。提示您可能需要打破僵局，权衡利弊，做出决定。',
            reversed: '压力决策、摆脱僵局、混乱',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑三',
            suit: '宝剑',
            number: '3',
            image: '/static/images/tarot/minor/3-of-swords.png',
            keywords: '心碎、悲伤、痛苦',
            meaning: '象征情感上的痛苦和心碎。提醒您接受痛苦是愈合的必要过程，允许自己感受并处理这些情感。',
            reversed: '康复、宽恕、释放痛苦',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑四',
            suit: '宝剑',
            number: '4',
            image: '/static/images/tarot/minor/4-of-swords.png',
            keywords: '休息、恢复、冥想',
            meaning: '代表在压力或冲突后需要休息和恢复。提示您暂时退出战场，给自己时间冥想和恢复精力。',
            reversed: '重返生活、恢复活力、压力卷土重来',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑五',
            suit: '宝剑',
            number: '5',
            image: '/static/images/tarot/minor/5-of-swords.png',
            keywords: '冲突、失败、不公',
            meaning: '象征冲突和争斗导致的伤害。提醒您考虑胜利的代价，注意他人的感受，学会和平解决冲突。',
            reversed: '和解、化解冲突、悔悟',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑六',
            suit: '宝剑',
            number: '6',
            image: '/static/images/tarot/minor/6-of-swords.png',
            keywords: '过渡、离开、旅程',
            meaning: '代表从困难或动荡的情况中离开，前往更平静的水域。提示您接受必要的变化，相信未来会更好。',
            reversed: '阻碍、抗拒变化、滞留过去',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑七',
            suit: '宝剑',
            number: '7',
            image: '/static/images/tarot/minor/7-of-swords.png',
            keywords: '欺骗、策略、逃避',
            meaning: '象征欺骗或策略性行动。提醒您警惕他人的欺骗，同时审视自己是否在逃避责任或使用不诚实的手段。',
            reversed: '承认错误、坦诚、被抓现行',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑八',
            suit: '宝剑',
            number: '8',
            image: '/static/images/tarot/minor/8-of-swords.png',
            keywords: '限制、受困、自我束缚',
            meaning: '代表感到被困和受限，但限制往往来自自己的思想。提示您认识到自己有能力摆脱这些束缚。',
            reversed: '释放、新视角、重获自由',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑九',
            suit: '宝剑',
            number: '9',
            image: '/static/images/tarot/minor/9-of-swords.png',
            keywords: '焦虑、恐惧、噩梦',
            meaning: '象征因恐惧和忧虑导致的精神痛苦。提醒您不要让负面思想控制自己，寻求支持和帮助。',
            reversed: '希望、克服恐惧、面对现实',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑十',
            suit: '宝剑',
            number: '10',
            image: '/static/images/tarot/minor/10-of-swords.png',
            keywords: '结束、失败、痛苦',
            meaning: '代表痛苦的结束或达到低谷。提示虽然当前情况令人痛苦，但这也意味着最坏的已经过去，新的开始即将到来。',
            reversed: '恢复、希望重燃、解脱',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑侍者',
            suit: '宝剑',
            number: '侍者',
            image: '/static/images/tarot/minor/page-of-swords.png',
            keywords: '好奇、敏锐、观察',
            meaning: '象征敏锐的观察力和好奇心。提示您保持警觉，收集信息，准备好接受新的想法和观点。',
            reversed: '谎言、八卦、不成熟思维',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑骑士',
            suit: '宝剑',
            number: '骑士',
            image: '/static/images/tarot/minor/knight-of-swords.png',
            keywords: '行动力、勇敢、直率',
            meaning: '代表积极主动和勇敢直率的能量。提示您全力以赴追求真相和正义，但也要注意可能的冲动行为。',
            reversed: '鲁莽、侵略性、盲目行动',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑王后',
            suit: '宝剑',
            number: '王后',
            image: '/static/images/tarot/minor/queen-of-swords.png',
            keywords: '独立、理性、直接',
            meaning: '象征理性思考和直接沟通的能力。提示您以清晰的思维和诚实的态度处理情况，保持独立判断。',
            reversed: '刻薄、冷漠、过度批判',
            element: '风',
            category: 'minor'
          },
          {
            name: '宝剑国王',
            suit: '宝剑',
            number: '国王',
            image: '/static/images/tarot/minor/king-of-swords.png',
            keywords: '理智、权威、真相',
            meaning: '代表理性思考和权威决策。提示您运用智慧和逻辑来分析情况，寻求真相，做出公正的判断。',
            reversed: '滥用权力、残酷、不公正',
            element: '风',
            category: 'minor'
          }
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
          {
            name: '金币二',
            suit: '金币',
            number: '2',
            image: '/static/images/tarot/minor/2-of-pentacles.png',
            keywords: '平衡、适应性、优先级',
            meaning: '代表在多项责任或情况间寻找平衡。提示您灵活应对变化，平衡不同的需求和优先事项。',
            reversed: '失衡、杂乱无章、优先次序颠倒',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币三',
            suit: '金币',
            number: '3',
            image: '/static/images/tarot/minor/3-of-pentacles.png',
            keywords: '合作、专业、技艺',
            meaning: '象征团队合作和专业技能的发展。提示您重视与他人的合作，投入时间提升自己的技能和专业知识。',
            reversed: '缺乏合作、低质量工作、缺乏认可',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币四',
            suit: '金币',
            number: '4',
            image: '/static/images/tarot/minor/4-of-pentacles.png',
            keywords: '安全、控制、吝啬',
            meaning: '代表对物质安全的追求和对资源的紧握。提示您注意在安全需求和慷慨之间找到平衡，避免过度控制。',
            reversed: '放手、花费、物质不安全感',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币五',
            suit: '金币',
            number: '5',
            image: '/static/images/tarot/minor/5-of-pentacles.png',
            keywords: '困难、排斥、贫穷',
            meaning: '象征物质或健康上的困难时期。提醒您注意周围可能的帮助和支持，不要因骄傲而拒绝援助。',
            reversed: '恢复、寻求帮助、心态改变',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币六',
            suit: '金币',
            number: '6',
            image: '/static/images/tarot/minor/6-of-pentacles.png',
            keywords: '慷慨、施与、接受',
            meaning: '代表慷慨和资源的交换。提示您在需要时敢于给予和接受帮助，保持物质世界的平衡和循环。',
            reversed: '不平等、自私、债务',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币七',
            suit: '金币',
            number: '7',
            image: '/static/images/tarot/minor/7-of-pentacles.png',
            keywords: '耐心、评估、努力结果',
            meaning: '象征等待努力成果和评估进展的时期。提示您耐心等待投资的回报，同时审视自己的努力方向。',
            reversed: '懒惰、缺乏耐心、不良投资',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币八',
            suit: '金币',
            number: '8',
            image: '/static/images/tarot/minor/8-of-pentacles.png',
            keywords: '勤奋、技能发展、细节',
            meaning: '代表专注于提升技能和精进工艺。提示您投入时间学习和完善技能，关注细节，追求卓越。',
            reversed: '完美主义、没有进展、技能不足',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币九',
            suit: '金币',
            number: '9',
            image: '/static/images/tarot/minor/9-of-pentacles.png',
            keywords: '独立、成就、享受',
            meaning: '象征通过自己的努力获得的成功和物质舒适。提示您欣赏自己的成就，享受独立自主的生活。',
            reversed: '表面繁荣、孤独、依赖',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币十',
            suit: '金币',
            number: '10',
            image: '/static/images/tarot/minor/10-of-pentacles.png',
            keywords: '财富、遗产、家族',
            meaning: '代表长期的财富积累和家族资源。提示您考虑长远规划和代际传承，建立持久的物质基础。',
            reversed: '家族问题、失去财富、短视',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币侍者',
            suit: '金币',
            number: '侍者',
            image: '/static/images/tarot/minor/page-of-pentacles.png',
            keywords: '学习、责任、机会',
            meaning: '象征新的学习和务实的机会。提示您以开放的态度学习新技能，重视教育和实际训练。',
            reversed: '缺乏专注、浪费机会、不切实际',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币骑士',
            suit: '金币',
            number: '骑士',
            image: '/static/images/tarot/minor/knight-of-pentacles.png',
            keywords: '勤奋、责任、方法',
            meaning: '代表踏实和负责任的行动。提示您脚踏实地地工作，有耐心和毅力，逐步实现目标。',
            reversed: '拖延、固执、工作狂',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币王后',
            suit: '金币',
            number: '王后',
            image: '/static/images/tarot/minor/queen-of-pentacles.png',
            keywords: '滋养、实用、丰盛',
            meaning: '象征务实和滋养的能量。提示您关注物质世界的舒适和安全，同时照顾和滋养他人。',
            reversed: '自我忽视、物质依赖、过度控制',
            element: '土',
            category: 'minor'
          },
          {
            name: '金币国王',
            suit: '金币',
            number: '国王',
            image: '/static/images/tarot/minor/king-of-pentacles.png',
            keywords: '富足、实力、安全',
            meaning: '代表在物质世界中取得成功和建立安全基础。提示您以稳健和负责的态度管理资源，创造持久的价值。',
            reversed: '贪婪、物质主义、固执',
            element: '土',
            category: 'minor'
          }
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
    },
    toggleSuit(suit) {
      this.suitExpanded[suit] = !this.suitExpanded[suit];
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
  
  .suit-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15rpx 20rpx;
    background-color: rgba($color-primary, 0.1);
    border-radius: 10rpx;
    margin-bottom: 15rpx;
    cursor: pointer;
    transition: background-color 0.3s ease;
    
    &:active {
      background-color: rgba($color-primary, 0.2);
    }
  
  .suit-title {
    font-size: 30rpx;
    font-weight: 600;
    color: $color-primary;
    }
    
    .toggle-icon {
      font-size: 34rpx;
      color: $color-primary;
      font-weight: bold;
    }
  }
}

.card-grid {
  display: flex;
  flex-wrap: wrap;
  margin: 0 -10rpx;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10rpx);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.card-item {
  width: calc(33.333% - 20rpx);
  margin: 10rpx;
  border-radius: 12rpx;
  overflow: hidden;
  box-shadow: 0 4rpx 8rpx rgba(0, 0, 0, 0.1);
  background-color: white;
  position: relative;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  
  &:active {
    transform: scale(0.98);
    box-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.1);
  }
  
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