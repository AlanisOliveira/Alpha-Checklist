import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/acao_p_d_f/acao_gerar_p_d_f_mensal/acao_gerar_p_d_f_mensal_widget.dart';
import '/pages/assinaturas/nova_assinatura/nova_assinatura_widget.dart';
import '/pages/p_d_fboolean/erro_p_d_f/erro_p_d_f_widget.dart';
import '/pages/p_d_fboolean/p_d_f_gerado_component/p_d_f_gerado_component_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'assinatura_component_mensal_model.dart';
export 'assinatura_component_mensal_model.dart';

class AssinaturaComponentMensalWidget extends StatefulWidget {
  const AssinaturaComponentMensalWidget({super.key});

  @override
  State<AssinaturaComponentMensalWidget> createState() =>
      _AssinaturaComponentMensalWidgetState();
}

class _AssinaturaComponentMensalWidgetState
    extends State<AssinaturaComponentMensalWidget> {
  late AssinaturaComponentMensalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AssinaturaComponentMensalModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(-1.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 95.0),
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                          ))
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 25.0, 0.0, 0.0),
                                    child: Text(
                                      'TERMO DE VERACIDADE DAS INFORMAÇÕES PRESTADAS',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Toboggan Bold',
                                            color: Color(0xFF0E0E0E),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Toboggan Bold'),
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (responsiveVisibility(
                            context: context,
                            tablet: false,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (responsiveVisibility(
                                  context: context,
                                  tablet: false,
                                  tabletLandscape: false,
                                  desktop: false,
                                ))
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 25.0, 0.0, 0.0),
                                        child: Text(
                                          'TERMO DE VERACIDADE DAS INFORMAÇÕES PRESTADAS',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Toboggan Bold',
                                                color: Color(0xFF0E0E0E),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'Toboggan Bold'),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 30.0, 15.0, 0.0),
                                  child: Container(
                                    width: 800.0,
                                    height: 117.0,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      'Declaro para devidos fins de direito, sob as penas da lei, que as informações prestadas e documentadas que apresentei, constituída para a finalidade de elaboração dos documentos técnicos de saúde e segurança do trabalho são verdadeiras e autênticas.',
                                      textAlign: TextAlign.justify,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Roboto'),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                          ))
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 10.0),
                                  child: Container(
                                    width: 200.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF04337A),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7.0,
                                          color: Color(0x33000000),
                                          offset: Offset(
                                            0.0,
                                            2.0,
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: NovaAssinaturaWidget(),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.mode_edit_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            size: 24.0,
                                          ),
                                          Text(
                                            'Nova assinatura',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      GoogleFonts.asMap()
                                                          .containsKey('Inter'),
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (responsiveVisibility(
                            context: context,
                            tablet: false,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 10.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: NovaAssinaturaWidget(),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      child: Container(
                                        width: 195.31,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF04337A),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 7.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                2.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mode_edit_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              size: 24.0,
                                            ),
                                            Text(
                                              'Nova assinatura',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts:
                                                        GoogleFonts.asMap()
                                                            .containsKey(
                                                                'Inter'),
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 30.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Assinaturas realizadas',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey('Roboto'),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final listAssinaturas =
                                    FFAppState().Assinaturas.toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(listAssinaturas.length,
                                          (listAssinaturasIndex) {
                                    final listAssinaturasItem =
                                        listAssinaturas[listAssinaturasIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 0.0, 15.0, 10.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 266.63,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF4F9FD),
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.person_outline_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                  Text(
                                                    getJsonField(
                                                      listAssinaturasItem,
                                                      r'''$['nome']''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      'Inter'),
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: 150.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Container(
                                                  width: 600.0,
                                                  height: 100.0,
                                                  child: custom_widgets
                                                      .ImageAssinatura(
                                                    width: 600.0,
                                                    height: 100.0,
                                                    base64Image: getJsonField(
                                                      listAssinaturasItem,
                                                      r'''$["assinatura"]''',
                                                    ).toString(),
                                                    borderRadius: 10.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                0.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        FFAppState()
                                                            .removeAtIndexFromAssinaturas(
                                                                listAssinaturasIndex);
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 100.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB3C1EE),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB3C1EE),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB3C1EE),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF04337A),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ].divide(SizedBox(width: 6.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 30.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if (!(FFAppState().Assinaturas.isNotEmpty)) {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: AcaoGerarPDFMensalWidget(),
                      );
                    },
                  ).then((value) => safeSetState(() {}));

                  await actions.saveDraftToSQLiteMensal();
                } else {
                  await actions.gerarPDFMensal(
                    FFAppState().nomeEmpresa,
                    FFAppState().enderecoAvMensal,
                    FFAppState().Avaliador,
                    FFAppState().profissaoAvMensal,
                    FFAppState().nomePDF,
                    FFAppState().listaFisicosMensal.toList(),
                    FFAppState().listaQuimicoMensais.toList(),
                    FFAppState().listaBiologicosMensais.toList(),
                    FFAppState().listaErgonomicosMensais.toList(),
                    FFAppState().listaAcidentesMensais.toList(),
                    FFAppState().modificacoesEmpresaAvMensal.toList(),
                    FFAppState().modificacoesEmpresaAvMensal2.toList(),
                    FFAppState().modificacoesEmpresaAvMensal3.toList(),
                    FFAppState().Assinaturas.toList(),
                    FFAppState().descricaoModificacoes,
                  );
                  await actions.saveDraftToSQLiteMensal();
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
                }
              },
              child: Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xFF04337A),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 10.0),
                  child: Text(
                    'Gerar PDF',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Sen',
                          color: Colors.white,
                          fontSize: 25.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Sen'),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
