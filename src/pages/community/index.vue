<template>
  <view class="community-index">
    <view class="container">
      <text class="title">塔罗社区</text>
      <view class="content">
        <!-- 社区首页内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'CommunityIndex',
  setup() {
    return {}
  }
}
</script>

<style>
.community-index {
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