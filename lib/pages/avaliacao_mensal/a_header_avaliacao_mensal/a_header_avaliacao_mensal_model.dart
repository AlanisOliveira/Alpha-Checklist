import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacao_mensal/a_informacao_empresa_mensal/a_informacao_empresa_mensal_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'a_header_avaliacao_mensal_widget.dart'
    show AHeaderAvaliacaoMensalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AHeaderAvaliacaoMensalModel
    extends FlutterFlowModel<AHeaderAvaliacaoMensalWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for A-InformacaoEmpresaMensal component.
  late AInformacaoEmpresaMensalModel aInformacaoEmpresaMensalModel;

  @override
  void initState(BuildContext context) {
    aInformacaoEmpresaMensalModel =
        createModel(context, () => AInformacaoEmpresaMensalModel());
  }

  @override
  void dispose() {
    aInformacaoEmpresaMensalModel.dispose();
  }
}
