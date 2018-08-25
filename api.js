const fs = require('fs')
const jsonServer = require('json-server')

const server = jsonServer.create()

server.use(jsonServer.defaults())

if (!fs.existsSync('./db.json')) {
  fs.writeFileSync('./db.json', JSON.stringify({
    "todos": [
      {
        "id": 1,
        "title": "test 1",
        "complete": true
      },
      {
        "id": 2,
        "title": "test 2",
        "complete": false
      },
      {
        "id": 3,
        "title": "test 3",
        "complete": false
      }
    ]
  }, null, 2), { encoding: 'utf8' });
}

const router = jsonServer.router('db.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
