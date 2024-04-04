import 'package:flutter/material.dart';

import 'package:xpenso/services/authenticate.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final Authenticate _auth = Authenticate();
final TextEditingController _emailcontroller = TextEditingController();
final TextEditingController _passwordcontroller = TextEditingController();
String? val;

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscured = true;
  bool _isObscured2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.green, Colors.amber])),
          child: Column(
            children: [
              Image.asset('assets/images/Xpenso.png', height: 220),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                      )),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          const Text(
                            "CREATE ACCOUNT",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                                controller: _emailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please a enter email';
                                  }
                                  final emailRegx = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegx.hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.email),
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                                controller: _passwordcontroller,
                                validator: (value) {
                                  val = value;
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.length < 4) {
                                    return 'Password must contain more than 4 characters';
                                  }
                                  return null;
                                },
                                obscureText: _isObscured2,
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isObscured2 = !_isObscured2;
                                          });
                                        },
                                        icon: Icon(_isObscured2
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                                validator: (value) {
                                  if (val!.isNotEmpty && value!.isEmpty) {
                                    return 'Please confirm password';
                                  }
                                  if (val != value) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                obscureText: _isObscured,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isObscured = !_isObscured;
                                          });
                                        },
                                        icon: Icon(_isObscured
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _auth.signupwithEmail(
                                      context: context,
                                      email:
                                          _emailcontroller.text.toLowerCase(),
                                      password: _passwordcontroller.text);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 80),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
