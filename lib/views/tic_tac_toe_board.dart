import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  void tappedGrid(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  @override
  void initState() {
    _socketMethods.tappedListner(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500, maxHeight: size.height * 0.7),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketId'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => tappedGrid(index, roomDataProvider),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        roomDataProvider.displayElements[index],
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 20,
                              color:
                                  roomDataProvider.displayElements[index] == 'O'
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
