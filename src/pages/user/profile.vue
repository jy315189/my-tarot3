<template>
  <view class="user-profile mystic-bg">
    <!-- 背景装饰元素 -->
    <view class="mystic-circle" style="width: 400rpx; height: 400rpx; top: 5%; right: -150rpx; opacity: 0.4;"></view>
    <view class="mystic-circle" style="width: 300rpx; height: 300rpx; bottom: 10%; left: -100rpx; opacity: 0.3;"></view>
    <view class="mystic-star" style="top: 15%; left: 10%;">✦</view>
    <view class="mystic-star" style="top: 25%; right: 15%;">✧</view>
    <view class="mystic-star" style="bottom: 20%; right: 20%;">✦</view>
    
    <view class="container">
      <!-- 头部用户信息 -->
      <view class="user-header">
        <view class="user-avatar-container" @tap="changeAvatar">
          <image class="user-avatar" :src="userInfo.avatar" mode="aspectFill"></image>
          <view class="avatar-edit-icon">
            <text class="icon-edit">✎</text>
          </view>
        </view>
        
        <view class="user-info">
          <view class="nickname-container">
            <text class="nickname">{{userInfo.nickname}}</text>
            <text class="edit-icon" @tap="editProfile">✎</text>
          </view>
          <text class="user-id">ID: {{userInfo.id}}</text>
          <view class="membership-badge" v-if="userInfo.isMember">
            <text class="badge-text">星光会员</text>
          </view>
        </view>
      </view>
      
      <!-- 数据统计 -->
      <view class="stats-container">
        <view class="stat-item" @tap="navigateTo('/pages/user/history')">
          <text class="stat-number">{{stats.readingCount}}</text>
          <text class="stat-label">占卜次数</text>
        </view>
        <view class="stat-item" @tap="navigateTo('/pages/user/collection')">
          <text class="stat-number">{{stats.collectionCount}}</text>
          <text class="stat-label">收藏数</text>
        </view>
        <view class="stat-item">
          <text class="stat-number">{{stats.daysActive}}</text>
          <text class="stat-label">活跃天数</text>
        </view>
      </view>
      
      <!-- 功能菜单 -->
      <view class="menu-container">
        <view class="menu-group">
          <view class="menu-title">我的内容</view>
          
          <view class="menu-item" @tap="navigateTo('/pages/user/history')">
            <text class="menu-icon">📖</text>
            <text class="menu-label">历史记录</text>
            <text class="menu-arrow">›</text>
          </view>
          
          <view class="menu-item" @tap="navigateTo('/pages/user/collection')">
            <text class="menu-icon">⭐</text>
            <text class="menu-label">我的收藏</text>
            <text class="menu-arrow">›</text>
          </view>
          
          <view class="menu-item" @tap="navigateTo('/pages/user/notes')">
            <text class="menu-icon">📝</text>
            <text class="menu-label">学习笔记</text>
            <text class="menu-arrow">›</text>
          </view>
        </view>
        
        <view class="menu-group">
          <view class="menu-title">账户设置</view>
          
          <view class="menu-item" @tap="navigateTo('/pages/user/membership')">
            <text class="menu-icon">👑</text>
            <text class="menu-label">会员中心</text>
            <text class="menu-arrow">›</text>
          </view>
          
          <view class="menu-item" @tap="navigateTo('/pages/user/settings')">
            <text class="menu-icon">⚙️</text>
            <text class="menu-label">偏好设置</text>
            <text class="menu-arrow">›</text>
          </view>
          
          <view class="menu-item" @tap="showFeedbackDialog">
            <text class="menu-icon">📨</text>
            <text class="menu-label">意见反馈</text>
            <text class="menu-arrow">›</text>
          </view>
          
          <view class="menu-item" @tap="showAboutDialog">
            <text class="menu-icon">ℹ️</text>
            <text class="menu-label">关于我们</text>
            <text class="menu-arrow">›</text>
          </view>
        </view>
      </view>
      
      <!-- 退出登录 -->
      <view class="logout-button" @tap="logout">
        <text>退出登录</text>
      </view>
    </view>
    
    <!-- 反馈弹窗 -->
    <view class="modal" v-if="showFeedback" @tap.stop="closeFeedback">
      <view class="modal-content" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">意见反馈</text>
          <text class="modal-close" @tap="closeFeedback">×</text>
        </view>
        <view class="modal-body">
          <textarea class="feedback-input" v-model="feedbackText" placeholder="请输入您的意见或建议..."></textarea>
          <button class="submit-button" @tap="submitFeedback">提交反馈</button>
        </view>
      </view>
    </view>
    
    <!-- 关于我们弹窗 -->
    <view class="modal" v-if="showAbout" @tap.stop="closeAbout">
      <view class="modal-content" @tap.stop>
        <view class="modal-header">
          <text class="modal-title">关于我们</text>
          <text class="modal-close" @tap="closeAbout">×</text>
        </view>
        <view class="modal-body about-content">
          <image class="app-logo" src="/static/images/logo.png" mode="aspectFit"></image>
          <text class="app-name">神秘星塔罗</text>
          <text class="app-version">版本: 1.0.0</text>
          <text class="app-desc">
            神秘星塔罗是一款专注于塔罗牌解读与学习的应用，提供专业的塔罗牌占卜、详细的牌义解析和系统的学习内容。
          </text>
          <text class="copyright">© 2023 神秘星塔罗 保留所有权利</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'UserProfile',
  data() {
    return {
      userInfo: {
        id: 'T10086',
        nickname: '星辰漫游者',
        avatar: '/static/images/avatars/default.png',
        isMember: true
      },
      stats: {
        readingCount: 42,
        collectionCount: 15,
        daysActive: 30
      },
      showFeedback: false,
      showAbout: false,
      feedbackText: ''
    }
  },
  methods: {
    navigateTo(url) {
      uni.navigateTo({
        url: url
      });
    },
    changeAvatar() {
      uni.chooseImage({
        count: 1,
        sizeType: ['compressed'],
        sourceType: ['album', 'camera'],
        success: (res) => {
          // 这里可以调用上传接口，上传成功后更新头像URL
          this.userInfo.avatar = res.tempFilePaths[0];
          uni.showToast({
            title: '头像已更新',
            icon: 'success'
          });
        }
      });
    },
    editProfile() {
      uni.showModal({
        title: '编辑昵称',
        editable: true,
        content: this.userInfo.nickname,
        success: (res) => {
          if (res.confirm && res.content) {
            this.userInfo.nickname = res.content;
            uni.showToast({
              title: '昵称已更新',
              icon: 'success'
            });
          }
        }
      });
    },
    showFeedbackDialog() {
      this.showFeedback = true;
    },
    closeFeedback() {
      this.showFeedback = false;
      this.feedbackText = '';
    },
    submitFeedback() {
      if (!this.feedbackText.trim()) {
        uni.showToast({
          title: '请输入反馈内容',
          icon: 'none'
        });
        return;
      }
      
      // 这里可以调用接口提交反馈
      uni.showLoading({
        title: '提交中...'
      });
      
      setTimeout(() => {
        uni.hideLoading();
        uni.showToast({
          title: '感谢您的反馈！',
          icon: 'success'
        });
        this.closeFeedback();
      }, 1000);
    },
    showAboutDialog() {
      this.showAbout = true;
    },
    closeAbout() {
      this.showAbout = false;
    },
    logout() {
      uni.showModal({
        title: '确认退出',
        content: '您确定要退出登录吗？',
        success: (res) => {
          if (res.confirm) {
            // 清除登录状态
            uni.showToast({
              title: '已退出登录',
              icon: 'success'
            });
            
            // 返回登录页面
            setTimeout(() => {
              uni.reLaunch({
                url: '/pages/login/login'
              });
            }, 1000);
          }
        }
      });
    }
  }
}
</script>

