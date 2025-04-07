import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'a_informacao_empresa_mensal_widget.dart'
    show AInformacaoEmpresaMensalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AInformacaoEmpresaMensalModel
    extends FlutterFlowModel<AInformacaoEmpresaMensalWidget> {
  ///  Local state fields for this component.

  bool empresaSet = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for NomePDF widget.
  FocusNode? nomePDFFocusNode1;
  TextEditingController? nomePDFTextController1;
  String? Function(BuildContext, String?)? nomePDFTextController1Validator;
  String? _nomePDFTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insira um nome para o PDF';
    }

    if (val.length < 1) {
      return '1';
    }

    return null;
  }

  // State field(s) for SelectEmpresa widget.
  int? selectEmpresaValue;
  FormFieldController<int>? selectEmpresaValueController;
  // Stores action output result for [Backend Call - SQLite (selectNomeEmpresaDrop)] action in SelectEmpresa widget.
  List<SelectNomeEmpresaDropRow>? empresaNomeResult;
  // State field(s) for NomePDF widget.
  FocusNode? nomePDFFocusNode2;
  TextEditingController? nomePDFTextController2;
  String? Function(BuildContext, String?)? nomePDFTextController2Validator;
  // State field(s) for SelectAvaliador widget.
  String? selectAvaliadorValue;
  FormFieldController<String>? selectAvaliadorValueController;
  // State field(s) for SelectProfissao widget.
  String? selectProfissaoValue;
  FormFieldController<String>? selectProfissaoValueController;

  @override
  void initState(BuildContext context) {
    nomePDFTextController1Validator = _nomePDFTextController1Validator;
  }

  @override
  void dispose() {
    nomePDFFocusNode1?.dispose();
    nomePDFTextController1?.dispose();

    nomePDFFocusNode2?.dispose();
    nomePDFTextController2?.dispose();
  }
}
