import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/a_informacao_empresa/a_informacao_empresa_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'a_header_avaliacao_draft_widget.dart' show AHeaderAvaliacaoDraftWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AHeaderAvaliacaoDraftModel
    extends FlutterFlowModel<AHeaderAvaliacaoDraftWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for A-InformacaoEmpresa component.
  late AInformacaoEmpresaModel aInformacaoEmpresaModel;

  @override
  void initState(BuildContext context) {
    aInformacaoEmpresaModel =
        createModel(context, () => AInformacaoEmpresaModel());
  }

  @override
  void dispose() {
    aInformacaoEmpresaModel.dispose();
  }
}
