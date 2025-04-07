import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'gerenciamento_dados_widget.dart' show GerenciamentoDadosWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GerenciamentoDadosModel
    extends FlutterFlowModel<GerenciamentoDadosWidget> {
  ///  Local state fields for this page.

  bool tipoAgemte = false;

  bool isEditing = false;

  bool bottomShow = false;

  bool descricaoBottom = false;

  bool sugestaoButtom = false;

  bool acoesButtom = false;

  bool riscosButtom = false;

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue1;
  FormFieldController<int>? tipoAgenteValueController1;
  // State field(s) for AgenteDescricaoDrop widget.
  int? agenteDescricaoDropValue;
  FormFieldController<int>? agenteDescricaoDropValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue2;
  FormFieldController<int>? tipoAgenteValueController2;
  // State field(s) for DropDown widget.
  int? dropDownValue1;
  FormFieldController<int>? dropDownValueController1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue3;
  FormFieldController<int>? tipoAgenteValueController3;
  // State field(s) for AgenteAcoesDropDown widget.
  int? agenteAcoesDropDownValue;
  FormFieldController<int>? agenteAcoesDropDownValueController;
  // State field(s) for AcoesTextField widget.
  FocusNode? acoesTextFieldFocusNode;
  TextEditingController? acoesTextFieldTextController;
  String? Function(BuildContext, String?)?
      acoesTextFieldTextControllerValidator;
  // State field(s) for TipoAgente widget.
  int? tipoAgenteValue4;
  FormFieldController<int>? tipoAgenteValueController4;
  // State field(s) for DropDown widget.
  int? dropDownValue2;
  FormFieldController<int>? dropDownValueController2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    acoesTextFieldFocusNode?.dispose();
    acoesTextFieldTextController?.dispose();

    textFieldFocusNode3?.dispose();
    textController4?.dispose();
  }
}
