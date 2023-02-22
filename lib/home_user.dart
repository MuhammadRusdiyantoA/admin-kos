import 'package:admin_kos/login.dart';
import 'package:admin_kos/edit_password.dart';
import 'package:admin_kos/edit_profile.dart';
import 'package:admin_kos/help.dart';
import 'package:admin_kos/room_detail.dart';
import 'package:flutter/material.dart';

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

  Widget room(AssetImage roomImg, String type, int roomNum, String roomStat,
      List<String> facilities, List<String> roomSpec, List<String> bathSpec,
      {String roomOwner = "Kosong"}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: TextButton(
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.black),
          minimumSize: MaterialStatePropertyAll(Size.zero),
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetail(
                roomImg,
                roomNum,
                roomStat,
                roomOwner,
                facilities,
                roomSpec,
                bathSpec,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(6),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: roomImg,
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      color: type == 'Premium' ? Colors.amber : Colors.green,
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nomor Kamar : "),
                      Text(
                        "Kamar $roomNum",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status : '),
                      Text(
                        roomStat,
                        style: TextStyle(
                          color:
                              roomStat == 'Terisi' ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.075,
                  vertical: 32,
                ),
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const FittedBox(
                      child: Text(
                        'Halo, Muhammad Sumbul bin Abdul Jalil!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
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
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.notifications,
                    //     color: Colors.white,
                    //   ),
                    // ),

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
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kamarmu',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextButton(
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomDetail(
                          AssetImage('assets/images/kamar_1.jpg'),
                          16,
                          'Terisi',
                          'Muhammad Sumbul bin Abdul Jalil',
                          [
                            'TV',
                            'Lemari',
                            'Kursi',
                            'Kasur',
                            'AC',
                            'Meja Belajar'
                          ],
                          [
                            '5 x 4 Meter',
                            'Termasuk Listrik',
                          ],
                          [
                            'KM. dalam',
                            'Kloset duduk',
                            'Ember mandi',
                            'Gayung mandi'
                          ],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(6),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/kamar_1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(64),
                                color: Colors.amber,
                              ),
                              child: const Text(
                                'Premium',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Nomor Kamar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                  ),
                                ),
                                Text(
                                  'Kamar 16',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  'Tipe Kamar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                  ),
                                ),
                                Text(
                                  'Premium',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Kamar Lainnya',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text('X Jenis Kamar')
                    ],
                  ),
                ),
                Flexible(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 24,
                    crossAxisCount: 2,
                    children: [
                      room(
                          const AssetImage('assets/images/kamar_2.jpg'),
                          "Premium",
                          1,
                          "Terisi",
                          [
                            'Kasur',
                            'Lemari',
                            'Meja Belajar',
                            'Kursi',
                            'AC',
                            'TV',
                            'Bantal',
                            'Guling'
                          ],
                          [
                            '5x4 meter',
                            'Termasuk Listrik',
                            'Termasuk Katering'
                          ],
                          [
                            'KM. dalam',
                            'Kloset duduk',
                            'Shower',
                            'Air Hangat',
                          ],
                          roomOwner: "Finna Nasywa"),
                      room(
                          const AssetImage('assets/images/kamar_1.jpg'),
                          "Premium",
                          2,
                          "Terisi",
                          [
                            'Kasur',
                            'Lemari',
                            'Meja Belajar',
                            'Kursi',
                            'AC',
                            'TV',
                            'Bantal',
                            'Guling'
                          ],
                          [
                            '6x4 meter',
                            'Termasuk Listrik',
                            'Termasuk Laundry',
                          ],
                          [
                            'KM. dalam',
                            'Kloset duduk',
                            'Shower',
                          ],
                          roomOwner: "Nizar Ali"),
                      room(
                        const AssetImage('assets/images/kamar_3.jpg'),
                        "Standar",
                        3,
                        "Kosong",
                        [
                          'Kasur',
                          'Lemari',
                          'Meja Belajar',
                          'Kursi',
                          'Bantal',
                          'Guling'
                        ],
                        [
                          '4x3 meter',
                          'Termasuk Listrik',
                        ],
                        [
                          'KM. dalam',
                          'Kloset jongkok',
                          'Ember mandi',
                          'Gayung mandi'
                        ],
                      ),
                      room(
                          const AssetImage('assets/images/kamar_2.jpg'),
                          "Standar",
                          4,
                          "Terisi",
                          [
                            'Kasur',
                            'Lemari',
                            'Meja Belajar',
                            'Kursi',
                            'Bantal',
                            'Guling'
                          ],
                          [
                            '4x3 meter',
                            'Termasuk Listrik',
                            'Termasuk Laundry',
                          ],
                          [
                            'KM. dalam',
                            'Kloset duduk',
                            'Ember mandi',
                            'Gayung mandi'
                          ],
                          roomOwner: "Naswa Bila"),
                      room(
                        const AssetImage('assets/images/kamar_3.jpg'),
                        "Standar",
                        5,
                        "Kosong",
                        [
                          'Kasur',
                          'Lemari',
                          'Meja Belajar',
                          'Kursi',
                          'Bantal',
                          'Guling'
                        ],
                        [
                          '4x3 meter',
                          'Termasuk Listrik',
                        ],
                        [
                          'KM. dalam',
                          'Kloset jongkok',
                          'Ember mandi',
                          'Gayung mandi'
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class About extends StatefulWidget {
  const About({super.key});

  @override
  _About createState() => _About();
}

class _About extends State<About> {
  String about =
      "Kos 'Mboke' mulai beroperasi sejak tahun 20xx dan sampai sekarang bla bla bla";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Sejarah',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(about),
              ],
            ),
          )
        ],
      ),
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
    return SingleChildScrollView(
      child: Column(
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
                      Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.065),
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
                      Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.065),
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
                      Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.065),
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
                        builder: (context) => const Help(),
                      ),
                    );
                  },
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
                      Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.065),
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Yakin ingin keluar?'),
                            actions: [
                              TextButton(
                                style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Tidak sekarang'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                },
                                child: const Text('Yakin'),
                              ),
                            ],
                          );
                        });
                  },
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
      ),
    );
  }
}
