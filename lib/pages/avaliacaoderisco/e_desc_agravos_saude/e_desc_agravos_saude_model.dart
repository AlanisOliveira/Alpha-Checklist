import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/f_desc_agravos/f_desc_agravos_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'e_desc_agravos_saude_widget.dart' show EDescAgravosSaudeWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EDescAgravosSaudeModel extends FlutterFlowModel<EDescAgravosSaudeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for F-DescAgravos component.
  late FDescAgravosModel fDescAgravosModel;

  @override
  void initState(BuildContext context) {
    fDescAgravosModel = createModel(context, () => FDescAgravosModel());
  }

  @override
  void dispose() {
    fDescAgravosModel.dispose();
  }
}
