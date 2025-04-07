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

import 'package:signature/signature.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssinaturaDB extends StatefulWidget {
  const AssinaturaDB({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<AssinaturaDB> createState() => _AssinaturaDBState();
}

class _AssinaturaDBState extends State<AssinaturaDB> {
  late SignatureController _signatureController;
  late TextEditingController _colaboradorTextController;
  bool hasSignature = false;
  List<Map<String, dynamic>> empresas = [];
  int? selectedEmpresaId;
  String? nomeColaboradorError;
  String? empresaError;

  @override
  void initState() {
    super.initState();
    _colaboradorTextController = TextEditingController();
    _signatureController = SignatureController(
      penStrokeWidth: 3.0,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
    _signatureController.addListener(() {
      if (_signatureController.isNotEmpty && !hasSignature && mounted) {
        setState(() {
          hasSignature = true;
        });
      }
    });
    _loadEmpresas();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _colaboradorTextController.dispose();
    super.dispose();
  }

  Future<void> _loadEmpresas() async {
    try {
      final empresasList = await getEmpresas();
      if (mounted) {
        setState(() {
          empresas = empresasList;
        });
      }
    } catch (e) {
      print('Erro ao carregar empresas: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar empresas. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<List<Map<String, dynamic>>> getEmpresas() async {
    final db = await SQLiteManager.instance.database;
    final List<Map<String, dynamic>> empresas = await db.query('EMPRESAS');
    return empresas;
  }

  void _validateFields() {
    setState(() {
      nomeColaboradorError = _colaboradorTextController.text.isEmpty
          ? 'Por favor, insira o nome do colaborador'
          : null;
      empresaError =
          selectedEmpresaId == null ? 'Por favor, selecione uma empresa' : null;
    });
  }

  Future<void> _captureSignature() async {
    _validateFields();

    if (nomeColaboradorError != null || empresaError != null) {
      return;
    }

    try {
      final signatureBytes = await _signatureController.toPngBytes(height: 300);

      if (signatureBytes != null) {
        final base64String = base64Encode(signatureBytes);
        final nomeColaborador = _colaboradorTextController.text;

        final db = await SQLiteManager.instance.database;
        await db.insert('assinaturas', {
          'nomeColaborador': nomeColaborador,
          'ID_EMPRESA': selectedEmpresaId,
          'assinatura': base64String,
        });

        if (!mounted) return;

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

        Navigator.pop(context);
      }
    } catch (e) {
      print('Erro ao capturar assinatura: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar assinatura'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
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
                      borderSide:
                          BorderSide(color: Color(0xFF04337A), width: 2),
                    ),
                    contentPadding: EdgeInsets.all(12),
                    errorText: nomeColaboradorError,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Dropdown de Empresas
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Empresa',
                  style: theme.bodyMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: selectedEmpresaId,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedEmpresaId = newValue;
                      empresaError = null;
                    });
                  },
                  items: empresas.map<DropdownMenuItem<int>>(
                      (Map<String, dynamic> empresa) {
                    return DropdownMenuItem<int>(
                      value: empresa['ID_EMPRESAS'],
                      child: Text(empresa['Nome'] ?? 'Nome não disponível'),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Color(0xFF04337A), width: 2),
                    ),
                    contentPadding: EdgeInsets.all(12),
                    errorText: empresaError,
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
                        if (mounted) {
                          setState(() => hasSignature = false);
                        }
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
      ),
    );
  }
}
