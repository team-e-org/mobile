import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  Logger.level = Level.verbose;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinterest',
      theme: ThemeData(
        buttonColor: Colors.red,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return _pageRoute(RootScreen(), name: '/');
          // Pin
          case '/pin/detail':
            return _pageRoute(PinDetailScreen());
          case '/pin/edit':
            return _pageRoute(PinEditScreen());
          // Board
          case '/board/detail':
            return _pageRoute(BoardDetailScreen());
          case '/board/edit':
            return _pageRoute(BoardEditScreen());
          // Create new pin/board
          case '/new':
            return _pageRoute(CreateNewScreen());
          case '/new/board':
            return _pageRoute(NewBoardScreen());
          case '/new/pin/select-photo':
            return _pageRoute(
              PinSelectPhotoScreen(),
              fullScreenDialog: true,
            );
          case '/new/pin/edit':
            return _pageRoute(PinEditScreen());
          case '/new/pin/select-board':
            return _pageRoute(SelectBoardScreen());
        }
        return null;
      },
    );
  }

  MaterialPageRoute _pageRoute(
    Widget widget, {
    bool fullScreenDialog = false,
    String name,
  }) {
    return MaterialPageRoute<dynamic>(
      settings: RouteSettings(
        name: name,
      ),
      builder: (context) => widget,
      fullscreenDialog: fullScreenDialog,
    );
  }
}
