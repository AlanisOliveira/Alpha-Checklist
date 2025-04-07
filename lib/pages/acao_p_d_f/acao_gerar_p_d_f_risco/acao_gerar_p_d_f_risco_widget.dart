import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/p_d_fboolean/erro_p_d_f/erro_p_d_f_widget.dart';
import '/pages/p_d_fboolean/p_d_f_gerado_component/p_d_f_gerado_component_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'acao_gerar_p_d_f_risco_model.dart';
export 'acao_gerar_p_d_f_risco_model.dart';

class AcaoGerarPDFRiscoWidget extends StatefulWidget {
  const AcaoGerarPDFRiscoWidget({
    super.key,
    bool? cancel,
    bool? delete,
  })  : this.cancel = cancel ?? false,
        this.delete = delete ?? false;

  final bool cancel;
  final bool delete;

  @override
  State<AcaoGerarPDFRiscoWidget> createState() =>
      _AcaoGerarPDFRiscoWidgetState();
}

class _AcaoGerarPDFRiscoWidgetState extends State<AcaoGerarPDFRiscoWidget> {
  late AcaoGerarPDFRiscoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AcaoGerarPDFRiscoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 270.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x3B1D2429),
                offset: Offset(
                  0.0,
                  -3.0,
                ),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_square,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    Text(
                      'Assinatura não fornecida!',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: 'Adicionar assinaturas',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                      elevation: 2.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await actions.gerarPDF(
                        FFAppState().nomeEmpresa,
                        FFAppState().Setor,
                        FFAppState().Funcao.toList(),
                        FFAppState().Avaliador,
                        FFAppState().PoliticasList.toList(),
                        FFAppState().ambienteTagList.toList(),
                        FFAppState().PisoTagList.toList(),
                        FFAppState().ParedeTagList.toList(),
                        FFAppState().CoberturaTagList.toList(),
                        FFAppState().IluminacaoTagList.toList(),
                        FFAppState().VentilacaoTagList.toList(),
                        FFAppState().PavimentoList.toList(),
                        FFAppState().ProtecaoIncendioList.toList(),
                        FFAppState().MaquinaseEquipamentosList.toList(),
                        FFAppState().outrosProgramas,
                        FFAppState().NomeColaboradores.toList(),
                        FFAppState().DescColaboradores,
                        FFAppState().DescAgravos,
                        FFAppState().DescEPIs,
                        FFAppState().medidasImplementadas,
                        FFAppState().ListadeRiscos.toList(),
                        FFAppState().espacoConfinado,
                        FFAppState().treinamentoNR33,
                        FFAppState().dataNr33,
                        FFAppState().descricaoNR33,
                        FFAppState().trabalhoAltura,
                        FFAppState().treinamentoNR35,
                        FFAppState().dataNR35,
                        FFAppState().descricaoNR35,
                        FFAppState().trabalhoEletricidade,
                        FFAppState().treinamentoNR10,
                        FFAppState().dataNR10,
                        FFAppState().descricaoNR10,
                        FFAppState().conducaoVeiculos,
                        FFAppState().treinamentoDirecao,
                        FFAppState().dataDirecao,
                        FFAppState().descricaoDirecao,
                        FFAppState().operacaoEquipamento,
                        FFAppState().treinamentoOperacao,
                        FFAppState().dataOperacao,
                        FFAppState().descricaoOperacao,
                        FFAppState().aposentadoriaEspecial,
                        FFAppState().cartaoIdentificacao,
                        FFAppState().observacoes,
                        FFAppState().Assinaturas.toList(),
                        FFAppState().Possivel.toList(),
                        FFAppState().JSONPreSelecao.toList(),
                        FFAppState().treinamentosrealizados,
                      );
                      if (FFAppState().isPDFGerado) {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: PDFGeradoComponentWidget(),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      } else {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: ErroPDFWidget(),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }

                      context.pushNamed(TelaInicialWidget.routeName);

                      await actions.saveDraftToSQLite();
                    },
                    text: 'Continuar sem assinatura\n',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Lexend Deca',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Lexend Deca'),
                          ),
                      elevation: 4.0,
                      borderSide: BorderSide(
                        color: Color(0x00383838),
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
