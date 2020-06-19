import 'package:flutter/material.dart';
import 'package:mobile/view/components/common/button_common.dart';
import 'package:mobile/view/components/common/textfield_common.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:mobile/view/components/notification.dart';

class PlaygroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: <Widget>[
              _buildButtonsSection(),
              _buildTextFieldSection(),
              _buildTypographySection(),
              _buildNotificationSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsSection() {
    return _Section(
      'Buttons',
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PinterestButton.primary(text: 'Primary', onPressed: () {}),
            const SizedBox(width: 20),
            PinterestButton.secondary(text: 'Primary', onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildTextFieldSection() {
    return _Section(
      'TextField',
      children: <Widget>[
        PinterestTextField(
          props: PinterestTextFieldProps(
            label: 'Title',
            hintText: 'hint etxt',
          ),
        ),
        PinterestTextField(
          props: PinterestTextFieldProps(
            label: 'Name',
            hintText: 'Type your name',
          ),
        ),
        PinterestTextField(
          props: PinterestTextFieldProps(
            label: 'Password',
            hintText: 'Type your password',
            obscure: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTypographySection() {
    const sampleText =
        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''';

    return _Section(
      'Typography',
      children: <Widget>[
        PinterestTypography.body1('body1: $sampleText'),
        const SizedBox(height: 12),
        PinterestTypography.body2('body2: $sampleText'),
        const SizedBox(height: 12),
        PinterestTypography.header('header: Lorem Ipsum'),
      ],
    );
  }

  Widget _buildNotificationSection() {
    return _Section(
      'Notification',
      children: <Widget>[
        Wrap(
          children: <Widget>[
            PinterestButton.secondary(
                text: 'normal',
                onPressed: () {
                  PinterestNotification.show(title: 'normal notification');
                }),
            PinterestButton.secondary(
                text: 'normal with leading',
                onPressed: () {
                  PinterestNotification.show(
                    title: 'normal notification',
                    subtitle: 'with leading image',
                    leading: Image.asset('assets/logo/logo.png'),
                  );
                }),
            PinterestButton.secondary(
              text: 'not implemented warning',
              onPressed: PinterestNotification.showNotImplemented,
            ),
            PinterestButton.secondary(
                text: 'error',
                onPressed: () {
                  PinterestNotification.showError(title: 'error notification');
                }),
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(
    this.header, {
    this.children,
  });

  final String header;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PinterestTypography.header(header),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ],
      ),
    );
  }
}
