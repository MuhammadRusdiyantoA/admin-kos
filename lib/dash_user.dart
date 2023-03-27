import 'package:admin_kos/room_detail.dart';
import 'package:admin_kos/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashUser extends StatefulWidget {
  const DashUser({super.key});

  @override
  _DashUser createState() => _DashUser();
}

class _DashUser extends State<DashUser> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  bool visibility = false;

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
                    FittedBox(
                      child: StreamBuilder(
                        stream: db
                            .collection('users')
                            .doc(auth.currentUser?.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return Column(
                              children: [
                                Text(
                                  'Halo, ${data["username"]}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
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
                    children: const [
                      Room(
                          AssetImage('assets/images/kamar_2.jpg'),
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
                      Room(
                          AssetImage('assets/images/kamar_1.jpg'),
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
                      Room(
                        AssetImage('assets/images/kamar_3.jpg'),
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
                      Room(
                          AssetImage('assets/images/kamar_2.jpg'),
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
                      Room(
                        AssetImage('assets/images/kamar_3.jpg'),
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
