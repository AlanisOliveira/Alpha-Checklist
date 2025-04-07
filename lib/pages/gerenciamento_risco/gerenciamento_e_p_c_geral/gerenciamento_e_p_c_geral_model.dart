import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/gerenciamento_risco/explicacao_gerenciamento_e_p_c/explicacao_gerenciamento_e_p_c_widget.dart';
import '/pages/updates/update_e_p_c/update_e_p_c_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'gerenciamento_e_p_c_geral_widget.dart' show GerenciamentoEPCGeralWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GerenciamentoEPCGeralModel
    extends FlutterFlowModel<GerenciamentoEPCGeralWidget> {
  ///  Local state fields for this page.

  bool tipoAgemte = false;

  bool isEditing = false;

  bool bottomShow = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
