import 'package:flutter/material.dart';
import 'package:mobile/view/board_detail_screen.dart';
import 'package:mobile/view/board_edit_screen.dart';
import 'package:mobile/view/create_new_screen.dart';
import 'package:mobile/view/new_board_screen.dart';
import 'package:mobile/view/pin_detail_screen.dart';
import 'package:mobile/view/pin_edit_screen.dart';
import 'package:mobile/view/pin_select_photo_screen.dart';
import 'package:mobile/view/root_screen.dart';
import 'package:mobile/view/select_board_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinterest',
      home: RootScreen(),
      routes: {
        // Pin
        '/pin/detail': (context) => PinDetailScreen(),
        '/pin/edit': (context) => PinEditScreen(),

        // Board
        '/board/edit': (context) => BoardEditScreen(),
        '/board/detail': (context) => BoardDetailScreen(),

        // Create new pin/board
        '/new': (context) => CreateNewScreen(),
        '/new/board': (context) => NewBoardScreen(),
        '/new/pin/select-photo': (context) => PinSelectPhotoScreen(),
        '/new/pin/edit': (context) => PinEditScreen(),
        '/new/pin/select-board': (context) => SelectBoardScreen(),
      },
    );
  }
}
