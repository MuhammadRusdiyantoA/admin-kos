import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotifyDetail extends StatefulWidget {
  final String type;
  final String content;
  final String notifyKey;

  const NotifyDetail(this.type, this.content, this.notifyKey, {super.key});

  @override
  State<NotifyDetail> createState() => _NotifyDetail();
}

class _NotifyDetail extends State<NotifyDetail> {
  var db = FirebaseFirestore.instance;

  void deleteNotify() async {
    try {
      await db.collection('notifications').doc(widget.notifyKey).delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kebijakan berhasil dihapus!'),
            backgroundColor: Colors.indigo,
          ),
        );

        Navigator.pop(context);

        Navigator.pop(context);
      }
    } catch (exception) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Something went wrong! $exception'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        widget.type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                const Text('Yakin ingin menghapus notifikasi?'),
                            actions: [
                              TextButton(
                                style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteNotify();
                                },
                                child: const Text('Yakin'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  )
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Flexible(
                    child: Text(widget.content),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
