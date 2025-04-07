import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'b_politicae_seguranca_widget.dart' show BPoliticaeSegurancaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BPoliticaeSegurancaModel
    extends FlutterFlowModel<BPoliticaeSegurancaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for PoliticasCheckBox widget.
  FormFieldController<List<String>>? politicasCheckBoxValueController;
  List<String>? get politicasCheckBoxValues =>
      politicasCheckBoxValueController?.value;
  set politicasCheckBoxValues(List<String>? v) =>
      politicasCheckBoxValueController?.value = v;

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
