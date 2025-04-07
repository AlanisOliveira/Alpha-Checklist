import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/empresas/cadastrarempresa/cadastrarempresa_widget.dart';
import '/pages/empresas/editarempresa/editarempresa_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'empresas_widget.dart' show EmpresasWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmpresasModel extends FlutterFlowModel<EmpresasWidget> {
  ///  Local state fields for this page.

  bool refreshTrigger = false;

  /// usado para mostrar as pesquisas
  bool showAll = true;

  ///  State fields for stateful widgets in this page.

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
