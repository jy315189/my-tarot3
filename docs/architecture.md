# 技术架构

## 技术栈选择

### 前端技术栈
- **开发框架**：uni-app
- **UI框架**：uView
- **编程语言**：JavaScript/TypeScript
- **构建工具**：Vite
- **版本控制**：Git

### 后端技术栈
- **云开发**：微信云开发
- **数据库**：云数据库
- **存储**：云存储
- **函数计算**：云函数
- **AI服务**：可选接入第三方AI服务

## 系统架构图

```
+-------------------+     +-------------------+     +-------------------+
|                   |     |                   |     |                   |
|    微信用户层     |     |     应用层        |     |     服务层        |
|                   |     |                   |     |                   |
+-------------------+     +-------------------+     +-------------------+
        |                         |                         |
        v                         v                         v
+-------------------+     +-------------------+     +-------------------+
|                   |     |                   |     |                   |
|    微信小程序     |     |    业务模块       |     |    云开发平台     |
|                   |     |                   |     |                   |
+-------------------+     +-------------------+     +-------------------+
                                  |                         |
                                  v                         v
                          +-------------------+     +-------------------+
                          |                   |     |                   |
                          |    数据模型       |     |    云数据库       |
                          |                   |     |                   |
                          +-------------------+     +-------------------+
```

## 模块结构

### 1. 用户模块
- 用户注册
- 用户登录
- 用户信息管理
- 会员管理

### 2. 占卜模块
- 牌阵选择
- 抽牌逻辑
- 结果生成
- 解读展示

### 3. 学习模块
- 塔罗牌介绍
- 牌义学习
- 技巧教程
- 文化知识

### 4. 社区模块
- 解读分享
- 评论互动
- 心得交流
- 问题讨论

### 5. 个人中心模块
- 历史记录
- 收藏管理
- 个人设置
- 反馈建议

## 数据模型

### 用户表(user)
```
{
  _id: String,            // 用户ID
  openid: String,         // 微信OpenID
  username: String,       // 用户名
  password: String,       // 密码(加密存储)
  avatar: String,         // 头像
  nickname: String,       // 昵称
  gender: Number,         // 性别
  birth_date: Date,       // 出生日期
  member_level: Number,   // 会员等级
  member_expire: Date,    // 会员到期时间
  created_at: Date,       // 创建时间
  updated_at: Date        // 更新时间
}
```

### 占卜记录表(divination)
```
{
  _id: String,            // 记录ID
  user_id: String,        // 用户ID
  spread_type: String,    // 牌阵类型
  question: String,       // 问题描述
  cards: Array,           // 卡牌数组
  interpretation: String, // 解读内容
  is_public: Boolean,     // 是否公开
  like_count: Number,     // 点赞数
  comment_count: Number,  // 评论数
  created_at: Date,       // 创建时间
  updated_at: Date        // 更新时间
}
```

### 卡牌表(card)
```
{
  _id: String,            // 卡牌ID
  name: String,           // 卡牌名称
  number: Number,         // 卡牌编号
  suit: String,           // 卡牌类别
  image_url: String,      // 图片地址
  upright_meaning: String, // 正位含义
  reversed_meaning: String, // 逆位含义
  description: String,    // 详细描述
  keywords: Array         // 关键词
}
```

### 牌阵表(spread)
```
{
  _id: String,            // 牌阵ID
  name: String,           // 牌阵名称
  card_count: Number,     // 卡牌数量
  description: String,    // 描述
  positions: Array,       // 位置描述
  image_url: String,      // 图片地址
  category: String        // 类别(爱情/事业等)
}
```

### 评论表(comment)
```
{
  _id: String,            // 评论ID
  divination_id: String,  // 占卜记录ID
  user_id: String,        // 用户ID
  content: String,        // 内容
  like_count: Number,     // 点赞数
  created_at: Date,       // 创建时间
  updated_at: Date        // 更新时间
}
```

## 接口设计

接口遵循RESTful风格设计，主要包括以下类型：

1. 用户接口：/api/user/*
2. 占卜接口：/api/divination/*
3. 卡牌接口：/api/card/*
4. 牌阵接口：/api/spread/*
5. 社区接口：/api/community/*

详细接口文档请参考 [API文档](./api/README.md)。

## 安全设计

1. **数据安全**
   - 用户密码加密存储
   - 敏感数据传输加密
   - 数据库访问权限控制

2. **身份认证**
   - 基于Token的认证机制
   - 微信授权登录

3. **权限控制**
   - 基于角色的权限控制
   - 操作审计日志

4. **防攻击措施**
   - 防SQL注入
   - 防XSS攻击
   - 防CSRF攻击
   - 请求频率限制

## 性能优化

1. **前端优化**
   - 组件懒加载
   - 图片资源优化
   - 本地缓存策略

2. **后端优化**
   - 数据库索引优化
   - 请求缓存
   - 云函数性能优化

3. **网络优化**
   - 接口合并
   - 数据压缩
   - CDN加速 