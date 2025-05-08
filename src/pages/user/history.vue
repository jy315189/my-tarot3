<template>
  <view class="user-history">
    <view class="container">
      <text class="title">历史记录</text>
      <view class="content">
        <!-- 历史记录内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'UserHistory',
  setup() {
    return {}
  }
}
</script>

<style>
.user-history {
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