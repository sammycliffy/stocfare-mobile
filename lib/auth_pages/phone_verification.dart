import 'package:flutter/material.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerification createState() => _PhoneVerification();
}

class _PhoneVerification extends State<PhoneVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset('assets/images/logo.png',
                    width: 40, height: 40)),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Phone Verification',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text('Enter the 6 digit that was sent to your phone',
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        validator: (val) =>
                            val.length < 11 ? 'Emaill Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter digit number',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      onTap: () {}),
                  SizedBox(height: 120),
                ],
              ),
            )
          ],
        )));
  }
}
