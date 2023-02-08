import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'home_user.dart';

void main() {
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
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeUser(),
          ),
        )
      },
    );
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
