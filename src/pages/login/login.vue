<template>
	<view class="login-container mystic-bg">
		<!-- 背景装饰元素 -->
		<view class="mystic-circle" style="width: 300rpx; height: 300rpx; top: 10%; right: -50rpx;"></view>
		<view class="mystic-circle" style="width: 200rpx; height: 200rpx; bottom: 20%; left: -50rpx;"></view>
		<view class="mystic-star" style="width: 20rpx; height: 20rpx; top: 25%; left: 20%;">✦</view>
		<view class="mystic-star" style="width: 20rpx; height: 20rpx; top: 40%; right: 30%;">✧</view>
		<view class="mystic-star" style="width: 20rpx; height: 20rpx; bottom: 30%; right: 15%;">✦</view>
		
		<!-- 顶部装饰图 -->
		<view class="login-header">
			<image src="/static/images/logo.png" mode="aspectFit" class="logo float"></image>
			<view class="title mystic">神秘塔罗</view>
			<view class="subtitle">探索命运的奥秘</view>
		</view>
		
		<!-- 登录表单 -->
		<view class="login-form card">
			<view class="form-header">
				<view class="subtitle">账号登录</view>
				<view class="form-toggle text-primary" @tap="toggleForm">{{ isLogin ? '没有账号？注册' : '返回登录' }}</view>
			</view>
			
			<view class="form-item">
				<view class="form-label">
					<text class="text-primary">✧</text> 用户名
				</view>
				<input class="input login-input" type="text" v-model="formData.username" placeholder="请输入用户名" placeholder-class="placeholder" />
			</view>
			
			<view class="form-item">
				<view class="form-label">
					<text class="text-primary">✧</text> 密码
				</view>
				<input class="input login-input" type="password" v-model="formData.password" placeholder="请输入密码" placeholder-class="placeholder" />
			</view>
			
			<view class="form-item" v-if="!isLogin">
				<view class="form-label">
					<text class="text-primary">✧</text> 确认密码
				</view>
				<input class="input login-input" type="password" v-model="formData.confirmPassword" placeholder="请再次输入密码" placeholder-class="placeholder" />
			</view>
			
			<view class="form-actions">
				<button class="btn btn-primary" @tap="submitForm">{{ isLogin ? '登 录' : '注 册' }}</button>
				<button class="btn btn-secondary" @tap="wechatLogin">微信一键登录</button>
			</view>
			
			<view class="divider"></view>
			
			<view class="form-footer">
				<view class="forgot-password text-center" @tap="forgotPassword">忘记密码？</view>
			</view>
		</view>
		
		<!-- 底部版权信息 -->
		<view class="copyright text-center">
			<text class="text-silver">© 2023 神秘塔罗 版权所有</text>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isLogin: true,
				formData: {
					username: '',
					password: '',
					confirmPassword: ''
				}
			}
		},
		methods: {
			// 切换登录/注册表单
			toggleForm() {
				this.isLogin = !this.isLogin;
				// 重置表单
				this.formData = {
					username: '',
					password: '',
					confirmPassword: ''
				};
			},
			
			// 提交表单
			submitForm() {
				if (!this.formData.username || !this.formData.password) {
					uni.showToast({
						title: '请填写完整信息',
						icon: 'none'
					});
					return;
				}
				
				// 注册时验证两次密码
				if (!this.isLogin) {
					if (this.formData.password !== this.formData.confirmPassword) {
						uni.showToast({
							title: '两次密码不一致',
							icon: 'none'
						});
						return;
					}
				}
				
				// 提交登录/注册请求
				const url = this.isLogin ? '/api/user/login' : '/api/user/register';
				uni.showLoading({
					title: this.isLogin ? '正在登录...' : '正在注册...'
				});
				
				// 模拟登录/注册请求
				setTimeout(() => {
					uni.hideLoading();
					
					// 登录/注册成功
					uni.showToast({
						title: this.isLogin ? '登录成功' : '注册成功',
						icon: 'success'
					});
					
					// 保存用户信息
					uni.setStorageSync('token', 'sample_token');
					uni.setStorageSync('userInfo', {
						id: 1,
						username: this.formData.username,
						avatar: '/static/images/avatar.png'
					});
					
					// 跳转到首页
					setTimeout(() => {
						uni.switchTab({
							url: '/pages/index/index'
						});
					}, 1500);
				}, 2000);
			},
			
			// 微信登录
			wechatLogin() {
				uni.showLoading({
					title: '正在登录...'
				});
				
				// 调用微信登录API
				// #ifdef MP-WEIXIN
				uni.login({
					provider: 'weixin',
					success: (loginRes) => {
						// 获取微信登录code
						const code = loginRes.code;
						// 发送code到服务器进行验证
						console.log('微信登录code:', code);
						
						// 模拟登录成功
						setTimeout(() => {
							uni.hideLoading();
							uni.showToast({
								title: '登录成功',
								icon: 'success'
							});
							
							// 保存用户信息
							uni.setStorageSync('token', 'wechat_token');
							uni.setStorageSync('userInfo', {
								id: 2,
								username: '微信用户',
								avatar: '/static/images/avatar.png'
							});
							
							// 跳转到首页
							setTimeout(() => {
								uni.switchTab({
									url: '/pages/index/index'
								});
							}, 1500);
						}, 2000);
					},
					fail: (err) => {
						uni.hideLoading();
						uni.showToast({
							title: '微信登录失败',
							icon: 'none'
						});
						console.error('微信登录失败:', err);
					}
				});
				// #endif
				
				// 非微信环境
				// #ifndef MP-WEIXIN
				setTimeout(() => {
					uni.hideLoading();
					uni.showToast({
						title: '请在微信环境使用此功能',
						icon: 'none'
					});
				}, 1000);
				// #endif
			},
			
			// 忘记密码
			forgotPassword() {
				uni.showToast({
					title: '请联系客服重置密码',
					icon: 'none'
				});
			}
		}
	}
</script>

<style lang="scss">
	@import '@/styles/global.scss';
	
	.login-container {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		padding: 60rpx 50rpx;
		box-sizing: border-box;
		position: relative;
		overflow: hidden;
	}
	
	.login-header {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-bottom: 80rpx;
		
		.logo {
			width: 180rpx;
			height: 180rpx;
			margin-bottom: 30rpx;
		}
		
		.title {
			margin-bottom: 10rpx;
		}
		
		.subtitle {
			color: $accent-silver;
		}
	}
	
	.login-form {
		padding: 40rpx;
		margin-bottom: 40rpx;
		
		.form-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 40rpx;
		}
		
		.form-toggle {
			font-size: 26rpx;
		}
		
		.form-item {
			margin-bottom: 30rpx;
		}
		
		.form-label {
			margin-bottom: 12rpx;
			font-size: 28rpx;
			display: flex;
			align-items: center;
			
			text {
				margin-right: 10rpx;
			}
		}
		
		.form-actions {
			margin: 50rpx 0 30rpx;
		}
		
		.form-footer {
			margin-top: 20rpx;
		}
		
		.forgot-password {
			font-size: 26rpx;
			color: $accent-silver;
		}
	}
	
	.login-input {
		height: 90rpx;
		border-bottom: 2rpx solid rgba($color-primary, 0.5);
		border-radius: 0;
		background-color: transparent;
		padding-left: 0;
		color: $color-text;
		width: 100%;
	}
	
	.placeholder {
		color: rgba($color-text, 0.5);
	}
	
	.copyright {
		margin-top: auto;
		padding: 20rpx 0;
		font-size: 24rpx;
	}
</style> 