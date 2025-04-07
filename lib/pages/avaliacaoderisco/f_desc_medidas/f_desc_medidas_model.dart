import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/g_desc_medidas_componente/g_desc_medidas_componente_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'f_desc_medidas_widget.dart' show FDescMedidasWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FDescMedidasModel extends FlutterFlowModel<FDescMedidasWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for G-DescMedidasComponente component.
  late GDescMedidasComponenteModel gDescMedidasComponenteModel;

  @override
  void initState(BuildContext context) {
    gDescMedidasComponenteModel =
        createModel(context, () => GDescMedidasComponenteModel());
  }

  @override
  void dispose() {
    gDescMedidasComponenteModel.dispose();
  }
}
