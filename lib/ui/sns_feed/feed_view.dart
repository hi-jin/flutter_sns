import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/widgets/colored_button.dart';
import 'package:flutter_sns/widgets/loading_widget.dart';
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
  ImageProvider? _image;

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

  Stream<Map<String, String>> getImages() async* {
    // listAll을 호출할 때에는 폴더를 명시해야 한다.
    ListResult result = await _fireStorage.child('post').listAll();

    Map<String, String> data = {};

    for (var element in result.items) {
      final url = await element.getDownloadURL();
      data[url] = element.name.split('-').elementAt(0);
    }
    yield data;
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
                  children: [
                    Expanded(
                      child: StreamBuilder<Map<String, String>>(
                        stream: getImages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.waiting) {
                            Map<String, String>? result = snapshot.data;

                            if (result == null) return SizedBox.shrink();

                            List<String> urls = [], publishers = [];

                            for (var key in result.keys) {
                              urls.add(key);
                              publishers.add(result[key]!);
                            }

                            return ListView.builder(
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Image.network(urls.elementAt(index)),
                                  subtitle: Text(publishers.elementAt(index)),
                                );
                              },
                            );
                          } else {
                            return LoadingWidget();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  getImages();
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

                  await _fireStorage
                      .child(
                          'post/${user!.email}-${DateTime.now().millisecondsSinceEpoch}.png')
                      .putFile(File(image.path))
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
