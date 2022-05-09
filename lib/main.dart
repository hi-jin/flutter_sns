import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns/firebase_options.dart';
import 'package:flutter_sns/ui/home/main_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  // initialize 할 떄 이 라인이 있어야 오류 X TODO 왜 그런지 찾아보기
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.teal
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black
        ),
      ),
      home: MainView(),
    );
  }
}
