// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:loginform/RemoteService.dart';
import 'package:loginform/welcome.dart';

class verification extends StatefulWidget {
  String id;
  verification(
    this.id,
  ) {
    id = id;
  }
  @override
  // ignore: no_logic_in_create_state
  State<verification> createState() => _verification(id);
}

class _verification extends State<verification> {
  late String id;
  _verification(String id) {
    this.id = id;
  }
  final _formkey = GlobalKey<FormState>();
  TextEditingController otp = TextEditingController();

  final bool autoFocus = true;

  void _trySubmit() async {
    var status = await remoteService.verification(id, otp.text);
    if (status == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    }
  }

  void _resentCode() async {
    var status = await remoteService.resentCode(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: otp,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _trySubmit,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              MaterialButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: _resentCode,
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
