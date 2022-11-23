import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';
import 'login.dart';
import 'home_user.dart';
import 'home_admin.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    height: 10
                        .toVHLength
                        .toPX(screenSize: MediaQuery.of(context).size),
                    width: 100
                        .toVWLength
                        .toPX(screenSize: MediaQuery.of(context).size),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Daftarkan akunmu dulu ya!'),
                          Text('Silahkan daftar dan nikmati fiturnya'),
                        ],
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
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi Password',
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
                      child: const Text('Register'),
                      onPressed: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeUser(),
                          ),
                        )
                      },
                    ),
                  )
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
