// ignore_for_file: prefer_const_constructors, unused_import

import 'PrintingPage.dart';
import 'TableGenerate.dart';
import 'backendvar.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final DBapi x = DBapi();

Future<void> main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await x.open();
  await x.close();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 5,
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shadowColor: Colors.black)),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 5,
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple.shade900,
            shadowColor: Colors.black),
      ),
      themeMode: ThemeMode.light,
      title: "Billing App",
      home: TableGenerate(),
    );
  }
}
