import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:getwidget/shape/gf_badge_shape.dart';
import 'package:getwidget/size/gf_size.dart';

import 'package:loginform/Models/jobs.dart';
import 'package:loginform/Models/policy.dart';
import 'package:loginform/RemoteService.dart';
import 'package:loginform/jobs.dart';
import 'package:loginform/signUp.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Policy? policyBody = null;
  void _trySubmit() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      var employee_cred = await remoteService.login(email.text, password.text);
      if (employee_cred != null) {
        List<EmpJobs>? empJobs =
            await remoteService.jobs(employee_cred.uniqueId);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => jobs(employee_cred, empJobs)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid User"),
        ));
      }
    }
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
              data: policyBody?.newPolicy,
            ),
          ))
        ],
      ),
    );
  }

  Future<void> getPolicy() async {
    policyBody = await remoteService.policy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Login',
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
                            label: Text("Email Address")),
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
                        onPressed: _trySubmit,
                        child: Text('Login',
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
                                  builder: (context) => signUp()));
                        },
                        child: Text('Create an account'),
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
                        child: Text('Privacy Policy'),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
