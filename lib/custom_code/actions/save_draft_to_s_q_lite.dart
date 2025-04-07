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

Future<void> saveDraftToSQLite() async {
  final db = await SQLiteManager.instance.database;
  int? draftId = FFAppState().currentDraftId; // ID do rascunho em edição
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  if (draftId == null) return; // Se não houver rascunho ativo, não faz nada

  final newName = FFAppState().nomePDF;

  List<dynamic> _convertList(List<dynamic> list) {
    return list
        .map((e) => e is Map<String, dynamic> ? e : e.toString())
        .toList();
  }

  List<String> _serializeListadeRiscos(List<dynamic> list) {
    return list.map((item) {
      // Se o item for um Map, converte para JSON string
      if (item is Map<String, dynamic>) {
        return jsonEncode(item);
      }
      // Se já for uma string, assume que é JSON válido
      return item.toString();
    }).toList();
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
    'idEmpresa': FFAppState().idEmpresa,
    'Setor': FFAppState().Setor,
    'Funcao': FFAppState().Funcao,
    'Avaliador': FFAppState().Avaliador,
    'PoliticasList': FFAppState().PoliticasList,
    'ambienteTagList': FFAppState().ambienteTagList,
    'PisoTagList': FFAppState().PisoTagList,
    'ParedeTagList': FFAppState().ParedeTagList,
    'CoberturaTagList': FFAppState().CoberturaTagList,
    'IluminacaoTagList': FFAppState().IluminacaoTagList,
    'VentilacaoTagList': FFAppState().VentilacaoTagList,
    'PavimentoList': FFAppState().PavimentoList,
    'ProtecaoIncendioList': FFAppState().ProtecaoIncendioList,
    'MaquinaseEquipamentosList': FFAppState().MaquinaseEquipamentosList,
    'outrosProgramas': FFAppState().outrosProgramas,
    'NomeColaboradores': FFAppState().NomeColaboradores,
    'DescColaboradores': FFAppState().DescColaboradores,
    'DescAgravos': FFAppState().DescAgravos,
    'DescEPIs': FFAppState().DescEPIs,
    'medidasImplementadas': FFAppState().medidasImplementadas,
    'ListadeRiscos': _serializeListadeRiscos(FFAppState().ListadeRiscos),
    'espacoConfinado': FFAppState().espacoConfinado,
    'treinamentoNR33': FFAppState().treinamentoNR33,
    'dataNR33': FFAppState().dataNr33?.toIso8601String(),
    'descricaoNR33': FFAppState().descricaoNR33,
    'trabalhoAltura': FFAppState().trabalhoAltura,
    'treinamentoNR35': FFAppState().treinamentoNR35,
    'dataNR35': FFAppState().dataNR35?.toIso8601String(),
    'descricaoNR35': FFAppState().descricaoNR35,
    'trabalhoEletricidade': FFAppState().trabalhoEletricidade,
    'treinamentoNR10': FFAppState().treinamentoNR10,
    'dataNR10': FFAppState().dataNR10?.toIso8601String(),
    'descricaoNR10': FFAppState().descricaoNR10,
    'conducaoVeiculos': FFAppState().conducaoVeiculos,
    'treinamentoDirecao': FFAppState().treinamentoDirecao,
    'dataDirecao': FFAppState().dataDirecao?.toIso8601String(),
    'descricaoDirecao': FFAppState().descricaoDirecao,
    'operacaoEquipamento': FFAppState().operacaoEquipamento,
    'treinamentoOperacao': FFAppState().treinamentoOperacao,
    'dataOperacao': FFAppState().dataOperacao?.toIso8601String(),
    'descricaoOperacao': FFAppState().descricaoOperacao,
    'aposentadoriaEspecial': FFAppState().aposentadoriaEspecial,
    'cartaoIdentificacao': FFAppState().cartaoIdentificacao,
    'observacoes': FFAppState().observacoes,
    'Assinaturas': serializedAssinaturas,
    'Possivel': FFAppState().Possivel,
    'JSONPreSelecao': FFAppState().JSONPreSelecao,
    'treinamentosrealizados': FFAppState().treinamentosrealizados,
  };
  final jsonData = jsonEncode(appStateData);

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
