import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loginform/RemoteService.dart';
import 'package:loginform/welcome.dart';
import 'package:path_provider/path_provider.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  late Box box;
  TextEditingController email = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController password = TextEditingController();
  void _trySubmit() async {
    //verify the configuration form here then pass to put data
    var valid =
        await remoteService.validConfig(email.text, url.text, password.text);
    if (valid == true) {
      putData();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Invalid Configuration"),
    ));
  }

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("data");
    return;
  }

  Future putData() async {
    await openBox();
    await box.clear();
    box.add(email.text);
    box.add(url.text);
    box.add(password.text);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Configuration',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(25),
              child: Form(
                  //key: _formkey,
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 68,
                  ),
                  TextFormField(
                    controller: email,
                    key: ValueKey('Email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        label: Text("Email")),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: url,
                    key: ValueKey('Url'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('https://')) {
                        return 'Please enter a valid url';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        label: Text("Url")),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: password,
                    key: ValueKey('Password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password atleast 7 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        label: Text("Password")),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async => {_trySubmit()},
                    child: Text('Set', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
            ),
          ),
        ));
  }
}
