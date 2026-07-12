const SCHEMA = "ot_ssm98yok";
const IMAGE_DIR = "/upload/";
const API_ROOTS = new Set([
  "address",
  "caipinfenlei",
  "caipinxinxi",
  "cantingxinxi",
  "cart",
  "chat",
  "config",
  "dingdanpingjia",
  "discusscaipinxinxi",
  "discusscantingxinxi",
  "file",
  "follow",
  "news",
  "option",
  "orders",
  "storeup",
  "token",
  "users",
  "yonghu",
]);

const ACTIONS = new Set([
  "add",
  "autoSort",
  "count",
  "delete",
  "detail",
  "follow",
  "group",
  "info",
  "list",
  "login",
  "option",
  "page",
  "register",
  "remind",
  "save",
  "session",
  "sh",
  "thumbsup",
  "update",
  "upload",
  "value",
  "vote",
]);

export default {
  async fetch(request, env) {
    try {
      const url = new URL(request.url);
      if (request.method === "OPTIONS") {
        return new Response(null, { headers: corsHeaders(request, env) });
      }

      if (url.pathname === "/health" || url.pathname === "/ssm98yok/health") {
        return json(request, env, ok({
          service: `${schema(env)}-api`,
          schema: schema(env),
          frontend: "original-ssm-vue-food-city",
          time: new Date().toISOString(),
        }));
      }

      const parts = pathParts(url.pathname);
      if (!parts.length || !API_ROOTS.has(parts[0])) {
        return serveAssetOrSpa(request, env);
      }

      if (request.method === "GET" && acceptsHtml(request)) {
        return serveAssetOrSpa(request, env);
      }

      const params = await requestParams(request, url);
      const payload = await handleLegacy(parts, params, env);
      return json(request, env, payload);
    } catch (error) {
      return json(request, env, fail(error.message || "server error"), 500);
    }
  },
};

function pathParts(pathname) {
  const parts = pathname.replace(/^\/+/, "").split("/").filter(Boolean);
  if (parts[0] === "ssm98yok") parts.shift();
  return parts;
}

async function serveAssetOrSpa(request, env) {
  if (!env.ASSETS) return new Response("Not found", { status: 404 });
  const response = await env.ASSETS.fetch(request);
  if (response.status !== 404) return response;

  if (!acceptsHtml(request)) return response;

  const url = new URL(request.url);
  url.pathname = url.pathname.startsWith("/admin/") ? "/admin/index.html" : "/index.html";
  url.search = "";
  return env.ASSETS.fetch(new Request(url, request));
}

async function handleLegacy(parts, params, env) {
  const [root] = parts;

  if (root === "file" && parts[1] === "upload") {
    return ok({ file: "picture1.jpg", data: { file: "picture1.jpg", url: `${IMAGE_DIR}picture1.jpg` } });
  }

  if (root === "option") {
    const [, table, column] = parts;
    const rows = await legacyRows(table, env);
    const values = uniqueValues(rows, column);
    return ok({ data: values });
  }

  if (root === "follow") {
    const [, table, column] = parts;
    const rows = await legacyRows(table, env);
    const value = params[column] || params.columnValue || params.value;
    const row = rows.find((item) => String(item[column]) === String(value)) || rows[0] || {};
    return ok({ data: row });
  }

  if (root === "users" || root === "yonghu") {
    return handleAccount(root, parts[1] || "list", parts[2], params, env);
  }

  const parsed = parseTableAction(parts);
  return handleRows(parsed.table, parsed.action, parsed.id, { ...params, ...parsed.filters }, env);
}

function parseTableAction(parts) {
  const table = parts[0];
  let action = parts[1] || "list";
  let id = parts[2];
  const filters = {};

  if (table === "orders" && action && !ACTIONS.has(action)) {
    filters.status = decodeURIComponent(action);
    action = parts[2] || "page";
    id = parts[3];
  }

  return { table, action, id, filters };
}

