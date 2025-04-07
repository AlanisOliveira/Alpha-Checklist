import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'agente_avaliacao_mensal_widget.dart' show AgenteAvaliacaoMensalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgenteAvaliacaoMensalModel
    extends FlutterFlowModel<AgenteAvaliacaoMensalWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxGroupFisico widget.
  FormFieldController<List<String>>? checkboxGroupFisicoValueController;
  List<String>? get checkboxGroupFisicoValues =>
      checkboxGroupFisicoValueController?.value;
  set checkboxGroupFisicoValues(List<String>? v) =>
      checkboxGroupFisicoValueController?.value = v;

  // State field(s) for CheckboxGroupQuimico widget.
  FormFieldController<List<String>>? checkboxGroupQuimicoValueController;
  List<String>? get checkboxGroupQuimicoValues =>
      checkboxGroupQuimicoValueController?.value;
  set checkboxGroupQuimicoValues(List<String>? v) =>
      checkboxGroupQuimicoValueController?.value = v;

  // State field(s) for CheckboxGroupBiologico widget.
  FormFieldController<List<String>>? checkboxGroupBiologicoValueController;
  List<String>? get checkboxGroupBiologicoValues =>
      checkboxGroupBiologicoValueController?.value;
  set checkboxGroupBiologicoValues(List<String>? v) =>
      checkboxGroupBiologicoValueController?.value = v;

  // State field(s) for CheckboxGroupErgonomico widget.
  FormFieldController<List<String>>? checkboxGroupErgonomicoValueController;
  List<String>? get checkboxGroupErgonomicoValues =>
      checkboxGroupErgonomicoValueController?.value;
  set checkboxGroupErgonomicoValues(List<String>? v) =>
      checkboxGroupErgonomicoValueController?.value = v;

  // State field(s) for CheckboxGroupAcidente widget.
  FormFieldController<List<String>>? checkboxGroupAcidenteValueController;
  List<String>? get checkboxGroupAcidenteValues =>
      checkboxGroupAcidenteValueController?.value;
  set checkboxGroupAcidenteValues(List<String>? v) =>
      checkboxGroupAcidenteValueController?.value = v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
