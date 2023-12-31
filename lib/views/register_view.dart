import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants/routes.dart';
import 'package:untitled/utilities/showErrorDialog.dart';

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
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                    }
                    on FirebaseAuthException catch (e){
                      if(e.code == 'weak-password'){
                        await showErrorDialog(context, "weak password");
                      }
                      else if (e.code == 'email-already-in-use'){
                        await showErrorDialog(context, 'Email already in use');
                      }
                      else if(e.code == 'invalid-email'){
                        await showErrorDialog(context, "This is an invalid email address");
                      }
                      else{
                        await showErrorDialog(context, "FireBaseAuthError ${e.code}");
                      }
                    }
                    catch(e){
                      await showErrorDialog(context, e.toString());
                    }
                  }, child: const Text('Register')),
                  TextButton(onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                            (route) => false
                    );
                  }, child: const Text("Already registered? Login here"))
                ]);
              default:
                return const Text("Loading......");
            }

          }
      ),

    );
  }
}
