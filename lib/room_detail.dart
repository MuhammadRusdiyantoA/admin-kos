import 'package:admin_kos/add_room.dart';
import 'package:admin_kos/dash_admin.dart';
import 'package:admin_kos/home_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoomDetail extends StatefulWidget {
  final AssetImage roomImg;
  final int roomNum;
  final String roomStat;
  final String roomOwner;
  final List<dynamic> facilities;
  final List<dynamic> roomSpec;
  final List<dynamic> bathSpec;
  final bool isAdmin;
  final int invoice;
  final String roomKey;
  final String type;

  const RoomDetail(
    this.roomImg,
    this.roomNum,
    this.roomStat,
    this.roomOwner,
    this.facilities,
    this.roomSpec,
    this.bathSpec, {
    super.key,
    this.isAdmin = false,
    this.invoice = 0,
    this.roomKey = "",
    this.type = "",
  });

  @override
  _RoomDetail createState() => _RoomDetail();
}

class _RoomDetail extends State<RoomDetail> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  String curUser = "Muhammad Sumbul bin Abdul Jalil";
  bool check = false;

  void updateRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRoom(formData: {
          "key": widget.roomKey,
          "type": widget.type,
          "room_num": widget.roomNum,
          "owner": widget.roomOwner,
          "facilities": widget.facilities,
          "specifications": widget.roomSpec,
          "bath_spec": widget.bathSpec,
          "invoice": widget.invoice
        }),
      ),
    );
  }

  void deleteRoom() async {
    try {
      await db.collection('rooms').doc(widget.roomKey).delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kamar berhasil dihapus!'),
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

  @override
  void initState() {
    super.initState();

    if (widget.roomOwner == auth.currentUser!.uid || widget.isAdmin) {
      setState(() {
        check = !check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    curUser = auth.currentUser!.uid;

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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 24,
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    widget.isAdmin
                        ? Row(
                            children: [
                              IconButton(
                                iconSize: 24,
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Yakin ingin menghapus kamar ${widget.roomNum}?'),
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
                                              deleteRoom();
                                            },
                                            child: const Text('Yakin'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                iconSize: 24,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  updateRoom();
                                },
                              ),
                            ],
                          )
                        : Row(),
                  ],
                )),
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
                        widget.roomOwner == "Kosong"
                            ? const FittedBox(
                                child: Text(
                                  "Kosong",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              )
                            : StreamBuilder(
                                stream: db
                                    .collection('users')
                                    .doc(widget.roomOwner)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.data()
                                        as Map<String, dynamic>;

                                    return widget.roomOwner ==
                                            auth.currentUser!.uid
                                        ? FittedBox(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: data['username'],
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '(You)',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : FittedBox(
                                            child: Text(
                                              data['username'],
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                          );
                                  }
                                  return const Text("wait...");
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            check
                ? widget.roomOwner != "Kosong"
                    ? OwnedRoom(
                        widget.roomImg,
                        widget.roomNum,
                        widget.roomStat,
                        widget.roomOwner,
                        widget.facilities,
                        widget.roomSpec,
                        widget.bathSpec,
                        isAdmin: widget.isAdmin,
                        invoice: widget.invoice,
                      )
                    : UnownedRoom(
                        widget.roomImg,
                        widget.roomNum,
                        widget.roomStat,
                        widget.roomOwner,
                        widget.facilities,
                        widget.roomSpec,
                        widget.bathSpec,
                        isAdmin: widget.isAdmin,
                        invoice: widget.invoice,
                      )
                : UnownedRoom(
                    widget.roomImg,
                    widget.roomNum,
                    widget.roomStat,
                    widget.roomOwner,
                    widget.facilities,
                    widget.roomSpec,
                    widget.bathSpec,
                    isAdmin: widget.isAdmin,
                    invoice: widget.invoice,
                  )
          ],
        ),
      ),
    );
  }
}

class OwnedRoom extends StatefulWidget {
  final AssetImage roomImg;
  final int roomNum;
  final String roomStat;
  final String roomOwner;
  final List<dynamic> facilities;
  final List<dynamic> roomSpec;
  final List<dynamic> bathSpec;
  final bool isAdmin;
  final int invoice;

  const OwnedRoom(this.roomImg, this.roomNum, this.roomStat, this.roomOwner,
      this.facilities, this.roomSpec, this.bathSpec,
      {super.key, this.isAdmin = false, this.invoice = 0});

  @override
  _OwnedRoom createState() => _OwnedRoom();
}

class _OwnedRoom extends State<OwnedRoom> {
  bool submitable = false;
  bool submitted = false;
  TextEditingController detailController = TextEditingController();

  bool anySelected() {
    for (int i = 0; i < facilitiesCheck.length; i++) {
      if (facilitiesCheck[i]) {
        return true;
      }
    }
    return false;
  }

