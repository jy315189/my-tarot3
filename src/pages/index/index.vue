<template>
	<view class="index-container mystic-bg">
		<!-- 背景装饰元素 -->
		<view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.6;"></view>
		<view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.5;"></view>
		<view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
		<view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
		<view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
		<view class="mystic-star" style="bottom: 30%; left: 25%;">✧</view>
		
		<!-- 顶部用户信息 -->
		<view class="user-info">
			<view class="user-avatar-container" @tap="goToUserCenter">
				<image class="user-avatar" :src="userInfo.avatar || '/static/images/default-avatar.png'"></image>
				<view class="avatar-badge" v-if="hasNewMessages">{{newMessageCount}}</view>
			</view>
			<view class="user-greeting">
				<text class="greeting">{{greeting}}</text>
				<text class="username">{{userInfo.username || '神秘访客'}}</text>
			</view>
			<view class="user-menu" @tap="openMenu">
				<text class="icon">☰</text>
			</view>
		</view>
		
		<!-- 塔罗牌选择模式 -->
		<view class="section-title">
			<text class="title mystic">塔罗占卜</text>
			<text class="subtitle">选择一种占卜方式</text>
		</view>
		
		<scroll-view scroll-x class="reading-types" show-scrollbar="false">
			<view class="reading-type-item card" v-for="(item, index) in readingTypes" :key="index" @tap="selectReadingType(item)">
				<image class="reading-type-image" :src="item.image" mode="aspectFill"></image>
				<view class="reading-type-info">
					<text class="reading-type-name">{{item.name}}</text>
					<text class="reading-type-desc">{{item.description}}</text>
				</view>
				<text class="reading-type-cards">{{item.cards}}张牌</text>
			</view>
		</scroll-view>
		
		<!-- 最近解读记录 -->
		<view class="section-title">
			<text class="title">历史解读</text>
			<text class="view-all" @tap="viewAllReadings">查看全部</text>
		</view>
		
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
		
		<!-- 今日运势 -->
		<view class="section-title fortune-section">
			<text class="title">今日运势</text>
			<text class="subtitle">{{todayDate}}</text>
		</view>
		
		<view class="daily-fortune card" v-if="hasDailyFortune">
			<view class="fortune-card-container">
				<view class="fortune-card">
					<image class="card-image" :src="dailyCard.image" mode="aspectFill"></image>
					<view class="card-glow"></view>
				</view>
				<text class="fortune-card-name mystic">{{dailyCard.name}}</text>
				<view class="card-position">正位</view>
			</view>
			<view class="fortune-divider"></view>
			<view class="fortune-info">
				<text class="fortune-title mystic">{{dailyCard.name}}</text>
				<text class="fortune-keyword">关键词: {{dailyCard.keywords}}</text>
				<text class="fortune-description">{{dailyCard.description}}</text>
				<button class="btn btn-secondary" @tap="readDailyFortune">查看详解</button>
			</view>
		</view>
		
		<view class="daily-fortune-empty card" v-else>
			<view class="mystic-symbol">✧</view>
			<image class="empty-fortune-img" src="/static/images/decorations/fortune-empty.png" mode="aspectFit"></image>
			<text class="empty-fortune-title mystic">神秘的今日运势</text>
			<text class="empty-fortune-text">通过塔罗牌揭示今天的能量与指引</text>
			<button class="btn btn-primary fortune-btn" @tap="drawDailyFortune">探索今日运势</button>
		</view>
		
		<!-- 今日运势测试按钮 -->
		<button v-if="hasDailyFortune" class="btn btn-text test-btn-fixed" @tap="resetDailyFortune">重新测试运势</button>
		
		<!-- 抽牌动画层 -->
		<view class="card-draw-overlay" v-if="isDrawing">
			<view class="mystic-stars">
				<view class="mystic-star" v-for="i in 20" :key="i" :style="getRandomStarStyle()">✦</view>
			</view>
			<view class="card-draw-container">
				<view class="card-deck" @tap="completeCardDraw">
					<image class="card-back" src="/static/images/tarot/back/card-back.png" @error="useDefaultCardBack"></image>
					<view class="deck-glow"></view>
				</view>
				<text class="draw-instruction">点击牌堆抽取今日运势</text>
			</view>
		</view>
		
		<!-- 卡牌飞行动画 -->
		<view class="flying-card" v-if="isCardFlying" :style="flyingCardStyle" :class="{'card-flipped': isCardFlipped, 'card-magic': isCardMagic}">
			<view class="card-sparkles" v-if="isCardMagic">
				<view class="sparkle" v-for="i in 10" :key="i" :style="getRandomSparkleStyle()"></view>
			</view>
			<view class="flying-card-inner">
				<view class="flying-card-back">
					<image :src="cardBackImage" @error="useDefaultCardBack"></image>
				</view>
				<view class="flying-card-front">
					<image :src="dailyCard.image"></image>
				</view>
			</view>
		</view>
		
		<!-- 占卜按钮 -->
		<button class="fab btn-primary" @tap="startNewReading">
			<text class="fab-icon">✦</text>
			<text class="fab-text">开始占卜</text>
		</button>
	</view>
