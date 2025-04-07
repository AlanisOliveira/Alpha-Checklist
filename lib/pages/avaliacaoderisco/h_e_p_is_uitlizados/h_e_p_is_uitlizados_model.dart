import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'h_e_p_is_uitlizados_widget.dart' show HEPIsUitlizadosWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HEPIsUitlizadosModel extends FlutterFlowModel<HEPIsUitlizadosWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for EPItext widget.
  FocusNode? ePItextFocusNode;
  TextEditingController? ePItextTextController;
  String? Function(BuildContext, String?)? ePItextTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    ePItextFocusNode?.dispose();
    ePItextTextController?.dispose();
  }
}
