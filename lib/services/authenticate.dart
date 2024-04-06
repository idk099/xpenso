import "package:firebase_auth/firebase_auth.dart";

import "package:get/get.dart";
import "package:flutter/material.dart";

import 'package:xpenso/screens/authentication/signin.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Future SigninwithEmail(
      {required context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'USER NOT FOUND',
          "Tap on \"sigin\" to register",
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      } else if (e.code == 'wrong-password') {
        
        Get.snackbar('Password incorrect', "You can reset your password",
            colorText: Colors.white, duration: const Duration(seconds: 1));
      } else {
        Get.snackbar('SOMETHING WENT WRONG', 'Try again',
            colorText: Colors.white, duration: const Duration(seconds: 1));
      }
    }
  }

  Future signupwithEmail(
      {required context,
      required String email,
      required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);

      print("signed up");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('EMAIL ALREADY IN USE', "Try again using new email id",
            colorText: Colors.white, duration: const Duration(seconds: 2));
      } else if (e.code == 'invalid-email') {
        Get.snackbar('INVALID EMAIL', "Check your email",
            colorText: Colors.white, duration: const Duration(seconds: 2));
      } else if (e.code == 'weak-password') {
        Get.snackbar('WEAK PASSWORD', "Choose Another password",
            colorText: Colors.white, duration: const Duration(seconds: 2));
      } else {
        Get.snackbar('SOMETHING WENT WRONG', 'Try again',
            colorText: Colors.white, duration: const Duration(seconds: 2));
      }
    }
  }

  Future siginOut() async {
    await _auth.signOut();
  }

  Future passwordReset({required context, required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        title: "PASSWORD RESET LINK SENT",
        content: const Text(
          "Check your inbox",
          style: TextStyle(fontSize: 20),
        ),
        titlePadding:
            const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
        cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text(
            "SIGN IN",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Signin()));
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          title: "Email Id not registered",
          barrierDismissible: false,
          content: const Icon(
            Icons.close,
            size: 30,
            color: Colors.red,
          ),
          titlePadding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
          cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text("CANCEL", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      } else {
        Get.defaultDialog(
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          barrierDismissible: false,
          title: "SOMETHING WENT WRONG",
          content: const Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
          ),
          titlePadding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
          cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text("CANCEL", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    }
  }
}
