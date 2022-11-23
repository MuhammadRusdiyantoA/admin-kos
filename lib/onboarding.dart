import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';
import 'login.dart';

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _Onboard(),
      ),
    );
  }
}

class _Onboard extends StatelessWidget {
  const _Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    const onbHeight = Length(60, unit: LengthUnit.vh);
    const onbWidth = Length(100, unit: LengthUnit.vw);

    double onbHeightPX =
        onbHeight.toPX(constraint: 100, screenSize: screenSize);
    double onbWidthPX = onbWidth.toPX(constraint: 100, screenSize: screenSize);

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                      'Manage kost dengan mudah hanya dengan satu aplikasi.'),
                  const Text('lorem ipsum'),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.indigo)),
                    child: const Text('Get Started'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
