import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/gerenciamento_risco/explicacao_gerenciamento_e_p_i/explicacao_gerenciamento_e_p_i_widget.dart';
import '/pages/updates/update_e_p_i/update_e_p_i_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'gerenciamento_e_p_i_agente_widget.dart'
    show GerenciamentoEPIAgenteWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GerenciamentoEPIAgenteModel
    extends FlutterFlowModel<GerenciamentoEPIAgenteWidget> {
  ///  Local state fields for this page.

  bool tipoAgemte = false;

  bool isEditing = false;

  bool bottomShow = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue1;
  FormFieldController<int>? tipoAgenteValueController1;
  // State field(s) for DropDown widget.
  int? dropDownValue1;
  FormFieldController<int>? dropDownValueController1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue2;
  FormFieldController<int>? tipoAgenteValueController2;
  // State field(s) for DropDown widget.
  int? dropDownValue2;
  FormFieldController<int>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
