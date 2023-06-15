import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text ("VerifyEmail")
    ),

      body: Column(
          children: [
            const Text("We've sent you a verification email, please check your email account"),
            const Text("If you haven't received an email, press the button below"),
            TextButton(onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              user?.sendEmailVerification();

            }, child: const Text("Send email verification")),
            TextButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
                      (route) => false,
              );
            }, child: const Text('Restart')),
          ]
      ),
    );
  }
}