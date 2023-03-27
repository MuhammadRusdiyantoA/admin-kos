import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';
import 'login.dart';

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height:
                    65.toVHLength.toPX(screenSize: MediaQuery.of(context).size),
                width: 100
                    .toVWLength
                    .toPX(screenSize: MediaQuery.of(context).size),
                child: PageView(
                  children: [
                    Image.asset(
                      'assets/images/kamar_1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/kamar_2.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/kamar_3.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Manage kost dengan mudah hanya dengan satu aplikasi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 3.5
                              .toVHLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Dengan menggunakan Kosinajaah anda bisa menanajemen kost anda dengan sepenuhnya.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 2.35
                              .toVHLength
                              .toPX(screenSize: MediaQuery.of(context).size),
                          color: Colors.black45,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height:
                    7.toVHLength.toPX(screenSize: MediaQuery.of(context).size),
                width:
                    80.toVWLength.toPX(screenSize: MediaQuery.of(context).size),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.indigo[800]),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    ),
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
