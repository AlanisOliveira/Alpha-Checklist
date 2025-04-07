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

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class ImageAssinatura extends StatefulWidget {
  const ImageAssinatura({
    super.key,
    this.width,
    this.height,
    this.base64Image,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final String? base64Image;
  final double? borderRadius;

  @override
  State<ImageAssinatura> createState() => _ImageAssinaturaState();
}

class _ImageAssinaturaState extends State<ImageAssinatura> {
  late Future<Uint8List?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = _decodeImage();
  }

  @override
  void didUpdateWidget(ImageAssinatura oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.base64Image != widget.base64Image) {
      _imageFuture = _decodeImage();
    }
  }

  Future<Uint8List?> _decodeImage() async {
    if (widget.base64Image == null || widget.base64Image!.isEmpty) {
      return null;
    }

    try {
      return await compute(_base64DecodeIsolate, widget.base64Image!);
    } catch (e) {
      debugPrint('Erro ao decodificar imagem: $e');
      return null;
    }
  }

  static Uint8List _base64DecodeIsolate(String image) => base64Decode(image);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = widget.width ?? constraints.maxWidth;
        final height = widget.height ?? constraints.maxHeight;

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          ),
          child: FutureBuilder<Uint8List?>(
            future: _imageFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || snapshot.data == null) {
                return _buildErrorWidget();
              }

              return _buildImage(snapshot.data!);
            },
          ),
        );
      },
    );
  }

  Widget _buildImage(Uint8List imageBytes) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      child: Image.memory(
        imageBytes,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.low,
        cacheWidth: widget.width?.toInt(),
        cacheHeight: widget.height?.toInt(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 40,
      ),
    );
  }
}
