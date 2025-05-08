<template>
  <view class="divination-single">
    <view class="container">
      <text class="title">单张塔罗牌占卜</text>
      <view class="content">
        <!-- 占卜内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'DivinationSingle',
  setup() {
    return {}
  }
}
</script>

<style>
.divination-single {
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