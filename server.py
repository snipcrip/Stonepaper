import asyncio
import json

clients = []
trans = {}
games = {1:2, 2:1}

def game():
    pass

def close_game():
    pass

def start_game():
    pass

def find():
    pass


def process_data(data, transport):
    try:
        print()
        print(transport)
        print(clients[games[trans[transport]] - 1].write("salam".encode()))
        print()
    except:
        pass
    data = json.dumps({"type":"game", "fields":["dawd", "dwaadf", "afafaw"], "pair" : games[trans[transport]]})
    return data

class ClientServerProtocol(asyncio.Protocol):
    def connection_made(self, transport):
        self.transport = transport
        # print(server.sockets[0].getpeername())
        # print(self.transport)
        clients.append(self.transport)
        trans[self.transport] = len(clients)
        # print(len(server.sockets))
        # print(server.sockets[0])
        text = json.dumps({"type":"connect"})
        self.transport.write(text.encode())

    def data_received(self, data):
        resp = process_data(data.decode(), self.transport)
        # print(resp)
        self.transport.write(resp.encode())


loop = asyncio.get_event_loop()


coro = loop.create_server(
    ClientServerProtocol,
    '127.0.0.1', 5555
)



server = loop.run_until_complete(coro)

print('Serving on {}'.format(server.sockets[0].getsockname()))

try:
    loop.run_forever()
except KeyboardInterrupt:
    pass

server.close()
loop.run_until_complete(server.wait_closed())
loop.close()