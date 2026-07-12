# 2026-07-12 原始前端恢复部署

## 稳定地址

```text
https://ot-ssm98yok.pages.dev
```

## 发布目录

```text
original-site
```

## 恢复内容

- 前台页面来自 `src/main/webapp/front/`。
- 后台页面来自 `src/main/webapp/admin/dist/`。
- 上传图片来自 `src/main/webapp/upload/`。
- Pages Worker 兼容原项目 `users/yonghu/config/news/caipinxinxi/cantingxinxi/orders/cart/address/storeup/chat/discuss*` 接口。
- 不再用统一作品集演示壳替代美食城小吃自助管理系统页面。

## 验证结果

- `GET /health` 通过，返回 `frontend=original-ssm-vue-food-city`。
- `GET /caipinxinxi/list?page=1&limit=2` 通过，返回菜品名称、图片、分类、价格。
- `POST /users/login` with `abo / abo` 通过。
- `POST /yonghu/login` with `user1 / 123456` 通过。
- Playwright 首页验证通过：可见图片 11 张、加载图片 11 张、模板残留 0、旧 CloudBase 请求 0。
- Playwright 后台验证通过：`abo / abo` 登录进入原后台首页，失败请求 0、页面错误 0。

## 截图

```text
docs/screenshots/original-home.png
docs/screenshots/original-login.png
docs/screenshots/original-admin.png
```
