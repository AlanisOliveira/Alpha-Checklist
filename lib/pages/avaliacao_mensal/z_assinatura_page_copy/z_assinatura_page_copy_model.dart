import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacao_mensal/assinatura_component_mensal/assinatura_component_mensal_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'z_assinatura_page_copy_widget.dart' show ZAssinaturaPageCopyWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ZAssinaturaPageCopyModel
    extends FlutterFlowModel<ZAssinaturaPageCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AssinaturaComponentMensal component.
  late AssinaturaComponentMensalModel assinaturaComponentMensalModel;

  @override
  void initState(BuildContext context) {
    assinaturaComponentMensalModel =
        createModel(context, () => AssinaturaComponentMensalModel());
  }

  @override
  void dispose() {
    assinaturaComponentMensalModel.dispose();
  }
}
