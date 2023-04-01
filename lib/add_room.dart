import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  _AddRoom createState() => _AddRoom();
}

class _AddRoom extends State<AddRoom> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  TextEditingController roomNum = TextEditingController();
  TextEditingController facilities = TextEditingController();
  TextEditingController roomSpec = TextEditingController();
  TextEditingController bathSpec = TextEditingController();

  List<String> roomTypeList = ["Standar", "Premium"];
  var selectedRoomType;

  void createRoom() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

      var facilitiesList = facilities.text.split(',');
      for (var i = 0; i < facilitiesList.length; i++) {
        facilitiesList[i] = facilitiesList[i].trim();
      }

      var roomSpecList = roomSpec.text.split(',');
      for (var i = 0; i < roomSpecList.length; i++) {
        roomSpecList[i] = roomSpecList[i].trim();
      }

      var bathSpecList = bathSpec.text.split(',');
      for (var i = 0; i < bathSpecList.length; i++) {
        bathSpecList[i] = bathSpecList[i].trim();
      }

      var random = Random().nextInt(3) + 1;

      await db.collection('rooms').add({
        "image": "assets/images/kamar_$random.jpg",
        "type": selectedRoomType,
        "room_num": int.parse(roomNum.text),
        "status": "Kosong",
        "facilities": facilitiesList,
        "specifications": roomSpecList,
        "bath_spec": bathSpecList,
        "owner": "Kosong",
        "invoice": 0
      });

      if (mounted) {
        Navigator.of(context).pop();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Kamar berhasil ditambahkan!"),
            backgroundColor: Colors.indigo,
          ),
        );
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

  Widget userInput(String hint, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
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
                      "Tambah Kamar Baru",
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
            padding: const EdgeInsets.all(16),
            width: screenSize.width,
            child: Column(
              children: [
                userInput("Nomor kamar", roomNum, isNumber: true),
                SizedBox(
                  height: screenSize.height * 0.025,
                ),
                DropdownButton(
                  hint: const Text("Tipe kamar"),
                  isExpanded: true,
                  value: selectedRoomType,
                  items: [
                    DropdownMenuItem(
                      value: roomTypeList[0],
                      child: const Text('Standar'),
                    ),
                    DropdownMenuItem(
                      value: roomTypeList[1],
                      child: const Text('Premium'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRoomType = value!;
                    });
                  },
                ),
                SizedBox(
                  height: screenSize.height * 0.025,
                ),
                Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(16),
                  color: Colors.indigo[100],
                  child: Column(
                    children: [
                      userInput("Fasilitas", facilities),
                      userInput("Spesifikasi", roomSpec),
                      userInput("Fasilitas kamar mandi", bathSpec),
                      SizedBox(
                        height: screenSize.height * 0.025,
                      ),
                      const Text(
                          "Note: Pisahkan setiap fasilitas dan spesifikasi dengan tanda koma (contoh: 'Kasur, Meja Belajar, AC,...')")
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 48,
            width: screenSize.width,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.indigo),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                ),
              ),
              onPressed: () {
                createRoom();
              },
              child: const Text('Simpan'),
            ),
          ),
        ],
      )),
    );
  }
}
