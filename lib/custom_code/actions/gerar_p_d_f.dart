// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'index.dart'; // Imports other custom actions

import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Variáveis globais
final Map<String, PdfColor> agentColors = {
  'Físico': PdfColors.green800,
  'Químico': PdfColors.red800,
  'Biológico': PdfColors.brown800,
  'Ergonômico': PdfColors.yellow800,
  'Psicossociais': PdfColors.yellow800,
  'Acidentes': PdfColors.blue800,
  'Desconhecido': PdfColors.grey800,
};

int colorIndex = 0;
final double pageWidth = 595;

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

// Função principal
Future<void> gerarPDF(
  String nomeEmpresa,
  String setor,
  List<String> funcao,
  String avaliador,
  List<String>? listPoliticas,
  List<String>? ambienteTagList,
  List<String>? pisoTagList,
  List<String>? paredeTagList,
  List<String>? coberturaTagList,
  List<String>? iluminacaoTagList,
  List<String>? ventilacaoTagList,
  List<String>? pavimentoList,
  List<String>? protecaoIncendioList,
  List<String>? maquinasList,
  String? outrosProgramas,
  List<String>? nomeColaboradores,
  String? descColaboradores,
  String? descAgravos,
  String? descEpis,
  String? medidasImplementadas,
  List<dynamic>? listadeRiscos,
  String? espacoConfinado,
  String? treinamentoNR33,
  DateTime? dataNR33,
  String? descricaoNR33,
  String? trabalhoAltura,
  String? treinamentoNR35,
  DateTime? dataNR35,
  String? descricaoNR35,
  String? trabalhoEletricidade,
  String? treinamentoNR10,
  DateTime? dataNR10,
  String? descricaoNR10,
  String? conducaoVeiculos,
  String? treinamentoDirecao,
  DateTime? dataDirecao,
  String? descricaoDirecao,
  String? operacaoEquipamento,
  String? treinamentoOperacao,
  DateTime? dataOperacao,
  String? descricaoOperacao,
  String? aposentadoriaEspecial,
  String? cartaoIdentificacao,
  String? observacoes,
  List<dynamic> assinaturas,
  List<String>? possiveis,
  List<dynamic>? PreSelecao,
  String? treinamentoRealizado,
) async {
  final pdf = pw.Document();
  tz.initializeTimeZones();
  final brasilia = tz.getLocation('America/Sao_Paulo');
  final horario = tz.TZDateTime.now(brasilia);

  try {
    final logoImage =
        await _carregarImagem('assets/images/Logo_Alpha_Consultoria.png');

    // Primeira parte do PDF (informações gerais)
    pdf.addPage(
      pw.MultiPage(
        maxPages: 1000,
        pageFormat: PdfPageFormat.a4,
        margin:
            const pw.EdgeInsets.only(left: 28, right: 25, top: 20, bottom: 20),
        build: (pw.Context context) {
          final List<pw.Widget> content = [];

          // Seção Inicial
          content.addAll([
            _buildHeader(logoImage),
            pw.SizedBox(height: 10),
            _buildInfoTable(nomeEmpresa, horario, setor, avaliador, funcao),
            pw.SizedBox(height: 10),
            _buildAgentsSection(PreSelecao),
            pw.SizedBox(height: 10),
            _buildPoliticasSection(listPoliticas, outrosProgramas),
            pw.SizedBox(height: 19),
            _buildDescricaoAmbienteSection(
              ambienteTagList,
              pisoTagList,
              paredeTagList,
              coberturaTagList,
              iluminacaoTagList,
              ventilacaoTagList,
              pavimentoList,
              protecaoIncendioList,
              maquinasList,
            ),
            pw.SizedBox(height: 10),
            _buildColaboradoresSection(nomeColaboradores),
            pw.SizedBox(height: 10),
            _buildDescricaoAtividadesSection(descColaboradores),
            pw.SizedBox(height: 10),
            _buildAgravosSection(descAgravos),
            pw.SizedBox(height: 10),
            _buildMedidasPrevencaoSection(medidasImplementadas),
            pw.SizedBox(height: 10),
            _buildEpisSection(descEpis),
            pw.SizedBox(height: 10),
          ]);

          // Seção de Riscos
          if (listadeRiscos != null && listadeRiscos.isNotEmpty) {
            for (var risco in listadeRiscos) {
              final riscoMap = risco as Map<String, dynamic>;

              content.addAll([
                pw.Table(
                    children: [_buildAgentTypeRow(riscoMap['TipoAgente'])]),
                pw.SizedBox(height: 10),
                pw.Table(children: [_buildAgentRow(riscoMap)]),
                pw.SizedBox(height: 10),
                pw.Table(children: [_buildRiskMatrixRow(riscoMap)]),
                pw.SizedBox(height: 10),
                pw.Table(children: [_buildGeneratingSourcesSection(riscoMap)]),
                pw.SizedBox(height: 10),
                pw.Table(children: [_buildAssessmentsSection(riscoMap)]),
                pw.SizedBox(height: 10),
                _buildEPISection(riscoMap),
                pw.SizedBox(height: 10),
                _buildEPCSection(riscoMap),
                pw.SizedBox(height: 10),
                _buildControlMeasuresSection(riscoMap),
                pw.SizedBox(height: 10),
                _buildAdditionalDataSection(riscoMap),
                pw.SizedBox(height: 10),
                _buildDangerActivityProcessSection(riscoMap),
                pw.SizedBox(height: 10),
              ]);

              // Seção de Imagens
              if (riscoMap['Imagens']?['ImagensRiscos']?.isNotEmpty ?? false) {
                content.addAll(_buildImagesSection(riscoMap));
                content.add(pw.SizedBox(height: 10));
              }
            }
          } else {
            content.addAll([
              pw.Center(
                child: pw.Text(
                  'Nenhum risco adicional identificado\n'
                  'Riscos pré-selecionados estão contemplados na análise inicial',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
            ]);
          }

          // Seção Final
          content.addAll([
            _buildTrainingSection(
              espacoConfinado,
              treinamentoNR33,
              dataNR33,
              descricaoNR33,
              trabalhoAltura,
              treinamentoNR35,
              dataNR35,
              descricaoNR35,
              trabalhoEletricidade,
              treinamentoNR10,
              dataNR10,
              descricaoNR10,
              conducaoVeiculos,
              treinamentoDirecao,
              dataDirecao,
              descricaoDirecao,
              operacaoEquipamento,
              treinamentoOperacao,
              dataOperacao,
              descricaoOperacao,
              cartaoIdentificacao,
              possiveis,
              treinamentoRealizado,
            ),
            pw.SizedBox(height: 10),
            _buildObservacoesSection(observacoes),
            pw.SizedBox(height: 10),
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
    print('Erro ao gerar o PDF: $e');
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
    String setor, String avaliador, List<String> funcao) {
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
              _buildInfoCell('FUNÇÕES:', funcao.join(', ')),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildAgentsSection(List<dynamic>? PreSelecao,
    {pw.Context? context}) {
  // Fallback seguro para data
  final data = (PreSelecao != null && PreSelecao.isNotEmpty)
      ? PreSelecao[0]
      : <String, dynamic>{};

  final listaAgente = data['listaAgente'] as Map<String, dynamic>? ?? {};

  // Cores definidas pelo usuário
  final Map<String, PdfColor> agentColors = {
    'Físico': PdfColors.green800,
    'Químico': PdfColors.red800,
    'Biológico': PdfColors.brown800,
    'Ergonômico': PdfColors.yellow800,
    'Psicossociais': PdfColors.yellow800,
    'Acidentes': PdfColors.blue800,
    'Desconhecido': PdfColors.grey800,
  };

  // Função para criar "pills" dos agentes
  pw.Widget _createAgentPill(String agentName) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(right: 3, bottom: 3),
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
      ),
      child: pw.Text(
        agentName,
        style: const pw.TextStyle(fontSize: 7),
      ),
    );
  }

  // Versão revisada da seção de agentes com cabeçalho no topo
  pw.Widget _buildAgentTypeSection(String title, String dataKey) {
    final agents = listaAgente[dataKey] as List? ?? [];
    final color = agentColors[title] ?? PdfColors.grey800;

    // Se não houver agentes, mostra mensagem
    if (agents.isEmpty) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        margin: const pw.EdgeInsets.only(bottom: 1),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // Cabeçalho colorido com o nome
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                color: color, // Cor movida para dentro da BoxDecoration
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Text(
                'Agentes $title',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ),
            // Área principal - mensagem de nenhum agente
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                'Nenhum agente selecionado',
                style: pw.TextStyle(
                  fontSize: 7,
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      margin: const pw.EdgeInsets.only(bottom: 1),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // Cabeçalho colorido com o nome
          pw.Container(
            color: color,
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            alignment: pw.Alignment.center,
            child: pw.Text(
              'Agentes $title',
              style: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
                fontSize: 8,
              ),
            ),
          ),
          // Área de pills em wrap
          pw.Container(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Wrap(
              children: agents
                  .map((agent) => _createAgentPill(agent.toString()))
                  .toList(),
              spacing: 2,
              runSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  // Função para criar o cabeçalho da seção
  pw.Widget _buildSectionHeader() {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColors.grey200,
        border: pw.Border.all(color: PdfColors.black),
      ),
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      alignment: pw.Alignment.center,
      child: pw.Text(
        'RISCOS PRÉ-SELECIONADOS',
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 9,
        ),
      ),
    );
  }

  const agentTypes = {
    'Físico': 'AgentesFisicos',
    'Químico': 'AgentesQuimicos',
    'Biológico': 'AgentesBiologicos',
    'Ergonômico': 'AgentesErgonomicos',
    'Psicossociais': 'AgentesPsicossociais',
    'Acidentes': 'AgentesAcidentes',
  };

  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        _buildSectionHeader(),
        ...agentTypes.entries.map((entry) {
          return _buildAgentTypeSection(entry.key, entry.value);
        }).toList(),
      ],
    ),
  );
}

pw.Widget _buildInfoCell(String label, String value) {
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

pw.Widget _buildPoliticasSection(List? listPoliticas, outrosProgramas) {
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
    'ASO',
    'NÃO FOI EVIDÊNCIADO DURANTE VISITA TÉCNICA'
  ];

  return pw.Stack(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              border: pw.Border.all(),
            ),
            child: pw.Text(
              'POLÍTICA E PROGRAMAS DE SAÚDE E SEGURANÇA',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 9,
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          // Conteúdo
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Wrap(
              alignment: pw.WrapAlignment.start,
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
          // Outros Programas
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Text(
              'Outros Programas: ' + (outrosProgramas ?? ''),
              style: pw.TextStyle(fontSize: 10),
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
  List<String>? pavimentoList,
  List<String>? maquinasList,
  List<String>? protecaoIncendioList,
) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
    ),
    child: pw.Stack(
      children: [
        // Conteúdo principal com padding para o título
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20), // Espaço para o título
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Tabela de conteúdo
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(1),
                },
                children: [
                  // Cabeçalho das colunas
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      _buildHeaderCell('Tipo de Ambiente'),
                      _buildHeaderCell('Tipo de Piso'),
                      _buildHeaderCell('Tipo de Parede'),
                    ],
                  ),
                  // Conteúdo das colunas
                  pw.TableRow(
                    children: [
                      _createSubTable(ambienteTagList),
                      _createSubTable(pisoTagList),
                      _createSubTable(paredeTagList),
                    ],
                  ),
                  // Cabeçalho das colunas
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      _buildHeaderCell('Cobertura'),
                      _buildHeaderCell('Tipo de Iluminação'),
                      _buildHeaderCell('Tipo de Ventilação'),
                    ],
                  ),
                  // Conteúdo das colunas
                  pw.TableRow(
                    children: [
                      _createSubTable(coberturaTagList),
                      _createSubTable(iluminacaoTagList),
                      _createSubTable(ventilacaoTagList),
                    ],
                  ),
                  // Cabeçalho das colunas
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      _buildHeaderCell('Pavimento'),
                      _buildHeaderCell('Máquinas e Equipamentos'),
                      _buildHeaderCell('Proteção contra incêndio'),
                    ],
                  ),
                  // Conteúdo das colunas
                  pw.TableRow(
                    children: [
                      _createSubTable(pavimentoList),
                      _createSubTable(maquinasList),
                      _createSubTable(protecaoIncendioList),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Título sobreposto com fundo cinza
        pw.Positioned(
          top: 2,
          left: (pageWidth / 2) - 140,
          child: pw.Container(
            color: PdfColors.white,
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: pw.Text(
              'DESCRIÇÃO DO AMBIENTE DE TRABALHO',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildHeaderCell(String text) {
  return pw.Container(
    alignment: pw.Alignment.center,
    height: 30,
    padding: const pw.EdgeInsets.all(4),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
      textAlign: pw.TextAlign.center,
    ),
  );
}

pw.Widget _createSubTable(List<String>? items, {int minRows = 4}) {
  List<pw.TableRow> rows = [];

  if (items != null && items.isNotEmpty) {
    rows = items
        .map((item) => pw.TableRow(
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  height: 15,
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(
                    item,
                    style: const pw.TextStyle(fontSize: 8),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ],
            ))
        .toList();
  }

  while (rows.length < minRows) {
    rows.add(
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            height: 15,
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.black),
    children: rows,
  );
}

pw.Widget _buildColaboradoresSection(List<String>? nomeColaboradores) {
  return pw.LayoutBuilder(builder: (context, constraints) {
    // Calcular altura necessária (aproximada)
    final numLinhas = nomeColaboradores?.length ?? 10;
    final alturaEstimada = 30 + (numLinhas * 20); // Cabeçalho + linhas

    // Usando acesso condicional (?.) para verificar se maxHeight é menor que alturaEstimada
    if (constraints?.maxHeight != null &&
        constraints!.maxHeight < alturaEstimada) {
      // Retornar um widget vazio que ocupa o resto da página atual,
      // forçando toda a tabela a ir para a próxima página
      return pw.Container(
        height: constraints.maxHeight,
      );
    } else {
      // Construir a tabela inteira com cabeçalho e conteúdo juntos
      return pw.Container(
        child: _buildTabelaColaboradoresCompleta(nomeColaboradores),
      );
    }
  });
}

pw.Widget _buildTabelaColaboradoresCompleta(List<String>? nomeColaboradores) {
  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.black),
    columnWidths: {0: pw.FixedColumnWidth(542.28)},
    children: [
      // Cabeçalho
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColors.grey300,
        ),
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(5),
            child: pw.Center(
              child: pw.Text(
                'NOME DOS COLABORADORES DO SETOR',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      // Conteúdo
      if (nomeColaboradores != null && nomeColaboradores.isNotEmpty)
        ...nomeColaboradores.map((nome) => pw.TableRow(
              children: [
                pw.Container(
                  height: 20,
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: pw.Text(
                    nome,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            )),
      if (nomeColaboradores == null || nomeColaboradores.isEmpty)
        ...List.generate(
          10,
          (index) => pw.TableRow(
            children: [
              pw.Container(
                height: 20,
                alignment: pw.Alignment.center,
                padding: pw.EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: pw.Text(
                  '',
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

pw.Widget _buildSectionWithTitle1(String title, String content) {
  const double minHeight = 200;
  const double lineSpacing = 20;
  int numberOfLines = (minHeight / lineSpacing).ceil();

  return pw.Stack(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              border: pw.Border.all(),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          // Conteúdo
          if (content.isNotEmpty)
            pw.Container(
              width: double.infinity,
              constraints: const pw.BoxConstraints(minHeight: minHeight),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                content,
                style: const pw.TextStyle(fontSize: 10),
              ),
            )
          else
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                children: [
                  for (int i = 0; i < numberOfLines; i++)
                    pw.Container(
                      width: double.infinity,
                      height: lineSpacing,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: i < numberOfLines - 1
                              ? pw.BorderSide(
                                  color: PdfColors.black, width: 0.5)
                              : pw.BorderSide.none,
                        ),
                      ),
                      padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                    ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

pw.Widget _buildSectionWithTitle2(String title, String content) {
  const double minHeight = 200;
  const double lineSpacing = 20;
  int numberOfLines = (minHeight / lineSpacing).ceil();

  return pw.Stack(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              border: pw.Border.all(),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          // Conteúdo
          if (content.isNotEmpty)
            pw.Container(
              width: double.infinity,
              constraints: const pw.BoxConstraints(minHeight: minHeight),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                content,
                style: const pw.TextStyle(fontSize: 10),
              ),
            )
          else
            pw.Container(
              width: double.infinity,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                children: [
                  for (int i = 0; i < numberOfLines; i++)
                    pw.Container(
                      width: double.infinity,
                      height: lineSpacing,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: i < numberOfLines - 1
                              ? pw.BorderSide(
                                  color: PdfColors.black, width: 0.5)
                              : pw.BorderSide.none,
                        ),
                      ),
                      padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                    ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

pw.Widget _buildDescricaoAtividadesSection(String? descColaboradores) {
  return _buildSectionWithTitle1(
    'DESCRIÇÃO DAS ATIVIDADES QUE OS COLABORADORES DO SETOR DESENVOLVEM',
    descColaboradores ?? '',
  );
}

pw.Widget _buildAgravosSection(String? descAgravos) {
  return _buildSectionWithTitle1(
    'DESCRIÇÃO DOS POSSÍVEIS AGRAVOS À SAÚDE',
    descAgravos ?? '',
  );
}

pw.Widget _buildMedidasPrevencaoSection(String? medidasImplementadas) {
  return _buildSectionWithTitle2(
    'DESCRIÇÃO DAS MEDIDAS DE PREVENÇÃO IMPLEMENTADAS',
    medidasImplementadas ?? '',
  );
}

pw.Widget _buildEpisSection(String? descEpis) {
  return _buildSectionWithTitle2(
    'EPIS UTILIZADOS / CERTIFICADOS DE APROVAÇÃO',
    descEpis ?? '',
  );
}

pw.TableRow _spacerRow() {
  return pw.TableRow(
    children: [
      pw.SizedBox(height: 10),
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

pw.Widget _buildPropagationCheckbox(
    String label, List<dynamic>? propagationList) {
  return pw.Row(
    mainAxisSize: pw.MainAxisSize.min,
    children: [
      pw.Container(
        width: 8,
        height: 8,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
          color: propagationList?.contains(label) == true
              ? PdfColors.black
              : PdfColors.white,
        ),
      ),
      pw.SizedBox(width: 2),
      pw.Text(label, style: pw.TextStyle(fontSize: 8)),
    ],
  );
}

pw.Widget _buildSectionHeader(String title) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(
        color: PdfColors.black,
        width: 1,
      ),
      color: PdfColors.grey300,
    ),
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
    child: pw.Text(
      text,
      style: pw.TextStyle(fontSize: fontSize),
      textAlign: pw.TextAlign.center,
    ),
  );
}

pw.TableRow _buildAgentTypeRow(String? tipoAgente) {
  final agentType = tipoAgente ?? 'Desconhecido';

  // Verifica se já existe uma cor atribuída ao tipo de agente
  if (!agentColors.containsKey(agentType)) {
    // Atribui uma nova cor do palette
    agentColors[agentType] = colorPalette[colorIndex % colorPalette.length];
    colorIndex++;
  }

  // Garante que o agente sempre terá uma cor atribuída
  final color = agentColors[agentType]!;

  return pw.TableRow(
    children: [
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black, width: 0.5),
          color: color,
        ),
        padding: const pw.EdgeInsets.all(5),
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
          pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Container(
                  padding: pw.EdgeInsets.all(3),
                  child: pw.Text(
                    'Agente: ${risco['Agente']}',
                    style: pw.TextStyle(
                        fontSize: 10, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
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
            decoration: pw.BoxDecoration(color: PdfColors.grey300),
            children: [
              _buildDataCell('Matriz de Risco', fontSize: 10),
              _buildDataCell('Gradação de Probabilidade', fontSize: 10),
              _buildDataCell('Gradação de Severidade', fontSize: 10),
            ],
          ),
          pw.TableRow(
            children: [
              _buildDataCell(risco['MatrizdeRisco'] ?? ''),
              _buildDataCell(risco['GradacaoProbabilidade'] ?? ''),
              _buildDataCell(risco['GradacaoSeveridade'] ?? ''),
            ],
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildGeneratingSourcesSection(Map<String, dynamic> risco) {
  // Extrair a lista de ambientes com segurança
  List<dynamic> ambientes = [];
  try {
    ambientes =
        (risco['Ambientes']?['TiposDeAmbientesItem'] as List<dynamic>?) ?? [];
  } catch (e) {
    print('Erro ao extrair ambientes: $e');
  }

  return pw.TableRow(
    children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeader('Fontes Geradoras'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black),
            children: ambientes.isNotEmpty
                ? ambientes
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
                          child: pw.Text('', style: pw.TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    ],
  );
}

pw.TableRow _buildAssessmentsSection(Map<String, dynamic> risco) {
  List<dynamic> getMeioDePropagacao() {
    // Verifica se o campo existe
    if (risco['MeioDePropagacao'] == null) return [];

    // Se for uma lista, retorna diretamente
    if (risco['MeioDePropagacao'] is List) return risco['MeioDePropagacao'];

    // Se for um Map, busca pela chave 'MeioDePropagacaoList'
    if (risco['MeioDePropagacao'] is Map) {
      final map = risco['MeioDePropagacao'] as Map<String, dynamic>;
      if (map.containsKey('MeioDePropagacaoList') &&
          map['MeioDePropagacaoList'] is List) {
        return map['MeioDePropagacaoList'] as List<dynamic>;
      }
    }

    // Caso contrário, retorna lista vazia
    return [];
  }

  return pw.TableRow(
    children: [
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          pw.TableRow(
            children: [
              _buildSectionHeader('Avaliações'),
            ],
          ),
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
                            _buildPropagationCheckbox(
                                'Ar - Cutâneo', getMeioDePropagacao()),
                            _buildPropagationCheckbox(
                                'Ar - Respiratório', getMeioDePropagacao()),
                            _buildPropagationCheckbox(
                                'Ar - Sonora', getMeioDePropagacao()),
                            _buildPropagationCheckbox(
                                'Contato', getMeioDePropagacao()),
                            _buildPropagationCheckbox(
                                'Não aplicável', getMeioDePropagacao()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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

pw.Widget _formatListItems(dynamic data) {
  if (data is List) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          for (var item in data)
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
              child: pw.Text('- $item', textAlign: pw.TextAlign.left),
            ),
        ],
      ),
    );
  }
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(data?.toString() ?? ''),
  );
}

pw.Widget _formatListItemsAsPills(dynamic data) {
  if (data is List) {
    if (data.isEmpty) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(5),
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'Nenhum EPI recomendado',
          style: pw.TextStyle(
            fontSize: 8,
            fontStyle: pw.FontStyle.italic,
            color: PdfColors.grey600,
          ),
        ),
      );
    }

    // Cria um layout com pills usando Wrap
    return pw.Container(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Wrap(
        spacing: 4, // Espaço horizontal entre os pills
        runSpacing: 4, // Espaço vertical entre linhas de pills
        children: data.map<pw.Widget>((item) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(right: 2, bottom: 2),
            padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
            ),
            child: pw.Text(
              item.toString(),
              style: const pw.TextStyle(fontSize: 8),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Tratamento para valores que não são listas
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(
      data?.toString() ?? 'Não informado',
      style: const pw.TextStyle(fontSize: 8),
    ),
  );
}

pw.Widget _buildEPISection(Map<String, dynamic> risco) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      // Cabeçalho da seção
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
          borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(2)),
        ),
        child: _buildSectionHeader('EPI(s)'),
      ),
      // Seção de EPIs Recomendados
      _buildEPIRecomendadosSection(risco),
      // Seção de EPIs Utilizados
      _buildEPIUtilizadosSection(risco),
      // Seção de checkboxes
      _buildEPICheckboxesSection(risco),
    ],
  );
}

pw.Widget _buildEPIRecomendadosSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        // EPIs Recomendados
        pw.Container(
          alignment: pw.Alignment.center,
          padding: pw.EdgeInsets.all(5),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('EPI(s) Recomendado(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          constraints: pw.BoxConstraints(minHeight: 50),
          child: _formatListItemsAsPills(
              risco['EPIsRecomendados']?['EPIsRecomendados']),
        ),
      ],
    ),
  );
}

pw.Widget _buildEPIUtilizadosSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        // EPIs Utilizados
        pw.Container(
          alignment: pw.Alignment.center,
          padding: pw.EdgeInsets.all(5),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('EPI(s) Utilizado(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          constraints: pw.BoxConstraints(minHeight: 50),
          child: _formatListItems(risco['EPIsUtilizados']),
        ),
      ],
    ),
  );
}

pw.Widget _buildEPICheckboxesSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.vertical(bottom: pw.Radius.circular(2)),
    ),
    child: pw.Column(
      children: [
        // Pergunta sobre EPIs
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: pw.Text(
            'EPI(s)?',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        // Checkboxes
        pw.Container(
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
  );
}

pw.Widget _buildEPCSection(Map<String, dynamic> risco) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      // Cabeçalho da seção
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
          borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(2)),
        ),
        child: _buildSectionHeader('EPC(s)'),
      ),
      // Seção de EPCs Recomendados
      _buildEPCRecomendadosSection(risco),
      // Seção de EPCs Utilizados
      _buildEPCUtilizadosSection(risco),
    ],
  );
}

pw.Widget _buildEPCRecomendadosSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        // EPCs Recomendados
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('EPC(s) Recomendado(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          constraints: pw.BoxConstraints(minHeight: 100),
          child: _formatListItemsAsPills(
              risco['EPCsRecomendados']?['EPCRecomendados']),
        ),
      ],
    ),
  );
}