async function handleAccount(table, action, id, params, env) {
  if (action === "login") {
    const username = String(params.username || params.yonghuming || params.userName || "").trim();
    const password = String(params.password || params.mima || "").trim();
    const account = await findAccount(table, username, password, env);
    if (!account) return fail("login failed");
    return ok({
      token: `demo-${table}-${account.id}-${Date.now()}`,
      data: publicAccount(table, account),
    });
  }

  if (action === "session") {
    const rows = await legacyRows(table, env);
    return ok({ data: rows[0] || publicAccount(table, {}) });
  }

  if (action === "register" || action === "save" || action === "add" || action === "update") {
    return ok({ data: { id: Number(params.id || Date.now()), ...params } });
  }

  if (action === "delete") return ok({ data: null });

  const rows = await legacyRows(table, env);
  if (action === "detail" || action === "info") return ok({ data: findById(rows, id || params.id) });
  return page(filterAndSort(rows, params), params);
}

async function handleRows(table, action, id, params, env) {
  if (action === "save" || action === "add" || action === "update" || action === "sh") {
    return ok({ msg: "success", data: cleanRow({ id: Number(params.id || Date.now()), ...params }) });
  }

  if (action === "delete") return ok({ msg: "success", data: null });

  const rows = await legacyRows(table, env);
  const filtered = filterAndSort(rows, params);

  if (action === "detail" || action === "info") return ok({ data: findById(rows, id || params.id) });
  if (action === "autoSort") return page(sortRows(filtered, "clicknum", "desc"), params);
  if (action === "count") return ok({ data: filtered.length });
  if (action === "group") return ok({ data: groupRows(filtered, id || params.column || "status") });
  if (action === "value") return ok({ data: valueRows(filtered, id || params.column || "addtime") });
  if (action === "thumbsup" || action === "vote" || action === "remind") return ok({ data: null });

  return page(filtered, params);
}

async function legacyRows(table, env) {
  const remote = await supabaseRows(env, table).catch(() => []);
  return (remote.length ? remote : fallbackRows(table)).map(cleanRow);
}

async function findAccount(table, username, password, env) {
  const directRows = await supabaseRows(env, table).catch(() => []);
  const direct = directRows.find((row) => accountMatches(table, row, username, password));
  if (direct) return direct;

  const fallback = fallbackRows(table).find((row) => accountMatches(table, row, username, password));
  if (fallback) return fallback;

  if (table === "users" && username === "admin" && password === "admin") {
    return { id: 1, username: "admin", password: "admin", role: "admin" };
  }

  if (table === "yonghu" && username && password === "123456") {
    const userIndex = username.match(/^user(\d+)$/i)?.[1] || username.match(/^用户(\d+)$/)?.[1] || "1";
    return { id: 10 + Number(userIndex), yonghuming: `用户${userIndex}`, mima: "123456", xingming: `姓名${userIndex}`, money: 100 };
  }

  return null;
}

function accountMatches(table, row, username, password) {
  if (!row) return false;
  if (table === "users") {
    return String(row.username || "").trim() === username && String(row.password || "").trim() === password;
  }
  const accountName = String(row.yonghuming || row.username || "").trim();
  const alias = accountName.replace(/^用户(\d+)$/, "user$1");
  return (accountName === username || alias === username) && String(row.mima || row.password || "").trim() === password;
}

function publicAccount(table, account) {
  if (table === "users") {
    return {
      id: Number(account.id || 1),
      username: account.username || "abo",
      role: account.role || "admin",
      addtime: account.addtime || now(),
    };
  }
  return {
    id: Number(account.id || 11),
    yonghuming: account.yonghuming || account.username || "user1",
    mima: "******",
    xingming: account.xingming || account.display_name || "Demo User",
    xingbie: account.xingbie || "male",
    touxiang: normalizeImage(account.touxiang || "yonghu_touxiang1.jpg"),
    shouji: account.shouji || "13823888881",
    money: Number(account.money || 100),
    addtime: account.addtime || now(),
  };
}

