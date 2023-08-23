import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginform/Global.dart';
import 'package:loginform/Models/Configuration.dart';
import 'package:loginform/logIn.dart';
import 'package:loginform/signUp.dart';
import 'package:path_provider/path_provider.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late Box box;
  List data = [];

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("data");
    return;
  }

  void getData() async {
    await openBox();
    data = box.toMap().values.toList();
    if (data.isEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Config()),
      );
    } else {
      globalData.setUrl(data[0], data[1], data[2]);
    }
  }

  void _trySignUp() async {
    if (globalData.url == "") {
      getData();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => signUp()),
      );
    }
  }

  void _tryLogin() async {
    if (globalData.url == "") {
      getData();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AuthForm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xfff7f6fb),
            body: Card(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Column(
                    children: [
                      Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            //replace the link from database or assest folder path
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1601158935942-52255782d322?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=872&q=80',
                            ),
                          )),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Let's get started",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Never a better time than now to start.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _trySignUp,
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _tryLogin,
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
