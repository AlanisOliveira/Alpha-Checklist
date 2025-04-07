import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/nav_bar/nav_bar_configuracao/nav_bar_configuracao_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'configuracoes_widget.dart' show ConfiguracoesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ConfiguracoesModel extends FlutterFlowModel<ConfiguracoesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBarConfiguracao component.
  late NavBarConfiguracaoModel navBarConfiguracaoModel;

  @override
  void initState(BuildContext context) {
    navBarConfiguracaoModel =
        createModel(context, () => NavBarConfiguracaoModel());
  }

  @override
  void dispose() {
    navBarConfiguracaoModel.dispose();
  }
}
