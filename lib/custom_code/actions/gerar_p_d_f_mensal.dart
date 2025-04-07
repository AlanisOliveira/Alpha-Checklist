// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final List<PdfColor> colorPalette = [
  PdfColors.red800,
  PdfColors.green800,
  PdfColors.blue800,
  PdfColors.orange800,
  PdfColors.purple800,
  PdfColors.teal800,
  PdfColors.pink800,
  PdfColors.indigo800,
  PdfColors.deepOrange400,
  PdfColors.yellow800,
];

Future<void> gerarPDFMensal(
  String nomeEmpresa,
  String endereco,
  String avaliador,
  String profissao,
  String nomePDF,
  List<String>? riscosFisicos,
  List<String>? riscosQuimicos,
  List<String>? riscosBiologicos,
  List<String>? riscosErgonomicos,
  List<String>? riscosAcidentes,
  List<String>? modificacoesEmpresa,
  List<String>? modificacoesEmpresa2,
  List<String>? modificacoesEmpresa3,
  List<dynamic> assinaturas,
  String? descricaoModificacoes,
) async {
  final pdf = pw.Document();
  tz.initializeTimeZones();
  final brasilia = tz.getLocation('America/Sao_Paulo');
  final data = tz.TZDateTime.now(brasilia);

  try {
    final logoImage =
        await _carregarImagem('assets/images/Logo_Alpha_Consultoria.png');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 28, right: 25, top: 20, bottom: 20),
        build: (pw.Context context) {
          final List<pw.Widget> content = [];
          content.addAll([
            _buildHeader(logoImage),
            pw.SizedBox(height: 10),
            _buildInfoTable(nomeEmpresa, data, endereco, avaliador, profissao),
            pw.SizedBox(height: 10),
            _buildRiscos(
              riscosFisicos,
              riscosQuimicos,
              riscosBiologicos,
              riscosErgonomicos,
              riscosAcidentes,
            ),
            pw.SizedBox(height: 10),
            _buildModificacoesSection(
              modificacoesEmpresa,
              modificacoesEmpresa2,
              modificacoesEmpresa3,
              descricaoModificacoes ?? '',
            ),
            _buildTermoVeracidadeSection(assinaturas),
          ]);
          return content;
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: FFAppState().nomePDF ?? 'Relatorio_Alpha',
    );

    FFAppState().isPDFGerado = true;
  } catch (e) {
    print('Erro ao gerar pdf: $e');
    FFAppState().isPDFGerado = false;
  }
}

Future<pw.MemoryImage> _carregarImagem(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  final Uint8List bytes = data.buffer.asUint8List();
  return pw.MemoryImage(bytes);
}

pw.Widget _buildHeader(pw.MemoryImage logoImage) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black, width: 1),
    ),
    child: pw.Row(
      children: [
        pw.Container(
          width: 190,
          height: 50,
          child: pw.Image(logoImage),
          margin: pw.EdgeInsets.only(left: 10),
        ),
        pw.Container(
          height: 40,
          width: 0.5,
          margin: pw.EdgeInsets.symmetric(horizontal: 10),
          color: PdfColors.black,
        ),
        pw.Container(
          width: 300,
          height: 60,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'CHECKLIST PARA AVALIAÇÃO MENSAL',
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildInfoTable(
  String nomeEmpresa,
  tz.TZDateTime data,
  String endereco,
  String avaliador,
  String? profissao,
) {
  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: {
          0: pw.FixedColumnWidth(350),
          1: pw.FlexColumnWidth(50),
        },
        children: [
          pw.TableRow(
            children: [
              _buildInfoCabecalho('EMPRESA AVALIADA:', nomeEmpresa),
              _buildInfoCabecalho('DATA:',
                  '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}'),
            ],
          ),
        ],
      ),
      pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: {
          0: pw.FixedColumnWidth(271),
          1: pw.FixedColumnWidth(271),
        },
        children: [
          pw.TableRow(
            children: [
              _buildInfoCabecalho('ENDEREÇO:', endereco),
            ],
          ),
        ],
      ),
      pw.Table(border: pw.TableBorder.all(), children: [
        pw.TableRow(
          children: [
            _buildInfoCabecalho('AVALIADOR:', avaliador),
            _buildInfoCabecalho('PROFISSÃO:', profissao ?? ''),
          ],
        ),
      ]),
    ],
  );
}

