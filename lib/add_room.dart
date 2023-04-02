import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddRoom extends StatefulWidget {
  final dynamic formData;

  const AddRoom({super.key, this.formData = false});

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
  TextEditingController invoice = TextEditingController();

  dynamic selectedRoomType;
  dynamic selectedUser;

  @override
  void initState() {
    super.initState();

    if (widget.formData != false) {
      roomNum.text = widget.formData['room_num'].toString();
      invoice.text = widget.formData['invoice'].toString();
      selectedRoomType = widget.formData['type'];
      selectedUser = widget.formData['owner'];

      List<dynamic> facilitiesList = widget.formData['facilities'];
      List<dynamic> roomSpecList = widget.formData['specifications'];
      List<dynamic> bathSpecList = widget.formData['bath_spec'];

      facilities.text = facilitiesList.join(", ");
      roomSpec.text = roomSpecList.join(", ");
      bathSpec.text = bathSpecList.join(", ");
    }
  }

  void setRoom() async {
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

      String status = selectedUser == "Kosong" ? "Kosong" : "Terisi";

      if (widget.formData != false) {
        await db.collection('rooms').doc(widget.formData['key']).update({
          "type": selectedRoomType,
          "room_num": int.parse(roomNum.text),
          "status": status,
          "facilities": facilitiesList,
          "specifications": roomSpecList,
          "bath_spec": bathSpecList,
          "owner": selectedUser,
          "invoice": int.parse(invoice.text)
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Kamar berhasil diubah!"),
              backgroundColor: Colors.indigo,
            ),
          );

          Navigator.of(context).pop();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } else {
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Kamar berhasil ditambahkan!"),
              backgroundColor: Colors.indigo,
            ),
          );

          Navigator.of(context).pop();
          Navigator.pop(context);
        }
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
                    Text(
                      widget.formData != false
                          ? "Edit Kamar ${widget.formData['room_num']}"
                          : "Tambah Kamar Baru",
                      style: const TextStyle(
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
                  items: const [
                    DropdownMenuItem(
                      value: "Standar",
                      child: Text('Standar'),
                    ),
                    DropdownMenuItem(
                      value: "Premium",
                      child: Text('Premium'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRoomType = value!;
                    });
                  },
                ),
                SizedBox(
                  height:
                      widget.formData != false ? screenSize.height * 0.025 : 0,
                ),
                widget.formData != false
                    ? StreamBuilder(
                        stream: db.collection('users').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.docs
                                .map((e) => e.data())
                                .toList();

                            for (var i = 0; i < data.length; i++) {
                              data[i]
                                  .addAll({'key': snapshot.data!.docs[i].id});
                            }

                            return DropdownButton(
                              isExpanded: true,
                              value: selectedUser,
                              items: [
                                const DropdownMenuItem(
                                  value: "Kosong",
                                  child: Text("Kosong"),
                                ),
                                for (var i = 0; i < data.length; i++)
                                  DropdownMenuItem(
                                    value: data[i]['key'],
                                    child: Text(data[i]['username']),
                                  )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedUser = value!;
                                });
                              },
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : Row(),
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
                ),
                SizedBox(
                  height: screenSize.height * 0.025,
                ),
                widget.formData != false
                    ? userInput("Tagihan (Rupiah)", invoice, isNumber: true)
                    : Row()
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
                setRoom();
              },
              child: const Text('Simpan'),
            ),
          ),
        ],
      )),
    );
  }
}
