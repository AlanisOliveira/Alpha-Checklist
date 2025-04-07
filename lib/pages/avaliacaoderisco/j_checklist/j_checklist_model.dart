import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/l_questionario_component/l_questionario_component_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'j_checklist_widget.dart' show JChecklistWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JChecklistModel extends FlutterFlowModel<JChecklistWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for L-QuestionarioComponent component.
  late LQuestionarioComponentModel lQuestionarioComponentModel;

  @override
  void initState(BuildContext context) {
    lQuestionarioComponentModel =
        createModel(context, () => LQuestionarioComponentModel());
  }

  @override
  void dispose() {
    lQuestionarioComponentModel.dispose();
  }
}
