import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/firebase_options.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   // Initialize Firebase

  runApp(const MyApp());
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('HomePage')),
        body: FutureBuilder(

          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                showToast('You are a verified user');
              }
              else{
                showToast('You need to verify your email!');
              }
              return const Text('Done');
            }
          },
        ),
      ),
    );
  }
}
