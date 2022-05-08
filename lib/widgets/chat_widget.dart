import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/core/auth.dart';
import 'package:flutter_sns/core/theme.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final _fireStore = FirebaseFirestore.instance;
  late TextEditingController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            border:
                Border.symmetric(horizontal: BorderSide(color: Colors.black))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('익명 채팅', style: kTitleTextStyle.copyWith(fontSize: 20.0)),
            SizedBox(height: 10),
            Expanded(child: SizedBox.shrink()),
            TextField(
              controller: _chatController,
              decoration: kInputDecoration.copyWith(
                suffixIcon: TextButton(
                  onPressed: () {
                    if (_chatController.text == "") {
                      return;
                    }
                    _fireStore.collection("messages").add({
                      'text': _chatController.text,
                      'sender': user!.email,
                    });
                    setState(() {
                      _chatController.text = "";
                    });
                  },
                  child: Icon(Icons.send),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
