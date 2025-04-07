import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/updates/update_medidas/update_medidas_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'gerenciamento_medidas_widget.dart' show GerenciamentoMedidasWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GerenciamentoMedidasModel
    extends FlutterFlowModel<GerenciamentoMedidasWidget> {
  ///  Local state fields for this page.

  bool tipoAgemte = false;

  bool isEditing = false;

  bool bottomShow = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue;
  FormFieldController<int>? tipoAgenteValueController;
  // State field(s) for DropDown widget.
  int? dropDownValue;
  FormFieldController<int>? dropDownValueController;
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
