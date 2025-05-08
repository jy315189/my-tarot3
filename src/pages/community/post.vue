<template>
  <view class="community-post">
    <view class="container">
      <text class="title">社区帖子</text>
      <view class="content">
        <!-- 社区帖子内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'CommunityPost',
  setup() {
    return {}
  }
}
</script>

<style>
.community-post {
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