import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/imagens/adicionarimagem/adicionarimagem_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'j_cadastro_tipode_risco_widget.dart' show JCadastroTipodeRiscoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class JCadastroTipodeRiscoModel
    extends FlutterFlowModel<JCadastroTipodeRiscoWidget> {
  ///  Local state fields for this component.

  bool matrizderiscoTrue = false;

  bool matrizderiscoFalse = false;

  ///  State fields for stateful widgets in this component.

  final formKey4 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  // State field(s) for TipoDropDown widget.
  int? tipoDropDownValue;
  FormFieldController<int>? tipoDropDownValueController;
  // Stores action output result for [Backend Call - SQLite (selectTipoRiscoDrop)] action in TipoDropDown widget.
  List<SelectTipoRiscoDropRow>? nome;
  // State field(s) for AgenteDropDown widget.
  int? agenteDropDownValue;
  FormFieldController<int>? agenteDropDownValueController;
  // Stores action output result for [Backend Call - SQLite (selectAgenteDrop)] action in AgenteDropDown widget.
  List<SelectAgenteDropRow>? nomeAgente;
  // Stores action output result for [Backend Call - SQLite (selectSugestao)] action in AgenteDropDown widget.
  List<SelectSugestaoRow>? sugestaoInicial;
  // Stores action output result for [Backend Call - SQLite (SelectDescricaoDados)] action in AgenteDropDown widget.
  List<SelectDescricaoDadosRow>? descricao;
  // Stores action output result for [Backend Call - SQLite (selectFromDados)] action in AgenteDropDown widget.
  List<SelectFromDadosRow>? riscos;
  // Stores action output result for [Backend Call - SQLite (selectFromDados)] action in AgenteDropDown widget.
  List<SelectFromDadosRow>? acoes;
  // Stores action output result for [Backend Call - SQLite (selectEPIs)] action in AgenteDropDown widget.
  List<SelectEPIsRow>? nomeEPI;
  // Stores action output result for [Backend Call - SQLite (selectEPCfromID)] action in AgenteDropDown widget.
  List<SelectEPCfromIDRow>? nomeEPC;
  // Stores action output result for [Backend Call - SQLite (SelectMedidasFromID)] action in AgenteDropDown widget.
  List<SelectMedidasFromIDRow>? nomeMedid;
  // State field(s) for MatrizdeRiscoDropdown widget.
  String? matrizdeRiscoDropdownValue;
  FormFieldController<String>? matrizdeRiscoDropdownValueController;
  // State field(s) for ProbabilidadeDropdown widget.
  String? probabilidadeDropdownValue;
  FormFieldController<String>? probabilidadeDropdownValueController;
  // State field(s) for SeveridadeDropdown widget.
  String? severidadeDropdownValue;
  FormFieldController<String>? severidadeDropdownValueController;
  // State field(s) for AmbienteTextField widget.
  FocusNode? ambienteTextFieldFocusNode;
  TextEditingController? ambienteTextFieldTextController;
  String? Function(BuildContext, String?)?
      ambienteTextFieldTextControllerValidator;
  String? _ambienteTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo.';
    }
    if (val.length > 75) {
      return 'Muitos caracteres!';
    }

    return null;
  }

  // State field(s) for AvaliacaoRadioButton widget.
  FormFieldController<String>? avaliacaoRadioButtonValueController;
  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController;
  List<String>? get checkboxGroupValues => checkboxGroupValueController?.value;
  set checkboxGroupValues(List<String>? v) =>
      checkboxGroupValueController?.value = v;

  // State field(s) for SituacaoDropDown widget.
  String? situacaoDropDownValue;
  FormFieldController<String>? situacaoDropDownValueController;
  // State field(s) for ExposicaoDropDown widget.
  String? exposicaoDropDownValue;
  FormFieldController<String>? exposicaoDropDownValueController;
  // State field(s) for TempoText widget.
  FocusNode? tempoTextFocusNode;
  TextEditingController? tempoTextTextController;
  String? Function(BuildContext, String?)? tempoTextTextControllerValidator;
  // State field(s) for EPIUtilizadoText widget.
  FocusNode? ePIUtilizadoTextFocusNode;
  TextEditingController? ePIUtilizadoTextTextController;
  String? Function(BuildContext, String?)?
      ePIUtilizadoTextTextControllerValidator;
  // State field(s) for DropDownEPI widget.
  List<String>? dropDownEPIValue;
  FormFieldController<List<String>>? dropDownEPIValueController;
  // State field(s) for EPIsRadioButton widget.
  FormFieldController<String>? ePIsRadioButtonValueController;
  // State field(s) for EPCUtilizadoText widget.
  FocusNode? ePCUtilizadoTextFocusNode;
  TextEditingController? ePCUtilizadoTextTextController;
  String? Function(BuildContext, String?)?
      ePCUtilizadoTextTextControllerValidator;
  // State field(s) for DropDownEPC widget.
  List<String>? dropDownEPCValue;
  FormFieldController<List<String>>? dropDownEPCValueController;
  // State field(s) for MedidaImplementadasText widget.
  FocusNode? medidaImplementadasTextFocusNode;
  TextEditingController? medidaImplementadasTextTextController;
  String? Function(BuildContext, String?)?
      medidaImplementadasTextTextControllerValidator;
  // State field(s) for DropDownMedidas widget.
  List<String>? dropDownMedidasValue;
  FormFieldController<List<String>>? dropDownMedidasValueController;
  // State field(s) for DescricaoText widget.
  FocusNode? descricaoTextFocusNode;
  TextEditingController? descricaoTextTextController;
  String? Function(BuildContext, String?)? descricaoTextTextControllerValidator;
  String? _descricaoTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 0) {
      return 'Requires at least 0 characters.';
    }
    if (val.length > 1000) {
      return 'Este campo só permite 1000 caracteres!';
    }

    return null;
  }

  // State field(s) for SugestaoText widget.
  FocusNode? sugestaoTextFocusNode;
  TextEditingController? sugestaoTextTextController;
  String? Function(BuildContext, String?)? sugestaoTextTextControllerValidator;
  String? _sugestaoTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 0) {
      return 'Requires at least 0 characters.';
    }
    if (val.length > 1000) {
      return 'Este campo só permite 1000 caracteres!';
    }

    return null;
  }

  // State field(s) for AcoesText widget.
  FocusNode? acoesTextFocusNode;
  TextEditingController? acoesTextTextController;
  String? Function(BuildContext, String?)? acoesTextTextControllerValidator;
  String? _acoesTextTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 0) {
      return 'Requires at least 0 characters.';
    }
    if (val.length > 1000) {
      return 'Este campo só permite 1000 caracteres!';
    }

    return null;
  }

  // State field(s) for RiscosLTextField widget.
  FocusNode? riscosLTextFieldFocusNode;
  TextEditingController? riscosLTextFieldTextController;
  String? Function(BuildContext, String?)?
      riscosLTextFieldTextControllerValidator;
  String? _riscosLTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 0) {
      return 'Requires at least 0 characters.';
    }
    if (val.length > 1000) {
      return 'Este campo só permite 1000 caracteres!';
    }

    return null;
  }

  // State field(s) for PerigosTextField widget.
  FocusNode? perigosTextFieldFocusNode;
  TextEditingController? perigosTextFieldTextController;
  String? Function(BuildContext, String?)?
      perigosTextFieldTextControllerValidator;
  // State field(s) for AtividadesTextField widget.
  FocusNode? atividadesTextFieldFocusNode;
  TextEditingController? atividadesTextFieldTextController;
  String? Function(BuildContext, String?)?
      atividadesTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    ambienteTextFieldTextControllerValidator =
        _ambienteTextFieldTextControllerValidator;
    descricaoTextTextControllerValidator =
        _descricaoTextTextControllerValidator;
    sugestaoTextTextControllerValidator = _sugestaoTextTextControllerValidator;
    acoesTextTextControllerValidator = _acoesTextTextControllerValidator;
    riscosLTextFieldTextControllerValidator =
        _riscosLTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    ambienteTextFieldFocusNode?.dispose();
    ambienteTextFieldTextController?.dispose();

    tempoTextFocusNode?.dispose();
    tempoTextTextController?.dispose();

    ePIUtilizadoTextFocusNode?.dispose();
    ePIUtilizadoTextTextController?.dispose();

    ePCUtilizadoTextFocusNode?.dispose();
    ePCUtilizadoTextTextController?.dispose();

    medidaImplementadasTextFocusNode?.dispose();
    medidaImplementadasTextTextController?.dispose();

    descricaoTextFocusNode?.dispose();
    descricaoTextTextController?.dispose();

    sugestaoTextFocusNode?.dispose();
    sugestaoTextTextController?.dispose();

    acoesTextFocusNode?.dispose();
    acoesTextTextController?.dispose();

    riscosLTextFieldFocusNode?.dispose();
    riscosLTextFieldTextController?.dispose();

    perigosTextFieldFocusNode?.dispose();
    perigosTextFieldTextController?.dispose();

    atividadesTextFieldFocusNode?.dispose();
    atividadesTextFieldTextController?.dispose();
  }

  /// Additional helper methods.
  String? get avaliacaoRadioButtonValue =>
      avaliacaoRadioButtonValueController?.value;
  String? get ePIsRadioButtonValue => ePIsRadioButtonValueController?.value;
}
