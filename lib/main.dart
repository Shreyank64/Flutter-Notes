import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/views/login_view.dart';
import 'package:untitled/views/register_view.dart';

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
  '/login/': (context) => const LoginView(),
  '/register/' : (context) => const RegisterView(),
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
          // final user = FirebaseAuth.instance.currentUser;
          //if (user?.emailVerified ?? false) {
          //showToast('You are a verified user');

          //}
          //else{
          //showToast('You need to verify your email!');
          //return const VerifyEmailView();
          //}
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}





