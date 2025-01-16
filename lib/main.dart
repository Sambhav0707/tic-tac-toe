import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/room_data_provider.dart';
import 'package:tic_tac_toe/routes/app_routes.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/screens/main_screen.dart';
import 'package:tic_tac_toe/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> RoomDataProvider(),
      child: MaterialApp(
        title: 'tic tac toe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Color.fromARGB(255, 50, 107, 154)),
            ),
          ),
        ),
        routes: {
          AppRoutes.createRoomScreen: (context) => const CreateRoomScreen(),
          AppRoutes.joinRoomScreen: (context) => const JoinRoomScreen(),
          AppRoutes.mainMenuScreen: (context) => const MainScreen(),
          AppRoutes.gameScreen:(context)=> GameScreen(),
        },
       initialRoute: AppRoutes.mainMenuScreen,
      ),
    );
  }
}
