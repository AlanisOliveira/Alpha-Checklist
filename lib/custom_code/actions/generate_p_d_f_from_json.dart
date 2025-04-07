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
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

final Map<String, PdfColor> agentColors = {};
int colorIndex = 0;

final List<PdfColor> colorPalette = [
  PdfColors.red800,
  PdfColors.green800,
  PdfColors.blue800,
  PdfColors.orange800,
  PdfColors.purple800,
  PdfColors.teal800,
  PdfColors.pink800,
  PdfColors.indigo800,
];

Future<void> generatePDFFromJson(List<dynamic>? listadeRiscos) async {
  if (listadeRiscos == null || listadeRiscos.isEmpty) {
    print('Lista de riscos está vazia ou nula.');
    return;
  }

  final pdf = pw.Document();
  final logoImage = await carregarImagem(
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/alpha-checklist-fiy1cd/assets/b11dtgcg6lti/Logo_Alpha_Consultoria.png');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          buildHeader(logoImage),
          pw.SizedBox(height: 10),
          ...listadeRiscos.map((risco) {
            final riscoMap = risco as Map<String, dynamic>;
            return buildRiskSection(riscoMap);
          }).toList(),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

Future<pw.MemoryImage> carregarImagem(String url) async {
  final response = await http.get(Uri.parse(url));
  return pw.MemoryImage(response.bodyBytes);
}

pw.Widget buildHeader(pw.MemoryImage logoImage) {
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
        pw.Expanded(
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

pw.Widget createImageWrap(List<String> base64Images, {double maxWidth = 500}) {
  List<pw.Widget> imageWidgets = [];

  for (String base64String in base64Images) {
    try {
      final decodedImage = base64Decode(base64String);
      final image = pw.MemoryImage(decodedImage);

      imageWidgets.add(pw.Container(
        width: maxWidth,
        child: pw.Image(image),
        margin: pw.EdgeInsets.only(bottom: 10),
      ));
    } catch (e) {
      print('Error decoding or rendering image: $e');
      imageWidgets.add(pw.Container(
        width: maxWidth,
        height: 100,
        margin: pw.EdgeInsets.only(bottom: 10),
        child: pw.Center(
          child: pw.Text('Imagem não disponível',
              style: pw.TextStyle(fontSize: 10)),
        ),
      ));
    }
  }

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: imageWidgets,
  );
}

pw.TableRow _buildSpacerRow(double height) {
  return pw.TableRow(
    children: [pw.Container(height: height)],
  );
}

pw.Widget buildRiskSection(Map<String, dynamic> risco) {
  final agentType = risco['TipoAgente'] as String;
  if (!agentColors.containsKey(agentType)) {
    agentColors[agentType] = colorPalette[colorIndex % colorPalette.length];
    colorIndex++;
  }
  final color = agentColors[agentType]!;

  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.black),
    children: [
      _buildAgentTypeRow(agentType, color),
      _buildAgentRow(risco),
      _buildRiskMatrixRow(risco),
      _buildGeneratingSourcesSection(risco),
      _buildAssessmentsSection(risco),
      _buildEPISection(risco),
      _buildEPCSection(risco),
      _buildControlMeasuresSection(risco),
      _buildAdditionalDataSection(risco),
      _buildDangerActivityProcessSection(risco),
      _buildImagesSection(risco),
    ],
  );
}

pw.Widget _buildCheckbox(String label, dynamic value) {
  return pw.Row(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      pw.Container(
        width: 8,
        height: 8,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
          color: value == label ? PdfColors.black : PdfColors.white,
        ),
      ),
      pw.SizedBox(width: 2),
      pw.Text(label, style: pw.TextStyle(fontSize: 8)),
    ],
  );
}

pw.Widget _buildSectionHeader(String title) {
  return pw.Container(
    color: PdfColors.grey400,
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
  );
}

pw.Widget _buildDataCell(String text, {double fontSize = 10}) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(5),
    child: pw.Text(text, style: pw.TextStyle(fontSize: fontSize)),
  );
}

