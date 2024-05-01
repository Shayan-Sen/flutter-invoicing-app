// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:billproject/PrintingPage.dart';
import 'package:billproject/backendvar.dart';
import 'package:flutter/material.dart';

int x = 1;

class TableGenerate extends StatefulWidget {
  TableGenerate({super.key});

  @override
  State<TableGenerate> createState() => _TableGenerateState();
}

class _TableGenerateState extends State<TableGenerate> {
  var controllerA = TextEditingController();
  var controllerB = TextEditingController();
  var controllerC = TextEditingController();
  var controllerD = TextEditingController();
  var controllerE = TextEditingController();
  var controllerF = TextEditingController();
  var controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Appbar"),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: controllerA,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: controllerB,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: controllerC,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: controllerD,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: controllerE,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: controllerF,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var jd = {
                        "Slno": x,
                        "A": controllerA.text,
                        "B": controllerB.text,
                        "C": controllerC.text,
                        "D": controllerD.text,
                        "E": controllerE.text,
                        "F": controllerF.text
                      };
                      jsonData.add(jd);
                      x++;
                      controllerA.text = "";
                      controllerB.text = "";
                      controllerC.text = "";
                      controllerD.text = "";
                      controllerE.text = "";
                      controllerF.text = "";
                    });
                  },
                  child: Text("Print"),
                ),
                SizedBox(
                  height: 70,
                ),
                DataTable(
                  headingTextStyle:
                      TextStyle(color: Colors.white, fontSize: 20),
                  columns: <DataColumn>[
                    DataColumn(
                        label: Text(
                      "SL.No",
                      style: TextStyle(fontSize: 16),
                    )),
                    DataColumn(label: Text("A")),
                    DataColumn(label: Text("B")),
                    DataColumn(label: Text("C")),
                    DataColumn(label: Text("D")),
                    DataColumn(label: Text("E")),
                    DataColumn(label: Text("F"))
                  ],
                  rows: jsonData.map<DataRow>((e) {
                    return DataRow(cells: <DataCell>[
                      DataCell(Text("${e["Slno"]}")),
                      DataCell(Text("${e["A"]}")),
                      DataCell(Text("${e["B"]}")),
                      DataCell(Text("${e["C"]}")),
                      DataCell(Text("${e["D"]}")),
                      DataCell(Text("${e["E"]}")),
                      DataCell(Text("${e["F"]}"))
                    ]);
                  }).toList(),
                  headingRowColor: MaterialStateProperty.all(Colors.blue),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrintingPage(),
                          ));
                    });
                  },
                  child: Text(
                    "Generate",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      overlayColor:
                          MaterialStateProperty.all(Colors.green.shade700),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                      fixedSize: MaterialStatePropertyAll(Size(500, 20))),
                )
              ],
            ),
          ),
        ));
  }
}

/*Container(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrintingPage(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    "Generate",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green),
              ),*/