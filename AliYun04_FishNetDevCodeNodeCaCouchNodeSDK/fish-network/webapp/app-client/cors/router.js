const compose = require('koa-compose');
const Router = require('koa-router');
var router = new Router();
const Query = require('./query');
router.get('/queryAllFish', Query.queryAllFish)

// app.use(router.routes()).use(router.allowedMethods());
module.exports = (ctx, next) => compose([router.routes(), router.allowedMethods()]);
