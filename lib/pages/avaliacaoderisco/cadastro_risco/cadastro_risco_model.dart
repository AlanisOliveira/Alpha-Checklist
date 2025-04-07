import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/j_cadastro_tipode_risco/j_cadastro_tipode_risco_widget.dart';
import '/pages/components_unit/back_component_risco/back_component_risco_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'cadastro_risco_widget.dart' show CadastroRiscoWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CadastroRiscoModel extends FlutterFlowModel<CadastroRiscoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for J-CadastroTipodeRisco component.
  late JCadastroTipodeRiscoModel jCadastroTipodeRiscoModel;

  @override
  void initState(BuildContext context) {
    jCadastroTipodeRiscoModel =
        createModel(context, () => JCadastroTipodeRiscoModel());
  }

  @override
  void dispose() {
    jCadastroTipodeRiscoModel.dispose();
  }
}
