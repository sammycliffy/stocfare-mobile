import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
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
              child:
                  Image.asset('assets/images/logo.png', width: 40, height: 40)),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
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
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                      obscureText: true,
                      validator: (val) =>
                          val.length < 11 ? 'Enter Digit number' : null,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        filled: true,
                        border: InputBorder.none,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                      obscureText: true,
                      validator: (val) =>
                          val.length < 11 ? 'Emaill Address or Phone' : null,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        filled: true,
                        border: InputBorder.none,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
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
                          'Update',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    onTap: () {}),
                SizedBox(height: 120),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: Text(
                        'Back to',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: InkWell(
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