pw.Widget _buildInfoCabecalho(String label, String value) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(4),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
        ),
        pw.SizedBox(width: 5),
        pw.Container(
          width: 200,
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 12),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildRiscos(
    List<String>? riscosFisicos,
    List<String>? riscosQuimicos,
    List<String>? riscosBiologicos,
    List<String>? riscosErgonomicos,
    List<String>? riscosAcidentes) {
  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: {
          0: const pw.FlexColumnWidth(1),
          1: const pw.FlexColumnWidth(1),
          2: const pw.FlexColumnWidth(1),
          3: const pw.FlexColumnWidth(
              1.2), // Slightly wider for ergonomic risks
          4: const pw.FlexColumnWidth(1.2), // Slightly wider for accident risks
        },
        children: [
          pw.TableRow(
            children: [
              _buildHeaderCell('FÍSICOS', PdfColors.green800),
              _buildHeaderCell('QUÍMICOS', PdfColors.red800),
              _buildHeaderCell('BIOLÓGICOS', PdfColors.deepOrange400),
              _buildHeaderCell('ERGONÔMICOS', PdfColors.yellow400),
              _buildHeaderCell('ACIDENTES', PdfColors.blue400),
            ],
          ),
          ..._buildRows(
            [
              riscosFisicos ?? [],
              riscosQuimicos ?? [],
              riscosBiologicos ?? [],
              riscosErgonomicos ?? [],
              riscosAcidentes ?? [],
            ],
            minRows: 5,
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildHeaderCell(String title, PdfColor color) {
  return pw.Container(
    alignment: pw.Alignment.center,
    height: 30,
    padding: const pw.EdgeInsets.all(5),
    decoration: pw.BoxDecoration(color: color),
    child: pw.Text(
      title,
      style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
      textAlign: pw.TextAlign.center,
    ),
  );
}

List<pw.TableRow> _buildRows(List<List<String>> allItems, {int minRows = 5}) {
  final maxLength =
      allItems.map((list) => list.length).fold(0, (a, b) => a > b ? a : b);
  final totalRows = maxLength > minRows ? maxLength : minRows;

  List<pw.TableRow> rows = [];
  for (int i = 0; i < totalRows; i++) {
    rows.add(
      pw.TableRow(
        children: allItems.map((items) {
          final text = i < items.length ? items[i] : '';
          return pw.Container(
            height: 25, // Fixed height for each cell
            padding: const pw.EdgeInsets.all(4),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  text,
                  style: const pw.TextStyle(fontSize: 8),
                  textAlign: pw.TextAlign.left,
                  maxLines: 2, // Limit to 2 lines
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  return rows;
}

pw.Widget _buildModificacoesSection(
  List? modificacoesEmpresa1,
  List? modificacoesEmpresa2,
  List? modificacoesEmpresa3,
  String descricaoModificacoes,
) {
  final allModificacoes = [
    'ALTERAÇÃO NO LAYOUT',
    'NOVO RISCO',
    'ADMISSÃO',
    'DEMISSÃO',
    'NÃO HOUVE ALTERAÇÃO',
    'ACIDENTE DE TRABALHO',
    'ASO ADMISSIONAL',
    'ASO DEMISSIONAL',
    'ASO PERIÓDICO'
  ];

  // Combina as listas em um único conjunto de dados
  final combinedModificacoes = {
    ...(modificacoesEmpresa1 ?? []),
    ...(modificacoesEmpresa2 ?? []),
    ...(modificacoesEmpresa3 ?? []),
  };

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(5),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'MODIFICAÇÕES E ALTERAÇÕES DA EMPRESA',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: pw.WrapAlignment.center,
              children: allModificacoes.map((modificacao) {
                final isChecked = combinedModificacoes.contains(modificacao);
                return pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Container(
                      width: 12,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      child: pw.Center(
                        child: pw.Text(
                          isChecked ? 'X' : '',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text(
                      modificacao,
                      style: pw.TextStyle(fontSize: 10),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
      pw.Container(
        width: double.infinity,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        child: pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          child: descricaoModificacoes == null || descricaoModificacoes.isEmpty
              ? pw.Column(
                  // Gera 8 linhas vazias
                  children: List.generate(
                    5,
                    (index) => pw.Container(
                      height: 30, // Altura ajustável conforme necessário
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : pw.Text(
                  descricaoModificacoes,
                  style: pw.TextStyle(fontSize: 10),
                  textAlign: pw.TextAlign.justify,
                ),
        ),
      ),
    ],
  );
}

pw.Widget _buildTermoVeracidadeSection(List<dynamic> assinaturas) {
  return pw.Stack(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Container(
                color: PdfColors.red,
                padding: pw.EdgeInsets.all(5),
                child: pw.Center(
                  child: pw.Text(
                    'TERMO DE VERACIDADE DAS INFORMAÇÕES PRESTADAS',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                        color: PdfColors.white),
                  ),
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Container(
                padding: pw.EdgeInsets.all(10),
                child: pw.Text(
                  'Declaro para devidos fins de direito, sob as penas da lei, que as informações prestadas e documentadas que apresentei, constituída para a finalidade de elaboração dos documentos técnicos de saúde e segurança do trabalho são verdadeiras e autênticas.',
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
          ...assinaturas
                  .map((assinatura) => pw.TableRow(
                        children: [
                          pw.Container(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'Assinatura do colaborador:',
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Container(
                                  height: 50,
                                  alignment: pw.Alignment.center,
                                  child: _buildAssinatura(
                                    assinatura['nome'] ?? '',
                                    assinatura['assinatura'] ?? '',
                                  ),
                                ),
                                pw.Container(
                                  width: 300,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(top: pw.BorderSide())),
                                  padding: pw.EdgeInsets.only(top: 5),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    assinatura['nome'] ?? '',
                                    style: pw.TextStyle(fontSize: 10),
                                    textAlign: pw.TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  .toList() ??
              [],
        ],
      ),
    ],
  );
}

pw.Widget _buildAssinatura(String nome, String base64Assinatura) {
  try {
    if (base64Assinatura.isNotEmpty) {
      final decodedImage = base64Decode(base64Assinatura);
      final image = pw.MemoryImage(decodedImage);
      return pw.Container(
        height: 50,
        width: 300,
        child: pw.Image(image),
      );
    }
  } catch (e) {
    print('Erro ao decodificar assinatura: $e');
  }

  return pw.Container(
    height: 50,
    width: 300,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(),
    ),
  );
}
