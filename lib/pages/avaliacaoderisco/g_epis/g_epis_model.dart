import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/h_e_p_is_uitlizados/h_e_p_is_uitlizados_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'g_epis_widget.dart' show GEpisWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GEpisModel extends FlutterFlowModel<GEpisWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for H-EPIsUitlizados component.
  late HEPIsUitlizadosModel hEPIsUitlizadosModel;

  @override
  void initState(BuildContext context) {
    hEPIsUitlizadosModel = createModel(context, () => HEPIsUitlizadosModel());
  }

  @override
  void dispose() {
    hEPIsUitlizadosModel.dispose();
  }
}
