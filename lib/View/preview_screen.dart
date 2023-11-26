import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;
  
  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
    MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          centerTitle: true,
          title: const Text("Preview"),
        ),
        body: PdfPreview(
            build: (format) => doc.save(),
            padding: isLandscape?  EdgeInsets.symmetric(horizontal: 20.w,vertical: 4.h) : EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
            allowSharing: true,
            allowPrinting: true,
            initialPageFormat: PdfPageFormat.a4,
        ));
  }
}
