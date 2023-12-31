

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/constants/routes.dart';

import 'package:untitled/views/NotesView.dart';
import 'package:untitled/views/VerifyEmailView.dart';
import 'package:untitled/views/login_view.dart';
import 'package:untitled/views/register_view.dart';

import 'firebase_options.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   // Initialize Firebase
   runApp(MaterialApp(
   title: 'Flutter Demo',
   theme: ThemeData(
   primarySwatch: Colors.blue,
   ),
  home: const HomePage(),
  routes: {
  loginRoute: (context) => const LoginView(),
   registerRoute : (context) => const RegisterView(),
       notesRoute:  (context) => const NotesView(),
    verifyEmailRoute: (context) => const VerifyEmailView(),
  },
  ));
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
          final user = FirebaseAuth.instance.currentUser;
          if(user != null){
            if(user.emailVerified){
              return const NotesView();
            }
            else{
              return const VerifyEmailView();
            }

          }
          else{
            return const LoginView();
          }
          //if (user?.emailVerified ?? false) {
          //showToast('You are a verified user');

          //}
          //else{
          //showToast('You need to verify your email!');
          //return const VerifyEmailView();
          //}
            //return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
enum MenuAction{ logout }

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}





