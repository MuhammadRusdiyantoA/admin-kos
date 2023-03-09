import 'package:admin_kos/room_detail.dart';
import 'package:admin_kos/dash_admin.dart';
import 'package:admin_kos/dash_user.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final bool isAdmin;

  const Dashboard({super.key, this.isAdmin = false});

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isAdmin ? const DashAdmin() : const DashUser(),
    );
  }
}

class Room extends StatelessWidget {
  final AssetImage roomImg;
  final String type;
  final int roomNum;
  final String roomStat;
  final List<String> facilities;
  final List<String> roomSpec;
  final List<String> bathSpec;
  final String roomOwner;
  final bool isAdmin;
  final int invoice;

  const Room(
    this.roomImg,
    this.type,
    this.roomNum,
    this.roomStat,
    this.facilities,
    this.roomSpec,
    this.bathSpec, {
    super.key,
    this.roomOwner = "Kosong",
    this.isAdmin = false,
    this.invoice = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: TextButton(
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.black),
          minimumSize: MaterialStatePropertyAll(Size.zero),
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetail(
                roomImg,
                roomNum,
                roomStat,
                roomOwner,
                facilities,
                roomSpec,
                bathSpec,
                isAdmin: isAdmin,
                invoice: invoice,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(6),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: roomImg,
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      color: type == 'Premium' ? Colors.amber : Colors.green,
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nomor Kamar : "),
                      Text(
                        "Kamar $roomNum",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status : '),
                      Text(
                        roomStat,
                        style: TextStyle(
                          color:
                              roomStat == 'Terisi' ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (isAdmin)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hutang : '),
                        Text(
                          "Rp. ${invoice.toString()}",
                          style: TextStyle(
                            color: invoice > 0 ? Colors.red : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
