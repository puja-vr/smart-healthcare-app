import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/services/user.dart';
import 'package:smarthealthcare/shared/constants.dart';

class Me extends StatefulWidget {
  String uid;
  Me({Key? key, required this.uid}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  final _fk1 = GlobalKey<FormState>();
  final _fk2 = GlobalKey<FormState>();
  final _fk3 = GlobalKey<FormState>();

  bool editName = false, editPhone = false, editAddress = false;
  String name = "", address = "";
  int phone = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: widget.uid).userData,
          builder: (context, snapshot) {
            UserData? userData = snapshot.data;
            if (!snapshot.hasData) {
              return const Loading();
            }
            return Column(
              children: [
                Container(
                  color: kpink,
                  child: UserAccountsDrawerHeader(
                    accountName: const Text(''),
                    accountEmail: Text('${userData!.email}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    currentAccountPictureSize: const Size.square(80),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: kwhite,
                      child: Text(
                        userData.name[0],
                        style: const TextStyle(
                            fontSize: 40.0,
                            color: kpurple,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    decoration: const BoxDecoration(
                        color: kpink,
                        image: DecorationImage(
                            alignment: Alignment.centerRight,
                            fit: BoxFit.fitHeight,
                            image: AssetImage('assets/profile.png'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name", style: cHeading),
                      if (!editName)
                        Row(
                          children: [
                            textContainer("${userData.name}"),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    editName = true;
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      if (editName)
                        Row(
                          children: [
                            Form(
                              key: _fk1,
                              child: Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter your name",
                                    fillColor: kback,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  DatabaseService(uid: widget.uid)
                                      .updateUserName(name);
                                  editName = false;
                                });
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                          ],
                        ),
                      const SizedBox(height: 30),
                      const Text("Phone", style: cHeading),
                      if (!editPhone)
                        Row(
                          children: [
                            textContainer("${userData.phone}"),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    editPhone = true;
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      if (editPhone)
                        Row(
                          children: [
                            Form(
                              key: _fk2,
                              child: Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                    setState(() {
                                      if (int.tryParse(value) != null) {
                                        phone = int.tryParse(value)!;
                                      }
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter your phone number",
                                    fillColor: kback,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  DatabaseService(uid: widget.uid)
                                      .updateUserPhone(phone);
                                  editPhone = false;
                                });
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                          ],
                        ),
                      const SizedBox(height: 30),
                      const Text("Address", style: cHeading),
                      if (!editAddress)
                        Row(
                          children: [
                            textContainer("${userData.address}"),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    editAddress = true;
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      if (editAddress)
                        Row(
                          children: [
                            Form(
                              key: _fk3,
                              child: Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                    setState(() {
                                      address = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter your address",
                                    fillColor: kback,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  DatabaseService(uid: widget.uid)
                                      .updateUserAddress(address);
                                  editAddress = false;
                                });
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
