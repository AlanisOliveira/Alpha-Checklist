import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home_page/agentes_select_component/agentes_select_component_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'agentes_pre_selecionados_widget.dart' show AgentesPreSelecionadosWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgentesPreSelecionadosModel
    extends FlutterFlowModel<AgentesPreSelecionadosWidget> {
  ///  Local state fields for this component.

  bool troggleOn = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap = {};
  List<dynamic> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
