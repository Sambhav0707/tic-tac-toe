import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/models/player_model.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  int _filledBoxes = 0;
  PlayerModel _player1 =
      PlayerModel(nickname: '', socketId: '', points: 0, playerType: 'X');

  PlayerModel _player2 =
      PlayerModel(nickname: '', socketId: '', points: 0, playerType: 'O');

  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];

  PlayerModel get player1 => _player1;
  PlayerModel get player2 => _player2;
  int get filledBoxes => _filledBoxes;

  Map<String, dynamic> get roomData => _roomData;

  List<String> get displayElements => _displayElements;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    log('Updating Player 1: $player1Data');
    _player1 = PlayerModel.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    log('Updating Player 2: $player2Data');
    _player2 = PlayerModel.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    if (_displayElements[index] == '') { // Prevent overwriting filled cells
      _displayElements[index] = choice;
      _filledBoxes += 1;
      log('Updated displayElements: $_displayElements');
      notifyListeners();
    } else {
      log('Cell $index is already filled with ${_displayElements[index]}');
    }
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
    notifyListeners(); // Notify listeners after resetting
  }

  void resetGame() {
    _displayElements = List.filled(9, ''); // Reset display elements
    setFilledBoxesTo0(); // Reset filled boxes
    notifyListeners(); // Notify listeners
  }
}

