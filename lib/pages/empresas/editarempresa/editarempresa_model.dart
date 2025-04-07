import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'editarempresa_widget.dart' show EditarempresaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditarempresaModel extends FlutterFlowModel<EditarempresaWidget> {
  ///  Local state fields for this component.

  bool trigger = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nomeEmpresa widget.
  FocusNode? nomeEmpresaFocusNode;
  TextEditingController? nomeEmpresaTextController;
  String? Function(BuildContext, String?)? nomeEmpresaTextControllerValidator;
  String? _nomeEmpresaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insira uma mensagem';
    }

    if (val.length < 1) {
      return 'Ao menos 1 caracter';
    }

    return null;
  }

  // State field(s) for cnpjEmpresa widget.
  FocusNode? cnpjEmpresaFocusNode;
  TextEditingController? cnpjEmpresaTextController;
  final cnpjEmpresaMask = MaskTextInputFormatter(mask: '##.###.###/####-##');
  String? Function(BuildContext, String?)? cnpjEmpresaTextControllerValidator;
  // State field(s) for CidadeEmpresa widget.
  FocusNode? cidadeEmpresaFocusNode;
  TextEditingController? cidadeEmpresaTextController;
  String? Function(BuildContext, String?)? cidadeEmpresaTextControllerValidator;
  String? _cidadeEmpresaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Preencha a cidade da empresa!';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for EstadoEmpresa widget.
  FocusNode? estadoEmpresaFocusNode;
  TextEditingController? estadoEmpresaTextController;
  String? Function(BuildContext, String?)? estadoEmpresaTextControllerValidator;
  String? _estadoEmpresaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Preencha o estado da empresa!';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for funcoes widget.
  FocusNode? funcoesFocusNode;
  TextEditingController? funcoesTextController;
  String? Function(BuildContext, String?)? funcoesTextControllerValidator;

  @override
  void initState(BuildContext context) {
    nomeEmpresaTextControllerValidator = _nomeEmpresaTextControllerValidator;
    cidadeEmpresaTextControllerValidator =
        _cidadeEmpresaTextControllerValidator;
    estadoEmpresaTextControllerValidator =
        _estadoEmpresaTextControllerValidator;
  }

  @override
  void dispose() {
    nomeEmpresaFocusNode?.dispose();
    nomeEmpresaTextController?.dispose();

    cnpjEmpresaFocusNode?.dispose();
    cnpjEmpresaTextController?.dispose();

    cidadeEmpresaFocusNode?.dispose();
    cidadeEmpresaTextController?.dispose();

    estadoEmpresaFocusNode?.dispose();
    estadoEmpresaTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    funcoesFocusNode?.dispose();
    funcoesTextController?.dispose();
  }

  /// Action blocks.
  Future component(BuildContext context) async {
    await component(context);
  }
}
