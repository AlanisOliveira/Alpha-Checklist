import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'f_desc_agravos_widget.dart' show FDescAgravosWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FDescAgravosModel extends FlutterFlowModel<FDescAgravosWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for AgravosText widget.
  FocusNode? agravosTextFocusNode;
  TextEditingController? agravosTextTextController;
  String? Function(BuildContext, String?)? agravosTextTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    agravosTextFocusNode?.dispose();
    agravosTextTextController?.dispose();
  }
}
