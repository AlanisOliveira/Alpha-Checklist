import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/d_nome_colaboradore/d_nome_colaboradore_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'd_nome_colaboradores_widget.dart' show DNomeColaboradoresWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DNomeColaboradoresModel
    extends FlutterFlowModel<DNomeColaboradoresWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for D-NomeColaboradore component.
  late DNomeColaboradoreModel dNomeColaboradoreModel;

  @override
  void initState(BuildContext context) {
    dNomeColaboradoreModel =
        createModel(context, () => DNomeColaboradoreModel());
  }

  @override
  void dispose() {
    dNomeColaboradoreModel.dispose();
  }
}
