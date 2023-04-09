import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormHelp extends StatefulWidget {
  final Map<String, dynamic> data;

  const FormHelp(this.data, {super.key});

  @override
  _FormHelp createState() => _FormHelp();
}

class _FormHelp extends State<FormHelp> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void deletePolicy() async {
    try {
      await db.collection('policy').doc(widget.data['key']).delete();

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

  void setPolicy() async {
    try {
      if (widget.data.isEmpty) {
        await db.collection('policy').add({
          "title": titleController.text,
          "content": contentController.text,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kebijakan berhasil ditambahkan!'),
              backgroundColor: Colors.indigo,
            ),
          );

          Navigator.pop(context);
        }
      } else {
        await db.collection('policy').doc(widget.data['key']).set({
          "title": titleController.text,
          "content": contentController.text,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kebijakan berhasil diubah!'),
              backgroundColor: Colors.indigo,
            ),
          );

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

  @override
  void initState() {
    super.initState();

    if (widget.data.isNotEmpty) {
      titleController.text = widget.data['title'];
      contentController.text = widget.data['content'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              child: Text(
                                widget.data.isEmpty
                                    ? "Tambah Kebijakan Baru"
                                    : "Edit ${widget.data['title']}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        color: Colors.red,
                        onPressed: widget.data.isEmpty
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          'Yakin ingin menghapus kebijakan ${widget.data["title"]}?'),
                                      actions: [
                                        TextButton(
                                          style: const ButtonStyle(
                                            foregroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Tidak'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deletePolicy();
                                          },
                                          child: const Text('Yakin'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                        icon: Icon(
                          widget.data.isEmpty ? null : Icons.delete,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {
                          if (titleController.text.isEmpty ||
                              contentController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon isi semua kolom!'),
                                backgroundColor: Colors.indigo,
                              ),
                            );
                          } else {
                            setPolicy();
                          }
                        },
                        icon: Icon(
                          widget.data.isEmpty ? Icons.add : Icons.edit,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.075),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(hintText: "Nama Kebijakan"),
                  ),
                  TextField(
                    controller: contentController,
                    decoration:
                        const InputDecoration(hintText: "Konten Kebijakan"),
                    minLines: 10,
                    maxLines: 9999,
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
