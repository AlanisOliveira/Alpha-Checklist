// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future insertSetorFuncao(
  String nome,
  String? cnpj,
  List<String>? setores,
  List<String>? funcoes,
  String? cidade,
  String? estado,
) async {
  final db = await SQLiteManager.instance.database;

  // Inserindo empresa e capturando o ID gerado
  int idEmpresa = await db.rawInsert(
    'INSERT INTO EMPRESAS (Nome, CNPJ, CIDADE, ESTADO) VALUES (?, ?, ?, ?)',
    [nome, cnpj, cidade, estado],
  );

  // Inserindo setores
  if (setores != null) {
    for (String setor in setores) {
      await db.rawInsert(
        'INSERT INTO SETORES (nome, idEmpresas) VALUES (?, ?)',
        [setor, idEmpresa],
      );
    }
  }

  // Inserindo funções
  if (funcoes != null) {
    for (String funcao in funcoes) {
      await db.rawInsert(
        'INSERT INTO FUNCOES (nome, idEmpresa) VALUES (?, ?)',
        [funcao, idEmpresa],
      );
    }
  }
}
