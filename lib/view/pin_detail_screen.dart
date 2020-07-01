import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mobile/bloc/pin_detail_screen_bloc.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/repository/users_repository.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile/view/components/notification.dart';
import 'package:mobile/view/components/tag_chips.dart';
import 'package:mobile/view/components/user_card.dart';
import 'package:url_launcher/url_launcher.dart';

class PinDetailScreenArguments {
  const PinDetailScreenArguments({
    this.pin,
  }) : assert(pin != null);

  final Pin pin;
}

class PinDetailScreen extends StatelessWidget {
  PinDetailScreen({this.args});

  final PinDetailScreenArguments args;

  UsersRepository _usersRepository;

  @override
  Widget build(BuildContext context) {
    _usersRepository = RepositoryProvider.of(context);

    return BlocProvider(
        create: (context) => PinDetailScreenBloc(
              usersRepository: _usersRepository,
              pin: args.pin,
            )..add(LoadInitial()),
        child: BlocConsumer<PinDetailScreenBloc, PinDetailScreenState>(
          listener: (context, state) {},
          builder: (context, state) => _contentBuilder(context, state),
        ));
  }

  Widget _contentBuilder(BuildContext context, PinDetailScreenState state) {
    final bloc = BlocProvider.of<PinDetailScreenBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _builder(context, state),
          Positioned(
            left: 12,
            top: 16,
            child: _backButton(context),
          ),
        ]),
      ),
    );
  }

  Widget _builder(BuildContext context, PinDetailScreenState state) {
    final user = state.user;

    if (state is InitialState || state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorState) {
      return Center(
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
            // TODO 投稿者情報を入れる
            const SizedBox(height: 32),

            _buildPinInfo(
              title: args.pin.title,
              description: args.pin.description,
            ),
            const SizedBox(height: 32),

            _buildTags(args.pin.tags),
            const SizedBox(height: 32),

            UserCard(
              user: user,
              onTap: (context, user) =>
                  {PinterestNotification.showNotImplemented()},
              margin: EdgeInsets.symmetric(horizontal: 40),
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
        onPressed: () {
          PinterestNotification.showNotImplemented();
        },
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
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
}
