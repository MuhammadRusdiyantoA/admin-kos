import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  _EditForm createState() => _EditForm();
}

class _EditForm extends State<EditForm> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  File? imageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nikController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  void uploadImage() async {}

  @override
  void initState() {
    super.initState();

    db.collection('users').doc(auth.currentUser?.uid).get().then((value) {
      var data = value.data() as Map<String, dynamic>;

      nameController.text = data['username'];
      addressController.text = data['address'];
      phoneController.text = data['phone'].toString();
      nikController.text = data['NIK'].toString();
    });
  }

  void updateProfile(BuildContext context) async {
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty ||
        nikController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mohon isi semua kolom!"),
          backgroundColor: Colors.indigo,
        ),
      );
    } else {
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

        await db.collection('users').doc(auth.currentUser?.uid).update({
          'username': nameController.text,
          'address': addressController.text,
          'phone': phoneController.text,
          'NIK': nikController.text
        });

        if (mounted) {
          Navigator.of(context).pop();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profil berhasil diperbarui"),
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
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      imageFile = File(img!.path);
    });
  }

  Widget textInput(
      String label, String value, TextEditingController controller) {
    controller.text = value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: MediaQuery.of(context).size.height * 0.1,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: Colors.black38,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Edit Profil",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: 72,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.white24,
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    onPressed: () {
                      updateProfile(context);
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    image: // imageFile != null
                        //     ? DecorationImage(
                        //         image: FileImage(imageFile!),
                        //         fit: BoxFit.cover,
                        //         colorFilter: const ColorFilter.mode(
                        //           Colors.black38,
                        //           BlendMode.darken,
                        //         ),
                        //       ) :
                        DecorationImage(
                      image: AssetImage('assets/images/dummyProfile.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black38,
                        BlendMode.darken,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                const Text(
                  'Ubah Foto',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            height: MediaQuery.of(context).size.height * 0.575,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // StreamBuilder(
                //   stream: db
                //       .collection('users')
                //       .doc(auth.currentUser?.uid)
                //       .snapshots(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       var data = snapshot.data?.data() as Map<String, dynamic>;

                //       setState(() {
                //         nameController.text = data['username'];
                //         addressController.text = data['address'];
                //         phoneController.text = data['phone'].toString();
                //         nikController.text = data['nik'].toString();
                //       });

                //       return Container();
                //     }

                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   },
                // ),
                textInput("Nama", "", nameController),
                textInput("Alamat", "", addressController),
                textInput("No. Handphone", "", phoneController),
                textInput("NIK", "", nikController),
              ],
            ),
          )
        ],
      ),
    );
  }
}
