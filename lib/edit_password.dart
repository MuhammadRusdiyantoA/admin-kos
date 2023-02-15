import 'package:flutter/material.dart';

class EditPw extends StatefulWidget {
  const EditPw({super.key});

  @override
  _EditPw createState() => _EditPw();
}

class _EditPw extends State<EditPw> {
  List<bool> check = [false, false, false];

  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Widget textInput(String label, TextEditingController controller, int index,
      IconData icon) {
    bool _check = check[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: MediaQuery.of(context).size.height * 0.1,
          child: TextField(
            controller: controller,
            obscureText: !_check,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: Colors.black38,
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(icon),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: Icon(_check ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      check[index] = !_check;
                    });
                  },
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
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Ubah Kata Sandi",
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
            height: MediaQuery.of(context).size.height * 0.6,
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    "Masukan password lama anda untuk mengubah kata sandi anda",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                textInput('Kata sandi lama', oldController, 0,
                    Icons.lock_clock_outlined),
                textInput(
                    'Kata sandi baru', newController, 1, Icons.lock_outline),
                textInput('Konfirmasi kata sandi', confirmController, 2,
                    Icons.lock_reset),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.indigo[300],
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (oldController.text.isEmpty ||
                          newController.text.isEmpty ||
                          confirmController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mohon isi semua kolom!'),
                            backgroundColor: Colors.indigo,
                          ),
                        );
                      } else if (oldController.text != 'password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password lama salah!'),
                            backgroundColor: Colors.indigo,
                          ),
                        );
                      } else if (newController.text != confirmController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Kolom konfirmasi password tidak sesuai!'),
                            backgroundColor: Colors.indigo,
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Kata sandi berhasil diperbarui!'),
                            backgroundColor: Colors.indigo,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Ubah sandi',
                      style: TextStyle(
                        color: Colors.indigo[900],
                      ),
                    ),
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
