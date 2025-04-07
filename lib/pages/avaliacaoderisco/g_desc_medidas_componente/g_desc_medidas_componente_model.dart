import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'g_desc_medidas_componente_widget.dart'
    show GDescMedidasComponenteWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GDescMedidasComponenteModel
    extends FlutterFlowModel<GDescMedidasComponenteWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for MedidasImplementadas widget.
  FocusNode? medidasImplementadasFocusNode;
  TextEditingController? medidasImplementadasTextController;
  String? Function(BuildContext, String?)?
      medidasImplementadasTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    medidasImplementadasFocusNode?.dispose();
    medidasImplementadasTextController?.dispose();
  }
}
