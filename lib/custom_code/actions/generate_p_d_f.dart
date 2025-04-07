// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> generatePDF(
  String nomeEmpresa,
  String setor,
  String funcao,
  String avaliador,
  List<String>? listPoliticas,
  List<String>? ambienteTagList,
  List<String>? pisoTagList,
  List<String>? paredeTagList,
  List<String>? coberturaTagList,
  List<String>? iluminacaoTagList,
  List<String>? ventilacaoTagList,
  List<String>? nomeColaboradores,
  String? descColaboradores,
  String? descAgravos,
  String? descEpis,
  String? medidasImplementadas,
) async {
  final pdf = pw.Document();
  tz.initializeTimeZones();
  final brasilia = tz.getLocation('America/Sao_Paulo');
  final horario = tz.TZDateTime.now(brasilia);

  try {
    final logoImage = await _carregarImagem(
        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/alpha-checklist-fiy1cd/assets/b11dtgcg6lti/Logo_Alpha_Consultoria.png');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 28, right: 25, top: 20, bottom: 20),
        build: (pw.Context context) {
          return [
            _buildHeader(logoImage),
            pw.SizedBox(height: 10),
            _buildInfoTable(nomeEmpresa, horario, setor, avaliador, funcao),
            pw.SizedBox(height: 10),
            _buildPoliticasSection(listPoliticas),
            pw.SizedBox(height: 10),
            _buildDescricaoAmbienteSection(
                ambienteTagList,
                pisoTagList,
                paredeTagList,
                coberturaTagList,
                iluminacaoTagList,
                ventilacaoTagList),
            pw.SizedBox(height: 10),
            _buildColaboradoresSection(nomeColaboradores),
            pw.SizedBox(height: 10),
            _buildDescricaoAtividadesSection(descColaboradores),
            pw.SizedBox(height: 10),
            _buildAgravosSection(descAgravos),
            pw.NewPage(),
            _buildHeader(logoImage),
            pw.SizedBox(height: 10),
            _buildMedidasPrevencaoSection(medidasImplementadas),
            pw.SizedBox(height: 10),
            _buildEpisSection(descEpis),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  } catch (e) {
    print('Erro ao gerar o PDF: $e');
  }
}

Future<pw.MemoryImage> _carregarImagem(String url) async {
  final response = await http.get(Uri.parse(url));
  return pw.MemoryImage(response.bodyBytes);
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
                'CHECKLIST PARA AVALIAÇÕES DE RISCOS AMBIENTAIS',
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                '(Levantamento Preliminar de Perigo, Análise Preliminar de Riscos, Avaliação Ergonômica Preliminar)',
                style: pw.TextStyle(fontSize: 6),
                textAlign: pw.TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildInfoTable(String nomeEmpresa, tz.TZDateTime horario,
    String setor, String avaliador, String funcao) {
  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: {
          0: pw.FixedColumnWidth(400),
          1: pw.FixedColumnWidth(142),
        },
        children: [
          pw.TableRow(
            children: [
              _buildInfoCell('EMPRESA AVALIADA:', nomeEmpresa),
              _buildInfoCell('DATA:',
                  '${horario.day.toString().padLeft(2, '0')}/${horario.month.toString().padLeft(2, '0')}/${horario.year}'),
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
              _buildInfoCell('SETOR / GHE:', setor),
              _buildInfoCell('AVALIADOR:', avaliador),
            ],
          ),
        ],
      ),
      pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: {
          0: pw.FixedColumnWidth(542),
        },
        children: [
          pw.TableRow(
            children: [
              _buildInfoCell('FUNÇÕES:', funcao),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildInfoCell(String label, String value) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(4),
    child: pw.Row(
      children: [
        pw.Text(label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
        pw.SizedBox(width: 5),
        pw.Text(value, style: pw.TextStyle(fontSize: 12)),
      ],
    ),
  );
}

pw.Widget _buildPoliticasSection(List<String>? listPoliticas) {
  final allPolicies = [
    'Política',
    'PGR',
    'LTCAT',
    'PCMSO',
    'PAE',
    'LTI',
    'LTP',
    'PCA',
    'PPR',
    'AET',
    'AEP',
    'ASO'
  ];

  return pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: PdfColors.grey200,
            padding: pw.EdgeInsets.all(5),
            child: pw.Center(
              child: pw.Text(
                'POLÍTICA E PROGRAMAS DE SAÚDE E SEGURANÇA',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
              ),
            ),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(5),
            child: pw.Wrap(
              alignment: pw.WrapAlignment.center,
              spacing: 5,
              runSpacing: 10,
              children: allPolicies.map((policy) {
                bool isSelected = listPoliticas?.contains(policy) ?? false;
                return pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Container(
                      width: 8,
                      height: 8,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                        color: isSelected ? PdfColors.black : PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text(policy, style: pw.TextStyle(fontSize: 10)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildDescricaoAmbienteSection(
  List<String>? ambienteTagList,
  List<String>? pisoTagList,
  List<String>? paredeTagList,
  List<String>? coberturaTagList,
  List<String>? iluminacaoTagList,
  List<String>? ventilacaoTagList,
) {
  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Container(
                color: PdfColors.grey200,
                padding: pw.EdgeInsets.all(5),
                child: pw.Center(
                  child: pw.Text(
                    'DESCRIÇÃO DO AMBIENTE DE TRABALHO',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColors.grey200),
            children: [
              _buildHeaderCell('Tipo de Ambiente'),
              _buildHeaderCell('Tipo de Piso'),
              _buildHeaderCell('Tipo de Parede'),
              _buildHeaderCell('Cobertura'),
              _buildHeaderCell('Tipo de Iluminação'),
              _buildHeaderCell('Tipo de Ventilação'),
            ],
          ),
          pw.TableRow(
            children: [
              _createSubTable(ambienteTagList),
              _createSubTable(pisoTagList),
              _createSubTable(paredeTagList),
              _createSubTable(coberturaTagList),
              _createSubTable(iluminacaoTagList),
              _createSubTable(ventilacaoTagList),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildHeaderCell(String text) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(7),
    child: pw.Text(text,
        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
  );
}

pw.Widget _createSubTable(List<String>? items, {int minRows = 5}) {
  List<pw.TableRow> rows = [];

  if (items != null && items.isNotEmpty) {
    rows = items
        .map((item) => pw.TableRow(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(4),
                  child: pw.Text(item, style: pw.TextStyle(fontSize: 8)),
                ),
              ],
            ))
        .toList();
  }

  while (rows.length < minRows) {
    rows.add(pw.TableRow(
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.all(4),
          child: pw.Text('', style: pw.TextStyle(fontSize: 8)),
        ),
      ],
    ));
  }

  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.black),
    children: rows,
  );
}

pw.Widget _buildColaboradoresSection(List<String>? nomeColaboradores) {
  return pw.Column(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Container(
                color: PdfColors.grey200,
                padding: pw.EdgeInsets.all(5),
                child: pw.Center(
                  child: pw.Text(
                    'NOME DOS COLABORADORES DO SETOR',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        child: pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          children: nomeColaboradores != null && nomeColaboradores.isNotEmpty
              ? nomeColaboradores
                  .map((nome) => pw.TableRow(
                        children: [
                          pw.Container(
                            height: 20,
                            alignment: pw.Alignment.center,
                            padding: pw.EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: pw.Text(nome,
                                style: pw.TextStyle(fontSize: 10)),
                          ),
                        ],
                      ))
                  .toList()
              : List.generate(
                  10,
                  (index) => pw.TableRow(
                        children: [
                          pw.Container(
                            height: 20,
                            alignment: pw.Alignment.center,
                            padding: pw.EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child:
                                pw.Text('', style: pw.TextStyle(fontSize: 10)),
                          ),
                        ],
                      )),
        ),
      ),
    ],
  );
}

pw.Widget _buildDescricaoAtividadesSection(String? descColaboradores) {
  return _buildSectionWithTitle(
    'DESCRIÇÃO DAS ATIVIDADES QUE OS COLABORADORES DO SETOR DESENVOLVEM',
    descColaboradores ?? '',
  );
}

pw.Widget _buildAgravosSection(String? descAgravos) {
  return _buildSectionWithTitle(
    'DESCRIÇÃO DOS POSSÍVEIS AGRAVOS À SAÚDE',
    descAgravos ?? '',
  );
}

pw.Widget _buildMedidasPrevencaoSection(String? medidasImplementadas) {
  return _buildSectionWithTitle(
    'DESCRIÇÃO DAS MEDIDAS DE PREVENÇÃO IMPLEMENTADAS',
    medidasImplementadas ?? '',
  );
}

pw.Widget _buildEpisSection(String? descEpis) {
  return _buildSectionWithTitle(
    'EPIS UTILIZADOS / CERTIFICADOS DE APROVAÇÃO',
    descEpis ?? '',
  );
}

pw.Widget _buildSectionWithTitle(String title, String content) {
  return pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            color: PdfColors.grey200,
            padding: pw.EdgeInsets.all(5),
            child: pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(10),
            child: pw.Text(content, style: pw.TextStyle(fontSize: 10)),
          ),
        ],
      ),
    ],
  );
}
