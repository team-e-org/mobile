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
import 'package:mobile/view/components/pin_image.dart';
import 'package:mobile/view/components/tag_chips.dart';
import 'package:mobile/view/components/user_card.dart';
import 'package:mobile/view/components/user_icon.dart';
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
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _builder(context, state),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 40,
              left: 0,
              right: 0,
              child: _actionButtons(context, args.pin),
            ),
            Positioned(
              left: 12,
              top: 16,
              child: SafeArea(child: _backButton(context)),
            ),
          ],
        ),
      ),
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
            _pinBuilder(args.pin),
            _userBuilder(state.user),
            _tagsBuilder(args.pin.tags),
            _relatedPins(context),
          ]..removeWhere((e) => e == null),
        ),
      ),
    );
  }

  Widget _pinBuilder(Pin pin) {
    return _RoundedContainer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        primary: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _pinImage(pin.imageUrl),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Column(
              children: [
                _pinTitle(pin.title),
                _pinDescription(pin.description),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _pinTitle(String text) {
    return PinterestTypography.body1(text);
  }

  Widget _pinDescription(String text) {
    return PinterestTypography.body2(text);
  }

  Widget _pinImage(String imageUrl) {
    return PinImage(imageUrl);
  }

  Widget _userBuilder(User user) {
    return _RoundedContainer(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            PinterestTypography.body2('created by'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Flexible(child: PinterestTypography.body2(user.name))],
            )
          ],
        ),
      ),
    );
  }

  Widget _tagsBuilder(List<String> tags) {
    if (tags == null || tags.isEmpty) {
      return null;
    }

    return _RoundedContainer(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            PinterestTypography.body2('tags'),
            TagChips(tags: tags),
          ],
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

  Widget _relatedPins(BuildContext context) {
    return _RoundedContainer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView(
          padding: const EdgeInsets.all(0),
          primary: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(child: PinterestTypography.body1('関連するピン')),
            Container(
              height: 500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButtons(BuildContext context, Pin pin) {
    final enableAccessButton = (pin?.url != null) && (pin.url.isNotEmpty);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        enableAccessButton ? _accessButton(context, pin) : null,
        enableAccessButton ? const SizedBox(width: 8) : null,
        _saveButton(context, pin),
      ]..removeWhere((e) => e == null),
    );
  }

  Widget _accessButton(BuildContext context, Pin pin) {
    return PinterestButton.secondary(
      text: 'Access',
      onPressed: () => _onAccessPressed(context, pin.url),
    );
  }

  Widget _saveButton(BuildContext context, Pin pin) {
    return PinterestButton.primary(
      text: 'Save',
      onPressed: () => _onSavePressed(context, pin),
    );
  }

  Future _onAccessPressed(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      PinterestNotification.showError(title: '無効なURLです');
    }
  }

  Future _onSavePressed(BuildContext context, Pin pin) async {
    await Navigator.of(context).pushNamed(
      Routes.pinSave,
      arguments: PinSaveScreenArguments(pin: args.pin),
    );
  }
}

class _RoundedContainer extends StatelessWidget {
  _RoundedContainer({this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
