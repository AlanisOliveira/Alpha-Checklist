import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacao_mensal/agente_avaliacao_mensal/agente_avaliacao_mensal_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'b_agentes_widget.dart' show BAgentesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BAgentesModel extends FlutterFlowModel<BAgentesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AgenteAvaliacaoMensal component.
  late AgenteAvaliacaoMensalModel agenteAvaliacaoMensalModel;

  @override
  void initState(BuildContext context) {
    agenteAvaliacaoMensalModel =
        createModel(context, () => AgenteAvaliacaoMensalModel());
  }

  @override
  void dispose() {
    agenteAvaliacaoMensalModel.dispose();
  }
}
