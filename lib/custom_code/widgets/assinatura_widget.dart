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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:signature/signature.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssinaturaWidget extends StatefulWidget {
  const AssinaturaWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<AssinaturaWidget> createState() => _AssinaturaWidgetState();
}

class _AssinaturaWidgetState extends State<AssinaturaWidget> {
  late SignatureController _signatureController;
  late TextEditingController _colaboradorTextController;
  bool hasSignature = false;

  @override
  void initState() {
    super.initState();
    _colaboradorTextController = TextEditingController();
    _signatureController = SignatureController(
      penStrokeWidth: 3.0,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
    // Adiciona um listener para detectar mudanças instantaneamente
    _signatureController.addListener(() {
      if (_signatureController.isNotEmpty && !hasSignature) {
        setState(() {
          hasSignature = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _colaboradorTextController.dispose();
    super.dispose();
  }

  Future<void> _captureSignature() async {
    if (_colaboradorTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira o nome do colaborador'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Use a fixed height and ensure it's large enough
      final signatureBytes = await _signatureController.toPngBytes(
        height:
            300, // Increase the height to ensure it captures the full signature
      );

      if (signatureBytes != null) {
        final base64String = base64Encode(signatureBytes);
        final nomeColaborador = _colaboradorTextController.text;

        if (!mounted) return;

        setState(() {
          FFAppState().Base64Signature = base64String;
          FFAppState().nomeColaboradorSignature = nomeColaborador;
          FFAppState().Assinaturas = [
            ...FFAppState().Assinaturas,
            {
              'nome': nomeColaborador,
              'assinatura': base64String,
            },
          ];
        });

        // Mostra mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(FontAwesomeIcons.circleCheck,
                    color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text('Assinatura salva com sucesso!'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );

        // Fecha o modal imediatamente após salvar
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error capturing signature: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar assinatura'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo Nome do Colaborador
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome do Colaborador',
                style: theme.bodyMedium.override(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _colaboradorTextController,
                decoration: InputDecoration(
                  hintText: 'Digite seu nome completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF04337A), width: 2),
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Área de Assinatura
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Área de Assinatura',
                    style: theme.bodyMedium.override(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _signatureController.clear();
                      setState(() => hasSignature = false);
                    },
                    icon: Icon(FontAwesomeIcons.trash,
                        size: 16, color: Colors.red[400]),
                    label: Text(
                      'Limpar',
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  ),
                ],
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  color: Colors.grey[50],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      if (!hasSignature)
                        Positioned.fill(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.signature,
                                    size: 32,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Clique ou toque para começar a assinar',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Positioned.fill(
                        child: Signature(
                          controller: _signatureController,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (!hasSignature)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.circleInfo,
                        size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Sua assinatura será usada em documentos oficiais. Certifique-se de assinar de forma clara e legível.',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Botões
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                ElevatedButton(
                  onPressed: hasSignature ? _captureSignature : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF04337A),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Salvar Assinatura'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
