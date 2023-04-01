import 'package:admin_kos/add_room.dart';
import 'package:admin_kos/dashboard.dart';
import 'package:admin_kos/about.dart';
import 'package:admin_kos/profile.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdmin createState() => _HomeAdmin();
}

class _HomeAdmin extends State<HomeAdmin> {
  int index = 0;

  List<Widget> pages = [
    const Dashboard(isAdmin: true),
    const About(isAdmin: true),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: index == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddRoom(),
                  ),
                );
              },
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo,
              child: const Icon(Icons.add),
            )
          : null,
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
