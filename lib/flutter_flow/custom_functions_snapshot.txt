import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/sqlite/sqlite_manager.dart';

String? listaAgentes(List<dynamic>? listaAgente) {
  if (listaAgente == null) return null;

  return listaAgente
      .where((agent) => agent != null && agent.toString().isNotEmpty)
      .join(', ');
}

String getsugestaoInicial(List<String> sugestaoInicial) {
  if (sugestaoInicial.isEmpty) {
    return '';
  }
  // Junta os itens da lista em uma única string usando o delimitador escolhido
  String sugestao = sugestaoInicial.join('\n');

  sugestao = sugestao.replaceAll(';', ';\n');

  return sugestao;
}

String? listEPIRisco(List<String>? lista) {
  if (lista == null || lista.isEmpty) return null;
  return lista.join('\n');
}

String? newCustomFunction(List<dynamic>? lista) {
  if (lista == null || lista.isEmpty) return null;

  final markdownList = lista.map((item) => '\u2022 $item').join('\n\n');
  return markdownList;
}
