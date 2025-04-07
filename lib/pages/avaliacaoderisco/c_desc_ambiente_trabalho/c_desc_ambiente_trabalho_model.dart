import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'c_desc_ambiente_trabalho_widget.dart' show CDescAmbienteTrabalhoWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CDescAmbienteTrabalhoModel
    extends FlutterFlowModel<CDescAmbienteTrabalhoWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey4 = GlobalKey<FormState>();
  final formKey9 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();
  final formKey7 = GlobalKey<FormState>();
  final formKey8 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for AmbienteText widget.
  FocusNode? ambienteTextFocusNode;
  TextEditingController? ambienteTextTextController;
  String? Function(BuildContext, String?)? ambienteTextTextControllerValidator;
  String? _ambienteTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for PisoText widget.
  FocusNode? pisoTextFocusNode;
  TextEditingController? pisoTextTextController;
  String? Function(BuildContext, String?)? pisoTextTextControllerValidator;
  String? _pisoTextTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este cmpo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for ParedeText widget.
  FocusNode? paredeTextFocusNode;
  TextEditingController? paredeTextTextController;
  String? Function(BuildContext, String?)? paredeTextTextControllerValidator;
  String? _paredeTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Esse campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for CoberturaText widget.
  FocusNode? coberturaTextFocusNode;
  TextEditingController? coberturaTextTextController;
  String? Function(BuildContext, String?)? coberturaTextTextControllerValidator;
  String? _coberturaTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for IluminacaoText widget.
  FocusNode? iluminacaoTextFocusNode;
  TextEditingController? iluminacaoTextTextController;
  String? Function(BuildContext, String?)?
      iluminacaoTextTextControllerValidator;
  String? _iluminacaoTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for VentilacaoText widget.
  FocusNode? ventilacaoTextFocusNode;
  TextEditingController? ventilacaoTextTextController;
  String? Function(BuildContext, String?)?
      ventilacaoTextTextControllerValidator;
  String? _ventilacaoTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for PavimentacaoText widget.
  FocusNode? pavimentacaoTextFocusNode;
  TextEditingController? pavimentacaoTextTextController;
  String? Function(BuildContext, String?)?
      pavimentacaoTextTextControllerValidator;
  String? _pavimentacaoTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for MaquinasText widget.
  FocusNode? maquinasTextFocusNode;
  TextEditingController? maquinasTextTextController;
  String? Function(BuildContext, String?)? maquinasTextTextControllerValidator;
  String? _maquinasTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres!';
    }

    return null;
  }

  // State field(s) for ProtecaoText widget.
  FocusNode? protecaoTextFocusNode;
  TextEditingController? protecaoTextTextController;
  String? Function(BuildContext, String?)? protecaoTextTextControllerValidator;
  String? _protecaoTextTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, preencha este campo.';
    }

    if (val.length < 1) {
      return 'Por favor, preencha este campo!';
    }
    if (val.length > 100) {
      return 'Este campo só permite 100 caracteres';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    ambienteTextTextControllerValidator = _ambienteTextTextControllerValidator;
    pisoTextTextControllerValidator = _pisoTextTextControllerValidator;
    paredeTextTextControllerValidator = _paredeTextTextControllerValidator;
    coberturaTextTextControllerValidator =
        _coberturaTextTextControllerValidator;
    iluminacaoTextTextControllerValidator =
        _iluminacaoTextTextControllerValidator;
    ventilacaoTextTextControllerValidator =
        _ventilacaoTextTextControllerValidator;
    pavimentacaoTextTextControllerValidator =
        _pavimentacaoTextTextControllerValidator;
    maquinasTextTextControllerValidator = _maquinasTextTextControllerValidator;
    protecaoTextTextControllerValidator = _protecaoTextTextControllerValidator;
  }

  @override
  void dispose() {
    ambienteTextFocusNode?.dispose();
    ambienteTextTextController?.dispose();

    pisoTextFocusNode?.dispose();
    pisoTextTextController?.dispose();

    paredeTextFocusNode?.dispose();
    paredeTextTextController?.dispose();

    coberturaTextFocusNode?.dispose();
    coberturaTextTextController?.dispose();

    iluminacaoTextFocusNode?.dispose();
    iluminacaoTextTextController?.dispose();

    ventilacaoTextFocusNode?.dispose();
    ventilacaoTextTextController?.dispose();

    pavimentacaoTextFocusNode?.dispose();
    pavimentacaoTextTextController?.dispose();

    maquinasTextFocusNode?.dispose();
    maquinasTextTextController?.dispose();

    protecaoTextFocusNode?.dispose();
    protecaoTextTextController?.dispose();
  }
}
