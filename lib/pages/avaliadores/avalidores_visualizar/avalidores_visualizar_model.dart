import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/empty_state/empty/empty_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'avalidores_visualizar_widget.dart' show AvalidoresVisualizarWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AvalidoresVisualizarModel
    extends FlutterFlowModel<AvalidoresVisualizarWidget> {
  ///  Local state fields for this page.

  bool update = false;

  ///  State fields for stateful widgets in this page.

  // Model for empty component.
  late EmptyModel emptyModel;

  @override
  void initState(BuildContext context) {
    emptyModel = createModel(context, () => EmptyModel());
  }

  @override
  void dispose() {
    emptyModel.dispose();
  }
}
