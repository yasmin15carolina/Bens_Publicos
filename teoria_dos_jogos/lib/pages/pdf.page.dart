import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class PdfPage extends StatefulWidget {
  final String? pdfName;
  final Function? then;

  const PdfPage({this.pdfName, this.then});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PdfViewerController? _pdfViewerController;
  bool read = false;
  bool readEnd = false;
  @override
  void initState() {
    // TODO: implement initState
    _pdfViewerController = PdfViewerController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double longestSide = MediaQuery.of(context).size.longestSide;

    bool landscape = MediaQuery.of(context).size.aspectRatio > 1.5;
    double fontSize = landscape ? longestSide * 0.015 : longestSide * 0.03;
    double padding = landscape ? longestSide * 0.02 : longestSide * 0.03;

    return Scaffold(
        body:
            //  Container(
            //   child: pdfView()
            // ));
            //         Container(
            //   child: SfPdfViewer.network(
            //     // "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
            //     'https://ccompjr.com.br/BeGapp/files/pg61925.pdf',
            //     // "https://ccompjr.com.br/BeGapp/loadPdf.php",
            //     // 'https://ccompjr.com.br/BeGapp/files/${widget.pdfName}.pdf',
            //     controller: _pdfViewerController,
            //   ),
            // ));
            Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            child: SfPdfViewer.network(
              'https://ccompjr.com.br/BeGapp/files/pg61925.pdf',
              // 'https://ccompjr.com.br/BeGapp/files/${widget.pdfName}.pdf',
              controller: _pdfViewerController,
            ),
          ),
        ),
        // Expanded(flex: 1, child: Text("aa")),
        Row(
          children: [
            Checkbox(
              value: read,
              onChanged: (value) {
                setState(() {
                  readEnd = _pdfViewerController!.pageNumber ==
                      _pdfViewerController!.pageCount;

                  if (readEnd) read = value!;
                });
              },
            ),
            Text(
              "Li e concordo com os termos",
              //AppLocalizations.of(context).translate('useNextLevel'),
              style: TextStyle(fontSize: Resize.getWidth(context) * 0.05),
            )
          ],
        ),
        Container(
          // height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          padding: EdgeInsets.symmetric(vertical: padding / 2),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () async {
              if (readEnd) //print("CHEGOU AO FIM");
                widget.then!();
            },
            child: Text(AppLocalizations.of(context).translate('next'),
                style: TextStyle(fontSize: fontSize, color: Colors.white)),
          ),
        ),
      ],
    ));
  }
}
