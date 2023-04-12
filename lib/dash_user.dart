import 'package:admin_kos/notifications.dart';
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
  bool roomlessUser = false;

  String getBy = "";

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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: StreamBuilder(
                            stream: db
                                .collection('users')
                                .doc(auth.currentUser?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.data()
                                    as Map<String, dynamic>;

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
                        // Row(
                        //   children: const [
                        //     Icon(
                        //       Icons.location_on,
                        //       color: Colors.white54,
                        //     ),
                        //     Text(
                        //       'Surakarta, Indonesia',
                        //       style: TextStyle(
                        //         color: Colors.white54,
                        //         fontSize: 16,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        StreamBuilder(
                          stream: db
                              .collection('notifications')
                              .orderBy('date_sent', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var notifyAmount = snapshot.data!.docs
                                  .map((e) => e.data())
                                  .where((element) =>
                                      element['to'] == auth.currentUser!.uid)
                                  .where(
                                      (element) => element['isRead'] == false)
                                  .toList()
                                  .length;

                              if (notifyAmount > 0) {
                                return Stack(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NotifyPage(),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          notifyAmount.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Stack(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NotifyPage(),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                            return Stack(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotifyPage(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        )
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
                          StreamBuilder(
                            stream: db
                                .collection('rooms')
                                .where('owner',
                                    isEqualTo: auth.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.docs
                                    .map((e) => e.data())
                                    .toList();

                                if (data.isEmpty) {
                                  return Text(
                                    visibility ? 'Rp. 0' : 'Rp. 0',
                                    style: TextStyle(
                                      color: visibility
                                          ? Colors.white
                                          : Colors.white38,
                                      fontSize: 24,
                                    ),
                                  );
                                }

                                return Text(
                                  visibility
                                      ? 'Rp. ${data[0]["invoice"]}'
                                      : 'Rp. 0',
                                  style: TextStyle(
                                    color: visibility
                                        ? Colors.white
                                        : Colors.white38,
                                    fontSize: 24,
                                  ),
                                );
                              }
                              return const Text(
                                'Mohon tunggu...',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 24,
                                ),
                              );
                            },
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
            margin: const EdgeInsets.only(top: 24, right: 16, left: 16),
            child: StreamBuilder(
              stream: db
                  .collection('rooms')
                  .where("owner", isEqualTo: auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs.map((e) => e.data()).toList();

                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        "Kamu belum punya kamar, pilih kamarmu sekarang juga!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }

                  for (int i = 0; i < data.length; i++) {
                    data[i].addAll({"key": snapshot.data!.docs[i].id});
                  }

                  return Column(
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
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomDetail(
                                AssetImage(data[0]['image']),
                                data[0]['room_num'],
                                data[0]['status'],
                                data[0]['owner'],
                                data[0]['facilities'],
                                data[0]['specifications'],
                                data[0]['bath_spec'],
                                invoice: data[0]['invoice'],
                                roomKey: data[0]['key'],
                                type: data[0]['type'],
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
                                image: DecorationImage(
                                  image: AssetImage(data[0]['image']),
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
                                      color: data[0]['type'] == "Premium"
                                          ? Colors.amber
                                          : Colors.green,
                                    ),
                                    child: Text(
                                      data[0]['type'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Nomor Kamar',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      Text(
                                        'Kamar ${data[0]["room_num"]}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Tipe Kamar',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      Text(
                                        data[0]['type'],
                                        style: const TextStyle(
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
                  );
                }
                return const CircularProgressIndicator();
              },
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
                    children: [
                      Text(
                        roomlessUser ? 'Pilih Kamarmu' : 'Kamar Lainnya',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      DropdownButton(
                        value: getBy,
                        items: const [
                          DropdownMenuItem(
                            value: "",
                            child: Text("Jenis kamar"),
                          ),
                          DropdownMenuItem(
                            value: "Standar",
                            child: Text("Standar"),
                          ),
                          DropdownMenuItem(
                            value: "Premium",
                            child: Text("Premium"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            getBy = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: getBy.isEmpty
                      ? db.collection('rooms').snapshots()
                      : db
                          .collection('rooms')
                          .orderBy('type',
                              descending: getBy == "Premium" ? false : true)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var currentUserId = auth.currentUser!.uid;
                      var data = snapshot.data!.docs
                          .map((e) => e.data())
                          .toList()
                          .where((element) => element['owner'] != currentUserId)
                          .toList();

                      if (data.isEmpty) {
                        return Row();
                      }

                      for (int i = 0; i < data.length; i++) {
                        data[i].addAll({"key": snapshot.data!.docs[i].id});
                      }

                      return GridView.count(
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
                              invoice: data[i]['invoice'],
                              roomOwner: data[i]['owner'],
                              roomKey: data[i]['key'],
                            )
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
