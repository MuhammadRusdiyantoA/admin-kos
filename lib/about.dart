import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final bool isAdmin;

  const About({super.key, this.isAdmin = false});

  @override
  _About createState() => _About();
}

class _About extends State<About> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  TextEditingController controller = TextEditingController();

  void updateAbout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );

    db.collection('about').doc('kost').set({
      'content': controller.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('History updated successfully!'),
          backgroundColor: Colors.indigo,
        ),
      );
    }).catchError((error) {
      AlertDialog(
        content: Text('Something went wrong! $error'),
      );
    });
  }

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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Tentang Kos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                if (widget.isAdmin)
                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        updateAbout();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('About cannot be empty!'),
                            backgroundColor: Colors.indigo,
                          ),
                        );
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.transparent,
                      ),
                      shadowColor: MaterialStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
              ],
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
                StreamBuilder(
                    stream: db.collection('about').doc('kost').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        controller.text = data['content'];

                        if (widget.isAdmin) {
                          return TextField(
                            minLines: 21,
                            maxLines: 9999,
                            controller: controller,
                          );
                        } else {
                          return Text(controller.text);
                        }
                      }
                      return const CircularProgressIndicator();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
