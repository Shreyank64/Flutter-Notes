import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/constants/routes.dart';

import '../utilities/showErrorDialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: const Text('Login'),
      ),
      body: Column(children: [
        TextField(
          controller:_email,
          decoration: const InputDecoration(
              hintText: 'Enter your email here'

          ),
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller:_password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
              hintText: 'Enter your password'
          ),
        ),
        TextButton(onPressed: () async{

          final email = _email.text;
          final password = _password.text;
          try{
            log("Entered the segment");
            final user = FirebaseAuth.instance.currentUser;
            if(user?.emailVerified ?? false){
              // if email is verified
              Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                      (route ) => false
              );
            }
            else{
              // if email is not verified
              Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute,
                    (route) => false,
              );

            }

          }
          on FirebaseAuthException catch(e){
            if (e.code == 'user-not-found'){
              await showErrorDialog(context, 'User not found');
            }
            else if (e.code == 'wrong-password'){
              await showErrorDialog(context, 'Wrong password!');
            }
            else{
              await showErrorDialog(context, 'Unknown Error, code : ${e.code}');
            }
          }
        }, child: const Text('Login')),
         TextButton(onPressed: () {
           Navigator.of(context).pushNamedAndRemoveUntil(
           registerRoute,
                   (route) => false);

        },
            child: const Text('Not registered yet? register here!') )
      ]),
    );
  }

}


