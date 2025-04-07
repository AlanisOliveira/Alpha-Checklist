import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/b_politicae_seguranca/b_politicae_seguranca_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'b_polticae_programasde_seguranca_widget.dart'
    show BPolticaeProgramasdeSegurancaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BPolticaeProgramasdeSegurancaModel
    extends FlutterFlowModel<BPolticaeProgramasdeSegurancaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for B-PoliticaeSeguranca component.
  late BPoliticaeSegurancaModel bPoliticaeSegurancaModel;

  @override
  void initState(BuildContext context) {
    bPoliticaeSegurancaModel =
        createModel(context, () => BPoliticaeSegurancaModel());
  }

  @override
  void dispose() {
    bPoliticaeSegurancaModel.dispose();
  }
}
