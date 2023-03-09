import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final bool isAdmin;

  const About({super.key, this.isAdmin = false});

  @override
  _About createState() => _About();
}

class _About extends State<About> {
  String about =
      "Kos 'Mboke' mulai beroperasi sejak tahun 20xx dan sampai sekarang bla bla bla";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin) {
      controller.text = about;
    }
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('History updated successfully!'),
                            backgroundColor: Colors.indigo,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('History cannot be empty!'),
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
                widget.isAdmin
                    ? TextField(
                        minLines: 21,
                        maxLines: 9999,
                        controller: controller,
                        decoration: InputDecoration(),
                      )
                    : Text(about),
              ],
            ),
          )
        ],
      ),
    );
  }
}
