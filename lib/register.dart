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
  bool? check = false;
  bool show1 = false;
  bool show2 = false;

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
                          child: const TextField(
                            decoration: InputDecoration(
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeUser(),
                                ),
                              )
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
