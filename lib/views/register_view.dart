import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import '../main.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
      appBar: AppBar(title: const Text('Register')),

      body: FutureBuilder(
          future:  Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context,snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(children: [
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
                    try {
                      final UserCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      print(UserCredential);
                    }
                    on FirebaseAuthException catch (e){
                      if(e.code == 'weak-password'){
                        showToast('Weak password');
                      }
                      else if (e.code == 'email-already-in-use'){
                        showToast('Email already in use');
                      }
                    }
                  }, child: const Text('Register'))]);
              default:
                return const Text("Loading......");
            }

          }
      ),

    );
  }
}