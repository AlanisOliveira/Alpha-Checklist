import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/nav_bar/nav_bar_sobre/nav_bar_sobre_widget.dart';
import '/pages/sobre/card_sobre_nos/card_sobre_nos_widget.dart';
import 'dart:ui';
import 'sobre_widget.dart' show SobreWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SobreModel extends FlutterFlowModel<SobreWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBarSobre component.
  late NavBarSobreModel navBarSobreModel;

  @override
  void initState(BuildContext context) {
    navBarSobreModel = createModel(context, () => NavBarSobreModel());
  }

  @override
  void dispose() {
    navBarSobreModel.dispose();
  }
}
