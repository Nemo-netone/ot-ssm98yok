# 原始前端恢复记录

## 恢复目标

本次恢复不再使用统一作品集演示壳替代业务页面，而是把原项目的前台、后台和上传图片按原结构发布到 Cloudflare Pages。

- 项目主题：美食城小吃自助管理系统
- 稳定地址：https://ot-ssm98yok.pages.dev
- 发布目录：`original-site/`
- 原前台来源：`src/main/webapp/front/`
- 原后台来源：`src/main/webapp/admin/dist/`
- 原上传资源来源：`src/main/webapp/upload/`

## 兼容实现

`original-site/_worker.js` 提供 Cloudflare Pages Worker 兼容 API，接住原 SSM/Vue 页面请求：

- `users/login`、`users/session`
- `yonghu/login`、`yonghu/session`、`yonghu/register`
- `config/list`
- `news/list/detail/info`
- `caipinxinxi/list/page/detail/info/autoSort`
- `cantingxinxi/list/page/detail/info`
- `caipinfenlei/list/page/option`
- `orders/cart/address/storeup/chat/dingdanpingjia/discuss*`
- `file/upload`

接口优先尝试 Supabase `ot_ssm98yok` schema；不可用时使用 Worker 内置的美食城演示数据兜底，保证公开演示不白屏。

## 关键修复

- 前台 `modules/http/http.js` 的接口基地址改为当前 Pages 同源地址。
- 后台 `admin/index.html` 注入 `window.SSM98YOK_API_BASE=window.location.origin + "/"`，让原后台 dist 请求同源 Worker。
- 旧 CloudBase 图片 URL 在 Worker 中统一转换为 `/upload/<file>`。
- 兼容后台账号 `abo / abo`。
- 兼容前台用户 `用户1 / 123456` 和 `user1 / 123456`。

## 验证记录

验证时间：2026-07-12

- `node --input-type=module --check < original-site/_worker.js`：通过。
- `GET /health`：返回 `frontend=original-ssm-vue-food-city`。
- `GET /caipinxinxi/list?page=1&limit=2`：返回菜品名称、分类、图片和价格。
- `POST /users/login` with `abo / abo`：通过。
- `POST /yonghu/login` with `user1 / 123456`：通过，返回 `用户1`。
- Playwright 首页验证：iframe 模板残留 `{{...}}` 为 0，可见图片 11 张，加载图片 11 张，旧 CloudBase 请求 0。
- Playwright 后台验证：`abo / abo` 登录进入 `美食城小吃自助管理` 后台首页，失败请求 0，页面错误 0。

截图：

- `docs/screenshots/original-home.png`
- `docs/screenshots/original-login.png`
- `docs/screenshots/original-admin.png`

## 已知边界

- 原项目文件存在历史编码遗留，恢复时保持原页面结构和视觉，不做大规模重写。
- Java/SSM 原后端源码继续保留，公开演示由 Pages Worker 提供兼容 API。
- 文件上传接口返回演示路径，不作为长期对象存储服务。
