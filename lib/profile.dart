import 'package:admin_kos/login.dart';
import 'package:admin_kos/edit_password.dart';
import 'package:admin_kos/edit_profile.dart';
import 'package:admin_kos/help.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  void logout(alertContext) async {
    try {
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        Navigator.pop(alertContext);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      }
    } catch (exception) {
      AlertDialog(
        content: Text('Something went wrong! $exception'),
      );
    }
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          Text(data['username']),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Text(
                            data['role'] == 'user'
                                ? 'Penghuni Kos'
                                : 'Pemilik Kos',
                            style: const TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
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
                                  logout(context);
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
