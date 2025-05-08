<template>
  <view class="result-detail">
    <view class="container">
      <text class="title">占卜结果详情</text>
      <view class="content">
        <!-- 占卜结果详情内容区域 -->
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'ResultDetail',
  setup() {
    return {}
  }
}
</script>

<style>
.result-detail {
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