import asyncio
import json
import random
import copy

clients = []
fields = {}
fields_players = {}
whose_move = {}
games = {}





def close_game(data, player1):
    data = json.dumps({"type":"disconnect"}).encode()
    if len(clients) and clients[0] == player1:
        clients.clear()
        player1.write(data)
    else:    
        num, player2 = games[player1]
        
        if num == 1:
            player1, player2 = player2, player1
            
        fields[(player1, player2)].clear()
        fields_players[(player1, player2)].clear()
        del games[player1]
        del games[player2]
        try:
            player1.write(data)
        except:
            pass
        try:
            player2.write(data)
        except:
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
    games[player1] = (2, player2) 
    games[player2] = (1, player1)
    whose_move[(player1, player2)] = 1

    field, field_player = generate_field()

    # fields[(player1, player2)] = field
    # fields_players[(player1, player2)] = field_player

    return field, field_player

def reverse(field, field_player):
    field[0][:], field[1][:], field[2][:], field[3][:], field[4][:], field[5][:] = \
            field[5][:], field[4][:], field[3][:], field[2][:], field[1][:], field[0][:]
    field_player[0][:], field_player[1][:], field_player[2][:], field_player[3][:], field_player[4][:], field_player[5][:] = \
        field_player[5][:], field_player[4][:], field_player[3][:], field_player[2][:], field_player[1][:], field_player[0][:]
    return field, field_player

def field_transform(field, field_player, player, move_player):
    # print(field, "\n", field_player, '\n', player)

    cnt = {1:{2:0, 3:0, 4:0}, 2:{2:0, 3:0, 4:0}}
    
    for row in range(6):
        for col in range(6):
            if field_player[row][col] != player and field_player[row][col] != 0:
                cnt[field_player[row][col]][field[row][col]] += 1
                field[row][col] = 1
    
    if player == 2:
        field, field_player = reverse(field, field_player)
        
    if move_player == player:
        move = 1
    else:
        move = 0

    move_enemy = move_player % 2 + 1 
    
    sum_player = sum(cnt[move_player].values())
    sum_enemy = sum(cnt[move_enemy].values())

    status = 0
    if (sum_player > 0 and sum_enemy == 0):
        status = 3
    elif (sum_player == 0 and sum_enemy > 0):
        status = 2
    else:
        for type_figure in cnt[move_player].keys():
            if sum_player == cnt[move_player][type_figure] and sum_enemy == cnt[move_enemy][type_figure]:
                status = 1


    # print(move, player, move_player)
    # type game!!!!!!!!!
    return {"type":"game", "field":field, "field_player":field_player, "move_player":move,
         "status_game":status} #status game 0 - идет игра 1 - ничья 2 - проигрыш 3 - выйгрыш


def data_complete(field, field_player, transport1, transport2):

        print(field)
        print(field_player)
        print()
        fields[(transport1, transport2)] = field
        fields_players[(transport1, transport2)] = field_player

        field1 = copy.deepcopy(field)
        field2 = copy.deepcopy(field)

        data1 = json.dumps(field_transform(field1, copy.deepcopy(field_player), 1, whose_move[(transport1, transport2)])).encode()
        data2 = json.dumps(field_transform(field2, copy.deepcopy(field_player), 2, whose_move[(transport1, transport2)])).encode()

        transport1.write(data1)
        transport2.write(data2)


def game(data, player1):
    num, player2 = games[player1]
    print(num, player2)

    move_player = num % 2 + 1
    print(move_player)
    
    
    if num == 1:
        print("swap")
        player1, player2 = player2, player1
        

    if move_player != whose_move[(player1, player2)]:
        return

    whose_move[(player1, player2)] = move_player % 2 + 1

    field = fields[(player1, player2)]
    field_player = fields_players[(player1, player2)]

    # print("fafefaefwaf", field_player)
    if num == 2:        
        move_from = (5 - data["move from"][0], data["move from"][1])
        move_to = (5 - data["move to"][0], data["move to"][1])
    else:
        move_from = data["move from"]
        move_to = data["move to"]
    # move_player = data["move_player"]


    value_from = field[move_from[0]][move_from[1]] 
    value_to = field[move_to[0]][move_to[1]]

    if value_from - 1 == value_to:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0

        field[move_to[0]][move_to[1]] = value_from
        field_player[move_to[0]][move_to[1]] = move_player
    elif value_to - 1 == value_from:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0
    elif value_from == 4 and value_to == 2:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0
    elif value_from == 2 and value_to == 4:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0

        field[move_to[0]][move_to[1]] = value_from
        field_player[move_to[0]][move_to[1]] = move_player
    elif value_from == value_to:
        pass
    else:
        field[move_from[0]][move_from[1]] = 0
        field_player[move_from[0]][move_from[1]] = 0

        field[move_to[0]][move_to[1]] = value_from
        field_player[move_to[0]][move_to[1]] = move_player

    data_complete(field, field_player, player1, player2)


def find_game(data, transport):
    if clients and clients[0] != transport:
        transport1 = clients[0]
        clients.clear()
        field, field_player = start_game(data, transport1, transport)

        data_complete(field, field_player, transport1, transport)
    else:
        clients.append(transport)
        return {"type":"find game"}

def process_data(data, transport):
    print(data)
    print()
    if data['type'] == "find game":
        find_game(data, transport)
    elif data['type'] == "game":
        game(data, transport)
    elif data['type'] == "close_game" or data['type'] == "disconnect":
        print("ohh")
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
        # print(dir(self.transport))
        print(self.transport._sock_fd)
        # print(self.transport.get_extra_info())
        text = json.dumps({"type":"connect"})
        self.transport.write(text.encode())

    def data_received(self, data):
        print(data.decode())
        process_data(json.loads(data.decode()), self.transport)
        # print(resp)
        # if resp:
        #     self.transport.write(resp.encode())
    def connection_lost(self, data):
        print("\nloooooooost\n")
        print()
        close_game(data, self.transport)
        super()

loop = asyncio.get_event_loop()


coro = loop.create_server(
    ClientServerProtocol,
    "109.234.39.222", 6022
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