</template>

<script>
	import { ref, reactive, computed, onMounted } from 'vue';
	export default {
		data() {
			return {
				userInfo: {},
				hasNewMessages: true,
				newMessageCount: 3,
				readingTypes: [
					{
						name: '时间之箭',
						description: '回答简单的问题',
						cards: 3,
						image: '/static/images/reading-single.jpg'
					},
					{
						name: '是非问题',
						description: '回答是非类问题',
						cards: 2,
						image: '/static/images/reading-three.jpg'
					},
					{
						name: '圣三角',
						description: '回答简单问题',
						cards: 3,
						image: '/static/images/reading-three.jpg'
					},
					{
						name: '钻石展开法',
						description: '解析事件走向',
						cards: 5,
						image: '/static/images/reading-cross.jpg'
					},
					{
						name: '恋人金字塔',
						description: '分析恋爱走向',
						cards: 6,
						image: '/static/images/reading-relationship.jpg'
					},
					{
						name: '自我探索',
						description: '认清自我处境',
						cards: 4,
						image: '/static/images/reading-three.jpg'
					},
					{
						name: '吉普赛十字',
						description: '分析关系走向',
						cards: 5,
						image: '/static/images/reading-cross.jpg'
					},
					{
						name: '二选一',
						description: '比较多种选择',
						cards: 5,
						image: '/static/images/reading-cross.jpg'
					},
					{
						name: '关系发展',
						description: '解析双方想法与期望',
						cards: 6,
						image: '/static/images/reading-relationship.jpg'
					},
					{
						name: '六芒星',
						description: '分析事业与事件走向',
						cards: 7,
						image: '/static/images/reading-relationship.jpg'
					},
					{
						name: '凯尔特十字',
						description: '古老而全面的牌阵',
						cards: 10,
						image: '/static/images/reading-cross.jpg'
					}
				],
				readingHistory: [
					{
						id: '1',
						type: '单牌占卜',
						question: '今天我适合做重要决定吗？',
						date: new Date(2023, 6, 15)
					},
					{
						id: '2',
						type: '三牌展开',
						question: '我的事业发展方向如何？',
						date: new Date(2023, 6, 12)
					},
					{
						id: '3',
						type: '关系解读',
						question: '我们的关系未来会如何发展？',
						date: new Date(2023, 6, 8)
					}
				],
				dailyCard: {
					name: '星星',
					keywords: '希望、灵感、平静',
					description: '今日为您带来希望与灵感，是追求梦想与崭新开始的好时机。',
					image: '/static/images/tarot/major/star.jpg'
				},
				// 新增今日运势相关状态
				hasDailyFortune: false,
				isDrawing: false,
				isCardFlying: false,
				isCardFlipped: false,
				isCardMagic: false,
				flyingCardStyle: {
					top: '50%',
					left: '50%'
				},
				// 塔罗牌数据库
				tarotCards: [
					{
						name: '愚者',
						keywords: '冒险、直觉、无忧无虑',
						description: '今天是开始新冒险的好时机，跟随你的直觉，放下担忧。',
						image: '/static/images/tarot/major/00-the-fool.png'
					},
					{
						name: '魔术师',
						keywords: '创造力、行动、意志力',
						description: '今天你拥有实现目标的技能和资源，把握良机开始行动。',
						image: '/static/images/tarot/major/01-the-magician.png'
					},
					{
						name: '女祭司',
						keywords: '直觉、内在智慧、神秘',
						description: '今天应留意直觉的指引，倾听内心的声音，寻求内在智慧。',
						image: '/static/images/tarot/major/02-the-high-priestess.png'
					},
					{
						name: '皇后',
						keywords: '丰盛、创造、滋养',
						description: '今天适合创造性活动，关注自我滋养，享受生活的丰盛。',
						image: '/static/images/tarot/major/03-the-empress.png'
					},
					{
						name: '皇帝',
						keywords: '权威、控制、领导',
						description: '今天适合展现领导力，建立结构和秩序，掌控局面。',
						image: '/static/images/tarot/major/04-the-emperor.png'
					},
					{
						name: '教皇',
						keywords: '传统、精神指引、信仰',
						description: '今天是寻求智慧和精神指引的好时机，尊重传统价值。',
						image: '/static/images/tarot/major/05-the-hierophant.png'
					},
					{
						name: '恋人',
						keywords: '爱情、选择、和谐',
						description: '今天可能面临重要选择，倾听内心，追求和谐与爱。',
						image: '/static/images/tarot/major/06-the-lovers.png'
					},
					{
						name: '战车',
						keywords: '决心、胜利、自信',
						description: '今天充满动力和决心，坚持不懈定能取得胜利。',
						image: '/static/images/tarot/major/07-the-chariot.png'
					},
					{
						name: '力量',
						keywords: '勇气、内在力量、坚韧',
						description: '今天能发挥内在力量，温和而坚定地克服挑战。',
						image: '/static/images/tarot/major/08-strength.png'
					},
					{
						name: '隐士',
						keywords: '反思、内省、独处',
						description: '今天适合独处和沉思，寻找内心的智慧和方向。',
						image: '/static/images/tarot/major/09-the-hermit.png'
					},
					{
						name: '命运之轮',
						keywords: '变化、机遇、命运',
						description: '今天可能带来意外转变，接受命运的流动，把握新机遇。',
						image: '/static/images/tarot/major/10-wheel-of-fortune.png'
					},
					{
						name: '正义',
						keywords: '公正、平衡、真相',
						description: '今天强调真相与公正，事物将趋于平衡，诚实为上。',
						image: '/static/images/tarot/major/11-justice.png'
					},
					{
						name: '倒吊人',
						keywords: '新视角、牺牲、等待',
						description: '今天可能需要停下脚步，转换视角，接受暂时的牺牲。',
						image: '/static/images/tarot/major/12-the-hanged-man.png'
					},
					{
						name: '死神',
						keywords: '转变、结束、新生',
						description: '今天是结束旧阶段的时候，为新的开始腾出空间。',
						image: '/static/images/tarot/major/13-death.png'
					},
					{
						name: '节制',
						keywords: '平衡、适度、和谐',
						description: '今天应当保持平衡，不走极端，寻求内外的和谐。',
						image: '/static/images/tarot/major/14-temperance.png'
					},
					{
						name: '恶魔',
						keywords: '束缚、欲望、物质主义',
						description: '今天需警惕欲望和执着带来的束缚，审视内心真正的需求。',
						image: '/static/images/tarot/major/15-the-devil.png'
					},
					{
						name: '塔',
						keywords: '突变、启示、释放',
						description: '今天可能带来突发变化，打破旧有结构，释放新的认知。',
						image: '/static/images/tarot/major/16-the-tower.png'
					},
					{
						name: '星星',
						keywords: '希望、灵感、平静',
						description: '今日为您带来希望与灵感，是追求梦想与崭新开始的好时机。',
						image: '/static/images/tarot/major/17-the-star.png'
					},
					{
						name: '月亮',
						keywords: '直觉、潜意识、幻觉',
						description: '今天直觉特别敏锐，但需要区分真相和幻觉，倾听内心深处的声音。',
						image: '/static/images/tarot/major/18-the-moon.png'
					},
					{
						name: '太阳',
						keywords: '活力、成功、喜悦',
						description: '今天充满积极能量，有望取得成功，感受纯粹的快乐。',
						image: '/static/images/tarot/major/19-the-sun.png'
					},
					{
						name: '审判',
						keywords: '重生、觉醒、召唤',
						description: '今天是觉醒和答应内心召唤的时刻，准备迎接重生和转变。',
						image: '/static/images/tarot/major/20-judgement.png'
					},
					{
						name: '世界',
						keywords: '完成、圆满、整合',
						description: '今天象征一个周期的圆满完成，体验成就感与和谐统一。',
						image: '/static/images/tarot/major/21-the-world.png'
					}
				],
				cardBackImage: '/static/images/tarot/back/card-back.png'
			}
		},
		computed: {
			greeting() {
				const hour = new Date().getHours();
				if (hour < 6) return '夜深了';
				if (hour < 12) return '早安';
				if (hour < 18) return '午安';
				return '晚安';
			},
			todayDate() {
				const date = new Date();
				return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`;
			}
		},
		onLoad() {
			// 获取用户信息
			this.getUserInfo();
			// 检查今日是否已抽取运势
			this.checkDailyFortune();
			// 初始化卡牌背面图片
			this.initCardBackImage();
		},
		methods: {
			// 获取用户信息
			getUserInfo() {
				try {
					const userInfo = uni.getStorageSync('userInfo');
					if (userInfo) {
						this.userInfo = userInfo;
					} else {
						// 未登录，跳转到登录页
						uni.navigateTo({
							url: '/pages/login/login'
						});
					}
				} catch (e) {
					console.error('获取用户信息失败', e);
				}
			},
			
			// 检查今日是否已抽取运势
			checkDailyFortune() {
				try {
					const dailyFortune = uni.getStorageSync('dailyFortune');
					if (dailyFortune) {
						const savedDate = new Date(dailyFortune.date);
						const today = new Date();
						
						// 检查是否是今天的运势
						if (savedDate.toDateString() === today.toDateString()) {
							this.dailyCard = dailyFortune.card;
							this.hasDailyFortune = true;
						} else {
							this.hasDailyFortune = false;
						}
					} else {
						this.hasDailyFortune = false;
					}
				} catch (e) {
					console.error('获取今日运势失败', e);
					this.hasDailyFortune = false;
				}
			},
			
			// 抽取今日运势
			drawDailyFortune() {
				// 显示抽牌动画界面
				this.isDrawing = true;
			},
			
			// 完成卡牌抽取
			completeCardDraw() {
				// 随机抽取一张牌
				const randomIndex = Math.floor(Math.random() * this.tarotCards.length);
				this.dailyCard = this.tarotCards[randomIndex];
				
				// 添加抽牌音效（如果需要的话）
				// uni.createInnerAudioContext().src = '/static/sounds/card-draw.mp3';
				
				// 隐藏抽牌界面，显示飞行动画
				setTimeout(() => {
					this.isDrawing = false;
					
					// 开始卡牌飞行动画
					this.isCardFlying = true;
					this.flyingCardStyle = {
						top: '50%',
						left: '50%',
						transform: 'translate(-50%, -50%) scale(1.2)',
						transition: 'all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275)'
					};
					
					// 添加抖动动画效果
					setTimeout(() => {
						this.flyingCardStyle = {
							...this.flyingCardStyle,
							transform: 'translate(-50%, -50%) scale(1.1) rotate(-5deg)'
						};
						
						setTimeout(() => {
							this.flyingCardStyle = {
								...this.flyingCardStyle,
								transform: 'translate(-50%, -50%) scale(1.1) rotate(3deg)'
							};
							
							// 300ms后翻转卡牌
							setTimeout(() => {
								this.isCardFlipped = true;
								
								// 翻牌后展示魔法效果
								setTimeout(() => {
									this.isCardMagic = true;
									
									// 1000ms后开始移动到今日运势位置
									setTimeout(() => {
										// 使用uni-app API获取元素位置
										const query = uni.createSelectorQuery();
										query.select('.daily-fortune-empty').boundingClientRect(data => {
											if (data) {
												// 动态计算今日运势卡片的位置
												this.flyingCardStyle = {
													top: `${data.top + 160}px`,
													left: `${data.left + data.width / 2}px`,
													transform: 'translate(-50%, -50%) scale(0.8)',
													transition: 'all 1s cubic-bezier(0.22, 0.61, 0.36, 1)'
												};
											}
											
											// 800ms后卡牌闪烁消失，同时显示今日运势
											setTimeout(() => {
												// 卡牌闪光消失效果
												this.flyingCardStyle = {
													...this.flyingCardStyle,
													transform: 'translate(-50%, -50%) scale(1.2)',
													opacity: 0,
													filter: 'brightness(2)',
													transition: 'all 0.5s ease-out'
												};
												
												// 在卡牌消失的同时显示今日运势
												setTimeout(() => {
													this.isCardFlying = false;
													this.isCardFlipped = false;
													this.isCardMagic = false;
													this.hasDailyFortune = true;
													
													// 保存今日运势到本地存储
													this.saveDailyFortune();
													
													// 显示抽取成功提示
													uni.showToast({
														title: '今日运势已揭晓',
														icon: 'none',
														duration: 2000
													});
												}, 300);
											}, 800);
										}).exec();
									}, 1000);
								}, 300);
							}, 300);
						}, 150);
					}, 150);
				}, 300);
			},
			
			// 保存今日运势到本地存储
			saveDailyFortune() {
				try {
					const dailyFortune = {
						card: this.dailyCard,
						date: new Date().toISOString()
					};
					uni.setStorageSync('dailyFortune', dailyFortune);
				} catch (e) {
					console.error('保存今日运势失败', e);
				}
			},
			
			// 重置今日运势（测试用）
			resetDailyFortune() {
				try {
					uni.removeStorageSync('dailyFortune');
					this.hasDailyFortune = false;
					uni.showToast({
						title: '已重置今日运势',
						icon: 'none'
					});
				} catch (e) {
					console.error('重置今日运势失败', e);
				}
			},
			
			// 格式化日期
			formatDay(date) {
				return new Date(date).getDate();
			},
			formatMonth(date) {
				const months = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
				return months[new Date(date).getMonth()];
			},
			
			// 跳转到个人中心
			goToUserCenter() {
				uni.switchTab({
					url: '/pages/user/user'
				});
			},
			
			// 打开菜单
			openMenu() {
				uni.showActionSheet({
					itemList: ['设置', '意见反馈', '关于我们', '退出登录'],
					success: (res) => {
						if (res.tapIndex === 3) {
							this.logout();
						}
					}
				});
			},
			
			// 退出登录
			logout() {
				uni.showModal({
					title: '提示',
					content: '确定要退出登录吗？',
					success: (res) => {
						if (res.confirm) {
							uni.removeStorageSync('userInfo');
							uni.removeStorageSync('token');
							uni.reLaunch({
								url: '/pages/login/login'
							});
						}
					}
				});
			},
			
			// 选择占卜类型
			selectReadingType(type) {
				uni.navigateTo({
					url: `/pages/reading/prepare?type=${type.name}&cards=${type.cards}`
				});
			},
			
			// 查看所有历史记录
			viewAllReadings() {
				uni.navigateTo({
					url: '/pages/reading/history'
				});
			},
			
			// 查看历史记录详情
			viewReadingDetail(item) {
				uni.navigateTo({
					url: `/pages/reading/detail?id=${item.id}`
				});
			},
			
			// 查看今日运势详情
			readDailyFortune() {
				uni.navigateTo({
					url: '/pages/fortune/daily'
				});
			},
			
			// 开始新的占卜
			startNewReading() {
				uni.navigateTo({
					url: '/pages/reading/prepare'
				});
			},
			
			// 生成随机星星样式
			getRandomStarStyle() {
				return {
					top: `${Math.random() * 100}%`,
					left: `${Math.random() * 100}%`,
					opacity: Math.random() * 0.7 + 0.3,
					fontSize: `${Math.random() * 20 + 10}px`,
					animationDelay: `${Math.random() * 2}s`,
					animationDuration: `${Math.random() * 3 + 2}s`
				};
			},
			
			// 生成随机闪光样式
			getRandomSparkleStyle() {
				return {
					top: `${Math.random() * 100}%`,
					left: `${Math.random() * 100}%`,
					width: `${Math.random() * 10 + 5}px`,
					height: `${Math.random() * 10 + 5}px`,
					animationDelay: `${Math.random() * 0.5}s`,
					animationDuration: `${Math.random() * 1 + 0.5}s`
				};
			},
			
			// 使用默认卡牌背面
			useDefaultCardBack() {
				// 创建一个内联的基本卡牌背面图片
				const fallbackCardBack = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxODAiIGhlaWdodD0iMzAwIiB2aWV3Qm94PSIwIDAgMTgwIDMwMCI+CiAgPHJlY3Qgd2lkdGg9IjE4MCIgaGVpZ2h0PSIzMDAiIGZpbGw9IiMxYTFhMmUiIC8+CiAgPHBhdGggZD0iTTIwLDIwIEwxNjAsMjAgTDE2MCwyODAgTDIwLDI4MCBMMjAsMjAgWiIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmRkMzlhIiBzdHJva2Utd2lkdGg9IjIiIC8+CiAgPGNpcmNsZSBjeD0iOTAiIGN5PSIxNTAiIHI9IjUwIiBmaWxsPSJub25lIiBzdHJva2U9IiNmZGQzOWEiIHN0cm9rZS13aWR0aD0iMiIgLz4KICA8cGF0aCBkPSJNNjAsOTAgTDEyMCw5MCBMMTIwLDIxMCBMNjAsMjEwIEw2MCw5MCBaIiBmaWxsPSJub25lIiBzdHJva2U9IiNmZGQzOWEiIHN0cm9rZS13aWR0aD0iMiIgLz4KICA8dGV4dCB4PSI5MCIgeT0iMTUwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiBmaWxsPSIjZmRkMzlhIiBmb250LXNpemU9IjE0IiBmb250LWZhbWlseT0ic2Fucy1zZXJpZiI+VEFST1Q8L3RleHQ+CiAgPHRleHQgeD0iOTAiIHk9IjE3MCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgZmlsbD0iI2ZkZDM5YSIgZm9udC1zaXplPSIxMCIgZm9udC1mYW1pbHk9InNhbnMtc2VyaWYiPk15c3RpYyBDYXJkPC90ZXh0Pgo8L3N2Zz4=';
				this.cardBackImage = fallbackCardBack;
				console.log('卡牌背面图片加载失败，使用内置备选图片');
			},
			
			// 初始化卡牌背面图片
			initCardBackImage() {
				// 尝试预加载卡牌背面图片
				const img = new Image();
				img.onerror = () => {
					this.useDefaultCardBack();
				};
				img.src = this.cardBackImage;
			}
		}
	}
</script>

<style lang="scss">
	@import '@/styles/global.scss';
	
	.index-container {
		min-height: 100vh;
		padding: 40rpx 30rpx 180rpx;
		box-sizing: border-box;
		position: relative;
	}
	
	.user-info {
		display: flex;
		align-items: center;
		justify-content: space-between;
		margin-bottom: 50rpx;
		
		.user-avatar-container {
			position: relative;
		}
		
		.user-avatar {
			width: 90rpx;
			height: 90rpx;
			border-radius: 50%;
			border: 3rpx solid $color-primary;
		}
		
		.avatar-badge {
			position: absolute;
			top: -8rpx;
			right: -8rpx;
			background-color: $color-secondary;
			color: white;
			font-size: 20rpx;
			width: 38rpx;
			height: 38rpx;
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
		}
		
		.user-greeting {
			flex: 1;
			padding-left: 20rpx;
			
			.greeting {
				font-size: 26rpx;
				color: $accent-silver;
				display: block;
			}
			
			.username {
				font-size: 32rpx;
				font-weight: 500;
				display: block;
			}
		}
		
		.user-menu {
			padding: 10rpx;
			
			.icon {
				font-size: 40rpx;
				color: $color-text;
			}
		}
	}
	
	.section-title {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
		margin: 30rpx 0 20rpx;
		
		.title {
			font-size: 36rpx;
			font-weight: 600;
		}
		
		.subtitle {
			font-size: 26rpx;
			color: $accent-silver;
		}
		
		.view-all {
			font-size: 26rpx;
			color: $color-primary;
		}
	}
	
	.reading-types {
		white-space: nowrap;
		margin: 0 -30rpx;
		padding: 0 30rpx;
		
		.reading-type-item {
			display: inline-flex;
			flex-direction: column;
			width: 260rpx;
			margin-right: 20rpx;
			overflow: hidden;
			background: rgba($color-bg-card, 0.9);
			
			&:last-child {
				margin-right: 60rpx;
			}
		}
		
		.reading-type-image {
			width: 100%;
			height: 160rpx;
			object-fit: cover;
		}
		
		.reading-type-info {
			padding: 20rpx;
			flex: 1;
		}
		
		.reading-type-name {
			font-weight: 600;
			font-size: 28rpx;
			display: block;
			margin-bottom: 10rpx;
		}
		
		.reading-type-desc {
			font-size: 24rpx;
			color: $accent-silver;
			display: block;
		}
		
		.reading-type-cards {
			background: rgba($color-primary, 0.15);
			color: $color-primary;
			font-size: 24rpx;
			padding: 6rpx 20rpx;
			border-radius: 30rpx;
			align-self: flex-start;
			margin: 0 20rpx 20rpx;
		}
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
	
	.fortune-section {
		position: relative;
		margin-top: 25rpx;
		
		&::before {
			content: '✧';
			position: absolute;
			right: 0;
			top: 5rpx;
			font-size: 36rpx;
			color: $color-accent;
			opacity: 0.6;
		}
	}
	
	.daily-fortune {
		display: flex;
		padding: 20rpx 30rpx;
		position: relative;
		background: linear-gradient(to bottom, rgba($color-bg-card, 1) 0%, rgba($color-bg-card, 0.95) 100%);
		overflow: visible;
		
		&::before {
			content: '';
			position: absolute;
			top: -8rpx;
			left: 20rpx;
			right: 20rpx;
			height: 2px;
			background: linear-gradient(to right, transparent, $color-accent, transparent);
			opacity: 0.3;
		}
		
		.fortune-card-container {
			display: flex;
			flex-direction: column;
			align-items: center;
			margin-right: 30rpx;
			position: relative;
			z-index: 1;
		}
		
		.fortune-card {
			width: 180rpx;
			height: 270rpx;
			position: relative;
			margin-bottom: 12rpx;
			transform: perspective(800px) rotateY(5deg);
			transition: transform 0.3s ease;
			
			&:hover {
				transform: perspective(800px) rotateY(0deg) translateY(-5rpx);
			}
			
			.card-image {
				width: 100%;
				height: 100%;
				object-fit: cover;
				border-radius: 12rpx;
				border: 2rpx solid rgba($color-accent, 0.7);
				box-shadow: 0 0 15rpx rgba($color-primary, 0.3);
			}
			
			.card-glow {
				position: absolute;
				width: 100%;
				height: 100%;
				top: 0;
				left: 0;
				border-radius: 12rpx;
				box-shadow: 0 0 20rpx rgba($color-primary, 0.6);
				animation: pulse 2s infinite alternate;
			}
		}
		
		.fortune-card-name {
			font-size: 24rpx;
			text-align: center;
			margin-top: 8rpx;
			font-weight: 500;
		}
		
		.card-position {
			font-size: 22rpx;
			color: $color-accent;
			background: rgba($color-bg, 0.6);
			padding: 4rpx 12rpx;
			border-radius: 20rpx;
			margin-top: 6rpx;
		}
		
		.fortune-divider {
			width: 1px;
			align-self: stretch;
			background: linear-gradient(to bottom, transparent, rgba($color-primary, 0.3), transparent);
			margin: 0 20rpx 0 10rpx;
		}
		
		.fortune-info {
			flex: 1;
			display: flex;
			flex-direction: column;
			padding-left: 10rpx;
			position: relative;
			
			&::before {
				content: '';
				position: absolute;
				top: -10rpx;
				left: 0;
				width: 30rpx;
				height: 30rpx;
				background: radial-gradient(circle, rgba($color-accent, 0.3) 0%, transparent 70%);
				border-radius: 50%;
			}
			
			.fortune-title {
				font-size: 36rpx;
				margin-bottom: 15rpx;
			}
			
			.fortune-keyword {
				font-size: 26rpx;
				color: $color-primary;
				margin-bottom: 10rpx;
				font-weight: 500;
			}
			
			.fortune-description {
				font-size: 28rpx;
				flex: 1;
				margin-bottom: 20rpx;
				line-height: 1.5;
				position: relative;
				
				&::first-letter {
					font-size: 120%;
					color: $color-accent;
				}
			}
		}
	}
	
	.daily-fortune-empty {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: flex-start;
		padding: 20rpx 30rpx 30rpx;
		position: relative;
		background: linear-gradient(to bottom, rgba($color-bg-card, 1) 0%, rgba($color-bg-card, 0.95) 100%);
		
		.mystic-symbol {
			position: absolute;
			top: 10rpx;
			font-size: 24rpx;
			color: $color-accent;
			opacity: 0.7;
		}
		
		.empty-fortune-img {
			width: 130rpx;
			height: 130rpx;
			margin-bottom: 10rpx;
			margin-top: 8rpx;
			opacity: 0.8;
			filter: drop-shadow(0 0 8rpx rgba($color-primary, 0.3));
			animation: float 4s ease-in-out infinite;
		}
		
		.empty-fortune-title {
			font-size: 32rpx;
			margin-bottom: 8rpx;
			font-weight: 600;
			margin-top: -5rpx;
		}
		
		.empty-fortune-text {
			font-size: 28rpx;
			color: $accent-silver;
			margin-bottom: 25rpx;
			text-align: center;
			max-width: 80%;
		}
		
		.fortune-btn {
			width: 80%;
			position: relative;
			overflow: hidden;
			
			&::after {
				content: '';
				position: absolute;
				top: -50%;
				left: -50%;
				width: 200%;
				height: 200%;
				background: linear-gradient(transparent, transparent, rgba(255,255,255,0.1), transparent, transparent);
				transform: rotate(45deg);
				animation: shine 3s infinite;
			}
		}
	}
	
	@keyframes shine {
		0% {
			left: -50%;
		}
		100% {
			left: 100%;
		}
	}
	
	.test-btn-fixed {
		position: fixed;
		bottom: 100rpx;
		left: 40rpx;
		color: $accent-silver;
		font-size: 24rpx;
		background: rgba($color-bg-card, 0.8);
		z-index: 99;
		padding: 10rpx 20rpx;
		border-radius: 30rpx;
		box-shadow: 0 4rpx 10rpx rgba(0, 0, 0, 0.2);
	}
	
	.card-draw-overlay {
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
		animation: fadeIn 0.3s ease;
		overflow: hidden;
	}
	
	.mystic-stars {
		position: absolute;
		width: 100%;
		height: 100%;
		overflow: hidden;
		
		.mystic-star {
			position: absolute;
			color: rgba($color-primary, 0.6);
			animation: twinkle 3s infinite alternate;
		}
	}
	
	@keyframes twinkle {
		0% {
			opacity: 0.3;
			transform: scale(0.8);
		}
		50% {
			opacity: 1;
			transform: scale(1.2);
		}
		100% {
			opacity: 0.5;
			transform: scale(1);
		}
	}
	
	.card-draw-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		animation: scaleIn 0.5s ease;
		position: relative;
		z-index: 2;
	}
	
	.card-deck {
		width: 240rpx;
		height: 420rpx;
		position: relative;
		margin-bottom: 50rpx;
		transform: perspective(1000px) rotateY(5deg);
		transition: all 0.3s ease;
		
		&:active {
			transform: perspective(1000px) rotateY(5deg) scale(0.95);
		}
		
		&::before {
			content: '';
			position: absolute;
			top: 5rpx;
			left: 5rpx;
			right: 5rpx;
			bottom: 5rpx;
			background: rgba($color-primary, 0.2);
			z-index: -1;
			border-radius: 12rpx;
		}
	}
	
	.deck-glow {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: transparent;
		border-radius: 12rpx;
		box-shadow: 0 0 30rpx 5rpx rgba($color-primary, 0.7);
		animation: pulse-strong 2s infinite alternate;
		z-index: -1;
	}
	
	@keyframes pulse-strong {
		0% {
			opacity: 0.5;
			box-shadow: 0 0 20rpx 5rpx rgba($color-primary, 0.5);
		}
		100% {
			opacity: 1;
			box-shadow: 0 0 40rpx 10rpx rgba($color-primary, 0.8);
		}
	}
	
	.card-back {
		width: 100%;
		height: 100%;
		border-radius: 12rpx;
		border: 2rpx solid rgba($color-primary, 0.5);
		box-shadow: 0 0 20rpx rgba($color-primary, 0.5);
	}
	
	.draw-instruction {
		color: white;
		font-size: 32rpx;
		text-align: center;
		text-shadow: 0 0 10rpx rgba($color-primary, 0.8);
		animation: pulse-text 2s infinite alternate;
	}
	
	@keyframes pulse-text {
		0% {
			opacity: 0.7;
		}
		100% {
			opacity: 1;
		}
	}
	
	.flying-card {
		position: fixed;
		z-index: 1001;
		width: 180rpx;
		height: 320rpx;
		transform: translate(-50%, -50%);
		transition: all 1s cubic-bezier(0.4, 0, 0.2, 1);
	}
	
	.card-sparkles {
		position: absolute;
		width: 100%;
		height: 100%;
		z-index: 3;
		
		.sparkle {
			position: absolute;
			background-color: rgba($color-primary, 0.8);
			border-radius: 50%;
			animation: sparkle-out 1s ease-out forwards;
		}
	}
	
	@keyframes sparkle-out {
		0% {
			transform: scale(0);
			opacity: 1;
		}
		100% {
			transform: scale(3);
			opacity: 0;
		}
	}
	
	.card-magic {
		&::before {
			content: '';
			position: absolute;
			top: -30%;
			left: -30%;
			right: -30%;
			bottom: -30%;
			background: radial-gradient(circle, rgba($color-primary, 0.4) 0%, rgba($color-primary, 0) 70%);
			border-radius: 50%;
			z-index: -1;
			animation: expand-glow 1.5s ease-out forwards;
		}
	}
	
	@keyframes expand-glow {
		0% {
			transform: scale(0.5);
			opacity: 0.8;
		}
		100% {
			transform: scale(1.5);
			opacity: 0;
		}
	}
	
	.flying-card-inner {
		position: relative;
		width: 100%;
		height: 100%;
		transform-style: preserve-3d;
		transition: transform 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	}
	
	.card-flipped .flying-card-inner {
		transform: rotateY(180deg);
	}
	
	.flying-card-back, .flying-card-front {
		position: absolute;
		width: 100%;
		height: 100%;
		backface-visibility: hidden;
		border-radius: 12rpx;
		overflow: hidden;
		box-shadow: 0 0 30rpx rgba($color-primary, 0.7);
	}
	
	.flying-card-back {
		background-color: #1a1a2e;
	}
	
	.flying-card-front {
		transform: rotateY(180deg);
	}
	
	.flying-card-back image, .flying-card-front image {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
	.fab {
		position: fixed;
		right: 40rpx;
		bottom: 160rpx;
		height: 100rpx;
		min-width: 240rpx;
		border-radius: 50rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		box-shadow: 0 8rpx 30rpx rgba($color-primary, 0.4);
		z-index: 100;
		
		.fab-icon {
			margin-right: 10rpx;
			font-size: 32rpx;
		}
		
		.fab-text {
			font-size: 30rpx;
			font-weight: 500;
		}
	}
	
	@keyframes pulse {
		0% {
			opacity: 0.3;
		}
		100% {
			opacity: 0.8;
		}
	}
	
	@keyframes fadeIn {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}
	
	@keyframes scaleIn {
		from {
			transform: scale(0.9);
		}
		to {
			transform: scale(1);
		}
	}
</style>
