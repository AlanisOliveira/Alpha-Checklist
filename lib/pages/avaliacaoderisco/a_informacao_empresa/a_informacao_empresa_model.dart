import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'a_informacao_empresa_widget.dart' show AInformacaoEmpresaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AInformacaoEmpresaModel
    extends FlutterFlowModel<AInformacaoEmpresaWidget> {
  ///  Local state fields for this component.

  bool empresaSet = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for NomePDF widget.
  FocusNode? nomePDFFocusNode;
  TextEditingController? nomePDFTextController;
  String? Function(BuildContext, String?)? nomePDFTextControllerValidator;
  String? _nomePDFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insira um nome para o PDF';
    }

    if (val.length < 1) {
      return '1';
    }
    if (val.length > 50) {
      return 'O nome não pode ter mais de 50 caracteres.';
    }

    return null;
  }

  // State field(s) for SelectEmpresa widget.
  int? selectEmpresaValue;
  FormFieldController<int>? selectEmpresaValueController;
  // Stores action output result for [Backend Call - SQLite (selectNomeEmpresaDrop)] action in SelectEmpresa widget.
  List<SelectNomeEmpresaDropRow>? empresaNomeResult;
  // State field(s) for SelectFuncao widget.
  List<String>? selectFuncaoValue;
  FormFieldController<List<String>>? selectFuncaoValueController;
  // State field(s) for SelectSetor widget.
  String? selectSetorValue;
  FormFieldController<String>? selectSetorValueController;
  // State field(s) for SelectAvaliador widget.
  String? selectAvaliadorValue;
  FormFieldController<String>? selectAvaliadorValueController;

  @override
  void initState(BuildContext context) {
    nomePDFTextControllerValidator = _nomePDFTextControllerValidator;
  }

  @override
  void dispose() {
    nomePDFFocusNode?.dispose();
    nomePDFTextController?.dispose();
  }
}
