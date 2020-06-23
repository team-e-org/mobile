import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobile/api/api_client.dart';
import 'package:mobile/config.dart';
import 'package:mobile/data/account_repository.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mobile/repository/pins_repository.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/repository/repositories.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/board_detail_screen.dart';
import 'package:mobile/view/board_edit_screen.dart';
import 'package:mobile/view/create_new_screen.dart';
import 'package:mobile/view/new_board_screen.dart';
import 'package:mobile/view/new_pin_screen.dart';
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
  const PinterestApplication({
    this.prefs,
  });

  final AuthenticationPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final config = readConfig();
    final apiClient = ApiClient(
      Client(),
      apiEndpoint: config.apiEndpoint,
      prefs: prefs,
    );
    final accountRepo = DefaultAccountRepository(
      api: DefaultAuthApi(apiClient),
      prefs: prefs,
    );
    // final accountRepo = MockAccountRepository();
    final pinsRepo = MockPinsRepository();
    final boardsRepo = MockBoardsRepository();
    // final usersRepo = DefaultUsersRepository(DefaultUsersApi(apiClient));
    final usersRepo = MockUsersRepository();

    return BlocProvider(
      create: (context) => AuthenticationBloc(accountRepository: accountRepo)
        ..add(AppInitialized()),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AccountRepository>(
            create: (_) => accountRepo,
          ),
          RepositoryProvider<PinsRepository>(
            create: (_) => pinsRepo,
          ),
          RepositoryProvider<BoardsRepository>(
            create: (_) => boardsRepo,
          ),
          RepositoryProvider<UsersRepository>(
            create: (_) => usersRepo,
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
              return _pageRoute(
                CreateNewScreen(),
                fullScreenDialog: true,
              );
            case Routes.createNewBoard:
              return _pageRoute(NewBoardScreen());
            case Routes.createNewPinSelectPhoto:
              return _pageRoute(PinSelectPhotoScreen());
            case Routes.createNewPin:
              return _pageRoute(NewPinScreen(), fullScreenDialog: true);
            case Routes.createNewPinEdit:
              final args = settings.arguments as PinEditScreenArguments;
              return _pageRoute(PinEditScreen(args: args));
            case Routes.createNewPinSelectBoard:
              final args = settings.arguments as SelectBoardScreenArguments;
              return _pageRoute(SelectBoardScreen(args: args));
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
