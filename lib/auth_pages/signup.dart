import 'package:flutter/material.dart';
import 'package:stockfare_mobile/auth_pages/registration_success.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
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
              height: 10,
            ),
            Center(
                child: Image.asset('assets/images/logo.png',
                    width: 40, height: 40)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Signup',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child:
                  Text('Signup to enjoy Stockfare inventory management system',
                      style: TextStyle(
                        fontSize: 12,
                      )),
            ),
            SizedBox(
              height: 22,
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
                          hintText: 'Business Name',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        obscureText: true,
                        validator: (val) =>
                            val.length < 11 ? 'Emaill Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Business Address',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        obscureText: true,
                        validator: (val) =>
                            val.length < 11 ? 'Emaill Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 16,
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
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        obscureText: true,
                        validator: (val) =>
                            val.length < 11 ? 'Emaill Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                        obscureText: true,
                        validator: (val) =>
                            val.length < 11 ? 'Emaill Address or Phone' : null,
                        decoration: InputDecoration(
                          hintText: 'Referral (Optional)',
                          filled: true,
                          border: InputBorder.none,
                        )),
                  ),
                  SizedBox(
                    height: 40,
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
                            'Signup',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuccessRegister()));
                      }),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: Text(
                          'Already registered?',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
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
      ),
    );
  }
}
