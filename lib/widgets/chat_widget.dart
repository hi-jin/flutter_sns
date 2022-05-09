import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns/core/providers.dart';
import 'package:flutter_sns/core/theme.dart';

class ChatWidget extends ConsumerStatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatWidget> createState() => _ChatWidgetState();
}

// void getChats() async {
//   //.orderBy('sent_at')
//   await for(var snapshot in FirebaseFirestore.instance.collection('messages').snapshots()) {
//     for(var data in snapshot.docs) {
//       print(data.data()['text']);
//     }
//   }
// }

class _ChatWidgetState extends ConsumerState<ChatWidget> {
  late TextEditingController _chatInputController;
  ScrollController? _scrollController;
  bool updated = false;

  @override
  void initState() {
    super.initState();
    _chatInputController = TextEditingController();
  }

  void setScrollController() {
  }

  @override
  Widget build(BuildContext context) {

    // TODO 좀 더 깔끔한 코드???
    Timer(const Duration(milliseconds: 200), () {
      if (_scrollController != null) {
        _scrollController!.animateTo(
          _scrollController!.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    });

    final user = ref.watch(userProvider);
    final chatStore = ref.watch(storeProvider).collection('messages');

    if (user == null) {
      Navigator.pop(context);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user!.email!.split('@').elementAt(0)}님',
            style: kTitleTextStyle.copyWith(fontSize: 15),
          ),
          const Divider(thickness: 3),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: chatStore.orderBy('sent_at').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return const SizedBox.shrink();
                  List<String> senders = [];

                  if (_scrollController == null) {
                    _scrollController = ScrollController();
                  }
                  List<String> messages = [];
                  List<Timestamp> times = [];

                  for (var chatData in snapshot.data!.docs) {
                    senders.add(chatData['sender']!);
                    messages.add(chatData['text']);
                    times.add(chatData['sent_at']);
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: senders.length,
                    itemBuilder: (context, index) {
                      return Chat(
                        sender:
                            senders.elementAt(index).split('@').elementAt(0),
                        message: messages.elementAt(index),
                        sentAt: times.elementAt(index),
                        isMine: (senders.elementAt(index) == user.email)
                            ? true
                            : false,
                      );
                    },
                  );
                }),
          ),
          const Divider(thickness: 3),
          TextField(
            controller: _chatInputController,
            decoration: kInputDecoration.copyWith(
              suffixIcon: TextButton(
                onPressed: () {
                  if (_chatInputController.text != '') {
                    chatStore.add({
                      'sender': user.email,
                      'sent_at': Timestamp.now(),
                      'text': _chatInputController.text,
                    });
                    _chatInputController.text = '';
                  }
                },
                child: const Icon(
                  Icons.send_sharp,
                  color: MyColors.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({
    Key? key,
    required this.sender,
    required this.message,
    required this.sentAt,
    required this.isMine,
  }) : super(key: key);

  final String sender;
  final String message;
  final Timestamp sentAt;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final time =
        DateTime.fromMicrosecondsSinceEpoch(sentAt.microsecondsSinceEpoch);

    return Container(
      decoration: BoxDecoration(
        color: (isMine) ? MyColors.primary.withOpacity(0.3) : Colors.white,
        border: const Border.symmetric(horizontal: BorderSide(width: 0.1)),
      ),
      child: ListTile(
        title: Text(message),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('by $sender'),
            Text('${time.month}월 ${time.day}일 ${time.hour}시 ${time.minute}분'),
          ],
        ),
      ),
    );
  }
}
