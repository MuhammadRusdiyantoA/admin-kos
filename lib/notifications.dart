import 'package:admin_kos/notification_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPage();
}

class _NotifyPage extends State<NotifyPage> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  void setRead(String type, String content, String key) async {
    await db.collection('notifications').doc(key).update({"isRead": true});

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotifyDetail(type, content, key),
        ),
      );
    }
  }

  Widget notifyBuilder(String type, String content, Timestamp dateSent,
      bool isRead, String key) {
    late IconData notifyIcon;
    var screenSize = MediaQuery.of(context).size;

    if (type == "Pembayaran") {
      notifyIcon = Icons.monetization_on_outlined;
    } else if (type == "Booking") {
      notifyIcon = Icons.book_outlined;
    } else if (type == "Perbaikan") {
      notifyIcon = Icons.home_repair_service_outlined;
    } else if (type == "Tagihan") {
      notifyIcon = Icons.receipt_long_outlined;
    } else {
      notifyIcon = Icons.abc;
    }

    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        color: isRead ? Colors.black12 : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: TextButton(
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          ),
        ),
        onPressed: () {
          setRead(type, content, key);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                notifyIcon,
                color: Colors.indigo,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width - 128,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        timeago.format(dateSent.toDate()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width - 128,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Text(
                          content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(right: 16),
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        iconSize: 28,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Notifikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // notifyData.isNotEmpty
            //     ? Column(
            //         children: [
            //           for (var i = 0; i < notifyData.length; i++)
            //             StreamBuilder(
            //               stream: db
            //                   .collection('users')
            //                   .doc(notifyData[i]['from'])
            //                   .snapshots(),
            //               builder: (context, snapshot) {
            //                 if (snapshot.hasData) {
            //                   var data =
            //                       snapshot.data!.data() as Map<String, dynamic>;
            //                   String content = notifyData[i]['content'];
            //                   notifyData[i]['content'] = content.replaceFirst(
            //                       RegExp('%name%'), data['username']);

            //                   return notifyBuilder(
            //                       notifyData[i]['type'],
            //                       notifyData[i]['content'],
            //                       notifyData[i]['date_sent'],
            //                       notifyData[i]['isRead'],
            //                       notifyData[i]['key']);
            //                 }
            //                 return const CircularProgressIndicator();
            //               },
            //             ),
            //         ],
            //       )
            //     : Container(
            //         margin: const EdgeInsets.only(top: 16),
            //         child: const Text('Tidak ada notifikasi'),
            //       ),
            StreamBuilder(
              stream: db
                  .collection('notifications')
                  .orderBy('date_sent', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var notifyData = snapshot.data!.docs
                      .map((e) => e.data())
                      .where(
                          (element) => element['to'] == auth.currentUser!.uid)
                      .toList();

                  for (var i = 0; i < notifyData.length; i++) {
                    notifyData[i].addAll({"key": snapshot.data!.docs[i].id});
                  }

                  if (notifyData.isNotEmpty) {
                    return Column(
                      children: [
                        for (var i = 0; i < notifyData.length; i++)
                          StreamBuilder(
                            stream: db
                                .collection('users')
                                .doc(notifyData[i]['from'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                String content = notifyData[i]['content'];
                                notifyData[i]['content'] = content.replaceFirst(
                                    RegExp('%name%'), data['username']);

                                return notifyBuilder(
                                    notifyData[i]['type'],
                                    notifyData[i]['content'],
                                    notifyData[i]['date_sent'],
                                    notifyData[i]['isRead'],
                                    notifyData[i]['key']);
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                      ],
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: const Text('Tidak ada notifikasi'),
                    );
                  }
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
