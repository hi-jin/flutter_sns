import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns/core/providers.dart';
import 'package:flutter_sns/core/theme.dart';
import 'package:flutter_sns/widgets/colored_button.dart';
import 'package:flutter_sns/widgets/loading_widget.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  late TextEditingController _emailController;
  late TextEditingController _pwController;
  bool nowLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: kInputDecoration.copyWith(label: Text('email')),
                ),
                TextField(
                  obscureText: true,
                  controller: _pwController,
                  decoration:
                      kInputDecoration.copyWith(label: Text('password')),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ColoredButton(
                        title: "로그인",
                        backgroundColor: MyColors.primary,
                        onPressed: () async {
                          try {
                            setState(() {
                              nowLoading = true;
                            });
                            await ref.watch(userProvider.notifier).login(
                                  _emailController.text,
                                  _pwController.text,
                                );
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              await showMessageDialog(
                                  context, '올바른 이메일 형식으로 입력해주세요');
                            } else {
                              await showMessageDialog(
                                  context, '이메일과 비밀번호를 확인해주세요');
                            }
                          }
                          setState(() {
                            nowLoading = false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ColoredButton(
                        title: "회원가입",
                        backgroundColor: Colors.grey,
                        onPressed: () async {
                          try {
                            setState(() {
                              nowLoading = true;
                            });
                            await ref.watch(userProvider.notifier).register(
                                _emailController.text, _pwController.text);
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              await showMessageDialog(
                                  context, '올바른 이메일 형식으로 입력해주세요');
                            } else {
                              await showMessageDialog(
                                  context, '이메일과 비밀번호를 확인해주세요');
                            }
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
        ),
        if (nowLoading) ...[LoadingWidget()],
      ],
    );
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
                backgroundColor: MyColors.primary,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
