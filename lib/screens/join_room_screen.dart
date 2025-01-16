import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final _socketMethods = SocketMethods();
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _socketMethods.joinRoomSuccessListner(context);
    _socketMethods.errorOccuredListner(context);
    _socketMethods.updatePlayersSateListner(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    color: Colors.blueAccent,
                    blurRadius: 10,
                  ),
                ],
                text: 'Join Room',
                fontSize: 80,
              ),
              SizedBox(height: size.height * 0.008),
              CustomTextField(
                  controller: _nameController, hintText: 'Enter your nickName'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: _gameIdController,
                  hintText: 'Enter your game Id'),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                  onTap: () => _socketMethods.joinRoom(
                      _nameController.text, _gameIdController.text),
                  text: 'Join')
            ],
          ),
        ),
      ),
    );
  }
}
