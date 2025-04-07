import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/l_observacoes/l_observacoes_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'k_observacao_widget.dart' show KObservacaoWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class KObservacaoModel extends FlutterFlowModel<KObservacaoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for L-Observacoes component.
  late LObservacoesModel lObservacoesModel;

  @override
  void initState(BuildContext context) {
    lObservacoesModel = createModel(context, () => LObservacoesModel());
  }

  @override
  void dispose() {
    lObservacoesModel.dispose();
  }
}
