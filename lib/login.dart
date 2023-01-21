import 'package:admin_kos/register.dart';
import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';
import 'home_user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  _Login createState() => _Login();
}

class _Login extends State<Login> {
  bool? check = false;
  bool show = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                                  "Selamat Datang Kembali!",
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
                            obscureText: !show,
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
                                  icon: Icon(show
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      show = !show;
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
                              TextButton(
                                onPressed: () {
                                  const AlertDialog(
                                    alignment: Alignment.center,
                                    content: Text('LOL, Sucx to be you!'),
                                  );
                                },
                                child: const Text(
                                  'Lupa kata sandi?',
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
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
                              'Login',
                            ),
                            onPressed: () => {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Fields cannot be empty'),
                                      backgroundColor: Colors.indigo,
                                    ),
                                  ),
                                }
                              else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text))
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please insert a valid email.'),
                                      backgroundColor: Colors.indigo,
                                    ),
                                  ),
                                }
                              else
                                {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeUser(),
                                    ),
                                  )
                                }
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
                  const Text('Belum punya akun?'),
                  TextButton(
                    child: const Text('Registerasi'),
                    onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
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
