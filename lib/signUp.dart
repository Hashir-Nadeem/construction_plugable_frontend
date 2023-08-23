import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loginform/RemoteService.dart';
import 'package:loginform/logIn.dart';
import 'package:loginform/verification.dart';
import 'package:getwidget/getwidget.dart';

import 'Models/policy.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUp();
}

class _signUp extends State<signUp> {
  final _formkey = GlobalKey<FormState>();
  Policy? policyBody = null;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool agree = false;
  void _trySubmit() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      var response = await remoteService.signUp(
          firstname.text, lastname.text, email.text, password.text);
      if (response != "") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => verification(response)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("SignUp Failed"),
        ));
      }
    }
  }

  Future<void> getPolicy() async {
    policyBody = await remoteService.policy();
  }

  Widget _buildPrivacyPopupDialog(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Html(
              data: policyBody?.newTerms,
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'SignUp',
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
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp2wwyNWvYcxh9sRy_1-B7iFPXCccDyIBou82XDjeYAeDXmCKWb2Etj1qZg2t82U4igWs&usqp=CAU',
                            ),
                          )),
                      SizedBox(
                        height: 68,
                      ),
                      TextFormField(
                        controller: firstname,
                        key: ValueKey('FirstName'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            label: Text("First Name")),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: lastname,
                        key: ValueKey('LastName'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Last name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            label: Text("Last Name")),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        key: ValueKey('Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            label: Text("Email Address")),
                      ),
                      SizedBox(
                        height: 15,
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
                      Row(
                        children: [
                          Material(
                            child: Checkbox(
                              value: agree,
                              onChanged: (value) {
                                setState(() {
                                  agree = value ?? false;
                                });
                              },
                            ),
                          ),
                          MaterialButton(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () async => {
                              if (policyBody == null) {await getPolicy()},
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPrivacyPopupDialog(context),
                              )
                            },
                            child: Text('Terms and conditions'),
                          ),
                        ],
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: agree
                            ? _trySubmit
                            : () => {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Must Agree To Terms And Conditons"),
                                  ))
                                },
                        child: Text('SignUp',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthForm()));
                        },
                        child: Text('Already Have An Account'),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
