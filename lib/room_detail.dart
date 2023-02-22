import 'package:flutter/material.dart';

class RoomDetail extends StatefulWidget {
  final AssetImage roomImg;
  final int roomNum;
  final String roomStat;
  final String roomOwner;
  final List<String> facilities;
  final List<String> roomSpec;
  final List<String> bathSpec;

  const RoomDetail(this.roomImg, this.roomNum, this.roomStat, this.roomOwner,
      this.facilities, this.roomSpec, this.bathSpec,
      {super.key});

  @override
  _RoomDetail createState() => _RoomDetail();
}

class _RoomDetail extends State<RoomDetail> {
  String curUser = "Muhammad Sumbul bin Abdul Jalil";
  bool check = false;
  bool submitable = false;
  bool submitted = false;
  TextEditingController detailController = TextEditingController();

  List<bool> facilitiesCheck = [];

  bool anySelected() {
    for (int i = 0; i < facilitiesCheck.length; i++) {
      if (facilitiesCheck[i]) {
        return true;
      }
    }
    return false;
  }

  List<Color?> getColor() {
    if (submitted) {
      return [Colors.indigo[200], Colors.indigo[800]];
    } else if (submitable && anySelected()) {
      return [Colors.indigo, Colors.white];
    } else {
      return [Colors.black38, Colors.black];
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.roomOwner == curUser) {
      for (int i = 0; i < widget.facilities.length; i++) {
        facilitiesCheck.add(false);
      }
      setState(() {
        check = !check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: widget.roomImg, fit: BoxFit.cover),
              ),
              child: IconButton(
                iconSize: 24,
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              padding: const EdgeInsets.only(bottom: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 32,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nomor Kamar'),
                        Text(
                          'Kamar ${widget.roomNum}',
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 32,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Penghuni'),
                        check
                            ? FittedBox(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: curUser,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 24,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '(You)',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : FittedBox(
                                child: Text(
                                  widget.roomOwner,
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            check
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          child: Text(
                            'Pilih beberapa tombol di bawah ini untuk mengonsultasikan kerusakan yang ada pada kamarmu.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Wrap(
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            for (var i = 0; i < widget.facilities.length; i++)
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                child: TextButton(
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 16),
                                    ),
                                    backgroundColor: MaterialStatePropertyAll(
                                      facilitiesCheck[i]
                                          ? Colors.indigo
                                          : Colors.transparent,
                                    ),
                                    foregroundColor: MaterialStatePropertyAll(
                                      facilitiesCheck[i]
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                        side: const BorderSide(
                                          color: Colors.indigo,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      facilitiesCheck[i] = !facilitiesCheck[i];
                                    });
                                  },
                                  child: Text(
                                    widget.facilities[i],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                submitable = true;
                              });
                            } else {
                              setState(() {
                                submitable = false;
                              });
                            }
                          },
                          controller: detailController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Tulis detail kerusakan...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black54,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 48,
                                  width:
                                      MediaQuery.of(context).size.width * 0.425,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          side: BorderSide(
                                            color: submitted
                                                ? Colors.black
                                                : Colors.black38,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      foregroundColor: MaterialStatePropertyAll(
                                        submitted
                                            ? Colors.black
                                            : Colors.black45,
                                      ),
                                    ),
                                    onPressed: submitted
                                        ? () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Laporan kerusakan berhasil diubah!',
                                                ),
                                                backgroundColor: Colors.indigo,
                                              ),
                                            );
                                          }
                                        : null,
                                    child: const Text('Edit'),
                                  ),
                                ),
                                SizedBox(
                                  height: 48,
                                  width:
                                      MediaQuery.of(context).size.width * 0.425,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          side: const BorderSide(
                                            color: Colors.black38,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: MaterialStatePropertyAll(
                                        getColor()[0],
                                      ),
                                      foregroundColor: MaterialStatePropertyAll(
                                        getColor()[1],
                                      ),
                                    ),
                                    onPressed: (anySelected() && submitable) &&
                                            !submitted
                                        ? () {
                                            setState(() {
                                              submitted = !submitted;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Laporan kerusakan berhasil dikirimkan!'),
                                                backgroundColor: Colors.indigo,
                                              ),
                                            );
                                          }
                                        : null,
                                    child:
                                        Text(submitted ? 'Terkirim' : 'Kirim'),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              height: 48,
                              width: MediaQuery.of(context).size.width - 32,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.green),
                                  foregroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white),
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.2),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.phone),
                                    Text('Konsultasi lewat Whatsapp')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.only(bottom: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Spesifikasi Kamar',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: GridView.count(
                                crossAxisCount: 1,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                childAspectRatio: (18 / 1),
                                children: [
                                  for (int i = 0;
                                      i < widget.roomSpec.length;
                                      i++)
                                    Text(widget.roomSpec[i])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.only(bottom: 16),
                        margin: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Fasilitas kamar',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: GridView.count(
                                crossAxisCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                childAspectRatio: (9 / 1),
                                children: [
                                  for (int i = 0;
                                      i < widget.facilities.length;
                                      i++)
                                    Text(widget.facilities[i])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.only(bottom: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Fasilitas kamar mandi',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: GridView.count(
                                crossAxisCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                childAspectRatio: (9 / 1),
                                children: [
                                  for (int i = 0;
                                      i < widget.bathSpec.length;
                                      i++)
                                    Text(widget.bathSpec[i])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: MediaQuery.of(context).size.height * 0.175,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    widget.roomStat == "Kosong"
                                        ? Colors.indigo
                                        : Colors.black12,
                                  ),
                                  foregroundColor: MaterialStatePropertyAll(
                                    widget.roomStat == "Kosong"
                                        ? Colors.white
                                        : Colors.black38,
                                  ),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                                onPressed:
                                    widget.roomStat == "Kosong" ? () {} : null,
                                child: const Text('Booking'),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                    Colors.indigo,
                                  ),
                                  foregroundColor:
                                      const MaterialStatePropertyAll(
                                    Colors.white,
                                  ),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Lihat kamar lain'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
