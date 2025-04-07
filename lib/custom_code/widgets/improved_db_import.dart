// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';

class ImprovedDbImport extends StatefulWidget {
  final double? width;
  final double? height;

  const ImprovedDbImport({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _ImprovedDbImportState createState() => _ImprovedDbImportState();
}

class _ImprovedDbImportState extends State<ImprovedDbImport> {
  String? selectedFileName;
  bool _isLoading = false;

  /// Solicita as permissões necessárias de acordo com a plataforma
  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }

      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        return false;
      }
      return true;
    }

    return true;
  }

  /// Mostra um diálogo informativo e reinicia o app com restart_app
  Future<void> _showSuccessDialogAndRestartApp() async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Banco de Dados Importado'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'O banco de dados foi substituído com sucesso!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Para que todas as alterações sejam aplicadas corretamente, o aplicativo precisa ser reiniciado.',
              ),
              SizedBox(height: 12),
              Text(
                'Clique em "Reiniciar Agora" para aplicar as alterações.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text('Fechar App (Sem Reiniciar)'),
              onPressed: () {
                // Fallback: fechar o app
                SystemNavigator.pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reiniciar Agora'),
              onPressed: () {
                try {
                  // Fecha o diálogo
                  Navigator.of(dialogContext).pop();

                  // Aguarda um pouco e então reinicia o app usando restart_app
                  Future.delayed(Duration(milliseconds: 500), () {
                    Restart.restartApp(
                      notificationTitle: 'Reabrindo Aplicativo',
                      notificationBody:
                          'Toque aqui para abrir o aplicativo com o novo banco de dados.',
                    );
                  });
                } catch (e) {
                  print('Erro ao reiniciar: $e');
                  // Fallback para fechar simplesmente
                  SystemNavigator.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  /// Função aprimorada para substituir o banco de dados com validações
  Future<String> _importAndReplaceDB(String sourcePath) async {
    if (_isLoading) return 'Operação já em andamento';

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Validar arquivo de origem
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) {
        return 'O arquivo selecionado não existe';
      }

      final fileSize = await sourceFile.length();
      if (fileSize < 100) {
        return 'Arquivo muito pequeno, pode não ser um banco de dados válido';
      }

      // 2. Obter e fechar o banco atual
      final db = await SQLiteManager.instance.database;
      final currentDbPath = db.path;

      // Fechando todas as conexões com o banco
      try {
        await db.close();
        print('Banco fechado com sucesso');
      } catch (e) {
        print('Erro ao fechar banco: $e');
      }

      // 3. Criar backup
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final backupPath = p.join(
        p.dirname(currentDbPath),
        'backup_before_import_$timestamp.db',
      );

      try {
        await File(currentDbPath).copy(backupPath);
        print('Backup criado em: $backupPath');
      } catch (e) {
        print('Aviso: Não foi possível criar backup: $e');
      }

      // 4. Copiar o novo banco
      try {
        await sourceFile.copy(currentDbPath);
      } catch (e) {
        try {
          // Método alternativo
          final bytes = await sourceFile.readAsBytes();
          await File(currentDbPath).writeAsBytes(bytes, flush: true);
        } catch (e2) {
          return 'Falha ao substituir o banco de dados: $e2';
        }
      }

      // 5. Reabrir o banco
      try {
        final newDb = await SQLiteManager.instance.database;
        try {
          await newDb.rawQuery('SELECT 1');
          print('Banco substituído e verificado com sucesso');
        } catch (e) {
          print('Banco substituído mas com alerta: $e');
        }
      } catch (e) {
        return 'Banco substituído, mas ocorreu um erro ao reabri-lo: $e';
      }

      // 6. Mostrar diálogo e reiniciar com restart_app
      await _showSuccessDialogAndRestartApp();

      return 'Banco importado com sucesso! Um backup foi salvo antes da substituição.';
    } catch (e, st) {
      print('Erro geral na importação: $e\nStack trace: $st');
      return 'Erro ao importar o banco: $e';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Método para selecionar o arquivo e realizar a importação
  Future<void> _pickFileAndImportDB() async {
    try {
      // 1. Verificar permissões
      if (!await _requestPermissions()) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permissões necessárias não concedidas'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // 2. Usar FilePicker
      final result = await FilePicker.platform.pickFiles();

      if (result == null ||
          result.files.isEmpty ||
          result.files.single.path == null) {
        return;
      }

      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;

      // 3. Verificar extensão .db
      if (!filePath.toLowerCase().endsWith('.db')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, selecione um arquivo com extensão .db'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // 4. Atualizar UI
      setState(() {
        selectedFileName = fileName;
      });

      // 5. Executar importação
      final resultMessage = await _importAndReplaceDB(filePath);

      // 6. Feedback
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultMessage),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e, st) {
      print('Erro ao selecionar ou processar arquivo: $e\nStack trace: $st');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ElevatedButton(
            onPressed: _isLoading ? null : _pickFileAndImportDB,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              disabledBackgroundColor: Colors.blue.withOpacity(0.6),
            ),
            child: Text(
              _isLoading
                  ? 'Processando...'
                  : (selectedFileName ?? 'Selecione o Banco de Dados'),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
