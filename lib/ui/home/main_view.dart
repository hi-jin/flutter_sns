import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/colored_button.dart';
import 'package:flutter_sns/widgets/login_dialog.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    getAuth();
  }

  void getAuth() {
    setState(() {
      user = _auth.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fastagram'),
        actions: [
          if (user == null) ...[
            TextButton(
              onPressed: () async {
                final user = await showDialog(
                  context: context,
                  builder: (context) {
                    return LoginDialog();
                  },
                );
                print(user);
                getAuth();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '로그인',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ] else ...[
            TextButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  getAuth();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '로그아웃',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            mainAxisSize:
                (user == null) ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (user == null) ...[
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
                        getAuth();
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
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user!.email!.split('@').elementAt(0),
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