<style lang="scss">
@import '@/styles/global.scss';

.user-profile {
  min-height: 100vh;
  padding: 40rpx 30rpx;
  box-sizing: border-box;
  position: relative;
}

.container {
  position: relative;
  z-index: 1;
}

// 用户头部信息
.user-header {
  display: flex;
  align-items: center;
  margin-bottom: 40rpx;
  
  .user-avatar-container {
    position: relative;
    margin-right: 30rpx;
    
    .user-avatar {
      width: 150rpx;
      height: 150rpx;
      border-radius: 75rpx;
      border: 4rpx solid rgba($color-primary, 0.6);
    }
    
    .avatar-edit-icon {
      position: absolute;
      right: 0;
      bottom: 0;
      width: 50rpx;
      height: 50rpx;
      border-radius: 25rpx;
      background-color: $color-primary;
      display: flex;
      align-items: center;
      justify-content: center;
      
      .icon-edit {
        color: white;
        font-size: 30rpx;
      }
    }
  }
  
  .user-info {
    flex: 1;
    
    .nickname-container {
      display: flex;
      align-items: center;
      margin-bottom: 10rpx;
      
      .nickname {
        font-size: 40rpx;
        font-weight: 600;
        color: $color-text;
        margin-right: 15rpx;
      }
      
      .edit-icon {
        font-size: 32rpx;
        color: $color-text-secondary;
      }
    }
    
    .user-id {
      font-size: 24rpx;
      color: $color-text-secondary;
      margin-bottom: 10rpx;
    }
    
    .membership-badge {
      display: inline-block;
      background: linear-gradient(to right, #D4AF37, #F5F9AD);
      border-radius: 30rpx;
      padding: 6rpx 20rpx;
      
      .badge-text {
        font-size: 22rpx;
        color: #1E1E2E;
        font-weight: 600;
      }
    }
  }
}

// 数据统计
.stats-container {
  display: flex;
  justify-content: space-between;
  background-color: rgba($color-bg-card, 0.7);
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 40rpx;
  box-shadow: $soft-shadow;
  
  .stat-item {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    
    &:not(:last-child)::after {
      content: '';
      position: absolute;
      right: 0;
      top: 15%;
      height: 70%;
      width: 1rpx;
      background-color: rgba($color-text-secondary, 0.3);
    }
    
    .stat-number {
      font-size: 36rpx;
      font-weight: 600;
      color: $color-primary;
      margin-bottom: 8rpx;
    }
    
    .stat-label {
      font-size: 24rpx;
      color: $color-text-secondary;
    }
  }
}

// 菜单样式
.menu-container {
  margin-bottom: 40rpx;
  
  .menu-group {
    background-color: rgba($color-bg-card, 0.7);
    border-radius: 16rpx;
    padding: 20rpx 30rpx;
    margin-bottom: 30rpx;
    box-shadow: $soft-shadow;
    
    .menu-title {
      font-size: 28rpx;
      color: $color-text-secondary;
      margin-bottom: 20rpx;
      padding-left: 10rpx;
    }
    
    .menu-item {
      display: flex;
      align-items: center;
      padding: 20rpx 10rpx;
      border-bottom: 1rpx solid rgba($color-text, 0.1);
      
      &:last-child {
        border-bottom: none;
      }
      
      .menu-icon {
        font-size: 40rpx;
        margin-right: 20rpx;
      }
      
      .menu-label {
        flex: 1;
        font-size: 30rpx;
        color: $color-text;
      }
      
      .menu-arrow {
        font-size: 36rpx;
        color: $color-text-secondary;
      }
    }
  }
}

// 退出登录按钮
.logout-button {
  text-align: center;
  padding: 25rpx 0;
  border-radius: 12rpx;
  background-color: rgba($color-bg-card, 0.7);
  color: #FF6B6B;
  font-size: 32rpx;
  font-weight: 500;
  box-shadow: $soft-shadow;
}

// 弹窗样式
.modal {
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
  
  .modal-content {
    width: 80%;
    background-color: $color-bg-card;
    border-radius: 20rpx;
    box-shadow: $deep-shadow;
    overflow: hidden;
    
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 30rpx;
      border-bottom: 1rpx solid rgba($color-text, 0.1);
      
      .modal-title {
        font-size: 36rpx;
        font-weight: 600;
        color: $color-text;
      }
      
      .modal-close {
        font-size: 40rpx;
        color: $color-text-secondary;
      }
    }
    
    .modal-body {
      padding: 30rpx;
      
      .feedback-input {
        width: 100%;
        height: 300rpx;
        background-color: rgba($color-bg, 0.5);
        border-radius: 12rpx;
        padding: 20rpx;
        font-size: 28rpx;
        color: $color-text;
        margin-bottom: 30rpx;
      }
      
      .submit-button {
        background-color: $color-primary;
        color: white;
        font-size: 30rpx;
        padding: 20rpx 0;
        border-radius: 12rpx;
        text-align: center;
      }
      
      &.about-content {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 40rpx 30rpx;
        
        .app-logo {
          width: 120rpx;
          height: 120rpx;
          margin-bottom: 20rpx;
        }
        
        .app-name {
          font-size: 36rpx;
          font-weight: 600;
          color: $color-text;
          margin-bottom: 10rpx;
        }
        
        .app-version {
          font-size: 24rpx;
          color: $color-text-secondary;
          margin-bottom: 30rpx;
        }
        
        .app-desc {
          font-size: 28rpx;
          color: $color-text;
          text-align: center;
          line-height: 1.6;
          margin-bottom: 30rpx;
        }
        
        .copyright {
          font-size: 22rpx;
          color: $color-text-secondary;
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