import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'agentes_select_component_widget.dart' show AgentesSelectComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgentesSelectComponentModel
    extends FlutterFlowModel<AgentesSelectComponentWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insira um nome para a empresa';
    }

    return null;
  }

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

  // State field(s) for CheckboxGroupPsicossociais widget.
  FormFieldController<List<String>>? checkboxGroupPsicossociaisValueController;
  List<String>? get checkboxGroupPsicossociaisValues =>
      checkboxGroupPsicossociaisValueController?.value;
  set checkboxGroupPsicossociaisValues(List<String>? v) =>
      checkboxGroupPsicossociaisValueController?.value = v;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
