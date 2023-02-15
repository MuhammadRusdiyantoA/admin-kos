import 'package:admin_kos/edit_password.dart';
import 'package:admin_kos/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:dimension/dimension.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  _HomeUser createState() => _HomeUser();
}

class _HomeUser extends State<HomeUser> {
  int index = 0;

  List<Widget> pages = [const Home(), const About(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Tentang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.indigo,
        currentIndex: index,
        onTap: (int value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: pages.elementAt(index),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height:
                  30.toVHLength.toPX(screenSize: MediaQuery.of(context).size),
              width:
                  100.toVWLength.toPX(screenSize: MediaQuery.of(context).size),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.075),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Halo, Finna Nasywa!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white54,
                                ),
                                Text(
                                  'Surakarta, Indonesia',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.only(top: 24),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white38,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            visibility ? 'Rp. 69.420' : 'Rp. 0',
                            style: TextStyle(
                              color: visibility ? Colors.white : Colors.white38,
                              fontSize: 24,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  width: 1,
                                  color: visibility
                                      ? Colors.transparent
                                      : Colors.white,
                                ),
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                visibility = !visibility;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      visibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    visibility
                                        ? 'Tutup tagihan'
                                        : 'Lihat tagihan',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const Text('Kamarmu')
      ],
    );
  }
}

class About extends StatefulWidget {
  const About({super.key});

  @override
  _About createState() => _About();
}

class _About extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          color: Colors.indigo,
          child: const Text(
            'Tentang Kos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const Text(
          'Sejarah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const Text('Lorem ipsum dolor sit amet,'),
      ],
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          color: Colors.indigo,
          child: const Text(
            'Profil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/dummyProfile.jpg'),
                radius: MediaQuery.of(context).size.width * 0.12,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              const Text(
                'Muhammad Sumbul bin Abdul Jalil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              const Text(
                'Penghuni Kos',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.325,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.075),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
                  ),
                  side: const MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  foregroundColor:
                      const MaterialStatePropertyAll(Colors.black54),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditForm(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.person_outline),
                        ),
                        Text('Edit profil'),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_outlined)
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
                  ),
                  side: const MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  foregroundColor:
                      const MaterialStatePropertyAll(Colors.black54),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditPw(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.lock_outline),
                        ),
                        Text('Ubah kata sandi'),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_outlined)
                  ],
                ),
              ),
              // TextButton(
              //   style: ButtonStyle(
              //     fixedSize: MaterialStatePropertyAll(
              //       Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
              //     ),
              //     side: const MaterialStatePropertyAll(
              //       BorderSide(
              //         color: Colors.black26,
              //         width: 1,
              //       ),
              //     ),
              //     shape: const MaterialStatePropertyAll(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(8),
              //         ),
              //       ),
              //     ),
              //     foregroundColor:
              //         const MaterialStatePropertyAll(Colors.black54),
              //   ),
              //   onPressed: () {},
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     children: const [
              //       Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 8),
              //         child: Icon(Icons.notifications_outlined),
              //       ),
              //       Text('Pengaturan notifikasi'),
              //     ],
              //   ),
              // ),
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
                  ),
                  side: const MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  foregroundColor:
                      const MaterialStatePropertyAll(Colors.black54),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.info_outline),
                        ),
                        Text('Pusat bantuan'),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_outlined)
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
                  ),
                  side: const MaterialStatePropertyAll(
                    BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  foregroundColor: const MaterialStatePropertyAll(Colors.red),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.exit_to_app),
                        ),
                        Text('Keluar'),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_outlined),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
