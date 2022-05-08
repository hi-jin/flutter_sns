import 'package:flutter/material.dart';

import '../../core/auth.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {

  @override
  void initState() {
    super.initState();
    getAuth();
  }

  void getAuth() {
    setState(() {
      user = auth.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
            "hello world"
        ),
      ),
    );
  }
}
