import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'l_questionario_component_widget.dart' show LQuestionarioComponentWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LQuestionarioComponentModel
    extends FlutterFlowModel<LQuestionarioComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for espacoConfinado widget.
  FormFieldController<String>? espacoConfinadoValueController1;
  // State field(s) for espacoConfinado widget.
  FormFieldController<String>? espacoConfinadoValueController2;
  // State field(s) for treinamentoNR33Tab widget.
  FormFieldController<String>? treinamentoNR33TabValueController1;
  // State field(s) for treinamentoNR33Tab widget.
  FormFieldController<String>? treinamentoNR33TabValueController2;
  // State field(s) for Datanr33 widget.
  FocusNode? datanr33FocusNode;
  TextEditingController? datanr33TextController;
  String? Function(BuildContext, String?)? datanr33TextControllerValidator;
  DateTime? datePicked1;
  // State field(s) for descricaonr33 widget.
  FocusNode? descricaonr33FocusNode;
  TextEditingController? descricaonr33TextController;
  String? Function(BuildContext, String?)? descricaonr33TextControllerValidator;
  // State field(s) for trabalhoAltura widget.
  FormFieldController<String>? trabalhoAlturaValueController1;
  // State field(s) for trabalhoAltura widget.
  FormFieldController<String>? trabalhoAlturaValueController2;
  // State field(s) for treinamentonr35Tab widget.
  FormFieldController<String>? treinamentonr35TabValueController;
  // State field(s) for treinamentonr35Cel widget.
  FormFieldController<String>? treinamentonr35CelValueController;
  // State field(s) for Datanr35 widget.
  FocusNode? datanr35FocusNode;
  TextEditingController? datanr35TextController;
  String? Function(BuildContext, String?)? datanr35TextControllerValidator;
  DateTime? datePicked2;
  // State field(s) for descricaonr35 widget.
  FocusNode? descricaonr35FocusNode;
  TextEditingController? descricaonr35TextController;
  String? Function(BuildContext, String?)? descricaonr35TextControllerValidator;
  // State field(s) for exposicaoEletricidade widget.
  FormFieldController<String>? exposicaoEletricidadeValueController1;
  // State field(s) for exposicaoEletricidade widget.
  FormFieldController<String>? exposicaoEletricidadeValueController2;
  // State field(s) for treinamentoNR10Tab widget.
  FormFieldController<String>? treinamentoNR10TabValueController1;
  // State field(s) for treinamentoNR10Tab widget.
  FormFieldController<String>? treinamentoNR10TabValueController2;
  // State field(s) for Datanr10 widget.
  FocusNode? datanr10FocusNode;
  TextEditingController? datanr10TextController;
  String? Function(BuildContext, String?)? datanr10TextControllerValidator;
  DateTime? datePicked3;
  // State field(s) for descricaonr10 widget.
  FocusNode? descricaonr10FocusNode;
  TextEditingController? descricaonr10TextController;
  String? Function(BuildContext, String?)? descricaonr10TextControllerValidator;
  // State field(s) for conducaoVeiculo widget.
  FormFieldController<String>? conducaoVeiculoValueController1;
  // State field(s) for direcaoDefensivaTab widget.
  FormFieldController<String>? direcaoDefensivaTabValueController1;
  // State field(s) for conducaoVeiculo widget.
  FormFieldController<String>? conducaoVeiculoValueController2;
  // State field(s) for direcaoDefensivaTab widget.
  FormFieldController<String>? direcaoDefensivaTabValueController2;
  // State field(s) for DataDirecao widget.
  FocusNode? dataDirecaoFocusNode;
  TextEditingController? dataDirecaoTextController;
  String? Function(BuildContext, String?)? dataDirecaoTextControllerValidator;
  DateTime? datePicked4;
  // State field(s) for descricaoveiculos widget.
  FocusNode? descricaoveiculosFocusNode;
  TextEditingController? descricaoveiculosTextController;
  String? Function(BuildContext, String?)?
      descricaoveiculosTextControllerValidator;
  // State field(s) for operacaoEquipamento widget.
  FormFieldController<String>? operacaoEquipamentoValueController1;
  // State field(s) for operacaoEquipamento widget.
  FormFieldController<String>? operacaoEquipamentoValueController2;
  // State field(s) for treinamentoOperacaoTab widget.
  FormFieldController<String>? treinamentoOperacaoTabValueController1;
  // State field(s) for treinamentoOperacaoTab widget.
  FormFieldController<String>? treinamentoOperacaoTabValueController2;
  // State field(s) for cartaoidentificacao widget.
  FormFieldController<String>? cartaoidentificacaoValueController1;
  // State field(s) for cartaoidentificacao widget.
  FormFieldController<String>? cartaoidentificacaoValueController2;
  // State field(s) for Data05 widget.
  FocusNode? data05FocusNode;
  TextEditingController? data05TextController;
  String? Function(BuildContext, String?)? data05TextControllerValidator;
  DateTime? datePicked5;
  // State field(s) for descricaoequipamento widget.
  FocusNode? descricaoequipamentoFocusNode;
  TextEditingController? descricaoequipamentoTextController;
  String? Function(BuildContext, String?)?
      descricaoequipamentoTextControllerValidator;
  // State field(s) for TreinamentoTextField widget.
  FocusNode? treinamentoTextFieldFocusNode;
  TextEditingController? treinamentoTextFieldTextController;
  String? Function(BuildContext, String?)?
      treinamentoTextFieldTextControllerValidator;
  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController1;
  List<String>? get checkboxGroupValues1 =>
      checkboxGroupValueController1?.value;
  set checkboxGroupValues1(List<String>? v) =>
      checkboxGroupValueController1?.value = v;

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController2;
  List<String>? get checkboxGroupValues2 =>
      checkboxGroupValueController2?.value;
  set checkboxGroupValues2(List<String>? v) =>
      checkboxGroupValueController2?.value = v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    datanr33FocusNode?.dispose();
    datanr33TextController?.dispose();

    descricaonr33FocusNode?.dispose();
    descricaonr33TextController?.dispose();

    datanr35FocusNode?.dispose();
    datanr35TextController?.dispose();

    descricaonr35FocusNode?.dispose();
    descricaonr35TextController?.dispose();

    datanr10FocusNode?.dispose();
    datanr10TextController?.dispose();

    descricaonr10FocusNode?.dispose();
    descricaonr10TextController?.dispose();

    dataDirecaoFocusNode?.dispose();
    dataDirecaoTextController?.dispose();

    descricaoveiculosFocusNode?.dispose();
    descricaoveiculosTextController?.dispose();

    data05FocusNode?.dispose();
    data05TextController?.dispose();

    descricaoequipamentoFocusNode?.dispose();
    descricaoequipamentoTextController?.dispose();

    treinamentoTextFieldFocusNode?.dispose();
    treinamentoTextFieldTextController?.dispose();
  }

  /// Additional helper methods.
  String? get espacoConfinadoValue1 => espacoConfinadoValueController1?.value;
  String? get espacoConfinadoValue2 => espacoConfinadoValueController2?.value;
  String? get treinamentoNR33TabValue1 =>
      treinamentoNR33TabValueController1?.value;
  String? get treinamentoNR33TabValue2 =>
      treinamentoNR33TabValueController2?.value;
  String? get trabalhoAlturaValue1 => trabalhoAlturaValueController1?.value;
  String? get trabalhoAlturaValue2 => trabalhoAlturaValueController2?.value;
  String? get treinamentonr35TabValue =>
      treinamentonr35TabValueController?.value;
  String? get treinamentonr35CelValue =>
      treinamentonr35CelValueController?.value;
  String? get exposicaoEletricidadeValue1 =>
      exposicaoEletricidadeValueController1?.value;
  String? get exposicaoEletricidadeValue2 =>
      exposicaoEletricidadeValueController2?.value;
  String? get treinamentoNR10TabValue1 =>
      treinamentoNR10TabValueController1?.value;
  String? get treinamentoNR10TabValue2 =>
      treinamentoNR10TabValueController2?.value;
  String? get conducaoVeiculoValue1 => conducaoVeiculoValueController1?.value;
  String? get direcaoDefensivaTabValue1 =>
      direcaoDefensivaTabValueController1?.value;
  String? get conducaoVeiculoValue2 => conducaoVeiculoValueController2?.value;
  String? get direcaoDefensivaTabValue2 =>
      direcaoDefensivaTabValueController2?.value;
  String? get operacaoEquipamentoValue1 =>
      operacaoEquipamentoValueController1?.value;
  String? get operacaoEquipamentoValue2 =>
      operacaoEquipamentoValueController2?.value;
  String? get treinamentoOperacaoTabValue1 =>
      treinamentoOperacaoTabValueController1?.value;
  String? get treinamentoOperacaoTabValue2 =>
      treinamentoOperacaoTabValueController2?.value;
  String? get cartaoidentificacaoValue1 =>
      cartaoidentificacaoValueController1?.value;
  String? get cartaoidentificacaoValue2 =>
      cartaoidentificacaoValueController2?.value;
}
