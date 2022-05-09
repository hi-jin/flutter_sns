import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns/core/providers.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/ui/settings/setting_view.dart';
import 'package:flutter_sns/widgets/chat_widget.dart';
import 'package:flutter_sns/widgets/login_dialog.dart';

class MainView extends ConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final currentPage = ref.watch(currentPageProvider);
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Fastagram"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (user == null) ...[
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("먼저", style: kTitleTextStyle),
                    TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => LoginDialog(),
                        );
                      },
                      child: Text(
                        "로그인",
                        style: kTitleTextStyle.copyWith(
                          color: MyColors.primary,
                        ),
                      ),
                    ),
                    Text("해주세요...", style: kTitleTextStyle),
                  ],
                ),
              ),
            ],
            [
              Container(),
              ChatWidget(),
              SettingView(),
            ].elementAt(currentPage)
          ],
        ),
      ),
      bottomNavigationBar: (user != null)
          ? BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: '피드'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: '설정'),
        ],
        currentIndex: currentPage,
        onTap: (index) {
          ref.read(currentPageProvider.state).state = index;
        },
      )
          : null,
    );
  }
}
