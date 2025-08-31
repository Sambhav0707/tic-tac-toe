import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/views/scoreborad.dart';
import 'package:tic_tac_toe/views/tic_tac_toe_board.dart';
import 'package:tic_tac_toe/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _socketMethods.updateRoomStateListner(context);
    _socketMethods.updatePlayersSateListner(context);
    _socketMethods.tappedListner(context);

    _socketMethods.pointIncreaseListner(context);
    _socketMethods.endGameListner(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context );

    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : Consumer<RoomDataProvider>(
            builder: (context , roomDataProvider , child) {
              return  SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Scoreborad(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TicTacToeBoard(),
                      ),

                      Text("${roomDataProvider.roomData['turn']['nickname']}'s Turn"),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("${roomDataProvider.roomData["currentRound"].toString()}")
              
                      // Text(roomDataProvider.roomData['players'][0]['nickname'].toString(), style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                      // SizedBox(height: 20,),
                      //  Text(roomDataProvider.player1.nickname.toString()),
                      //  SizedBox(height: 20,),
                      //  Text(roomDataProvider.player2.nickname.toString()),
                    ],
                  ),
                );
            }
          ),
    );
  }
}


