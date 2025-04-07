import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'd_nome_colaboradore_widget.dart' show DNomeColaboradoreWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DNomeColaboradoreModel extends FlutterFlowModel<DNomeColaboradoreWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ColaboradorText widget.
  FocusNode? colaboradorTextFocusNode;
  TextEditingController? colaboradorTextTextController;
  String? Function(BuildContext, String?)?
      colaboradorTextTextControllerValidator;
  String? _colaboradorTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo!';
    }

    if (val.length < 1) {
      return '1';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    colaboradorTextTextControllerValidator =
        _colaboradorTextTextControllerValidator;
  }

  @override
  void dispose() {
    colaboradorTextFocusNode?.dispose();
    colaboradorTextTextController?.dispose();
  }
}
