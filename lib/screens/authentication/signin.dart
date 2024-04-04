import 'package:flutter/material.dart';
import 'package:xpenso/screens/authentication/siginup.dart';
import 'package:xpenso/screens/forgotpassword.dart';
import 'package:xpenso/services/authenticate.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscured = true;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final Authenticate _auth = Authenticate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/3.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Image.asset('assets/images/Xpenso.png', height: 220),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
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
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.length < 4) {
                                    return 'Password must contain more than 4 characters';
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
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Forgot(),
                                      ));
                                },
                                child: const Text(
                                  "forgot password?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _auth.SigninwithEmail(
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
                          const SizedBox(height: 20),
                          const Text(
                            "New user?",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signup()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60),
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
