import 'package:admin_kos/about.dart';
import 'package:admin_kos/dashboard.dart';
import 'package:admin_kos/profile.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  _HomeUser createState() => _HomeUser();
}

class _HomeUser extends State<HomeUser> {
  int index = 0;

  List<Widget> pages = [const Dashboard(), const About(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
