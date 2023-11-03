import express from 'express';
import { createServer } from 'node:http';
import { Server } from 'socket.io';
import path from 'path';
import url from 'url';

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const server = createServer(app);
const io = new Server(server);

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '/index.html'));
});

io.on('connection', (socket) => {
  console.log('a user connected');
});

io.on('connection', (socket) => {
  socket.on('message', (msg) => {
    console.log('message: ' + msg);
  });
});

/* const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log(`server running at http://localhost:${port}`);
}); */

const port = 8000;
server.listen(port, () => {
  console.log(`server running at http://localhost:${port}`);
});
