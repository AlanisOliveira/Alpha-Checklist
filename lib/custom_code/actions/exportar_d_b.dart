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
import 'package:awesome_notifications/awesome_notifications.dart';

Future<bool> initializeNotifications() async {
  return await AwesomeNotifications().initialize(
    null, // icone pode ser null
    [
      NotificationChannel(
        channelKey: 'backup_channel',
        channelName: 'Backup Notifications',
        channelDescription: 'Notificações de backup do banco de dados',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      )
    ],
  );
}

Future<void> showBackupNotification(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'backup_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<String> exportarDB() async {
  try {
    await initializeNotifications();

    print('Iniciando exportação do banco de dados...');
    print('Plataforma: ${Platform.isAndroid ? 'Android' : 'iOS'}');

    if (Platform.isAndroid) {
      print('Verificando permissões...');

      // Solicita permissão de notificação
      await Permission.notification.request();

      // Solicita permissão de armazenamento
      final status = await Permission.manageExternalStorage.request();
      print('Status da permissão: $status');

      if (!status.isGranted) {
        print('Permissão não concedida');
        await showBackupNotification('Permissão Necessária',
            'É necessário permitir o acesso ao armazenamento');
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

    if (Platform.isAndroid) {
      final directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final backupPath = join(directory.path, backupName);
      print('Caminho do backup: $backupPath');

      final dbFile = File(db.path);
      if (!await dbFile.exists()) {
        print('Banco de dados não encontrado em: ${db.path}');
        await showBackupNotification(
            'Erro no Backup', 'Banco de dados não encontrado');
        return 'Banco de dados não encontrado';
      }

      print('Copiando arquivo...');
      await dbFile.copy(backupPath);

      final backupFile = File(backupPath);
      if (await backupFile.exists()) {
        print('Backup confirmado em: $backupPath');
        await showBackupNotification(
            'Backup Concluído', 'Arquivo salvo em Downloads/$backupName');
        return 'Backup criado em Downloads/$backupName';
      } else {
        print('Backup não encontrado após cópia');
        await showBackupNotification(
            'Erro no Backup', 'Não foi possível criar o arquivo de backup');
        return 'Erro: Backup não foi criado corretamente';
      }
    } else if (Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      final backupPath = join(directory.path, backupName);
      await File(db.path).copy(backupPath);
      await showBackupNotification(
          'Backup Concluído', 'Arquivo salvo em Documentos/$backupName');
      return 'Backup criado em: Documentos/$backupName';
    }

    return 'Plataforma não suportada';
  } catch (e, stackTrace) {
    print('Erro ao exportar: $e');
    print('Stack trace: $stackTrace');
    await showBackupNotification(
        'Erro no Backup', 'Ocorreu um erro ao fazer o backup');
    return 'Erro ao exportar o banco de dados: $e';
  }
}
