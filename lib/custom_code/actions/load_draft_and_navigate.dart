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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'dart:convert';

Future<void> loadDraftAndNavigate(int draftId) async {
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

    bool _safeBool(dynamic value) {
      if (value is bool) return value;
      if (value is String) return value.toLowerCase() == 'true';
      return false;
    }

    int? _safeInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    List<String> _safeList(dynamic value) {
      if (value is List) {
        return value.map((e) => e.toString()).toList().cast<String>();
      }
      return [];
    }

    DateTime? _safeDate(dynamic value) {
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    List<Map<String, dynamic>> _deserializeListadeRiscos(List<dynamic>? list) {
      if (list == null) return []; // Retorna uma lista vazia se for null

      return list.map((item) {
        if (item is String) {
          try {
            return jsonDecode(item) as Map<String, dynamic>;
          } catch (e) {
            print('Erro ao desserializar item: $item');
            return <String, dynamic>{};
          }
        }
        if (item is Map<String, dynamic>) {
          return item;
        }
        return <String, dynamic>{};
      }).toList();
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

    // Atualização do AppState com tratamento completo
    FFAppState().currentDraftId = draftId;

    // Strings básicas
    FFAppState().nomePDF = _safeString(draftData['nomePDF']);
    FFAppState().idEmpresa = draftData['idEmpresa'] ?? 0;
    FFAppState().nomeEmpresa = _safeString(draftData['nomeEmpresa']);
    FFAppState().Setor = _safeString(draftData['Setor']);
    FFAppState().Avaliador = _safeString(draftData['Avaliador']);
    FFAppState().outrosProgramas = _safeString(draftData['outrosProgramas']);
    FFAppState().PoliticasList = _safeList(draftData['PoliticasList']);
    FFAppState().JSONPreSelecao = _safeList(draftData['JSONPreSelecao']);

    // Descrições
    FFAppState().DescColaboradores =
        _safeString(draftData['DescColaboradores']);
    FFAppState().DescAgravos = _safeString(draftData['DescAgravos']);
    FFAppState().DescEPIs = _safeString(draftData['DescEPIs']);
    FFAppState().medidasImplementadas =
        _safeString(draftData['medidasImplementadas']);

    // Listas
    FFAppState().Funcao = _safeList(draftData['Funcao']);
    FFAppState().ambienteTagList = _safeList(draftData['ambienteTagList']);
    FFAppState().PisoTagList = _safeList(draftData['PisoTagList']);
    FFAppState().ParedeTagList = _safeList(draftData['ParedeTagList']);
    FFAppState().CoberturaTagList = _safeList(draftData['CoberturaTagList']);
    FFAppState().IluminacaoTagList = _safeList(draftData['IluminacaoTagList']);
    FFAppState().VentilacaoTagList = _safeList(draftData['VentilacaoTagList']);
    FFAppState().PavimentoList = _safeList(draftData['PavimentoList']);
    FFAppState().ProtecaoIncendioList =
        _safeList(draftData['ProtecaoIncendioList']);
    FFAppState().MaquinaseEquipamentosList =
        _safeList(draftData['MaquinaseEquipamentosList']);
    FFAppState().NomeColaboradores = _safeList(draftData['NomeColaboradores']);
    FFAppState().ListadeRiscos =
        _deserializeListadeRiscos(draftData['ListadeRiscos']);

    // Booleanos (convertendo strings vazias para false)
    FFAppState().espacoConfinado = _safeString(draftData['espacoConfinado']);
    FFAppState().treinamentoNR33 = _safeString(draftData['treinamentoNR33']);
    FFAppState().trabalhoAltura = _safeString(draftData['trabalhoAltura']);
    FFAppState().treinamentoNR35 = _safeString(draftData['treinamentoNR35']);
    FFAppState().trabalhoEletricidade =
        _safeString(draftData['trabalhoEletricidade']);
    FFAppState().treinamentoNR10 = _safeString(draftData['treinamentoNR10']);
    FFAppState().conducaoVeiculos = _safeString(draftData['conducaoVeiculos']);
    FFAppState().treinamentoDirecao =
        _safeString(draftData['treinamentoDirecao']);
    FFAppState().operacaoEquipamento =
        _safeString(draftData['operacaoEquipamento']);
    FFAppState().treinamentoOperacao =
        _safeString(draftData['treinamentoOperacao']);
    FFAppState().aposentadoriaEspecial =
        _safeString(draftData['aposentadoriaEspecial']);
    FFAppState().cartaoIdentificacao =
        _safeString(draftData['cartaoIdentificacao']);
    FFAppState().Possivel = _safeList(draftData['Possivel']);

    // Datas
    FFAppState().dataNr33 = _safeDate(draftData['dataNR33']);
    FFAppState().dataNR35 = _safeDate(draftData['dataNR35']);
    FFAppState().dataNR10 = _safeDate(draftData['dataNR10']);
    FFAppState().dataDirecao = _safeDate(draftData['dataDirecao']);
    FFAppState().dataOperacao = _safeDate(draftData['dataOperacao']);

    // Textos adicionais
    FFAppState().descricaoNR33 = _safeString(draftData['descricaoNR33']);
    FFAppState().descricaoNR35 = _safeString(draftData['descricaoNR35']);
    FFAppState().descricaoNR10 = _safeString(draftData['descricaoNR10']);
    FFAppState().descricaoDirecao = _safeString(draftData['descricaoDirecao']);
    FFAppState().descricaoOperacao =
        _safeString(draftData['descricaoOperacao']);

    FFAppState().JSONPreSelecao =
        _deserializeListadeRiscos(draftData['JSONPreSelecao']);

    FFAppState().treinamentosrealizados =
        _safeString(draftData['treinamentosrealizados']);

    FFAppState().observacoes = _safeString(draftData['observacoes']);
    FFAppState().Assinaturas = Assinaturas;
  }
  FFAppState().isLoading = false;
}
