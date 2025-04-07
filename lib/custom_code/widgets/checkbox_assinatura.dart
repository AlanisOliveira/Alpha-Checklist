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

class CheckboxAssinatura extends StatefulWidget {
  const CheckboxAssinatura({
    super.key,
    this.width,
    this.height,
    required this.nomeColaborador,
    required this.assinatura,
  });

  final double? width;
  final double? height;
  final String nomeColaborador;
  final String assinatura;

  @override
  State<CheckboxAssinatura> createState() => _CheckboxAssinaturaState();
}

class _CheckboxAssinaturaState extends State<CheckboxAssinatura> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _updateSelectionState();
  }

  // Atualiza o estado do checkbox baseado na lista do AppState
  void _updateSelectionState() {
    _isSelected = FFAppState().Assinaturas.any(
          (item) =>
              item['nome'] == widget.nomeColaborador &&
              item['assinatura'] == widget.assinatura,
        );
  }

  // Lógica para adicionar/remover da lista
  void _handleCheckboxChange(bool? newValue) {
    if (newValue == null) return;

    setState(() {
      _isSelected = newValue;
    });

    if (newValue) {
      // Adiciona à lista
      FFAppState().Assinaturas.add({
        'nome': widget.nomeColaborador,
        'assinatura': widget.assinatura,
      });
    } else {
      // Encontra o índice pelo conteúdo e remove
      final index = FFAppState().Assinaturas.indexWhere(
            (item) =>
                item['nome'] == widget.nomeColaborador &&
                item['assinatura'] == widget.assinatura,
          );
      if (index != -1) {
        FFAppState().Assinaturas.removeAt(index);
      }
    }

    // Atualiza a UI globalmente (equivalente ao Set State do FlutterFlow)
    FFAppState().update(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isSelected,
      onChanged: _handleCheckboxChange,
      activeColor: Colors.blue, // Personalize conforme seu tema
      checkColor: Colors.white,
    );
  }
}
