import 'package:flutter/material.dart';
import 'package:flutter_sns/firebase_options.dart';
import 'package:flutter_sns/ui/home/main_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // initialize 할 떄 이 라인이 있어야 오류 X TODO 왜 그런지 찾아보기
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}
