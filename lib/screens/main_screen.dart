import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/routes/app_routes.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.createRoomScreen);
                },
                text: 'Create Room'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.joinRoomScreen);
                },
                text: 'Join Room'),
          ],
        ),
      ),
    );
  }
}