async function supabaseRows(env, table) {
  if (!API_ROOTS.has(table) || ["file", "option", "follow", "token"].includes(table)) return [];
  const base = cleanEnv(env.SUPABASE_URL);
  const key = cleanEnv(env.SUPABASE_ANON_KEY || env.SUPABASE_SERVICE_ROLE_KEY);
  if (!base || !key) return [];

  const url = new URL(`${base.replace(/\/$/, "")}/rest/v1/${table}`);
  url.searchParams.set("select", "*");
  url.searchParams.set("order", "id.asc");
  url.searchParams.set("limit", "200");

  const response = await fetch(url, {
    headers: {
      apikey: key,
      Authorization: `Bearer ${key}`,
      "Accept-Profile": schema(env),
    },
  });
  if (!response.ok) return [];
  const data = await response.json();
  return Array.isArray(data) ? data : [];
}

function fallbackRows(table) {
  const rows = {
    config: [
      { id: 1, name: "picture1", value: `${IMAGE_DIR}picture1.jpg` },
      { id: 2, name: "picture2", value: `${IMAGE_DIR}picture2.jpg` },
      { id: 3, name: "picture3", value: `${IMAGE_DIR}picture3.jpg` },
      { id: 6, name: "homepage", value: "" },
    ],
    users: [
      { id: 1, username: "abo", password: "abo", role: "admin", addtime: "2021-01-25 02:23:59" },
    ],
    yonghu: range(6, 11).map((id, index) => ({
      id,
      addtime: "2021-01-25 02:23:59",
      yonghuming: `用户${index + 1}`,
      mima: "123456",
      xingming: `姓名${index + 1}`,
      xingbie: "男",
      touxiang: `${IMAGE_DIR}yonghu_touxiang${index + 1}.jpg`,
      shouji: `1382388888${index + 1}`,
      money: 100,
    })),
    caipinfenlei: range(6, 31).map((id, index) => ({
      id,
      addtime: "2021-01-25 02:23:59",
      caipinfenlei: `菜品分类${index + 1}`,
    })),
    cantingxinxi: range(6, 21).map((id, index) => ({
      id,
      addtime: "2021-01-25 02:23:59",
      cantingmingcheng: `餐厅名称${index + 1}`,
      cantingleixing: `餐厅类型${index + 1}`,
      cantingtupian: `${IMAGE_DIR}cantingxinxi_cantingtupian${index + 1}.jpg`,
      peisongshijian: "30分钟",
      peisongfuwu: "配送服务",
      lianxidianhua: `025-8888888${index}`,
      cantingdizhi: `美食城${index + 1}层`,
      cantingjieshao: html(`餐厅介绍${index + 1}`),
    })),
    caipinxinxi: range(6, 41).map((id, index) => ({
      id,
      addtime: "2021-01-25 02:23:59",
      caipinmingcheng: `菜品名称${index + 1}`,
      caipinfenlei: `菜品分类${index + 1}`,
      tupian: `${IMAGE_DIR}caipinxinxi_tupian${index + 1}.jpg`,
      cailiao: `材料${index + 1}`,
      fenliang: "1份",
      caipinjieshao: html(`菜品介绍${index + 1}`),
      cantingmingcheng: `餐厅名称${index + 1}`,
      lianxidianhua: `025-8888888${index}`,
      clicktime: "2021-01-25 10:23:59",
      clicknum: 20 + index,
      price: 19.9 + index * 5,
    })),
    news: range(6, 111).map((id, index) => ({
      id,
      addtime: "2021-01-25 02:23:59",
      title: `标题${index + 1}`,
      introduction: "简介",
      picture: `${IMAGE_DIR}news_picture${index + 1}.jpg`,
      content: html(`内容${index + 1}`),
    })),
    address: range(3, 1).map((id, index) => ({
      id,
      addtime: now(),
      userid: 11,
      address: `收货地址${index + 1}`,
      name: `收货人${index + 1}`,
      phone: `1380000000${index + 1}`,
      isdefault: index === 0 ? "yes" : "no",
    })),
    cart: [
      { id: 1, addtime: now(), tablename: "caipinxinxi", userid: 11, goodid: 41, goodname: "菜品名称1", picture: `${IMAGE_DIR}caipinxinxi_tupian1.jpg`, buynumber: 1, price: 19.9, discountprice: 19.9 },
    ],
    orders: range(4, 101).map((id, index) => ({
      id,
      addtime: now(),
      orderid: `OD${String(id).padStart(6, "0")}`,
      tablename: "caipinxinxi",
      userid: 11,
      goodid: 41 + (index % 6),
      goodname: `菜品名称${(index % 6) + 1}`,
      picture: `${IMAGE_DIR}caipinxinxi_tupian${(index % 6) + 1}.jpg`,
      buynumber: 1 + index,
      price: 19.9 + index * 5,
      total: (1 + index) * (19.9 + index * 5),
      type: 1,
      status: ["未支付", "已支付", "已发货", "已完成"][index % 4],
      address: `收货地址${index + 1}`,
    })),
    storeup: [
      { id: 1, addtime: now(), userid: 11, refid: 41, tablename: "caipinxinxi", name: "菜品名称1", picture: `${IMAGE_DIR}caipinxinxi_tupian1.jpg`, type: "1" },
    ],
    chat: [
      { id: 61, addtime: now(), userid: 11, adminid: 1, ask: "提问1", reply: "回复1", isreply: 1 },
      { id: 62, addtime: now(), userid: 11, adminid: 1, ask: "提问2", reply: "", isreply: 0 },
    ],
    dingdanpingjia: range(6, 51).map((id, index) => ({
      id,
      addtime: "2021-01-25 02:23:59",
      dingdanbianhao: `OD${String(index + 1).padStart(4, "0")}`,
      caipinmingcheng: `菜品名称${index + 1}`,
      caipinfenlei: `菜品分类${index + 1}`,
      pingfen: String((index % 5) + 1),
      pingjianeirong: `评价内容${index + 1}`,
      pingjiariqi: "2021-01-25",
      yonghuming: "用户1",
      shouji: "13823888881",
      sfsh: "yes",
      shhf: "",
    })),
    discusscaipinxinxi: commentRows("caipinxinxi"),
    discusscantingxinxi: commentRows("cantingxinxi"),
  };

  return rows[table] || [];
}

