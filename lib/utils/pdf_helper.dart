import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart'; 

class PDFHelper {
  static Future<void> generateAndSavePDF(
      List<Map<String, Object>> summary, int? correctAnswers) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Quiz Result',
                  style: const pw.TextStyle(
                    fontSize: 20,
                  ),
                  
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'You answered $correctAnswers out of ${summary.length} questions correctly',
                ),
                pw.SizedBox(height: 20),
                _buildSummaryTable(summary),
              ],
            ),
          );
        },
      ),
    );

    final Directory? downloadsDir = await getDownloadsDirectory();
    print('downloadsDir... $downloadsDir');
    // final file = File("${downloadsDir!.path}/quiz_result.pdf");
    final output = await getTemporaryDirectory();
    // final out = await get
    final file = File("${output.path}/quiz_result.pdf");
    print('file... $file');
    await file.writeAsBytes(await pdf.save());

    // opens the PDF using the default viewer
    // await Process.run('open', [file.path]);
    OpenFile.open(file.path);
    print('file path... ${file.path}');
  }

  static pw.Widget _buildSummaryTable(List<Map<String, Object>> summary) {
    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: pw.FlexColumnWidth(1),
        1: pw.FlexColumnWidth(3),
        2: pw.FlexColumnWidth(3),
        3: pw.FlexColumnWidth(3),
      },
      children: [
        _buildTableRow(['Index', 'Question', 'Correct Answer', 'User Answer'],
            header: true),
        for (var data in summary)
          _buildTableRow([
            ((data['question_index'] as int) + 1).toString(),
            data['question'],
            data['correct_answer'],
            data['user_answer']
          ]),
      ],
    );
  }

  static pw.TableRow _buildTableRow(List<dynamic> data, {bool header = false}) {
    return pw.TableRow(
      children: [
        for (var cellData in data)
          pw.Container( 
            padding: const pw.EdgeInsets.all(8),
            alignment: header ? pw.Alignment.center : pw.Alignment.topLeft,
            child: pw.Text('$cellData',
                style: header
                    ? pw.TextStyle(fontWeight: pw.FontWeight.bold)
                    : null),
          ),
      ],
    );
  }
}
