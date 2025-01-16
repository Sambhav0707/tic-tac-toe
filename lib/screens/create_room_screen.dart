import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_methods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.createRoomSuccessListner(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    super.dispose();
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
                text: 'Create Room',
                fontSize: 80,
              ),
              SizedBox(height: size.height * 0.008),
              CustomTextField(
                  controller: _nameController, hintText: 'Enter your nickName'),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                  onTap: () => _socketMethods.creatRoom(_nameController.text),
                  text: 'Create')
            ],
          ),
        ),
      ),
    );
  }
}
