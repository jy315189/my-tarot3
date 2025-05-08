# 开发指南

## 开发环境搭建

### 基础环境要求
- Node.js v14.0.0 或更高版本
- npm v6.0.0 或更高版本
- Git

### 开发工具
- **推荐IDE**：HBuilderX（官方推荐）或 Visual Studio Code
- **微信开发工具**：微信开发者工具
- **版本控制**：Git

### 环境搭建步骤

1. **安装 Node.js 和 npm**

   访问 [Node.js 官网](https://nodejs.org/) 下载并安装 Node.js

2. **安装 Git**

   访问 [Git 官网](https://git-scm.com/) 下载并安装 Git

3. **安装 HBuilderX**

   访问 [HBuilderX 官网](https://www.dcloud.io/hbuilderx.html) 下载并安装 HBuilderX

4. **安装微信开发者工具**

   访问 [微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html) 下载并安装

5. **克隆项目**

   ```bash
   git clone <项目仓库地址>
   cd <项目文件夹>
   ```

6. **安装项目依赖**

   ```bash
   npm install
   ```

7. **配置微信开发者工具**

   - 打开微信开发者工具
   - 导入项目（选择项目根目录）
   - 在项目设置中填入您的AppID

## 项目结构说明

```
my-tarot/
  ├── src/                     # 源代码目录
  │   ├── pages/               # 页面文件
  │   │   ├── index/           # 首页
  │   │   ├── login/           # 登录页
  │   │   └── ...              # 其他页面
  │   ├── static/              # 静态资源
  │   │   ├── images/          # 图片资源
  │   │   ├── fonts/           # 字体资源
  │   │   └── ...
  │   ├── components/          # 公共组件
  │   ├── api/                 # API接口
  │   ├── store/               # 状态管理
  │   ├── utils/               # 工具函数
  │   ├── styles/              # 全局样式
  │   ├── App.vue              # 应用入口组件
  │   ├── main.js              # 应用入口js
  │   ├── pages.json           # 页面配置
  │   ├── manifest.json        # 应用配置
  │   └── uni.scss             # 全局样式变量
  ├── docs/                    # 项目文档
  ├── public/                  # 公共资源
  ├── dist/                    # 编译输出目录
  ├── .gitignore               # Git忽略文件
  ├── package.json             # 项目配置
  ├── README.md                # 项目说明
  └── ...
```

## 开发流程

### 1. 启动开发服务

```bash
# 微信小程序平台
npm run dev:mp-weixin

# H5平台（浏览器调试）
npm run dev:h5
```

### 2. 开发调试

- **浏览器调试模式**：
  - 访问 `http://localhost:8080/` 进行H5平台调试
  - 可以使用浏览器开发者工具进行调试

- **小程序调试模式**：
  - 使用微信开发者工具打开项目的 `dist/dev/mp-weixin` 目录
  - 可以使用微信开发者工具进行真机预览和调试

### 3. 构建发布

```bash
# 微信小程序平台
npm run build:mp-weixin

# H5平台
npm run build:h5
```

构建完成后，对于微信小程序，可以在微信开发者工具中上传版本并提交审核。

## 编码规范

### 命名规范

1. **文件命名**
   - 页面文件夹使用小写字母，如 `login`, `user-center`
   - 组件文件使用大驼峰命名法，如 `TarotCard.vue`, `LoginForm.vue`
   - 工具类文件使用小驼峰命名法，如 `httpRequest.js`, `timeFormat.js`

2. **变量命名**
   - 使用小驼峰命名法，如 `userName`, `cardList`
   - 常量使用全大写，下划线分隔，如 `MAX_COUNT`, `API_URL`
   - 布尔类型变量使用 is/has 等前缀，如 `isLoading`, `hasPermission`

3. **组件命名**
   - 使用大驼峰命名法，如 `<CardItem>`, `<UserProfile>`
   - 避免单个单词，至少两个单词组成，如 `<CardItem>` 而不是 `<Card>`

### 代码风格

1. **缩进**
   - 使用2个空格进行缩进

2. **注释**
   - 单行注释使用 `//`
   - 多行注释使用 `/* */`
   - 为每个函数、组件、页面添加适当的注释说明

3. **组件结构**
   - 组件顺序：`<template>`, `<script>`, `<style>`
   - script中的结构顺序：
     1. components
     2. props
     3. data
     4. computed
     5. watch
     6. created/mounted等生命周期
     7. methods

4. **CSS规范**
   - 使用类选择器，避免使用ID选择器
   - 使用类命名空间避免冲突，如 `.card-item_title`
   - 尽量使用uni-app提供的样式单位 `rpx`

## Git工作流

1. **分支管理**
   - `master`: 主分支，保持与线上版本一致
   - `develop`: 开发分支，所有开发工作都基于此分支
   - `feature/*`: 功能分支，用于开发新功能
   - `bugfix/*`: 修复分支，用于修复bug
   - `release/*`: 发布分支，用于版本发布准备

2. **提交规范**
   - 提交信息格式：`类型(范围): 描述`
   - 类型包括：
     - `feat`: 新功能
     - `fix`: 修复bug
     - `docs`: 文档更新
     - `style`: 样式变更
     - `refactor`: 代码重构
     - `perf`: 性能优化
     - `test`: 测试相关
     - `chore`: 构建过程或辅助工具变更

   例如：`feat(login): 添加微信快捷登录功能`

3. **代码审查**
   - 每个功能开发完成后，提交Pull Request
   - 至少一名团队成员进行代码审查
   - 通过审查后，合并到develop分支

## 调试技巧

1. **控制台输出**
   - 使用 `console.log()` 输出调试信息
   - 小程序环境中可以在开发者工具的Console面板查看

2. **网络请求分析**
   - 使用开发者工具的Network面板分析网络请求
   - 检查请求参数、响应数据和请求耗时

3. **真机调试**
   - 在微信开发者工具中使用"真机调试"功能
   - 使用远程调试真机上的问题

4. **性能分析**
   - 使用开发者工具的Performance面板分析性能瓶颈
   - 关注首屏加载时间、页面渲染性能等指标

## 常见问题解决

1. **样式问题**
   - 确保使用rpx单位以适应不同屏幕
   - 注意微信小程序的样式隔离规则
   - 检查样式优先级和继承关系

2. **数据渲染问题**
   - 检查数据是否正确获取
   - 确保正确使用v-if和v-show
   - 使用vue开发者工具查看组件状态

3. **网络请求问题**
   - 检查请求URL和参数
   - 确保处理了请求错误情况
   - 查看服务端返回的具体错误信息

4. **权限问题**
   - 检查微信小程序是否已申请相应权限
   - 确保在合适的时机申请用户授权
   - 处理用户拒绝授权的情况

5. **兼容性问题**
   - 测试不同机型和系统版本
   - 避免使用新版本API而没有兼容处理
   - 关注官方文档中的兼容性说明

## 发布流程

1. **测试验收**
   - 完成功能测试
   - 完成UI还原度检查
   - 完成兼容性测试
   - 修复所有已知问题

2. **版本构建**
   - 更新版本号
   - 使用生产环境配置
   - 执行构建命令

3. **上传代码**
   - 在微信开发者工具中上传代码
   - 填写版本号和更新说明

4. **提交审核**
   - 在微信公众平台提交审核
   - 准备审核所需材料和说明

5. **发布版本**
   - 审核通过后发布新版本
   - 监控版本运行状况
   - 收集用户反馈 