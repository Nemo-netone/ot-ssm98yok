window.PROJECT_CONFIG = {
  "title": "美食城小吃自助管理系统",
  "positioning": "面向餐厅、菜品、订单、评价和客服管理的餐饮服务演示系统。",
  "schema": "ot_ssm98yok",
  "colors": {
    "primary": "#0f766e",
    "secondary": "#ea580c",
    "accent": "#ca8a04"
  },
  "repo": "ot-ssm98yok",
  "demoUrl": "https://ot-ssm98yok.pages.dev",
  "githubUrl": "https://github.com/Nemo-netone/ot-ssm98yok",
  "accounts": [
    {
      "role": "admin",
      "username": "abo",
      "password": "abo",
      "label": "平台管理员"
    },
    {
      "role": "user",
      "username": "用户1",
      "password": "123456",
      "label": "普通用户"
    },
    {
      "role": "staff",
      "username": "商家01",
      "password": "123456",
      "label": "餐厅运营"
    }
  ],
  "modules": [
    {
      "key": "restaurant",
      "name": "餐厅管理",
      "summary": "餐厅资料、营业状态和服务信息"
    },
    {
      "key": "dish",
      "name": "菜品管理",
      "summary": "菜品分类、价格、库存与推荐状态"
    },
    {
      "key": "order",
      "name": "订单管理",
      "summary": "下单、支付、制作和配送状态"
    },
    {
      "key": "review",
      "name": "订单评价",
      "summary": "评分、评价内容和回复处理"
    },
    {
      "key": "notice",
      "name": "公告管理",
      "summary": "平台公告、活动信息和轮播内容"
    },
    {
      "key": "support",
      "name": "客服管理",
      "summary": "咨询、留言和售后跟进"
    }
  ]
};
