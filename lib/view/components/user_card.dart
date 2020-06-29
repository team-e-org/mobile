import 'package:flutter/material.dart';
import 'package:mobile/model/models.dart';
import 'package:mobile/view/components/common/typography_common.dart';
import 'package:mobile/view/components/user_icon.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    this.user,
    this.onTap,
  });

  final User user;
  final void Function(BuildContext context, User user) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context, user),
      child: Card(
        child: Container(
          height: 60,
          child: Row(
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
