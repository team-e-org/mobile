import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/data/account_repository.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_support/overlay_support.dart';

class PinterestApplication extends StatelessWidget {
  PinterestApplication({
    @required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    // TODO: Build環境分ける
    final apiEndpoint =
        Platform.isAndroid ? 'http://10.0.2.2:3100' : 'http://localhost:8080';

    final accountRepo = DefaultAccountRepository(
      api: DefaultAuthApi(
        ApiClient(
          Client(),
          apiEndpoint: apiEndpoint,
        ),
      ),
      prefs: prefs,
    );

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
            case '/':
              return _pageRoute(
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Unauthenticated || state is Authenticating) {
                      return AuthWidget.newInstance();
                    }
                    return RootScreen();
                  },
                ),
                name: '/',
              );
            // Pin
            case '/pin/detail':
              final args = settings.arguments as PinDetailScreenArguments;
              return _pageRoute(PinDetailScreen(args: args));
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
