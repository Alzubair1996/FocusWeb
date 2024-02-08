import 'dart:convert';

import 'dart:ui';


import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'GuardDetails.dart';

class PdfService {
  Future<void> printCustomersPdf(List<GuardData> data) async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();
    PdfGrid grid = PdfGrid();

    //Define number of columns in table
    grid.columns.add(count: 5);
    //Add header to the grid
    grid.headers.add(1);
    //Add the rows to the grid
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "Id";
    header.cells[1].value = "NAME_EN";
    header.cells[2].value = "POSITION_EN";
    header.cells[3].value = "DATE_OF_JOINING";
    header.cells[4].value = "NATIONALITY";
    //Add header style
    header.style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightGray,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
    );

    //Add rows to grid
    for (final customer in data) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = customer.ID_NO.toString();
      row.cells[1].value = customer.NAME_EN;
      row.cells[2].value = customer.POSITION_EN;
      row.cells[3].value = customer.DATE_OF_JOINING;
      row.cells[4].value = customer.NATIONALITY;
    }
    //Add rows style
    grid.style = PdfGridStyle(
      cellPadding: PdfPaddings(left: 10, right: 3, top: 4, bottom: 5),
      backgroundBrush: PdfBrushes.white,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
    );

    //Draw the grid
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = await document.save();
/*
    //Download document
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "report.pdf")
      ..click();
*/
    //Dispose the document
    document.dispose();
  }
}
