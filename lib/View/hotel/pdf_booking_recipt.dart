import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:barcode/barcode.dart';
import 'package:ugdlayout2/View/preview_screen.dart';
import '';

Future<void> createBookingPdf(
    String tipe,
    int jumlahKamar,
    String idBooking,
    int jumlahOrang,
    String checkin,
    String checkout,
    // String image,
    BuildContext context) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  //gambar untuk logo
  final imageLogo =
      (await rootBundle.load("image/globalHotelLogo.png")).buffer.asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  //ambil gambar dari galeri atau kamera
  pw.ImageProvider pdfImageProvider(Uint8List imageBytes) {
    return pw.MemoryImage(imageBytes);
  }

  // final imageBytes = File(image).readAsBytesSync();

  //border dokumen pdf

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1,
          ),
        ),
      );
    },
  );

  pw.Padding dataKamarInput(tipe, kapasitas, idBooking, jumlahOrang, checkin, checkout) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: pw.Table(
        border: pw.TableBorder.all(),
        children: [
          // add image on top row
          // pw.TableRow(
          //   children: [
          //     pw.Padding(
          //       padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       child: pw.Text(
          //         'Gambar Kamar',
          //         style: pw.TextStyle(
          //           fontWeight: pw.FontWeight.bold,
          //           fontSize: 10,
          //         ),
          //       ),
          //     ),
              // pw.Padding(
              //   padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   child: pw.Center(
              //     child: pw.FittedBox(
              //       fit: pw.BoxFit
              //           .contain, // You can change this to other BoxFit options
              //       child: pw.Image(pw.MemoryImage(roomImage!), height: 200),
              //     ),
              //   ),
              // ),
          //   ],
          // ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: pw.Text(
                  'Tipe Kamar',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: pw.Text(
                  tipe,
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
                padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: pw.Text(
                  'Id Booking',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: pw.Text(
                  idBooking,
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
                padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: pw.Text(
                  'Kapasitas Kamar',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: pw.Text(
                  kapasitas.toString(),
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
                padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: pw.Text(
                  'Jumlah Orang',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: pw.Text(
                  jumlahOrang.toString(),
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
      pageTheme: pdfTheme,
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
                    margin:
                        pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
                //outputkan gambar
                // imageFromInput(pdfImageProvider, imageBytes),

                //output data kamar
                dataKamarInput(tipe, jumlahKamar, idBooking, jumlahOrang, checkin, checkout),
                pw.SizedBox(height: 10),

                // topOfInvoice(imageInvoice),
                barcodeGaris(idBooking),
                pw.SizedBox(height: 5),

                // contentOfInvoice(table),

                //barcode
                barcodeKotak(idBooking),
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
            fontSize: 20,
          ),
        ),
      ));
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
              color: PdfColors.amberAccent),
          padding: const pw.EdgeInsets.only(
              left: 40, top: 10, bottom: 10, right: 40),
          alignment: pw.Alignment.centerLeft,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(color: PdfColors.amber100, fontSize: 12),
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                pw.Text('Global Hotel',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.Text('Jl. Menuju Kayangan',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.SizedBox(height: 1),
                pw.Text('Yogyakarta 666',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.SizedBox(height: 1),
                pw.SizedBox(height: 1),
                pw.Text('Contact Us',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.SizedBox(height: 1),
                pw.Text('Phone Number',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.Text('0812345678',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.Text('Email',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
                pw.Text('globalhotel@gmail.com',
                    style:
                        pw.TextStyle(fontSize: 10, color: PdfColors.blue800)),
              ],
            ),
          ),
        )),
      ],
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
        pw.SizedBox(height: 3),
        table, //Tabel yang sudah diatur tampilannya dalam file item_doc.dart
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
    child: pw.Column(
      children: [
        pw.Center(
          child:
              //Jenis barcode berbeda dengan value sama (hanya untuk contoh guided)
              pw.BarcodeWidget(
            barcode: pw.Barcode.qrCode(
              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
            ),
            data: id,
            width: 150,
            height: 150,
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Text(id),
        ),
      ],
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
        width: 100,
        height: 50,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) => pw.Center(
    child: pw.Text('Created At $formattedDate',
        style: pw.TextStyle(fontSize: 10, color: PdfColors.blue)));
