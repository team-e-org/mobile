import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/bloc/pin_detail_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/users_repository.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/components/tag_chips.dart';
import 'package:mobile/view/components/user_card.dart';
import 'package:mobile/view/pin_save_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PinDetailScreenArguments {
  const PinDetailScreenArguments({
    @required this.pin,
  });

  final Pin pin;
}

class PinDetailScreen extends StatelessWidget {
  const PinDetailScreen({this.args});

  final PinDetailScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinDetailScreenBloc(
        usersRepository: RepositoryProvider.of<UsersRepository>(context),
        pin: args.pin,
      )..add(const LoadInitial()),
      child: BlocBuilder<PinDetailScreenBloc, PinDetailScreenState>(
        builder: _contentBuilder,
      ),
    );
  }

  Widget _contentBuilder(BuildContext context, PinDetailScreenState state) {
    return Scaffold(
      body: Stack(children: [
        _builder(context, state),
        Positioned(
          left: 12,
          top: 16,
          child: SafeArea(child: _backButton(context)),
        ),
      ]),
    );
  }

  Widget _builder(BuildContext context, PinDetailScreenState state) {
    final user = state.user;

    if (state is InitialState || state is Loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorState) {
      return const Center(
        child: Text('読み込みに失敗しました'),
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _pinImage(args.pin.imageUrl),
            const SizedBox(height: 32),
            _buildPinInfo(
              title: args.pin.title,
              description: args.pin.description,
          ]..removeWhere((e) => e == null),
            ),
            const SizedBox(height: 32),
            _buildTags(args.pin.tags),
            const SizedBox(height: 32),
            UserCard(
              user: user,
              onTap: (context, user) =>
                  {PinterestNotification.showNotImplemented()},
              margin: const EdgeInsets.symmetric(horizontal: 40),
            ),
            const SizedBox(height: 32),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _pinImage(String imageUrl) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500), // FIXME 決め打ちにしない
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 200,
          width: 200,
        ),
        errorWidget: (_, __, dynamic err) => const Placeholder(
          fallbackHeight: 200,
          fallbackWidth: 200,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.black.withOpacity(0.3), // button color
        child: InkWell(
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildPinInfo({String title, String description}) {
    if (title == null && String == null) {
      return Container();
    }

    final list = <Widget>[];

    if (title != null) {
      list.add(PinterestTypography.body1(title));
    }
    if (title != null && description != null) {
      list.add(const SizedBox(height: 8));
    }
    if (description != null) {
      list.add(PinterestTypography.body2(description));
    }

    return Column(children: list);
  }

  Widget _buildTags(List<String> tags) {
    return TagChips(tags: tags);
  }

  Widget _buildActions(BuildContext context) {
    final list = <Widget>[];

    if (args.pin.url != null && args.pin.url.isNotEmpty) {
      list.addAll([
        PinterestButton.secondary(
          text: 'Access',
          onPressed: () => _onAccessPressed(context),
        ),
        const SizedBox(width: 20),
      ]);
    }
    list.add(
      PinterestButton.primary(
        text: 'Save',
        onPressed: () => _onSavePressed(context),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
      ]..removeWhere((e) => e == null),
    );
  }

  Future _onAccessPressed(BuildContext context) async {
    Logger().d('Open URL: ${args.pin.url}');
    if (await canLaunch(args.pin.url)) {
      await launch(args.pin.url);
    } else {
      PinterestNotification.showError(title: '無効なURLです');
    }
  }

  Future _onSavePressed(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      Routes.pinSave,
      arguments: PinSaveScreenArguments(pin: args.pin),
    );
  }
}
