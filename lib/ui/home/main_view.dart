import 'package:flutter/material.dart';
import 'package:flutter_sns/core/app_user.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/ui/settings/setting_view.dart';
import 'package:flutter_sns/widgets/login_dialog.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (AppUser.currentUser == null) {
      setState(() {
        _selectedTab = 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Fastagram"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (AppUser.currentUser == null) ...[
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
                        setState(() {}); // 로그인 정보 변경사항 적용
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
              Container(),
              SettingView(
                logout: () {
                  setState(() {});
                },
              ),
            ].elementAt(_selectedTab)
          ],
        ),
      ),
      bottomNavigationBar: (AppUser.currentUser != null)
          ? BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.feed), label: '피드'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble), label: '채팅'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: '설정'),
              ],
              currentIndex: _selectedTab,
              onTap: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
            )
          : null,
    );
  }
}
