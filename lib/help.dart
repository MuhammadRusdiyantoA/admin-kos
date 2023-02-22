import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  _Help createState() => _Help();
}

class _Help extends State<Help> {
  late List<bool> isOpen = [];
  List<List<dynamic>> privacies = [
    ['Kebijakan privasi', 'Kami tidak akan mengambil data anda.'],
    ['Kebijakan privasi', 'Kami tidak akan mengambil data anda.'],
    ['Kebijakan privasi', 'Kami tidak akan mengambil data anda.'],
    ['Kebijakan privasi', 'Kami tidak akan mengambil data anda.'],
  ];

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

    for (int i = 0; i < privacies.length; i++) {
      isOpen.add(false);
      privacies[i].add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        isOpen[panelIndex] = !isExpanded;
                      });
                    },
                    animationDuration: const Duration(milliseconds: 250),
                    children: [
                      for (int i = 0; i < privacies.length; i++)
                        expansive(
                            privacies[i][0], privacies[i][1], privacies[i][2])
                    ],
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
