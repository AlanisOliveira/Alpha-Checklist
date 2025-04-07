import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'e_desc_colaboradores_widget.dart' show EDescColaboradoresWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EDescColaboradoresModel
    extends FlutterFlowModel<EDescColaboradoresWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for AtividadesDesenvolvidas widget.
  FocusNode? atividadesDesenvolvidasFocusNode;
  TextEditingController? atividadesDesenvolvidasTextController;
  String? Function(BuildContext, String?)?
      atividadesDesenvolvidasTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    atividadesDesenvolvidasFocusNode?.dispose();
    atividadesDesenvolvidasTextController?.dispose();
  }
}
