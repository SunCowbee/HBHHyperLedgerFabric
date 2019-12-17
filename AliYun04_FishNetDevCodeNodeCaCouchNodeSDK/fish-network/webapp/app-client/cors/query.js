const axios = require('axios')

class Query {
    static async queryAllFish(ctx, next) {
        // const {info,userId} =ctx.request.query
        //const {data} = await axios.post('http://www.tuling123.com/openapi/api', {
        //             key: 'c9d1eb9811e648a49ece24b7cb1065e9',
        //             info: info,
        //             userId: userId
        //         })
        console.log('11111111111111')
        const {data} = await axios.get('http://47.88.50.237:3002/queryAllFish')
        console.log(data)
        ctx.body = data
    }
}

module.exports = Query