pw.Widget _buildEPCUtilizadosSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.vertical(bottom: pw.Radius.circular(2)),
    ),
    child: pw.Column(
      children: [
        // EPCs Utilizados
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('EPC(s) Utilizado(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          constraints: pw.BoxConstraints(minHeight: 100),
          child: _formatListItems(risco['EPCsUtilizados']),
        ),
      ],
    ),
  );
}

pw.Widget _buildControlMeasuresSection(Map<String, dynamic> risco) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      // Cabeçalho da seção
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
          borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(2)),
        ),
        child: _buildSectionHeader('Medidas de Controle'),
      ),
      // Seção de Medidas Implementadas
      _buildMedidasRecomendadasSection(risco),
      _buildMedidasImplementadasSection(risco),
      // Seção de Medidas Recomendadas
    ],
  );
}

pw.Widget _buildMedidasImplementadasSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        // Medidas Implementadas
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('Medida(s) Implementada(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          constraints: pw.BoxConstraints(minHeight: 100),
          child: _formatListItems(risco['MedidasUtilizadas']),
        ),
      ],
    ),
  );
}

pw.Widget _buildMedidasRecomendadasSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.vertical(bottom: pw.Radius.circular(2)),
    ),
    child: pw.Column(
      children: [
        // Medidas Recomendadas
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('Medida(s) Recomendada(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          constraints: pw.BoxConstraints(minHeight: 100),
          child: _formatListItemsAsPills(
              risco['MedidasRecomendadas']?['MedidasRecomendadas']),
        ),
      ],
    ),
  );
}

