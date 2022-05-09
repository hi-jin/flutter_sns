import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns/core/providers.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/colored_button.dart';

class SettingView extends ConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    return Center(
      child: Column(
        children: [
          ColoredButton(
            title: "로그아웃",
            backgroundColor: MyColors.primary,
            onPressed: () async {
              await ref.watch(userProvider.notifier).logout();
              ref.watch(currentPageProvider.state).state = 0;
            },
          )
        ],
      ),
    );
  }
}
