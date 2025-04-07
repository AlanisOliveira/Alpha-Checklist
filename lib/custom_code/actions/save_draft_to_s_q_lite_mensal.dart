// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'dart:convert';

Future<void> saveDraftToSQLiteMensal() async {
  final db = await SQLiteManager.instance.database;
  int? draftId = FFAppState().currentDraftId; // ID do rascunho em edição

  if (draftId == null) return; // Se não houver rascunho ativo, não faz nada
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  final newName = FFAppState().nomePDF;

  List<dynamic> _convertList(List<dynamic> list) {
    return list
        .map((e) => e is Map<String, dynamic> ? e : e.toString())
        .toList();
  }

  final serializedAssinaturas = FFAppState().Assinaturas.map((item) {
    if (item is Map<String, dynamic>) {
      return jsonEncode(item);
    }
    return item.toString();
  }).toList();

  final appStateData = {
    'nomePDF': FFAppState().nomePDF,
    'nomeEmpresa': FFAppState().nomeEmpresa,
    'endereco': FFAppState().enderecoAvMensal,
    'avaliador': FFAppState().Avaliador,
    'profissao': FFAppState().profissaoAvMensal,
    'riscosFisicos': FFAppState().listaFisicosMensal,
    'riscosQuimico': FFAppState().listaQuimicoMensais,
    'riscosErgonomicos': FFAppState().listaErgonomicosMensais,
    'riscosAcidentes': FFAppState().listaAcidentesMensais,
    'riscosBiologicos': FFAppState().listaBiologicosMensais,
    'modificacoesEmpresaAvMensal': FFAppState().modificacoesEmpresaAvMensal,
    'modificacoesEmpresaAvMensal2': FFAppState().modificacoesEmpresaAvMensal2,
    'modificacoesEmpresaAvMensal3': FFAppState().modificacoesEmpresaAvMensal3,
    'descricaoModificacoes': FFAppState().descricaoModificacoes,
    'Assinaturas': serializedAssinaturas,
  };
  final jsonData = jsonEncode(appStateData);

  print('Assinaturas após serialização: $serializedAssinaturas');

  await db.update(
    'pdfGerado',
    {
      'nome': newName,
      'dados': jsonData,
      'data_atualizacao': dateFormat.format(DateTime.now()),
    },
    where: 'id = ?',
    whereArgs: [draftId],
  );
}
