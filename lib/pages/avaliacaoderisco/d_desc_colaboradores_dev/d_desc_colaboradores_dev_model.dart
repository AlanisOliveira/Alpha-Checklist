import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/e_desc_colaboradores/e_desc_colaboradores_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'd_desc_colaboradores_dev_widget.dart' show DDescColaboradoresDevWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DDescColaboradoresDevModel
    extends FlutterFlowModel<DDescColaboradoresDevWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for E-DescColaboradores component.
  late EDescColaboradoresModel eDescColaboradoresModel;

  @override
  void initState(BuildContext context) {
    eDescColaboradoresModel =
        createModel(context, () => EDescColaboradoresModel());
  }

  @override
  void dispose() {
    eDescColaboradoresModel.dispose();
  }
}
