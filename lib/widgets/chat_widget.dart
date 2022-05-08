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
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('messages').orderBy('sent_at').snapshots(),
                builder: (context, snapshot) {
                  List<String> senders = [];
                  List<String> messages = [];
                  List<Timestamp> sent_at = [];

                  if (snapshot.hasData) {
                    for (var data in snapshot.data!.docs) {
                      senders.add(data['sender']);
                      messages.add(data['text']);
                      sent_at.add(data['sent_at']);
                    }
                  }
                  return ListView.builder(
                    itemCount: senders.length,
                    itemBuilder: (context, i) {
                      final at = DateTime.fromMicrosecondsSinceEpoch(sent_at.elementAt(i).microsecondsSinceEpoch);
                      return ListTile(
                        textColor: (user!.email != senders.elementAt(i)) ? Colors.black: Colors.blue,
                        title: Text(messages.elementAt(i)),
                        subtitle: Text('by ${senders.elementAt(i).split('@').elementAt(0)}'),
                        trailing: Text('${at.hour}시 ${at.minute}분'),
                      );
                    },
                  );
                },
              ),
            ),
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
                      'sent_at': Timestamp.now(),
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
