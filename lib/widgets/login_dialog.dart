import 'package:flutter/material.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/colored_button.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  late TextEditingController _emailController, _pwController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _pwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
                      onPressed: () {
                        // check empty
                        if (_emailController.text == "" ||
                            _pwController.text == "") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('잠시만요!'),
                                  content: Text('이메일, 패스워드를 모두 입력해주세요'),
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
                          return;
                        }
                        print(_emailController.text);
                        print(_pwController.text);
                      },
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      title: "로그인",
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        // check empty
                        if (_emailController.text == "" ||
                            _pwController.text == "") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('잠시만요!'),
                                  content: Text('이메일, 패스워드를 모두 입력해주세요'),
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
                          return;
                        }
                        print(_emailController.text);
                        print(_pwController.text);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
