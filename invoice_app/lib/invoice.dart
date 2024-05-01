//import 'dart:io';

// ignore_for_file: prefer_const_constructors

import 'backendvar.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(style: pw.BorderStyle.none),
        /*pw.TableBorder.symmetric(
          outside: pw.BorderSide(
              color: PdfColors.black, style: pw.BorderStyle.solid, width: 2.0),
        ),*/
        headerHeight: 25,
        cellHeight: 30,
        columnWidths: {0: pw.FixedColumnWidth(10)},
        cellStyle: const pw.TextStyle(
          color: PdfColors.black,
          fontSize: 10,
        ),
        rowDecoration: pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              color: PdfColors.black,
              width: .5,
            ),
          ),
        ),
        headerStyle: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
        headerDecoration: pw.BoxDecoration(
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(1)),
          color: PdfColors.blue,
        ),
        cellAlignment: pw.Alignment.center,
        cellPadding: pw.EdgeInsets.all(1.0),
        headers: <String>["SL.No", "A", "B", "C", "D", "E", "F"],
        data: jsonData.map<List<String>>((e) {
          return [
            "${e["Slno"]}",
            "${e["A"]}",
            "${e["B"]}",
            "${e["C"]}",
            "${e["D"]}",
            "${e["E"]}",
            "${e["F"]}",
          ];
        }).toList(),
      ),
      /*pw.Table(
          children: <pw.TableRow>[
            pw.TableRow(
              children: <pw.Text>[
                pw.Text("\t\tSL no"),
                pw.Text("\t\tName"),
                pw.Text("\t\tCp"),
                pw.Text("qty")
              ],
            )
          ],
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
          tableWidth: pw.TableWidth.max,
          //defaultColumnWidth: pw.IntrinsicColumnWidth(flex: 2),
          border: pw.TableBorder.all(
              color: PdfColors.black, width: 1.0, style: pw.BorderStyle.solid)),*/
    ),
    // ),
  );

  return pdf.save();
}
