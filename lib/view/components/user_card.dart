import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:mobile/view/components/user_icon.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    this.user,
    this.onTap,
    this.margin,
    this.padding,
    this.height = 60,
  });

  final User user;
  final double height;
  final EdgeInsetsGeometry margin, padding;
  final void Function(BuildContext context, User user) onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: GestureDetector(
        onTap: () => onTap(context, user),
        child: Container(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserIcon(
                imageUrl: user.icon,
              ),
              PinterestTypography.body1(user.name),
            ],
          ),
        ),
      ),
    );
  }
}