function commentRows(table) {
  return range(6, table === "caipinxinxi" ? 131 : 121).map((id, index) => ({
    id,
    addtime: "2021-01-25 02:23:59",
    refid: index + 1,
    userid: 11,
    avatarurl: `${IMAGE_DIR}yonghu_touxiang1.jpg`,
    nickname: "user1",
    content: `评论内容${index + 1}`,
    reply: `回复内容${index + 1}`,
  }));
}

function page(rows, params = {}) {
  const current = Math.max(Number(params.page || params.currPage || params.current || 1), 1);
  const size = Math.max(Number(params.limit || params.pageSize || params.size || rows.length || 10), 1);
  const start = (current - 1) * size;
  return ok({
    data: {
      list: rows.slice(start, start + size),
      total: rows.length,
      pageSize: size,
      currPage: current,
      totalPage: Math.max(Math.ceil(rows.length / size), 1),
    },
  });
}

function filterAndSort(rows, params) {
  let result = [...rows];
  const ignored = new Set(["_", "t", "page", "limit", "sort", "order", "current", "size", "pageSize", "currPage"]);
  for (const [key, value] of Object.entries(params)) {
    if (ignored.has(key) || value === undefined || value === null || value === "") continue;
    result = result.filter((row) => String(row[key] ?? "").includes(String(value)));
  }
  return sortRows(result, params.sort, params.order);
}

function sortRows(rows, field, order = "asc") {
  if (!field) return rows;
  const direction = String(order).toLowerCase() === "desc" ? -1 : 1;
  return [...rows].sort((a, b) => {
    const av = a[field];
    const bv = b[field];
    if (typeof av === "number" && typeof bv === "number") return (av - bv) * direction;
    return String(av ?? "").localeCompare(String(bv ?? "")) * direction;
  });
}

