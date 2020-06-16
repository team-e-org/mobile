import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/account_repository.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/board_detail_screen.dart';
import 'package:mobile/view/board_edit_screen.dart';
import 'package:mobile/view/create_new_screen.dart';
import 'package:mobile/view/new_board_screen.dart';
import 'package:mobile/view/onboarding/auth_screen.dart';
import 'package:mobile/view/onboarding/authentication_bloc.dart';
import 'package:mobile/view/pin_detail_screen.dart';
import 'package:mobile/view/pin_edit_screen.dart';
import 'package:mobile/view/pin_select_photo_screen.dart';
import 'package:mobile/view/root_screen.dart';
import 'package:mobile/view/select_board_screen.dart';
import 'package:overlay_support/overlay_support.dart';

class PinterestApplication extends StatelessWidget {
  final accountRepo = MockAccountRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(accountRepository: accountRepo)
        ..add(AppInitialized()),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AccountRepository>(
            create: (_) => accountRepo,
          ),
        ],
        child: _app(),
      ),
    );
  }

  Widget _app() {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Pinterest',
        theme: ThemeData(
          buttonColor: Colors.red,
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Routes.root:
              return _pageRoute(
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Unauthenticated || state is Authenticating) {
                      return AuthWidget.newInstance();
                    }
                    return RootScreen();
                  },
                ),
                name: Routes.root,
              );
            // Pin
            case Routes.pinDetail:
              final args = settings.arguments as PinDetailScreenArguments;
              return _pageRoute(PinDetailScreen(args: args));
            case Routes.pinEdit:
              return _pageRoute(PinEditScreen());
            // Board
            case Routes.boardDetail:
              return _pageRoute(BoardDetailScreen());
            case Routes.boardEdit:
              return _pageRoute(BoardEditScreen());
            // Create new pin/board
            case Routes.createNew:
              return _pageRoute(CreateNewScreen());
            case Routes.createNewBoard:
              return _pageRoute(NewBoardScreen());
            case Routes.createNewPinSelectPhoto:
              return _pageRoute(
                PinSelectPhotoScreen(),
                fullScreenDialog: true,
              );
            case Routes.createNewPinEdit:
              return _pageRoute(PinEditScreen());
            case Routes.createNewPinSelectBoard:
              return _pageRoute(SelectBoardScreen());
          }
          return null;
        },
      ),
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
