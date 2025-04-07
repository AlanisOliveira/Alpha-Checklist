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
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

final ImagePicker _picker = ImagePicker();

Future<String?> fotoCamera(BuildContext context) async {
  String? error1;

  try {
    final XFile? photoURL = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 768,
      maxWidth: 1024,
      imageQuality: 50,
    );

    // Só processa se uma foto foi realmente capturada
    if (photoURL != null) {
      var bytes = await photoURL.readAsBytes();
      String base64Image = base64.encode(bytes);

      // Só atualiza o AppState se tiver uma imagem válida
      if (base64Image.isNotEmpty) {
        FFAppState().base64lmage = base64Image;
      } else {
        error1 = 'Imagem inválida';
      }
    } else {
      error1 = 'Nenhuma foto selecionada';
    }
  } catch (e) {
    error1 = e.toString();
    print('error $error1');
  }

  // Se error1 for null, significa que tudo ocorreu bem e temos uma imagem válida
  return error1;
}
