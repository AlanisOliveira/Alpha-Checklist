// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';

// Tenta abrir a pasta de exportação usando o package open_file
Future<bool> _abrirPasta(String caminho) async {
  try {
    print('Tentando abrir pasta: $caminho');
    
    // Em Android, tentar abrir especificamente como pasta
    if (Platform.isAndroid) {
      final result = await OpenFile.open(
        caminho,
        type: 'resource/folder', // Tipo MIME para pastas
      );

      if (result.type == ResultType.done) {
        print('Pasta aberta com sucesso!');
        return true;
      } else {
        print('Erro ao abrir pasta: ${result.message}');
        // Tentar sem especificar o tipo
        final fallbackResult = await OpenFile.open(caminho);
        return fallbackResult.type == ResultType.done;
      }
    } else {
      // Para iOS, usar o método padrão
      final result = await OpenFile.open(caminho);
      return result.type == ResultType.done;
    }
  } catch (e) {
    print('Exceção ao tentar abrir pasta: $e');
    return false;
  }
}

Future<String> exportarDB() async {
  try {
    print('Iniciando exportação do banco de dados...');
    print('Plataforma: ${Platform.isAndroid ? 'Android' : 'iOS'}');

    if (Platform.isAndroid) {
      print('Verificando permissões...');

      // Solicita permissão de armazenamento
      final status = await Permission.manageExternalStorage.request();
      print('Status da permissão: $status');

      if (!status.isGranted) {
        print('Permissão não concedida');
        return 'É necessário permitir o acesso ao armazenamento';
      }
    }

    print('Obtendo instância do banco de dados...');
    final db = await SQLiteManager.instance.database;
    print('Caminho do banco de dados: ${db.path}');

    final timestamp =
        DateTime.now().toString().replaceAll(RegExp(r'[^0-9]'), '');
    final backupName = 'backup_$timestamp.db';
    print('Nome do arquivo de backup: $backupName');

    String backupPath = '';
    String folderPath = '';
    String mensagem = '';

    if (Platform.isAndroid) {
      final directory = Directory('/storage/emulated/0/Download');
      folderPath = directory.path;

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      backupPath = join(directory.path, backupName);
      print('Caminho do backup: $backupPath');

      final dbFile = File(db.path);
      if (!await dbFile.exists()) {
        print('Banco de dados não encontrado em: ${db.path}');
        return 'Banco de dados não encontrado';
      }

      print('Copiando arquivo...');
      await dbFile.copy(backupPath);

      final backupFile = File(backupPath);
      if (await backupFile.exists()) {
        print('Backup confirmado em: $backupPath');
        mensagem = 'Backup criado em Downloads/$backupName';
      } else {
        print('Backup não encontrado após cópia');
        return 'Erro: Backup não foi criado corretamente';
      }
    } else if (Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      folderPath = directory.path;
      
      backupPath = join(directory.path, backupName);
      await File(db.path).copy(backupPath);
      mensagem = 'Backup criado em: Documentos/$backupName';
    } else {
      return 'Plataforma não suportada';
    }

    // Tentar abrir a pasta onde o backup foi salvo
    final pastaAberta = await _abrirPasta(folderPath);
    
    if (pastaAberta) {
      return '$mensagem\nPasta aberta automaticamente.';
    } else {
      return '$mensagem\nA pasta não pôde ser aberta automaticamente.';
    }
    
  } catch (e, stackTrace) {
    print('Erro ao exportar: $e');
    print('Stack trace: $stackTrace');
    return 'Erro ao exportar o banco de dados: $e';
  }
}
