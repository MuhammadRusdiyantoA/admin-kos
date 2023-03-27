import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';
import 'login.dart';
import 'home_user.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Register> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  bool? check = false;
  bool show1 = false;
  bool show2 = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  void tryRegister() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

      await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = <String, dynamic>{
        'username': 'user${Random().nextInt(999999)}',
        'address': 'none',
        'phone': 0,
        'NIK': 0,
        'role': 'user'
      };

      db.collection('users').doc(auth.currentUser!.uid).set(user);
    } catch (exception) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Something went wrong! $exception'),
          );
        },
      );
    }

    if (auth.currentUser != null) {
      navigate();
    }
  }

  void navigate() {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeUser(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 25
                        .toVHLength
                        .toPX(screenSize: MediaQuery.of(context).size),
                    width: 100
                        .toVWLength
                        .toPX(screenSize: MediaQuery.of(context).size),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Daftar akunmu dulu ya!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  "Silahkan masuk dan nikmati fiturnya",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10
                              .toVHLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          width: 90
                              .toVWLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Icon(Icons.mail),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10
                              .toVHLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          width: 90
                              .toVWLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          child: TextField(
                            controller: passwordController,
                            obscureText: !show1,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Icon(Icons.lock),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: IconButton(
                                  icon: Icon(
                                    show1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      show1 = !show1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10
                              .toVHLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          width: 90
                              .toVWLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          child: TextField(
                            controller: confirmController,
                            obscureText: !show2,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Icon(Icons.lock_reset),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: IconButton(
                                  icon: Icon(
                                    show2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      show2 = !show2;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          width: MediaQuery.of(context).size.width * .9,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Checkbox(
                                    value: check,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        check = value;
                                      });
                                    },
                                  ),
                                  const Text('Ingat saya'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7
                              .toVHLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          width: 90
                              .toVWLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.indigo),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Register',
                            ),
                            onPressed: () => {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  confirmController.text.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Mohon isi semua kolom!'),
                                      backgroundColor: Colors.indigo,
                                    ),
                                  )
                                }
                              else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text))
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Mohon isi kolom dengan email yang valid!'),
                                      backgroundColor: Colors.indigo,
                                    ),
                                  )
                                }
                              else if (passwordController.text !=
                                  confirmController.text)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Kolom konfirmasi password tidak sesuai!'),
                                      backgroundColor: Colors.indigo,
                                    ),
                                  )
                                }
                              else
                                {tryRegister()}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Sudah punya akun?'),
                  TextButton(
                    child: const Text('Login'),
                    onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      )
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
