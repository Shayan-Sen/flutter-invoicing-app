// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'invoice.dart';

class PrintingPage extends StatefulWidget {
  PrintingPage({super.key});

  @override
  State<PrintingPage> createState() => _PrintingPageState();
}

class _PrintingPageState extends State<PrintingPage> {
  final AppBar appbr = AppBar(title: Text("Appbar"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbr,
      body: Preview(),
    );
  }
}

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => buildPdf(format),
      maxPageWidth: 700,
    );
  }
}