pw.Widget _buildAdditionalDataSection(Map<String, dynamic> risco) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      // Cabeçalho da seção
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
          borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(2)),
        ),
        child: _buildSectionHeader('Dados adicionais'),
      ),
      _buildDescricaoSection(risco),
      _buildSugestoesSection(risco),
      _buildRiscosSection(risco),
    ],
  );
}

pw.Widget _buildDescricaoSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('Descrição:', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: _buildDataCell(risco['Descricao'] ?? ''),
        ),
      ],
    ),
  );
}

pw.Widget _buildSugestoesSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('Sugestões:', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: _buildDataCell(risco['Sugestao'] ?? ''),
        ),
      ],
    ),
  );
}

pw.Widget _buildRiscosSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.vertical(bottom: pw.Radius.circular(2)),
    ),
    child: pw.Column(
      children: [
        pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            children: [
              _buildDataCell('Risco(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: _buildDataCell(risco['Risco'] ?? ''),
        ),
      ],
    ),
  );
}

pw.Widget _buildDangerActivityProcessSection(Map<String, dynamic> risco) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      // Cabeçalho da seção
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
          borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(2)),
        ),
        child: _buildSectionHeader('Perigo(s) / Atividade(s) / Processo(s)'),
      ),
      _buildPerigosSection(risco),
      _buildAtividadesSection(risco),
    ],
  );
}

