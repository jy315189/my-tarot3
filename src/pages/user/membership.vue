<template>
  <view class="user-membership">
    <view class="container">
      <text class="title">会员中心</text>
      <view class="content">
        <!-- 会员中心内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'UserMembership',
  setup() {
    return {}
  }
}
</script>

<style>
.user-membership {
  min-height: 100vh;
  padding: 20px;
}

.title {
  font-size: 24px;
  font-weight: bold;
  text-align: center;
  margin-bottom: 20px;
}

.content {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style> 