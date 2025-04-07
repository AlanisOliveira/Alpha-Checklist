import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/i_tipoderiscoo/i_tipoderiscoo_widget.dart';
import '/pages/home_page/agentes_pre_selecionados/agentes_pre_selecionados_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'h_tipoderisco_widget.dart' show HTipoderiscoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HTipoderiscoModel extends FlutterFlowModel<HTipoderiscoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for I-Tipoderiscoo component.
  late ITipoderiscooModel iTipoderiscooModel;

  @override
  void initState(BuildContext context) {
    iTipoderiscooModel = createModel(context, () => ITipoderiscooModel());
  }

  @override
  void dispose() {
    iTipoderiscooModel.dispose();
  }
}