function findById(rows, id) {
  return rows.find((row) => String(row.id) === String(id)) || rows[0] || null;
}

function uniqueValues(rows, column) {
  return [...new Set(rows.map((row) => row[column]).filter((value) => value !== undefined && value !== null && value !== ""))];
}

function groupRows(rows, column) {
  const counts = new Map();
  for (const row of rows) {
    const name = String(row[column] || "unknown");
    counts.set(name, (counts.get(name) || 0) + 1);
  }
  return [...counts.entries()].map(([name, value]) => ({ name, value }));
}

function valueRows(rows, column) {
  return rows.map((row, index) => ({
    name: String(row[column] || row.name || row.title || row.caipinmingcheng || row.cantingmingcheng || `item-${index + 1}`),
    value: Number(row.price || row.total || row.money || row.clicknum || 1),
  }));
}

function cleanRow(row) {
  if (!row || typeof row !== "object") return row;
  const copy = Array.isArray(row) ? [] : {};
  for (const [key, value] of Object.entries(row)) {
    copy[key] = typeof value === "string" ? cleanString(key, value) : value && typeof value === "object" ? cleanRow(value) : value;
  }
  return copy;
}

function cleanString(key, value) {
  if (/tupian|picture|image|avatar|touxiang|fengmian|photo|value/i.test(key)) {
    return normalizeImage(value);
  }
  if (value.includes("/upload/")) return normalizeImage(value);
  return value;
}

function normalizeImage(value) {
  const text = String(value || "").trim();
  if (!text) return text;
  const match = text.match(/\/upload\/([^?#]+)/i);
  if (match) return `${IMAGE_DIR}${match[1]}`;
  if (/^[^/\\]+\.(png|jpe?g|gif|webp)$/i.test(text)) return `${IMAGE_DIR}${text}`;
  return text;
}

async function requestParams(request, url) {
  const query = Object.fromEntries(url.searchParams.entries());
  if (request.method === "GET" || request.method === "HEAD") return query;

  const contentType = request.headers.get("Content-Type") || "";
  if (contentType.includes("multipart/form-data")) return query;

  const text = await request.text();
  if (!text) return query;
  if (contentType.includes("application/json")) {
    try {
      return { ...query, ...JSON.parse(text) };
    } catch {
      return query;
    }
  }
  return { ...query, ...Object.fromEntries(new URLSearchParams(text).entries()) };
}

function ok(extra = {}) {
  return { code: 0, msg: "success", ...extra };
}

function fail(msg) {
  return { code: 500, msg, data: null };
}

function json(request, env, payload, status = 200) {
  return new Response(JSON.stringify(payload), {
    status,
    headers: { "Content-Type": "application/json; charset=utf-8", ...corsHeaders(request, env) },
  });
}

function corsHeaders(request, env) {
  const origin = request.headers.get("Origin") || "";
  const allowed = String(env.CORS_ALLOWED_ORIGINS || "").split(",").map((item) => item.trim()).filter(Boolean);
  const allowOrigin = allowed.includes(origin) ? origin : allowed[0] || origin || "*";
  return {
    "Access-Control-Allow-Origin": allowOrigin,
    "Access-Control-Allow-Credentials": "true",
    "Access-Control-Allow-Methods": "GET,POST,PUT,PATCH,DELETE,OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type,Authorization,Token,token",
    "Access-Control-Max-Age": "86400",
  };
}

function schema(env) {
  return cleanEnv(env.SUPABASE_SCHEMA || SCHEMA);
}

function cleanEnv(value) {
  return String(value || "").replace(/^\uFEFF/, "").trim();
}

function acceptsHtml(request) {
  return (request.headers.get("Accept") || "").includes("text/html");
}

function range(count, start = 1) {
  return Array.from({ length: count }, (_, index) => start + index);
}

function now() {
  return new Date().toISOString().slice(0, 19).replace("T", " ");
}

function html(text) {
  return `<p>${String(text || "").replace(/[<>&]/g, (char) => ({ "<": "&lt;", ">": "&gt;", "&": "&amp;" }[char]))}</p>`;
}
