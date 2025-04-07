import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacao_mensal/modificacoes_empresa/modificacoes_empresa_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'c_modificacaoe_alteracao_widget.dart' show CModificacaoeAlteracaoWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CModificacaoeAlteracaoModel
    extends FlutterFlowModel<CModificacaoeAlteracaoWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ModificacoesEmpresa component.
  late ModificacoesEmpresaModel modificacoesEmpresaModel;

  @override
  void initState(BuildContext context) {
    modificacoesEmpresaModel =
        createModel(context, () => ModificacoesEmpresaModel());
  }

  @override
  void dispose() {
    modificacoesEmpresaModel.dispose();
  }
}
