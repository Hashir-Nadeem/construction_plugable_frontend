import 'package:flutter/material.dart';
import 'package:loginform/Global.dart';
import 'package:loginform/Models/Configuration.dart';
import 'package:loginform/logIn.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'welcome.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(backgroundColor: Colors.blue, primarySwatch: Colors.blue),
        title: 'LoginForm',
        home: Scaffold(
          body: Welcome(),
        ));
  }
}
