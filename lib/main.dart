import 'dart:async';
import 'package:admin_kos/home_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'onboarding.dart';
import 'home_user.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: 'admin.kostapp@gmail.com', password: 'kostapp1');
  // FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser?.uid)
  //     .set({
  //   'username': 'Administrator',
  //   'address': 'none',
  //   'phone': 0,
  //   'NIK': 0,
  //   'role': 'admin'
  // });
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  late Widget page;
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  void isLoggedIn() async {
    var user = auth.currentUser;

    if (auth.currentUser != null) {
      var userData = await db
          .collection('users')
          .doc(user?.uid)
          .get()
          .then((value) => value.data() as Map<String, dynamic>);

      if (userData['role'] == 'admin') {
        page = const HomeAdmin();
      } else {
        page = const HomeUser();
      }
    } else {
      page = const Onboard();
    }

    Timer(
      const Duration(seconds: 3),
      () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        )
      },
    );
  }

  @override
  void initState() {
    super.initState();

    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/icons/Logo.png'),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Kosinajaah',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
