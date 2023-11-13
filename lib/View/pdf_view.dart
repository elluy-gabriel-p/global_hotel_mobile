import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ugdlayout2/View/preview_screen.dart';

Future<void> createPdf(
    TextEditingController tipeController,
    TextEditingController hargaController,
    TextEditingController kapasitasController,
    String id,
    Uint8List image,
    BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final imageLogo =
      (await rootBundle.load("image/globalHotelLogo.png")).buffer.asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  pw.ImageProvider pdfImageProvider(Uint8List imageBytes) {
    return pw.MemoryImage(imageBytes);
  }

  pw.Padding dataKamarInput(
    TextEditingController tipeController,
    TextEditingController hargaController,
    TextEditingController kapasitasController,
  ) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  'Tipe Kamar',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  tipeController.text,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  'Harga Kamar',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  hargaController.text,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  'Kapasitas Kamar',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  kapasitasController.text,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  margin: pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                ),
                // Output image
                imageFromInput(pdfImageProvider, image),

                // Output data kamar
                dataKamarInput(
                  tipeController,
                  hargaController,
                  kapasitasController,
                ),
                pw.SizedBox(height: 10),

                topOfInvoice(imageInvoice),
                barcodeGaris(id),
                pw.SizedBox(height: 5),

                // Content of invoice
                contentOfInvoice(
                  dataKamarInput(
                    tipeController,
                    hargaController,
                    kapasitasController,
                  ),
                ),

                // Barcode
                barcodeKotak(id),
                pw.SizedBox(height: 1),
              ],
            ),
          ),
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
          color: PdfColor.fromHex('#FFBD59'),
          child: footerPDF(formattedDate),
        );
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PreviewScreen(doc: doc),
    ),
  );
}


pw.Header headerPDF() {
  return pw.Header(
    margin: pw.EdgeInsets.zero,
      outlineColor: PdfColors.amber50,
      outlineStyle: PdfOutlineStyle.normal,
      level: 5,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.rectangle,
        gradient: pw.LinearGradient(
          colors: [PdfColor.fromHex('#FCDF8A'), PdfColor.fromHex('#F38381')],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          '-Kamar Detail PDF-',
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 12,
          ),
        ),
      )
  );
}

pw.Padding imageFromInput(
    pw.ImageProvider Function(Uint8List imageBytes) pdfImageProvider,
    Uint8List imageBytes) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    child: pw.FittedBox(
      child: pw.Image(pdfImageProvider(imageBytes), width: 33),
      fit: pw.BoxFit.fitHeight,
      alignment: pw.Alignment.center,
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(imageInvoice, height: 30, width: 30),
        pw.Expanded(
          child: pw.Container(
            height: 10,
            decoration: const pw.BoxDecoration(
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
              color: PdfColors.amberAccent,
            ),
            padding: const pw.EdgeInsets.only(
              left: 40,
              top: 10,
              bottom: 10,
              right: 40,
            ),
            alignment: pw.Alignment.centerLeft,
            child: pw.DefaultTextStyle(
              style: const pw.TextStyle(
                color: PdfColors.amber100,
                fontSize: 12,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  contactInfoText('Global Hotel'),
                  contactInfoText('Jl. Menuju Kayangan'),
                  pw.SizedBox(height: 1),
                  contactInfoText('Yogyakarta 666'),
                  pw.SizedBox(height: 1),
                  pw.SizedBox(height: 1),
                  contactInfoText('Contact Us'),
                  pw.SizedBox(height: 1),
                  contactInfoText('Phone Number'),
                  contactInfoText('0812345678'),
                  contactInfoText('Email'),
                  contactInfoText('globalhotel@gmail.com'),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Text contactInfoText(String text) {
  return pw.Text(
    text,
    style: pw.TextStyle(
      fontSize: 10,
      color: PdfColors.blue800,
    ),
  );
}



pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Column(children: [
        pw.Text(
          "Dear Costumer thank you for trusting Global Hotel",
        ),
        pw.SizedBox(height: 3),//Tabel yang sudah diatur tampilannya dalam file item_doc.dart
        pw.Text("Thanks for your trust, and till the next time"),
        pw.SizedBox(height: 3),
        pw.Text("Kind Regards,"),
        pw.SizedBox(height: 3),
        pw.Text("Global Hotel"),
      ]));
}


pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
    child: pw.Center(
      child:
          //Jenis barcode berbeda dengan value sama (hanya untuk contoh guided)
          pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 15,
        height: 15,
      ),
    ),
  );
}

pw.Container barcodeGaris(String id) {
  return pw.Container(
    child: pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: pw.BarcodeWidget(
        barcode: Barcode.code128(escapes: true),
        data: id,
        width: 10,
        height: 5,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.blue)));