  List<bool> facilitiesCheck = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.facilities.length; i++) {
      facilitiesCheck.add(false);
    }
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

  bool adminFixTime = true;

  Widget adminFixDialog() {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width - 32,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.indigo[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Kapan anda akan memperbaikinya?',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          RadioListTile(
            title: const Text("Hari ini"),
            value: true,
            groupValue: adminFixTime,
            onChanged: (value) {
              setState(() {
                adminFixTime = value as bool;
              });
            },
          ),
          RadioListTile(
            title: const Text("Besok"),
            value: false,
            groupValue: adminFixTime,
            onChanged: (value) {
              setState(() {
                adminFixTime = value as bool;
              });
            },
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width - 64,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(Colors.indigo),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                ),
              ),
              onPressed: () {},
              child: const Text('Kirim'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.isAdmin
          ? MediaQuery.of(context).size.height
          : screenSize.height * 0.75,
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
                        EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        facilitiesCheck[i] ? Colors.indigo : Colors.transparent,
                      ),
                      foregroundColor: MaterialStatePropertyAll(
                        facilitiesCheck[i] ? Colors.white : Colors.black54,
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
                children: widget.isAdmin
                    ? widget.roomOwner != "Kosong"
                        ? [
                            Column(
                              children: [
                                adminFixDialog(),
                                Container(
                                  margin: const EdgeInsets.only(top: 24),
                                  width: MediaQuery.of(context).size.width - 32,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Tagihan'),
                                          Text(
                                            '${widget.invoice}',
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 16),
                                        height: 48,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                            ),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.indigo),
                                            foregroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.white),
                                            padding: MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.2),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Minta Tagihan'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]
                        : []
                    : [
                        Column(
                          children: [
                            SizedBox(
                              width: screenSize.width - 32,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width *
                                        0.425,
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
                                        foregroundColor:
                                            MaterialStatePropertyAll(
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
                                                  backgroundColor:
                                                      Colors.indigo,
                                                ),
                                              );
                                            }
                                          : null,
                                      child: const Text('Edit'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width *
                                        0.425,
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          getColor()[0],
                                        ),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                          getColor()[1],
                                        ),
                                      ),
                                      onPressed:
                                          (anySelected() && submitable) &&
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
                                                      backgroundColor:
                                                          Colors.indigo,
                                                    ),
                                                  );
                                                }
                                              : null,
                                      child: Text(
                                          submitted ? 'Terkirim' : 'Kirim'),
                                    ),
                                  ),
                                ],
                              ),
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
                            ),
                          ],
                        ),
                      ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UnownedRoom extends StatefulWidget {
  final AssetImage roomImg;
  final int roomNum;
  final String roomStat;
  final String roomOwner;
  final List<dynamic> facilities;
  final List<dynamic> roomSpec;
  final List<dynamic> bathSpec;
  final bool isAdmin;
  final int invoice;

  const UnownedRoom(this.roomImg, this.roomNum, this.roomStat, this.roomOwner,
      this.facilities, this.roomSpec, this.bathSpec,
      {super.key, this.isAdmin = false, this.invoice = 0});

  @override
  _UnownedRoom createState() => _UnownedRoom();
}

class _UnownedRoom extends State<UnownedRoom> {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  bool booked = false;

  void bookRoom() async {
    try {
      var data =
          await db.collection('users').where('role', isEqualTo: 'admin').get();
      var adminID = data.docs[0].id;

      await db.collection('notifications').add({
        "from": auth.currentUser!.uid,
        "to": adminID,
        "type": "Booking",
        "content":
            "%name% telah memesan booking untuk kamar ${widget.roomNum}.",
        "isRead": false,
        "date_sent": DateTime.now()
      });

      if (mounted) {
        setState(() {
          booked = !booked;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kamar berhasil di-booking!'),
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

  List<Color?> getBookingColor() {
    if (widget.roomStat == "Kosong" && !booked) {
      return [Colors.indigo, Colors.white];
    } else if (booked) {
      return [Colors.indigo[200], Colors.indigo[800]];
    } else {
      return [Colors.black12, Colors.black38];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    for (int i = 0; i < widget.roomSpec.length; i++)
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
                    for (int i = 0; i < widget.facilities.length; i++)
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
                    for (int i = 0; i < widget.bathSpec.length; i++)
                      Text(widget.bathSpec[i])
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 32,
          height: !widget.isAdmin
              ? MediaQuery.of(context).size.height * 0.175
              : MediaQuery.of(context).size.height * 0.175 / 2,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              !widget.isAdmin
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.075,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            getBookingColor()[0],
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            getBookingColor()[1],
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        onPressed: (widget.roomStat == "Kosong" && !booked)
                            ? () {
                                bookRoom();
                              }
                            : null,
                        child: const Text('Booking'),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.indigo,
                    ),
                    foregroundColor: const MaterialStatePropertyAll(
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
    );
  }
}
