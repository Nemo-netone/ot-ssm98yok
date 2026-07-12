# 部署记录

## 固定资源

| 项目 | 值 |
|---|---|
| GitHub 仓库 | `Nemo-netone/ot-ssm98yok` |
| GitHub 仓库地址 | `https://github.com/Nemo-netone/ot-ssm98yok` |
| 生产分支 | `main` |
| Cloudflare Pages 项目 | `ot-ssm98yok` |
| Cloudflare Pages 稳定地址 | `https://ot-ssm98yok.pages.dev` |
| CloudBase Run 服务 | `ot-ssm98yok-api` |
| CloudBase API Base | `https://ot-ssm98yok-api-273280-7-1369167244.sh.run.tcloudbase.com` |
| 后端应用上下文 | `/ssm98yok` |
| Supabase schema | `ot_ssm98yok` |

第一次生产部署使用 `main` 分支。后续更新继续推送 `main`，并复用同一个 Cloudflare Pages 项目，避免演示地址变化。

## 数据库隔离

Supabase 初始化脚本：

```text
supabase/migrations/202607090001_init_ot_ssm98yok.sql
```

隔离策略：

- 创建并使用 `ot_ssm98yok` schema。
- 不写入 `public` schema。
- 不执行全库 `reset`、全局 migration repair、未限定 schema 的 `DROP`、`TRUNCATE` 或清理操作。
- 线上运行使用项目专用数据库角色，权限限定在 `ot_ssm98yok` schema。
- 真实数据库密码只放在 CloudBase Run 环境变量中，不写入仓库和文档。

## CloudBase Run 环境变量

```text
DB_TYPE=postgres
DB_VALIDATION_QUERY=SELECT 1
DB_URL=jdbc:postgresql://<supabase-host>:5432/postgres?sslmode=require&currentSchema=ot_ssm98yok
DB_USERNAME=<project-runtime-db-role>
DB_PASSWORD=<database-password>
```

真实值只配置在平台环境变量中。公开仓库只保留占位符。

## CloudBase Run 部署

后端容器构建文件：

```text
Dockerfile
```

构建逻辑：

1. 使用 Maven 构建 `ssm98yok.war`。
2. 将 WAR 放入 Tomcat 9 `/usr/local/tomcat/webapps/ssm98yok.war`。
3. 容器暴露 `8080`。
4. CloudBase Run 对外提供 `/ssm98yok/*` API。

已验证接口：

```text
GET  /ssm98yok/health
GET  /ssm98yok/cantingxinxi/list?page=1&limit=1
POST /ssm98yok/users/login
POST /ssm98yok/yonghu/login
```

## Cloudflare Pages

发布目录：

```text
original-site
```

发布命令：

```powershell
npx wrangler@3 pages deploy original-site --project-name ot-ssm98yok --branch main --commit-dirty=true
```

说明：

- 当前全局 Wrangler 要求 Node 22，本机 Node 为 20，因此使用 `npx wrangler@3` 发布。
- Pages 项目名和 GitHub 仓库名保持一致：`ot-ssm98yok`。
- 稳定生产地址为 `https://ot-ssm98yok.pages.dev`。

## 静态资源整理

| 来源 | 发布位置 | 说明 |
|---|---|---|
| `original-site/index.html` | `/` | 作品集演示入口 |
| `src/main/webapp/front/` | `/front/` | 前台静态页面 |
| `src/main/webapp/admin/dist/` | `/admin/` | 后台管理端构建产物 |
| `src/main/webapp/upload/` | `/upload/` | 演示图片资源 |

## 验证记录

最近一次验证日期：2026-07-09

- `mvn -B -DskipTests package`：通过。
- `npm run build` in `src/main/webapp/admin`：通过，有旧依赖 Sass/webpack 警告。
- `node --check dist/js/*.js`：通过。
- `https://ot-ssm98yok.pages.dev`：HTTP 200。
- `https://ot-ssm98yok.pages.dev/front/`：HTTP 200。
- `https://ot-ssm98yok.pages.dev/admin/`：HTTP 200。
- `GET /ssm98yok/health`：返回 `ok=true`。
- `GET /ssm98yok/cantingxinxi/list?page=1&limit=1`：返回 Supabase 演示餐厅数据。
- 后台账号 `abo / abo`：浏览器登录成功，进入后台首页。
- 前台账号 `用户1 / 123456`：登录接口验证成功。
- README 截图：`docs/screenshots/home.png`、`docs/screenshots/admin.png`、`docs/screenshots/mobile.png` 已生成。

## 已知限制

- 原始项目是旧式 Eclipse + Tomcat + MySQL 项目，线上已迁移到容器化 WAR + Supabase PostgreSQL，部分历史编码文本仍保留。
- 文件上传适合演示，不保证作为长期存储。
- 后台 Vue 2 项目构建产物较大，当前以功能可用为优先。
- 地图类旧插件未作为本次线上核心演示能力验证。

## 2026-07-11 Pages Worker 恢复部署

原 CloudBase Run 后端已出现 503、CORS 或资源隔离问题。线上演示已切换为 Cloudflare Pages Worker + Supabase 独立 schema：

- Pages 项目：`ot-ssm98yok`
- 稳定地址：https://ot-ssm98yok.pages.dev
- Supabase schema：`ot_ssm98yok`
- API：`/health`、`/api/login`、`/api/summary`、`/api/items/*`
- 数据：3 个公开演示账号、18 条业务记录
- 验证：全部账号登录、summary、列表、创建、更新、删除清理和 Playwright 登录前后视图均通过

原 Java/Vue/SSM 源码继续保留；兼容层只负责稳定的公开作品集体验。

