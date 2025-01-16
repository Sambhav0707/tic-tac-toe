import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController(
        text: Provider.of<RoomDataProvider>(context , listen: false).roomData['_id']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Waiting for other player to join...',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 35),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomTextField(
            controller: controller,
            hintText: '',
            isReadOnly: true,
          ),
        )
      ],
    );
  }
}
