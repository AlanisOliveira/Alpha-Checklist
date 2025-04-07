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

import 'dart:convert';
import 'package:flutter/foundation.dart';

class HtmlImage extends StatefulWidget {
  const HtmlImage({
    super.key,
    this.width,
    this.height,
    this.base64Image,
    this.borde,
    required this.index, // O índice é agora required
  });

  final double? width;
  final double? height;
  final String? base64Image;
  final double? borde;
  final int index; // Índice não nulo

  @override
  State<HtmlImage> createState() => _HtmlImageState();
}

class _HtmlImageState extends State<HtmlImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.index >= FFAppState().imagemLista.length) {
      // Se a imagem foi removida, retornamos um container vazio
      return Container();
    }
    // Definindo um tamanho máximo para a imagem
    double maxImageWidth = widget.width ?? 200; // Tamanho máximo da largura
    double maxImageHeight = widget.height ?? 200; // Tamanho máximo da altura

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borde ?? 0),
      ),
      child: FutureBuilder<Uint8List>(
        future: decodeBase64Image(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar a imagem');
          } else {
            Uint8List imageBytes = snapshot.data!;

            return Column(
              children: [
                if (imageBytes.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borde ?? 0),
                    child: Image.memory(
                      imageBytes,
                      width: maxImageWidth, // Limitando a largura
                      height: maxImageHeight, // Limitando a altura
                      fit: BoxFit.contain, // Ajustando a imagem sem cortar
                    ),
                  ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Remove a imagem da lista de imagens
                    FFAppState().imagemLista.removeAt(widget.index);
                    setState(() {}); // Atualiza o widget após a remoção
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Uint8List> decodeBase64Image() async {
    return await compute(base64Decode, widget.base64Image!);
  }
}