pw.TableRow _buildAgentTypeRow(String agentType, PdfColor color) {
  return pw.TableRow(
    children: [
      pw.Container(
        color: color,
        padding: pw.EdgeInsets.all(5),
        child: pw.Center(
          child: pw.Text(
            agentType,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
              color: PdfColors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

pw.TableRow _buildAgentRow(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(children: [
            pw.Padding(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text(
                'Agente: ${risco['Agente']}',
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ]),
        ],
      ),
    ],
  );
}

pw.TableRow _buildRiskMatrixRow(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColors.grey400),
            children: [
              _buildDataCell('Matriz de Risco', fontSize: 10),
              _buildDataCell('Gradação de Probabilidade', fontSize: 10),
              _buildDataCell('Gradação de Severidade', fontSize: 10),
              _buildDataCell('Nível/Gravidade', fontSize: 10),
            ],
          ),
          pw.TableRow(
            children: [
              _buildDataCell(risco['MatrizdeRisco'] ?? ''),
              _buildDataCell(risco['GradacaoProbabilidade'] ?? ''),
              _buildDataCell(risco['GradacaoSeveridade'] ?? ''),
              _buildDataCell(risco['NivelGravidade'] ?? ''),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildGeneratingSourcesSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader('Fontes Geradoras'),
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
            ),
            child: pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              children: (risco['Ambientes']['TiposDeAmbientesItem']
                              as List<dynamic>?)
                          ?.isNotEmpty ==
                      true
                  ? (risco['Ambientes']['TiposDeAmbientesItem']
                          as List<dynamic>)
                      .map((fonte) => pw.TableRow(
                            children: [
                              pw.Container(
                                height: 20,
                                alignment: pw.Alignment.center,
                                padding: pw.EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: pw.Text(fonte.toString(),
                                    style: pw.TextStyle(fontSize: 10)),
                              ),
                            ],
                          ))
                      .toList()
                  : List.generate(
                      5,
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
                      ),
                    ),
            ),
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildAssessmentsSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          // Cabeçalho da seção
          pw.TableRow(
            children: [
              _buildSectionHeader('Avaliações'),
            ],
          ),
          // Tabela de Avaliação e Meio de propagação
          pw.TableRow(
            children: [
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildDataCell('Avaliação', fontSize: 12),
                      _buildDataCell('Meio de propagação', fontSize: 12),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            _buildCheckbox('Quantitativa', risco['Avaliacao']),
                            pw.SizedBox(width: 15),
                            _buildCheckbox('Qualitativa', risco['Avaliacao']),
                          ],
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            _buildCheckbox(
                                'Ar - Cutâneo', risco['MeioDePropagacao']),
                            _buildCheckbox(
                                'Ar - Respiratório', risco['MeioDePropagacao']),
                            _buildCheckbox(
                                'Ar - Sonora', risco['MeioDePropagacao']),
                            _buildCheckbox(
                                'Contato', risco['MeioDePropagacao']),
                            _buildCheckbox(
                                'Não aplicável', risco['MeioDePropagacao']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Tabela de Situação e Tempo de exposição
          pw.TableRow(
            children: [
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildDataCell('Situação', fontSize: 12),
                      _buildDataCell('Tempo de exposição', fontSize: 12),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Center(
                          child: pw.Text(risco['Situacao'] ?? ''),
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Center(
                          child: pw.Text(
                              '${risco['TempoExposicao'] ?? ''} ${risco['Tempo'] ?? ''}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildEPISection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          // Cabeçalho da seção
          pw.TableRow(
            children: [
              pw.Container(
                color: PdfColors.grey200,
                padding: pw.EdgeInsets.all(5),
                child: pw.Center(
                  child: pw.Text(
                    'EPI(s)',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // EPIs Recomendados e Utilizados
          pw.TableRow(
            children: [
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      _buildDataCell('EPI(s) Recomendado(s):', fontSize: 12),
                      _buildDataCell('EPI(s) Utilizado(s):', fontSize: 12),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildDataCell(risco['EPIsRecomendados'] ?? ''),
                      _buildDataCell(risco['EPIsUtilizados'] ?? ''),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Seção EPI(s)?
          pw.TableRow(
            children: [
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('EPI(s)?',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCheckbox('Eficaz', risco['EPIs']),
                            _buildCheckbox('Não Eficaz', risco['EPIs']),
                            _buildCheckbox('Não Aplicável', risco['EPIs']),
                            _buildCheckbox('Não Utilizado', risco['EPIs']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildEPCSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader('EPC(s)'),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildDataCell('EPC(s) Recomendado(s):', fontSize: 12),
                  _buildDataCell('EPC(s) Utilizado(s):', fontSize: 12),
                ],
              ),
              pw.TableRow(
                children: [
                  _buildDataCell(risco['EPCsRecomendados'] ?? ''),
                  _buildDataCell(risco['EPCsUtilizados'] ?? ''),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildControlMeasuresSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader('Medida(s) de Controle'),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildDataCell('Medida(s) de Controle Recomendada(s):',
                      fontSize: 12),
                  _buildDataCell('Medida(s) de Controle Implementada(s):',
                      fontSize: 12),
                ],
              ),
              pw.TableRow(
                children: [
                  _buildDataCell(risco['MedidasRecomendadas'] ?? ''),
                  _buildDataCell(risco['MedidasUtilizadas'] ?? ''),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildAdditionalDataSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader('Dados adicionais'),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildDataCell('Descrição:', fontSize: 12),
                  _buildDataCell('Sugestões:', fontSize: 12),
                  _buildDataCell('Risco(s):', fontSize: 12),
                ],
              ),
              pw.TableRow(
                children: [
                  _buildDataCell(risco['Descricao'] ?? ''),
                  _buildDataCell(risco['Sugestao'] ?? ''),
                  _buildDataCell(risco['Risco'] ?? ''),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildDangerActivityProcessSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
        children: [
          _buildSectionHeader('Perigo(s) / Atividade(s) / Processo(s)'),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildDataCell('Perigo(s):', fontSize: 12),
                  _buildDataCell('Atividade(s)/Processo(s):', fontSize: 12),
                ],
              ),
              pw.TableRow(
                children: [
                  _buildDataCell(risco['Perigos'] ?? ''),
                  _buildDataCell(risco['AtividadesProcessos'] ?? ''),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildImagesSection(Map<String, dynamic> risco) {
  return pw.TableRow(
    children: [
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          // Cabeçalho da seção
          pw.TableRow(
            children: [
              _buildSectionHeader('Imagens'),
            ],
          ),
          // Conteúdo da seção de imagens
          pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Descrição: ${risco['descricaoImagem'] ?? ''}',
                      style: pw.TextStyle(
                          fontSize: 10, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5),
                    createImageWrap(
                        (risco['Imagens']['ImagensRiscos'] as List<dynamic>)
                            .cast<String>(),
                        maxWidth: 500),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
