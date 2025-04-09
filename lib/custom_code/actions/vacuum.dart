// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/sqlite/sqlite_manager.dart'; // Importante: adicione esta importação
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io'; // Para manipulação de arquivos

Future<String> vacuum() async {
  try {
    print('Iniciando operação VACUUM para limpar o banco de dados...');

    // Obter instância do banco de dados
    final db = await SQLiteManager.instance.database;

    // Verificar tamanho atual do banco
    final tamanhoAntes = await _obterTamanhoDB(db.path);

    print(
        'Tamanho do banco antes da limpeza: ${_formatarTamanho(tamanhoAntes)}');

    // Iniciar cronômetro para medir o tempo da operação
    final inicioOperacao = DateTime.now();

    // Executar comando VACUUM para limpar o banco
    await db.execute('VACUUM');

    // Calcular tempo total da operação
    final fimOperacao = DateTime.now();
    final duracaoOperacao = fimOperacao.difference(inicioOperacao);

    // Verificar tamanho após a limpeza
    final tamanhoDepois = await _obterTamanhoDB(db.path);

    print(
        'Tamanho do banco depois da limpeza: ${_formatarTamanho(tamanhoDepois)}');

    // Calcular espaço economizado
    final espacoEconomizado = tamanhoAntes - tamanhoDepois;

    // Gerar mensagem de resultado
    String mensagem = 'Banco de dados otimizado com sucesso!\n\n';
    mensagem += 'Tamanho antes: ${_formatarTamanho(tamanhoAntes)}\n';
    mensagem += 'Tamanho depois: ${_formatarTamanho(tamanhoDepois)}\n';
    mensagem += 'Espaço recuperado: ${_formatarTamanho(espacoEconomizado)}\n';
    mensagem += 'Tempo de execução: ${duracaoOperacao.inSeconds} segundos';

    return mensagem;
  } catch (e, stackTrace) {
    print('Erro ao executar VACUUM: $e');
    print('Stack trace: $stackTrace');
    return 'Erro ao otimizar o banco de dados: $e';
  }
}

// Função auxiliar para obter o tamanho do arquivo de banco de dados
Future<int> _obterTamanhoDB(String caminhoDB) async {
  try {
    final arquivo = File(caminhoDB);
    if (await arquivo.exists()) {
      return await arquivo.length();
    }
    return 0;
  } catch (e) {
    print('Erro ao obter tamanho do arquivo: $e');
    return 0;
  }
}

// Função auxiliar para formatar o tamanho em bytes para uma representação mais legível
String _formatarTamanho(int bytes) {
  if (bytes < 1024) {
    return '$bytes bytes';
  } else if (bytes < 1024 * 1024) {
    return '${(bytes / 1024).toStringAsFixed(2)} KB';
  } else if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  } else {
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
