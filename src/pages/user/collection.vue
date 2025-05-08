<template>
  <view class="user-collection">
    <view class="container">
      <text class="title">我的收藏</text>
      <view class="content">
        <!-- 收藏内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'UserCollection',
  setup() {
    return {}
  }
}
</script>

<style>
.user-collection {
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