import 'package:flutter/material.dart';
import 'package:flutter_sns/core/app_user.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/colored_button.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key, required this.logout}) : super(key: key);

  Function logout;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ColoredButton(
            title: "로그아웃",
            backgroundColor: MyColors.primary,
            onPressed: () {
              AppUser.logout();
              logout();
            },
          )
        ],
      ),
    );
  }
}