pw.Widget _buildPerigosSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.zero,
    ),
    child: pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('Perigo(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: _buildDataCell(risco['Perigos'] ?? ''),
        ),
      ],
    ),
  );
}

pw.Widget _buildAtividadesSection(Map<String, dynamic> risco) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
      borderRadius: pw.BorderRadius.vertical(bottom: pw.Radius.circular(2)),
    ),
    child: pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              _buildDataCell('Atividade(s):', fontSize: 12),
            ],
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: _buildDataCell(risco['AtividadesProcessos'] ?? ''),
        ),
      ],
    ),
  );
}

List<pw.Widget> _buildImagesSection(Map<String, dynamic> risco) {
  if ((risco['Imagens']['ImagensRiscos'] as List<dynamic>?)?.isEmpty ?? true) {
    return [
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          pw.TableRow(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  _buildSectionHeader('Imagens'),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Text(
                      'Não há imagens disponíveis',
                      style: pw.TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
  }

  final List<String> images =
      (risco['Imagens']['ImagensRiscos'] as List<dynamic>).cast<String>();

  // Dividir as imagens em grupos de 2 por página
  const int imagesPerPage = 2;
  List<List<String>> imageGroups = [];

  for (var i = 0; i < images.length; i += imagesPerPage) {
    imageGroups.add(images.sublist(i,
        i + imagesPerPage > images.length ? images.length : i + imagesPerPage));
  }

  List<pw.Widget> allPages = [];

  // Primeira página com cabeçalho
  allPages.add(
    pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('Imagens'),
                pw.Padding(
                  padding: pw.EdgeInsets.all(5),
                  child: pw.Container(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Descrição: ${risco['descricaoImagem'] ?? ''}',
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 5),
                        ...imageGroups[0].map((base64String) =>
                            _buildImageContainer(base64String)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // Páginas adicionais
  for (var i = 1; i < imageGroups.length; i++) {
    allPages.add(pw.SizedBox(height: 20)); // Espaçamento entre páginas
    allPages.add(
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          pw.TableRow(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  _buildSectionHeader('Imagens (continuação)'),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(5),
                    child: pw.Column(
                      children: imageGroups[i]
                          .map((base64String) =>
                              _buildImageContainer(base64String))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  return allPages;
}

pw.Widget _buildImageContainer(String base64String) {
  try {
    final decodedImage = base64Decode(base64String);
    final image = pw.MemoryImage(decodedImage);

    return pw.Container(
      height: 300,
      padding: pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Image(image, fit: pw.BoxFit.contain),
    );
  } catch (e) {
    print('Error decoding or rendering image: $e');
    return pw.Container(
      height: 300,
      padding: pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Center(
        child:
            pw.Text('Imagem não disponível', style: pw.TextStyle(fontSize: 10)),
      ),
    );
  }
}

pw.Widget _buildTrainingSection(
  String? espacoConfinado,
  String? treinamentoNR33,
  DateTime? dataNR33,
  String? descricaoNR33,
  String? trabalhoAltura,
  String? treinamentoNR35,
  DateTime? dataNR35,
  String? descricaoNR35,
  String? trabalhoEletricidade,
  String? treinamentoNR10,
  DateTime? dataNR10,
  String? descricaoNR10,
  String? conducaoVeiculos,
  String? treinamentoDirecao,
  DateTime? dataDirecao,
  String? descricaoDirecao,
  String? operacaoEquipamento,
  String? treinamentoOperacao,
  DateTime? dataOperacao,
  String? descricaoOperacao,
  String? cartaoIdentificacao,
  List<String>? possiveis,
  String? treinamentoRealizado,
) {
  String formatDate(DateTime? date) {
    if (date == null) return '___/___/______';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  bool isSimSelected(String? value) {
    return value?.toUpperCase() == 'SIM';
  }

  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
    ),
    child: pw.Stack(
      children: [
        // Conteúdo principal com padding para o título
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20), // Espaço para o título
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Tabelas mantidas como no original
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildQuestionRow(
                    'Realiza trabalho em espaço confinado?',
                    'O funcionário recebeu treinamento da NR 33?',
                    isSimSelected(espacoConfinado),
                    isSimSelected(treinamentoNR33),
                    formatDate(dataNR33),
                    descricao: descricaoNR33,
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildQuestionRow(
                    'Realiza trabalho em altura?',
                    'O funcionário recebeu treinamento da NR 35?',
                    isSimSelected(trabalhoAltura),
                    isSimSelected(treinamentoNR35),
                    formatDate(dataNR35),
                    descricao: descricaoNR35,
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildQuestionRow(
                    'Realiza trabalho com exposto a eletricidade?',
                    'O funcionário recebeu treinamento da NR 10?',
                    isSimSelected(trabalhoEletricidade),
                    isSimSelected(treinamentoNR10),
                    formatDate(dataNR10),
                    descricao: descricaoNR10,
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildQuestionRow(
                    'Realiza condução de veículos para empresa?',
                    'Recebeu treinamento de direção defensiva?',
                    isSimSelected(conducaoVeiculos),
                    isSimSelected(treinamentoDirecao),
                    formatDate(dataDirecao),
                    descricao: descricaoDirecao,
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildLastQuestionRow(
                    'Realiza condução/operação de equipamento?',
                    'Recebeu treinamento de operação?',
                    isSimSelected(operacaoEquipamento),
                    isSimSelected(treinamentoOperacao),
                    formatDate(dataOperacao),
                    isSimSelected(cartaoIdentificacao),
                    descricao: descricaoOperacao,
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildPossibilidadesRow(possiveis),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildOutrosTreinamentosRealizados(treinamentoRealizado),
                ],
              ),
            ],
          ),
        ),

        // Título sobreposto com fundo cinza - CORRIGIDO
        pw.Positioned(
          top: 2,
          // Centralizar horizontalmente usando a largura da página
          left: (pageWidth / 2) -
              140, // 105 é metade da largura aproximada do container
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.white,
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: pw.Text(
              'TREINAMENTOS E AUTORIZAÇÕES',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 11,
                color: PdfColors.black,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.TableRow _buildQuestionRow(
  String pergunta1,
  String pergunta2,
  bool resposta1,
  bool resposta2,
  String data, {
  String? descricao,
}) {
  return pw.TableRow(
    children: [
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 0.5),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: pw.Table(
                border: pw.TableBorder.symmetric(),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Primeira pergunta
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  pergunta1,
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Text(
                                '( ${resposta1 ? "x" : " "} ) SIM    ( ${!resposta1 ? "x" : " "} ) NÃO',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 4),
                          // Segunda pergunta
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  pergunta2,
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Text(
                                '( ${resposta2 ? "x" : " "} ) SIM    ( ${!resposta2 ? "x" : " "} ) NÃO',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Data
                      pw.Padding(
                        padding: pw.EdgeInsets.only(left: 4),
                        child: pw.Text(
                          'Data: $data',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Descrição
            pw.Container(
              width: double.infinity,
              padding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: pw.BoxDecoration(
                border: pw.Border(top: pw.BorderSide(width: 0.5)),
              ),
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: 'Descrição: ',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.TextSpan(
                      text: descricao ?? 'N/A',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: descricao != null
                            ? PdfColors.black
                            : PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

pw.TableRow _buildLastQuestionRow(
  String pergunta1,
  String pergunta2,
  bool resposta1,
  bool resposta2,
  String data,
  bool possuiCartao, {
  String? descricao,
  String? treinamentoRealizado,
}) {
  return pw.TableRow(
    children: [
      pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 0.5),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: pw.Table(
                border: pw.TableBorder.symmetric(),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Primeira pergunta
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  pergunta1,
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Text(
                                '( ${resposta1 ? "x" : " "} ) SIM    ( ${!resposta1 ? "x" : " "} ) NÃO',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 4),
                          // Segunda pergunta
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  pergunta2,
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Text(
                                '( ${resposta2 ? "x" : " "} ) SIM    ( ${!resposta2 ? "x" : " "} ) NÃO',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 4),
                          // Possui cartão
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'Possui cartão de identificação para operação?',
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                              ),
                              pw.Text(
                                '( ${possuiCartao ? "x" : " "} ) SIM    ( ${!possuiCartao ? "x" : " "} ) NÃO',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Data
                      pw.Padding(
                        padding: pw.EdgeInsets.only(left: 4),
                        child: pw.Text(
                          'Data: $data',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Descrição
            pw.Container(
              width: double.infinity,
              padding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: pw.BoxDecoration(
                border: pw.Border(top: pw.BorderSide(width: 0.5)),
              ),
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: 'Descrição: ',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.TextSpan(
                      text: descricao ?? 'N/A',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: descricao != null
                            ? PdfColors.black
                            : PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

pw.TableRow _buildPossibilidadesRow(List<String>? possiveis) {
  final allPossibilidades = [
    'APOSENTADORIA ESPECIAL ',
    'INSALUBRIDADE',
    'PERICULOSIDADE',
    'VERIFICAR AVALIAÇÃO QUANTITATIVA'
  ];

  return pw.TableRow(
    children: [
      pw.Container(
        padding: pw.EdgeInsets.all(5),
        child: pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          children: [
            pw.TableRow(
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(5),
                  child: pw.Wrap(
                    spacing: 15,
                    runSpacing: 5,
                    children: [
                      pw.Text('POSSÍVEL:', style: pw.TextStyle(fontSize: 12)),
                      ...allPossibilidades
                          .map((possibilidade) => pw.Row(
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  pw.Container(
                                    width: 15,
                                    height: 15,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        possiveis?.contains(possibilidade) ??
                                                false
                                            ? 'x'
                                            : '',
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(width: 5),
                                  pw.Text(possibilidade,
                                      style: pw.TextStyle(fontSize: 8)),
                                ],
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

pw.TableRow _buildOutrosTreinamentosRealizados(String? treinamentoRealizado) {
  return pw.TableRow(children: [
    pw.Container(
      padding: pw.EdgeInsets.all(5),
      child: pw.Table(
        border: pw.TableBorder.all(width: 0.5),
        children: [
          pw.TableRow(
            children: [
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text('OUTROS TREINAMENTOS REALIZADOS',
                    style: pw.TextStyle(fontSize: 12)),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(treinamentoRealizado ?? '',
                    style: pw.TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ],
      ),
    )
  ]);
}

pw.Widget _buildObservacoesSection(String? observacoes) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        // Cabeçalho
        pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            border: pw.Border.all(color: PdfColors.black),
          ),
          padding: pw.EdgeInsets.all(5),
          child: pw.Center(
            child: pw.Text(
              'OBSERVAÇÕES',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        // Instruções
        pw.Container(
          padding: pw.EdgeInsets.all(5),
          child: pw.Text(
            'DEVEM SER ANOTADAS AS INFORMAÇÕES REFERENTES AOS EPI\'S, EPC\'S, MEDIDAS DE CONTROLE, SUGESTÕES, DESCRIÇÃO, PERIGO E ATIVIDADES QUE GERAM O RISCO AMBIENTAL',
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        // Observações
        pw.Container(
          padding: pw.EdgeInsets.all(10),
          constraints: pw.BoxConstraints(minHeight: 100), // Altura mínima
          child: pw.Text(
            observacoes ?? '',
            style: pw.TextStyle(fontSize: 10),
          ),
        ),
      ],
    ),
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
