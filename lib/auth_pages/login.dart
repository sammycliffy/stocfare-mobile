import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/auth_pages/signup.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
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
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text('Secure login to your stockfare app',
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        validator: (val) =>
                            val.length < 11 ? 'Email Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Email Address or Phone',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        obscureText: true,
                        validator: (val) =>
                            val.length < 11 ? 'Emaill Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: InkWell(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                      )),
                  SizedBox(
                    height: 100,
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
                            'Login',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: Login()));
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to Stockfare?',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
