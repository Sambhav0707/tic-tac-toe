import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/game_methods.dart';
import 'package:tic_tac_toe/routes/app_routes.dart';
import 'package:tic_tac_toe/utils/utils.dart';

import 'socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance!.socket!;

  Socket get socketClient => _socketClient;

  //EMITS
  void creatRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });

      log("Socket connected: ${_socketClient.connected}");
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  //LISTENERS
  void createRoomSuccessListner(BuildContext context) {
    _socketClient.on("createRoomSuccess", (room) {
      // log(room);
      // Navigator.pushNamed(context, AppRoutes.gameScreen);

      if (room is Map<String, dynamic>) {
        log("Room received: ${room.toString()}");
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, AppRoutes.gameScreen, arguments: room);
      } else {
        log("Unexpected data type for room: $room");
      }
    });
    _socketClient.on("error", (data) {
      log("Error received: $data");
    });
  }

  void joinRoomSuccessListner(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (room) {
      // log(room);
      // Navigator.pushNamed(context, AppRoutes.gameScreen);

      if (room is Map<String, dynamic>) {
        log("Room received: ${room.toString()}");
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, AppRoutes.gameScreen, arguments: room);
      } else {
        log("Unexpected data type for room: $room");
      }
    });
    _socketClient.on("error", (data) {
      log("Error received: $data");
    });
  }

  void errorOccuredListner(BuildContext context) {
    _socketClient.on('errorOccured', (data) {
      showScanckBar(context, data);
    });
  }

  void updatePlayersSateListner(BuildContext context) {
    _socketClient.on('updatePLayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

//   void updatePlayersSateListner(BuildContext context) {
//   _socketClient.on('updatePLayers', (playerData) {
//     log('Player Data Received: $playerData'); // Debugging
//     if (playerData is List && playerData.length == 2) {
//       Provider.of<RoomDataProvider>(context, listen: false)
//           .updatePlayer1(playerData[0]);
//       Provider.of<RoomDataProvider>(context, listen: false)
//           .updatePlayer2(playerData[1]);
//     } else {
//       log('Invalid Player Data Format: $playerData');
//     }
//   });
// }

  void updateRoomStateListner(BuildContext context) {
    _socketClient.on('updateRoom', (roomData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(roomData);
    });
  }

  void tappedListner(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListner(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      log("Point Increase Event: ${playerData.toString()}");
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);

      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListner(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialougeBox(context, "${playerData['nickname']} has Won!!");
      Navigator.popUntil(context, (routes) => false);
    });
  }
}
