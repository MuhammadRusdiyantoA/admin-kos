import 'package:admin_kos/room_detail.dart';
import 'package:admin_kos/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashAdmin extends StatefulWidget {
  const DashAdmin({super.key});

  @override
  _DashAdmin createState() => _DashAdmin();
}

class _DashAdmin extends State<DashAdmin> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.175,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(24),
            color: Colors.indigo,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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

                        return Text(
                          'Halo, ${data["username"]}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
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
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 24,
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
                  ['5x4 meter', 'Termasuk Listrik', 'Termasuk Katering'],
                  [
                    'KM. dalam',
                    'Kloset duduk',
                    'Shower',
                    'Air Hangat',
                  ],
                  roomOwner: "Finna Nasywa",
                  isAdmin: true,
                  invoice: 150000,
                ),
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
                  roomOwner: "Nizar Ali",
                  isAdmin: true,
                  invoice: 0,
                ),
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
                  isAdmin: true,
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
                  ['KM. dalam', 'Kloset duduk', 'Ember mandi', 'Gayung mandi'],
                  roomOwner: "Naswa Bila",
                  isAdmin: true,
                  invoice: 50000,
                ),
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
                  isAdmin: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
