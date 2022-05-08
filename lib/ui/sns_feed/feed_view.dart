import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/widgets/colored_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/auth.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final _fireStorage = FirebaseStorage.instance.ref();
  final _imagePicker = ImagePicker();
  File? _image;

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Column(
                children: [],
              )),
              TextButton(
                onPressed: () async {
                  ListResult result = await _fireStorage.listAll();

                  result.items.forEach((element) {
                    print(element);
                  });

                  _fireStorage.listAll().then((value) =>
                      print(value.items.length)); // TODO : 저장된 파일 링크 불러오는 방법???
                },
                child: Text("get list"),
              ),
              ColoredButton(
                title: "사진 업로드",
                backgroundColor: Colors.blue,
                onPressed: () async {
                  XFile? image = await _imagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 400,
                      maxHeight: 400);
                  if (image == null) return;

                  setState(() {
                    _image = File(image.path);
                  });
                  await _fireStorage
                      .child(
                          'post/${user!.email}-${DateTime.now().millisecondsSinceEpoch}.png')
                      .putFile(_image!)
                      .whenComplete(() => print('hi'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
