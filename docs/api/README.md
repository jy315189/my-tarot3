# API 文档

本文档描述了塔罗牌小程序的API接口规范和使用方法。

## 通用规范

### 基础URL

- 开发环境：`https://dev-api.tarot-app.com`
- 生产环境：`https://api.tarot-app.com`

### 请求方法

API支持以下HTTP请求方法：

- `GET`: 获取资源
- `POST`: 创建资源
- `PUT`: 更新资源
- `DELETE`: 删除资源

### 认证方式

除了登录注册等公开接口外，所有API请求需要进行身份验证，支持以下认证方式：

1. **Token认证**：在请求头中添加`Authorization`字段，格式为`Bearer {token}`
2. **微信小程序认证**：通过`wx.request`自动携带的登录凭证

### 响应格式

所有API响应均为JSON格式，基本结构如下：

```json
{
  "code": 200,       // 状态码，200表示成功，非200表示异常
  "message": "OK",   // 状态描述信息
  "data": {}         // 响应数据，根据接口不同而不同
}
```

### 错误码说明

| 错误码 | 说明 |
|--------|------|
| 200 | 请求成功 |
| 400 | 请求参数错误 |
| 401 | 未授权或授权失败 |
| 403 | 没有权限 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |

## API目录

- [用户相关接口](./user.md)
  - 用户注册
  - 用户登录
  - 获取用户信息
  - 修改用户信息
  - 重置密码

- [卡牌相关接口](./card.md)
  - 获取卡牌列表
  - 获取卡牌详情
  - 获取随机卡牌

- [占卜相关接口](./divination.md)
  - 创建占卜
  - 获取占卜结果
  - 获取占卜历史
  - 删除占卜记录

- [牌阵相关接口](./spread.md)
  - 获取牌阵列表
  - 获取牌阵详情

- [社区相关接口](./community.md)
  - 发布分享
  - 获取分享列表
  - 点赞
  - 评论
  - 获取评论列表

## 请求示例

### 使用uni-app发起请求

```javascript
// GET请求示例
uni.request({
  url: 'https://api.tarot-app.com/api/card/list',
  method: 'GET',
  header: {
    'Authorization': `Bearer ${token}`
  },
  success: (res) => {
    console.log(res.data);
  },
  fail: (err) => {
    console.error(err);
  }
});

// POST请求示例
uni.request({
  url: 'https://api.tarot-app.com/api/divination/create',
  method: 'POST',
  header: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  data: {
    spreadType: 'single',
    question: '我的事业发展如何？'
  },
  success: (res) => {
    console.log(res.data);
  },
  fail: (err) => {
    console.error(err);
  }
});
```

## 接口封装

为了更好地复用代码，建议将API请求进行统一封装，请参考 [API请求封装](../development-guide.md#API请求封装) 章节的说明。 