import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/z_assinatura_component/z_assinatura_component_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'z_assinatura_page_widget.dart' show ZAssinaturaPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ZAssinaturaPageModel extends FlutterFlowModel<ZAssinaturaPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Z-AssinaturaComponent component.
  late ZAssinaturaComponentModel zAssinaturaComponentModel;

  @override
  void initState(BuildContext context) {
    zAssinaturaComponentModel =
        createModel(context, () => ZAssinaturaComponentModel());
  }

  @override
  void dispose() {
    zAssinaturaComponentModel.dispose();
  }
}
