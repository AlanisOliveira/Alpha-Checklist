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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'dart:convert';

Future<void> loadMensalDraft(int draftId) async {
  final db = await SQLiteManager.instance.database;

  // Log 1: Verificar draftId
  print('ID do draft sendo carregado: $draftId');
  FFAppState().isLoading = true;

  final result = await db.query(
    'pdfGerado',
    where: 'id = ?',
    whereArgs: [draftId],
    limit: 1,
  );

  // Log 2: Verificar resultado da query
  print('Resultado da query: ${result.length} registros');

  if (result.isNotEmpty) {
    // Log 3: Verificar dados brutos do banco
    final rawData = result.first['Dados'] as String? ?? '{}';
    print('Dados brutos do banco: $rawData');

    final draftData = jsonDecode(rawData) as Map<String, dynamic>;
    print('Dados decodificados: $draftData');

    // ========== FUNÇÕES AUXILIARES ==========
    String _safeString(dynamic value) => value?.toString() ?? '';

    List<String> _safeList(dynamic value) {
      if (value is List) {
        return value.map((e) => e.toString()).toList().cast<String>();
      }
      return [];
    }

    final Assinaturas = ((draftData['Assinaturas'] ?? []) as List<dynamic>)
        .map<Map<String, dynamic>>((item) {
      try {
        return jsonDecode(item as String);
      } catch (e) {
        print('Erro ao decodificar assinatura: $e');
        return <String, dynamic>{};
      }
    }).toList();

    // ========================================

    // Atualização do AppState com os dados específicos do "saveDraftToSQLiteMensal"
    FFAppState().currentDraftId = draftId;

    // Strings básicas
    FFAppState().nomePDF = _safeString(draftData['nomePDF']);
    FFAppState().nomeEmpresa = _safeString(draftData['nomeEmpresa']);
    FFAppState().enderecoAvMensal = _safeString(draftData['endereco']);
    FFAppState().Avaliador = _safeString(draftData['avaliador']);
    FFAppState().profissaoAvMensal = _safeString(draftData['profissao']);

    // Listas de Riscos (convertendo para o tipo correto)
    FFAppState().listaFisicosMensal = _safeList(draftData['riscosFisicos']);
    FFAppState().listaQuimicoMensais = _safeList(draftData['riscosQuimico']);
    FFAppState().listaErgonomicosMensais =
        _safeList(draftData['riscosErgonomicos']);
    FFAppState().listaAcidentesMensais =
        _safeList(draftData['riscosAcidentes']);
    FFAppState().listaBiologicosMensais =
        _safeList(draftData['riscosBiologicos']);
    FFAppState().modificacoesEmpresaAvMensal =
        _safeList(draftData['modificacoesEmpresaAvMensal']);
    FFAppState().modificacoesEmpresaAvMensal2 =
        _safeList(draftData['modificacoesEmpresaAvMensal2']);
    FFAppState().modificacoesEmpresaAvMensal3 =
        _safeList(draftData['modificacoesEmpresaAvMensal3']);
    FFAppState().descricaoModificacoes =
        _safeString(draftData['descricaoModificacoes']);
    FFAppState().Assinaturas = Assinaturas;
    print('Dados carregados com sucesso!');
  } else {
    print('Nenhum rascunho encontrado com o ID: $draftId');
  }
  FFAppState().isLoading = false;
}
