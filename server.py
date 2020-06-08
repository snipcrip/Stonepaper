import asyncio
import json
import random
import copy

clients = []
fields = {}
fields_players = {}
games = {}





def close_game(data, transport):
    pass

def generate_field():
    field = []
    field_player = []
    cnt = {}
    cnt[2] = 0 # 
    cnt[3] = 0 #
    cnt[4] = 0 #
    for row in range(2):
        field.append([])
        field_player.append([])
        for _ in range(6):
            field_player[row].append(1)
            rnd = random.randint(2, 4)
            while cnt[rnd] >= 4:
                rnd = random.randint(2, 4)
            cnt[rnd] += 1
            field[row].append(rnd)

    for row in range(2, 4):
        field.append([])
        field_player.append([])
        for _ in range(6):
            field[row].append(0)
            field_player[row].append(0)

    cnt[2] = 0 # 
    cnt[3] = 0 #
    cnt[4] = 0 #

    for row in range(4, 6):
        field.append([])
        field_player.append([])
        for _ in range(6):
            field_player[row].append(2)
            rnd = random.randint(2, 4)
            while cnt[rnd] >= 4:
                rnd = random.randint(2, 4)
            cnt[rnd] += 1
            field[row].append(rnd)

    
    return field, field_player

def start_game(data, player1, player2):
    games[player1] = (1, player2) 
    games[player2] = (2, player1)

    field, field_player = generate_field()

    fields[(player1, player2)] = field
    fields_players[(player1, player2)] = field_player

    return field, field_player

def reverse(field, field_player):
    field[0][:], field[1][:], field[2][:], field[3][:], field[4][:], field[5][:] = \
            field[5][:], field[4][:], field[3][:], field[2][:], field[1][:], field[0][:]
    field_player[0][:], field_player[1][:], field_player[2][:], field_player[3][:], field_player[4][:], field_player[5][:] = \
        field_player[5][:], field_player[4][:], field_player[3][:], field_player[2][:], field_player[1][:], field_player[0][:]
    return field, field_player

def field_transform(field, field_player, player):
    # print(field, "\n", field_player, '\n', player)
    for row in range(6):
        for col in range(6):
            if field_player[row][col] != player and field_player[row][col] != 0:
                field[row][col] = 1
    
    if player == 2:
        field, field_player = reverse(field, field_player)
        

    return {"type":"start game", "field":field, "field_player":field_player}


def data_complete(field, field_player, transport1, transport2):
        field1 = copy.deepcopy(field)
        field2 = copy.deepcopy(field)

        data1 = json.dumps(field_transform(field1, field_player.copy(), 1)).encode()
        data2 = json.dumps(field_transform(field2, field_player.copy(), 2)).encode()

        transport1.write(data1)
        transport2.write(data2)


def game(data, player1):
    player2, num = games[player1]

    if num == 1:
        player1, player2 = player2, player1
        
    field = fields[(player1, player2)]
    field_player = fields_players[(player1, player2)]
    
    move_from = data["move from"]
    move_to = data["move to"]
    move_player = data["move_player"]

    value_from = field[move_from[0]][move_from[1]] 
    value_to = field[move_to[0]][move_to[1]]

    if value_from - 1 == value_to:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0

        field[move_to[0]][move_to[1]] = value_to
        field_player[move_to[0]][move_to[1]] = move_player
    elif value_to - 1 == value_from:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0
    elif value_from == 4 and value_to == 2:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0
    else:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0

        field[move_to[0]][move_to[1]] = value_to
        field_player[move_to[0]][move_to[1]] = move_player

    data_complete(field, field_player, player1, player2)


def find_game(data, transport):
    if clients:
        transport1 = clients[0]
        clients.clear()
        field, field_player = start_game(data, transport1, transport)

        data_complete(field, field_player, transport1, transport)
    else:
        clients.append(transport)
        return {"type":"find game"}

def process_data(data, transport):
    if data['type'] == "find game":
        find_game(data, transport)
    elif data['type'] == "game":
        game(data, transport)
    elif data['type'] == "close_game":
        close_game(data, transport)
    # return json.dumps(data)

class ClientServerProtocol(asyncio.Protocol):
    def connection_made(self, transport):
        self.transport = transport
        # print(server.sockets[0].getpeername())
        # print(self.transport)
        # clients.append(self.transport)
        # trans[self.transport] = len(clients)
        # print(len(server.sockets))
        # print(server.sockets[0])
        text = json.dumps({"type":"connect"})
        self.transport.write(text.encode())

    def data_received(self, data):
        print(data.decode())
        process_data(json.loads(data.decode()), self.transport)
        # print(resp)
        # if resp:
        #     self.transport.write(resp.encode())

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