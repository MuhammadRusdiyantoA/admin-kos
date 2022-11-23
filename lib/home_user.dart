import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Tentang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Profil',
          ),
        ],
      ),
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
                    12.toVHLength.toPX(screenSize: MediaQuery.of(context).size),
                width: 100
                    .toVWLength
                    .toPX(screenSize: MediaQuery.of(context).size),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: const [
                              Text('Halo, Jingan!'),
                              Text('Jawa Tengah, Indonesia')
                            ],
                          ),
                          const Text('X Notif'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text('Rp. 69.420'),
                          Text('X Tagihan'),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
