import 'package:admin_kos/form_help.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  _Help createState() => _Help();
}

class _Help extends State<Help> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  late List<bool> isOpen = [];
  List<List<dynamic>> privacies = [];
  late Map<String, dynamic> user;
  bool isAdmin = false;

  void updateHelpCenter() {}

  ExpansionPanel expansive(String title, String body, int index) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(title),
        );
      },
      body: ListTile(
        title: Text(body),
      ),
      isExpanded: isOpen[index],
    );
  }

  @override
  void initState() {
    super.initState();

    db.collection('users').doc(auth.currentUser!.uid).get().then((value) {
      var user = value.data() as Map<String, dynamic>;
      if (user['role'] == "admin") {
        setState(() {
          isAdmin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormHelp({}),
                  ),
                );
              },
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                        "Pusat Bantuan",
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Hai, apa yang bisa saya bantu?',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
                    stream: db.collection('policy').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs
                            .map((doc) => doc.data())
                            .toList();

                        for (int i = 0; i < data.length; i++) {
                          data[i].addAll({"key": snapshot.data!.docs[i].id});
                        }

                        if (isAdmin) {
                          return Column(
                            children: [
                              for (int i = 0; i < data.length; i++)
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(
                                        Size.fromHeight(
                                            MediaQuery.of(context).size.height *
                                                0.065),
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
                                          const MaterialStatePropertyAll(
                                              Colors.black54),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FormHelp(data[i]),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data[i]['title']),
                                        const Icon(Icons.arrow_forward_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else {
                          for (int i = 0; i < data.length; i++) {
                            isOpen.add(false);
                            data[i].addAll({'index': i});
                          }
                          return ExpansionPanelList(
                            expansionCallback: (panelIndex, isExpanded) {
                              setState(() {
                                isOpen[panelIndex] = !isExpanded;
                              });
                            },
                            animationDuration:
                                const Duration(milliseconds: 250),
                            children: [
                              for (int i = 0; i < data.length; i++)
                                expansive(
                                  data[i]['title'],
                                  data[i]['content'],
                                  data[i]['index'],
                                )
                            ],
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
