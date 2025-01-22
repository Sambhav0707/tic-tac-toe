import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';

class Scoreborad extends StatelessWidget {
  const Scoreborad({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                roomDataProvider.roomData['players'][0]['nickname'].toString(),
                // roomDataProvider.player1.nickname.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<RoomDataProvider>(
                  builder: (context, roomDataProvider, child) {
                return Text(
                  // roomDataProvider.player1.points.toInt().toString(),
                  roomDataProvider.roomData['players'][0]['points'].toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                // roomDataProvider.player2.nickname.toString(),
                roomDataProvider.roomData['players'][1]['nickname'].toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<RoomDataProvider>(
                  builder: (context, roomDataProvider, child) {
                return Text(
                  // roomDataProvider.player2.points.toInt().toString(),
                  roomDataProvider.roomData['players'][1]['points'].toString(),

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
