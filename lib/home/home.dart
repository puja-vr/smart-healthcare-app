import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/services/user.dart';
import 'package:smarthealthcare/shared/constants.dart';

class Home extends StatefulWidget {
  String uid;
  Home({Key? key, required this.uid}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _fkw = GlobalKey<FormState>();
  final _fkb = GlobalKey<FormState>();
  late dynamic data;
  bool editWeight = false, editDate = false, editBMI = false;
  int kg = 0, kg1 = 0, days = 0, diff = 0;
  double bmi = 0, m = 0, m1 = 0;
  late Timestamp date;
  String lit = "0";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder(
            stream: DatabaseService(uid: widget.uid).userData,
            builder: (context, snapshot) {
              UserData? userData = snapshot.data as UserData?;
              if (!snapshot.hasData) {
                return const Loading();
              }
              kg = userData!.weight;
              m = userData.height;
              bmi = (kg / (m * m)).roundToDouble();
              lit = (kg * 0.033).toStringAsFixed(1);
              date = userData.date;
              diff = DateTime.now().difference(date.toDate()).inDays;
              days = 28 - diff;
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "How much should you drink every day? ",
                      style: cHeading,
                    ),
                    if (!editWeight)
                      Row(
                        children: [
                          textContainer("$kg kgs"),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  editWeight = true;
                                });
                              },
                              icon: const Icon(Icons.edit)),
                          textContainer("$lit litres"),
                        ],
                      ),
                    if (editWeight)
                      Form(
                        key: _fkw,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  setState(() {
                                    if (int.tryParse(value) != null) {
                                      kg1 = int.tryParse(value)!;
                                      print(kg1);
                                      lit = (kg1 * 0.033).toStringAsFixed(1);
                                    } else {
                                      lit = '0';
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter your weight",
                                  fillColor: kback,
                                  filled: true,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  print(kg1);
                                  DatabaseService(uid: widget.uid)
                                      .updateUserWeight(kg1);
                                  editWeight = false;
                                  kg = userData.weight;
                                  lit = (kg * 0.033).toStringAsFixed(1);
                                });
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 30),
                    const Text(
                      "Ovulation Tracker",
                      style: cHeading,
                    ),
                    Row(
                      children: [
                        const Text("Freak out! Only ", style: cContent),
                        textContainer("$days"),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("days left", style: cContent),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                editDate = true;
                              });
                              if (editDate) {
                                final DateTime? selected = await showDatePicker(
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: const ColorScheme.dark(
                                          surface: kpinkdark,
                                          onSurface: kwhite,
                                          primary: kpinkdark,
                                          onPrimary: kwhite,
                                        ),
                                        dialogBackgroundColor: kpink,
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: kwhite,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  helpText: "Enter your LMP date",
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2025),
                                );
                                if (selected == null) {
                                  setState(() {
                                    editDate = false;
                                  });
                                } else {
                                  if (selected != selectedDate) {
                                    selectedDate = selected;
                                  }
                                  DatabaseService(uid: widget.uid)
                                      .updateUserDate(selectedDate);
                                  var diff = DateTime.now()
                                      .difference(selectedDate)
                                      .inDays;
                                  setState(() {
                                    days = 28 - diff;
                                  });
                                }
                              }
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "BMI Calculator",
                      style: cHeading,
                    ),
                    if (!editBMI)
                      Row(
                        children: [
                          textContainer("$kg kgs"),
                          const SizedBox(width: 20),
                          textContainer("$m m"),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  editBMI = true;
                                });
                              },
                              icon: const Icon(Icons.edit)),
                        ],
                      ),
                    const SizedBox(height: 10),
                    if (!editBMI)
                      Row(
                        children: [
                          textContainer((bmi > 25)
                              ? "Overweight"
                              : (bmi < 18.5)
                                  ? "Underweight"
                                  : "Healthy"),
                        ],
                      ),
                    if (editBMI)
                      Form(
                        key: _fkb,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  setState(() {
                                    if (double.tryParse(value) != null) {
                                      m1 = double.tryParse(value)!;
                                      bmi = (kg / (m1 * m1)).roundToDouble();
                                    } else {
                                      bmi = 0;
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter your height",
                                  fillColor: kback,
                                  filled: true,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  print("$m1");
                                  DatabaseService(uid: widget.uid)
                                      .updateUserHeight(m1);
                                  editBMI = false;
                                  kg = userData.weight;
                                  m = userData.height;
                                  print("$kg $m");
                                  bmi = (kg / (m * m)).roundToDouble();
                                });
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
