import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socket) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    String winner = '';
    // Check rows
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[3] != '') {
      winner = roomDataProvider.displayElements[3];
    }
    if (roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[6] != '') {
      winner = roomDataProvider.displayElements[6];
    }

    // Check columns
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[1] != '') {
      winner = roomDataProvider.displayElements[1];
    }
    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    }
    // Check diagonals
    if (roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    }

    // if (winner != '') {
    //   if (roomDataProvider.player1.playerType == winner) {
    //     showGameDialougeBox(context,
    //         "${roomDataProvider.roomData['players'][0]['nickname']} Wins");
    //     socket.emit("winner", {
    //       "winnerSocketId": roomDataProvider.player1.socketID,
    //       "roomId": roomDataProvider.roomData['_id'],
    //     });
    //     clearBoard(context);
    //   } else {
    //     showGameDialougeBox(context,
    //         "${roomDataProvider.roomData['players'][1]['nickname']} Wins");
    //     socket.emit("winner", {
    //       "winnerSocketId": roomDataProvider.player2.socketID,
    //       "roomId": roomDataProvider.roomData['_id'],
    //     });
    //     clearBoard(context);
    //   }
    // }

    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        showGameDialougeBox(context,
            "${roomDataProvider.roomData['players'][0]['nickname']} Wins");
        log(" ${roomDataProvider.roomData['players'][1]['socketId']}");
        socket.emit("winner", {
          "winnerSocketId":
              roomDataProvider.roomData['players'][0]['socketId'].toString(),
          "roomId": roomDataProvider.roomData['_id'],
        });
      } else {
        showGameDialougeBox(context,
            "${roomDataProvider.roomData['players'][1]['nickname']} Wins");
        log(" ${roomDataProvider.roomData['players'][1]['socketId']}");
        socket.emit("winner", {
          "winnerSocketId":
              roomDataProvider.roomData['players'][1]['socketId'].toString(),
          "roomId": roomDataProvider.roomData['_id'],
        });
      }
      clearBoard(context); // Clear the board after a win
    } else if (roomDataProvider.filledBoxes == 9) {
      // Only declare a draw if no winner exists
      showGameDialougeBox(context, "Draw");
      clearBoard(context); // Clear the board after a draw
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    // for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
    //   roomDataProvider.updateDisplayElements(i, '');
    // }
    // roomDataProvider.setFilledBoxesTo0();
    roomDataProvider.resetGame();
  }
}
