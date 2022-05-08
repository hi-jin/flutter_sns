import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/colored_button.dart';

import '../core/auth.dart';
import 'loading_widget.dart';

class LoginDialog extends StatefulWidget {
  LoginDialog({Key? key}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  late TextEditingController _emailController, _pwController;
  bool nowLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _pwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: kInputDecoration.copyWith(hintText: "email"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _pwController,
                  obscureText: true,
                  decoration: kInputDecoration.copyWith(hintText: "password"),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ColoredButton(
                        title: "회원가입",
                        backgroundColor: Colors.grey,
                        onPressed: () async {
                          // check empty
                          if (_emailController.text == "" ||
                              _pwController.text == "") {
                            showMessageDialog(context, '이메일, 패스워드를 모두 입력해주세요');
                            return;
                          }
                          if (_pwController.text.length < 6) {
                            showMessageDialog(context, '비밀번호는 6자 이상 입력해주세요');
                            return;
                          }

                          setState(() {
                            nowLoading = true;
                          });
                          try {
                            final newUser =
                                await auth.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _pwController.text,
                            );
                            Navigator.pop(context, newUser);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              showMessageDialog(context, '이미 사용중인 이메일입니다.');
                            }
                            if (e.code == 'invalid-email') {
                              showMessageDialog(context, '올바른 이메일 형식으로 입력해주세요');
                            }
                            print(e.code);
                          }
                          setState(() {
                            nowLoading = false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ColoredButton(
                        title: "로그인",
                        backgroundColor: Colors.blue,
                        onPressed: () async {
                          // check empty
                          if (_emailController.text == "" ||
                              _pwController.text == "") {
                            showMessageDialog(context, '이메일, 패스워드를 모두 입력해주세요');
                            return;
                          }
                          setState(() {
                            nowLoading = true;
                          });
                          try {
                            final user = await auth.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _pwController.text,
                            );

                            Navigator.pop(context, user);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              showMessageDialog(context, '올바른 이메일 형식으로 입력해주세요');
                            } else {
                              showMessageDialog(
                                  context, '이메일, 패스워드를 다시 확인해주세요');
                            }
                            print(e);
                          }
                          setState(() {
                            nowLoading = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      if (nowLoading) ...[
        LoadingWidget(),
      ]
    ]);
  }

  Future<dynamic> showMessageDialog(BuildContext context, String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('잠시만요!'),
            content: Text(content),
            actions: [
              ColoredButton(
                title: "알겠습니다",
                backgroundColor: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
