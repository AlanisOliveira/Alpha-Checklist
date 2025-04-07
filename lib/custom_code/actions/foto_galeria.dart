// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart'; // Importação do pacote para selecionar imagens
import 'dart:convert'; // Importação do pacote para codificar/decodificar dados em base64

final ImagePicker _picker = ImagePicker(); // Instanciação do objeto ImagePicker

Future<String?> fotoGaleria(BuildContext context) async {
  String?
      error1; // Declaração de uma variável que irá armazenar um possível erro

  try {
    final XFile? photoURL = await _picker.pickImage(
        // Seleciona a imagem com o objeto ImagePicker
        source: ImageSource.gallery, // Seleciona a galeria como fonte da imagem
        maxHeight: 768, // Define a altura máxima da imagem
        maxWidth: 1024, // Define a largura máxima da imagem
        imageQuality: 50); // Define a qualidade da imagem

    if (photoURL != null) {
      // Se a imagem foi selecionada com sucesso
      var bytes = await photoURL.readAsBytes(); // Converte a imagem em bytes
      FFAppState().base64lmage = base64.encode(
          bytes); // Codifica a imagem em base64 e armazena em uma variável

      // OBS: o trecho de código FFAppState().uploadimagem = photoURL.path; foi comentado, possivelmente por não estar sendo utilizado.
    }
  } catch (e) {
    // Se ocorreu algum erro na seleção da imagem
    error1 = e.toString(); // Armazena o erro na variável error1
    print('error $error1'); // Imprime o erro no console
  }

  return error1; // Retorna a variável error1, que pode conter um erro ou ser nula
}
