import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components_unit/load_component/load_component_widget.dart';
import '/pages/nav_bar/nav_bar_home/nav_bar_home_widget.dart';
import '/pages/nav_bar/nav_bar_home_tablet/nav_bar_home_tablet_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'tela_inicial_widget.dart' show TelaInicialWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class TelaInicialModel extends FlutterFlowModel<TelaInicialWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBarHome component.
  late NavBarHomeModel navBarHomeModel;
  // Model for NavBarHomeTablet component.
  late NavBarHomeTabletModel navBarHomeTabletModel;

  @override
  void initState(BuildContext context) {
    navBarHomeModel = createModel(context, () => NavBarHomeModel());
    navBarHomeTabletModel = createModel(context, () => NavBarHomeTabletModel());
  }

  @override
  void dispose() {
    navBarHomeModel.dispose();
    navBarHomeTabletModel.dispose();
  }
}
