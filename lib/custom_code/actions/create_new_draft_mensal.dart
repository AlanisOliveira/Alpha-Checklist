// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:sqflite/sqflite.dart'; // Import necessário
import 'dart:convert';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

Future<void> createNewDraftMensal() async {
  final db = await SQLiteManager.instance.database;
  final dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  // Criando um rascunho vazio
  int draftId = await db.insert(
    'pdfGerado',
    {
      'tipo': 'Mensal',
      'nome': 'Novo Rascunho',
      'dados': jsonEncode({}), // Começa com um JSON vazio
      'data_criacao': dateFormat.format(DateTime.now()),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  // Armazena o ID do rascunho no estado global
  FFAppState().currentDraftId = draftId;
}
