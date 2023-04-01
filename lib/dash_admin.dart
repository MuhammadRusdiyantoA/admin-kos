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
          StreamBuilder(
            stream: db.collection('rooms').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs.map((e) => e.data()).toList();

                for (int i = 0; i < data.length; i++) {
                  data[i].addAll({"key": snapshot.data!.docs[i].id});
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    crossAxisCount: 2,
                    children: [
                      for (var i = 0; i < data.length; i++)
                        Room(
                          AssetImage(data[i]['image']),
                          data[i]['type'],
                          data[i]['room_num'],
                          data[i]['status'],
                          data[i]['facilities'],
                          data[i]['specifications'],
                          data[i]['bath_spec'],
                          isAdmin: true,
                          invoice: data[i]['invoice'],
                          roomOwner: data[i]['owner'],
                          roomKey: data[i]['key'],
                        )
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
