# 功能说明

## 功能树

```text
美食城小吃自助管理系统
├── 前台用户
│   ├── 首页和公告
│   ├── 餐厅信息
│   ├── 菜品信息
│   ├── 用户注册登录
│   ├── 购物车
│   ├── 收货地址
│   ├── 订单管理
│   ├── 订单评价
│   ├── 收藏管理
│   └── 客服问答
├── 后台管理员
│   ├── 用户管理
│   ├── 餐厅信息管理
│   ├── 菜品分类管理
│   ├── 菜品信息管理
│   ├── 订单评价管理
│   ├── 公告信息管理
│   ├── 客服管理
│   ├── 轮播图配置
│   └── 订单状态管理
└── 基础能力
    ├── Token 登录态
    ├── 文件上传下载
    ├── 分页查询
    ├── 增删改查
    └── Supabase schema 数据隔离
```

## 用户场景

| 场景 | 角色 | 操作路径 | 数据对象 |
|---|---|---|---|
| 浏览餐厅 | 游客/用户 | 前台首页 -> 餐厅信息 -> 详情 | `cantingxinxi` |
| 浏览菜品 | 游客/用户 | 前台首页 -> 菜品信息 -> 详情 | `caipinxinxi`、`caipinfenlei` |
| 下单演示 | 前台用户 | 登录 -> 菜品详情 -> 加入购物车 -> 订单 | `cart`、`orders`、`address` |
| 评价菜品 | 前台用户 | 订单/菜品详情 -> 评论或评价 | `dingdanpingjia`、`discusscaipinxinxi` |
| 维护菜品 | 管理员 | 后台登录 -> 菜品信息管理 -> 新增/修改/删除 | `caipinxinxi` |
| 处理客服 | 管理员 | 后台登录 -> 系统管理 -> 客服管理 | `chat` |
| 发布公告 | 管理员 | 后台登录 -> 系统管理 -> 公告信息 | `news` |

## 文件 ownership

| 层级 | 目录/文件 | 责任 |
|---|---|---|
| 前台页面 | `src/main/webapp/front/` | 普通用户浏览、登录、购物车、订单、评价和客服页面 |
| 后台页面 | `src/main/webapp/admin/src/` | Vue 2 管理端源码 |
| 后台构建产物 | `src/main/webapp/admin/dist/` | 管理端静态发布产物 |
| API 控制器 | `src/main/java/com/controller/` | HTTP 路由入口和业务请求处理 |
| 业务服务 | `src/main/java/com/service/` | 业务操作封装 |
| 数据访问 | `src/main/java/com/dao/` | MyBatis-Plus Mapper |
| 数据实体 | `src/main/java/com/entity/` | 表字段映射 |
| 数据库脚本 | `supabase/migrations/` | Supabase schema 和演示数据初始化 |
| Pages 发布目录 | `pages-site/` | Cloudflare Pages 实际发布内容 |

## 调用链

### 前台列表查询

```text
用户打开 /front/
-> iframe 加载前台页面
-> front/modules/http/http.js 拼接 CloudBase API base
-> GET /ssm98yok/cantingxinxi/list 或 /ssm98yok/caipinxinxi/list
-> Controller
-> Service
-> DAO / MyBatis-Plus
-> Supabase PostgreSQL ot_ssm98yok schema
-> JSON 返回前台渲染
```

### 后台登录

```text
管理员打开 /admin/
-> Vue 登录页提交 abo / abo
-> admin/src/utils/http.js 请求 CloudBase API
-> POST /ssm98yok/users/login
-> UserController 校验账号
-> Token 写入 token 表
-> 前端保存 Token
-> 进入 /admin/#/index/
```

### 后台数据维护

```text
管理员在后台点击业务菜单
-> Vue Router 加载对应 list 或 add-or-update 组件
-> Axios 带 Token 调用 page/save/update/delete
-> Controller 校验登录态和参数
-> Service 执行业务
-> DAO 写入 Supabase PostgreSQL
-> 前端刷新表格或详情
```

## 数据流

| 数据 | 来源 | 处理 | 去向 |
|---|---|---|---|
| 餐厅数据 | `cantingxinxi` 表 | 前台列表/详情、后台维护 | 前台展示、后台表格 |
| 菜品数据 | `caipinxinxi` 表 | 分类筛选、详情、购物车引用 | 前台展示、订单数据 |
| 用户数据 | `yonghu` 表 | 登录、个人中心、订单归属 | 前台用户功能 |
| 管理员数据 | `users` 表 | 后台登录和会话 | 后台管理 |
| 订单数据 | `orders` 表 | 创建、状态维护、评价关联 | 用户订单和后台订单 |
| 评论评价 | `discuss*`、`dingdanpingjia` 表 | 前台提交、后台审核/回复 | 详情页和后台管理 |
| 文件资源 | `upload/` 和文件接口 | 图片展示、上传下载 | 前台/后台页面 |

## 演示状态

| 模块 | 状态 | 说明 |
|---|---|---|
| 前台首页 | 已验证 | 线上可打开并展示导航和页面内容 |
| 餐厅列表 API | 已验证 | 返回 Supabase 演示数据 |
| 后台登录 | 已验证 | `abo / abo` 可进入后台首页 |
| 前台登录接口 | 已验证 | `用户1 / 123456` 接口登录成功 |
| 后台管理菜单 | 已验证 | 进入后台后可看到主要业务菜单 |
| 文件上传 | 部分验证 | 接口存在，线上长期保存需对象存储 |
| 地图插件 | 非核心演示 | 旧插件不作为本次线上核心验收项 |

## 在线兼容层核心功能

- 三角色登录和会话保持
- 业务概览、列表和搜索
- 新增、编辑、删除和刷新
- 餐厅管理：餐厅资料、营业状态和服务信息
- 菜品管理：菜品分类、价格、库存与推荐状态
- 订单管理：下单、支付、制作和配送状态
- 订单评价：评分、评价内容和回复处理
- 公告管理：平台公告、活动信息和轮播内容
- 客服管理：咨询、留言和售后跟进
