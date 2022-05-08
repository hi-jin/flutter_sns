import 'package:flutter/material.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/login_dialog.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fastagram'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '안녕하세요',
              style: kTitleTextStyle,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '사용하기에 앞서',
                  style: kTitleTextStyle,
                ),
                TextButton(
                  onPressed: () async {
                    final user = await showDialog(
                      context: context,
                      builder: (context) {
                        return LoginDialog();
                      },
                    );
                    print(user);
                    setState(() {});
                  },
                  child: Text(
                    "로그인",
                    style: kTitleTextStyle,
                  ),
                ),
                Text(
                  '해주세요',
                  style: kTitleTextStyle,
                ),
              ],
            ),
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
