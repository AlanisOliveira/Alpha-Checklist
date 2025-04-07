import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'agente_avaliacao_mensal_model.dart';
export 'agente_avaliacao_mensal_model.dart';

class AgenteAvaliacaoMensalWidget extends StatefulWidget {
  const AgenteAvaliacaoMensalWidget({super.key});

  @override
  State<AgenteAvaliacaoMensalWidget> createState() =>
      _AgenteAvaliacaoMensalWidgetState();
}

class _AgenteAvaliacaoMensalWidgetState
    extends State<AgenteAvaliacaoMensalWidget> {
  late AgenteAvaliacaoMensalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgenteAvaliacaoMensalModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 0.0, 20.0),
                    child: Text(
                      'Selecione os agentes',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Sen',
                                color: Color(0xFF14181B),
                                fontSize: 24.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Sen'),
                              ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 0.0, 20.0),
                    child: Text(
                      'Fase de teste: ainda não implementado a parte de adicionar novos agentes',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Sen',
                                color: Color(0xFF14181B),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Sen'),
                              ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Físicos:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sen',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Sen'),
                                    ),
                              ),
                            ].divide(SizedBox(width: 15.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 75.0),
                          child: FutureBuilder<List<SelectFisicosAvMensalRow>>(
                            future:
                                SQLiteManager.instance.selectFisicosAvMensal(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final checkboxGroupFisicoSelectFisicosAvMensalRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupFisicoSelectFisicosAvMensalRowList
                                        .map((e) => e.nomeRisco)
                                        .withoutNulls
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.checkboxGroupFisicoValues = val);
                                  FFAppState().listaFisicosMensal = _model
                                      .checkboxGroupFisicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupFisicoValueController ??=
                                    FormFieldController<List<String>>(
                                  List.from(
                                      FFAppState().listaFisicosMensal ?? []),
                                ),
                                activeColor: Color(0xFF04337A),
                                checkColor: FlutterFlowTheme.of(context).info,
                                checkboxBorderColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                checkboxBorderRadius:
                                    BorderRadius.circular(4.0),
                                initialized:
                                    _model.checkboxGroupFisicoValues != null,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Químicos:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sen',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Sen'),
                                    ),
                              ),
                            ].divide(SizedBox(width: 15.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 75.0),
                          child: FutureBuilder<List<SelectQuimicoAvMensalRow>>(
                            future:
                                SQLiteManager.instance.selectQuimicoAvMensal(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final checkboxGroupQuimicoSelectQuimicoAvMensalRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupQuimicoSelectQuimicoAvMensalRowList
                                        .map((e) => e.nomeRisco)
                                        .withoutNulls
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.checkboxGroupQuimicoValues = val);
                                  FFAppState().listaQuimicoMensais = _model
                                      .checkboxGroupQuimicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupQuimicoValueController ??=
                                    FormFieldController<List<String>>(
                                  List.from(
                                      FFAppState().listaQuimicoMensais ?? []),
                                ),
                                activeColor: Color(0xFF04337A),
                                checkColor: FlutterFlowTheme.of(context).info,
                                checkboxBorderColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                checkboxBorderRadius:
                                    BorderRadius.circular(4.0),
                                initialized:
                                    _model.checkboxGroupQuimicoValues != null,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Biológicos:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sen',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Sen'),
                                    ),
                              ),
                            ].divide(SizedBox(width: 15.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child:
                              FutureBuilder<List<SelectBiologicosAvMensalRow>>(
                            future: SQLiteManager.instance
                                .selectBiologicosAvMensal(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final checkboxGroupBiologicoSelectBiologicosAvMensalRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupBiologicoSelectBiologicosAvMensalRowList
                                        .map((e) => e.nomeRisco)
                                        .withoutNulls
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model
                                      .checkboxGroupBiologicoValues = val);
                                  FFAppState().listaBiologicosMensais = _model
                                      .checkboxGroupBiologicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupBiologicoValueController ??=
                                    FormFieldController<List<String>>(
                                  List.from(
                                      FFAppState().listaBiologicosMensais ??
                                          []),
                                ),
                                activeColor: Color(0xFF04337A),
                                checkColor: FlutterFlowTheme.of(context).info,
                                checkboxBorderColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                checkboxBorderRadius:
                                    BorderRadius.circular(4.0),
                                initialized:
                                    _model.checkboxGroupBiologicoValues != null,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Ergonômicos:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sen',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Sen'),
                                    ),
                              ),
                            ].divide(SizedBox(width: 15.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child:
                              FutureBuilder<List<SelectErgonomicoAvMensalRow>>(
                            future: SQLiteManager.instance
                                .selectErgonomicoAvMensal(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final checkboxGroupErgonomicoSelectErgonomicoAvMensalRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupErgonomicoSelectErgonomicoAvMensalRowList
                                        .map((e) => e.nomeRisco)
                                        .withoutNulls
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model
                                      .checkboxGroupErgonomicoValues = val);
                                  FFAppState().listaErgonomicosMensais = _model
                                      .checkboxGroupErgonomicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupErgonomicoValueController ??=
                                    FormFieldController<List<String>>(
                                  List.from(
                                      FFAppState().listaErgonomicosMensais ??
                                          []),
                                ),
                                activeColor: Color(0xFF04337A),
                                checkColor: FlutterFlowTheme.of(context).info,
                                checkboxBorderColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                checkboxBorderRadius:
                                    BorderRadius.circular(4.0),
                                initialized:
                                    _model.checkboxGroupErgonomicoValues !=
                                        null,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Acidentes:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Sen',
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Sen'),
                                    ),
                              ),
                            ].divide(SizedBox(width: 15.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 100.0),
                          child: FutureBuilder<List<SelectAcidenteAvMensalRow>>(
                            future:
                                SQLiteManager.instance.selectAcidenteAvMensal(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final checkboxGroupAcidenteSelectAcidenteAvMensalRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupAcidenteSelectAcidenteAvMensalRowList
                                        .map((e) => e.nomeRisco)
                                        .withoutNulls
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.checkboxGroupAcidenteValues = val);
                                  FFAppState().listaAcidentesMensais = _model
                                      .checkboxGroupAcidenteValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupAcidenteValueController ??=
                                    FormFieldController<List<String>>(
                                  List.from(
                                      FFAppState().listaAcidentesMensais ?? []),
                                ),
                                activeColor: Color(0xFF04337A),
                                checkColor: FlutterFlowTheme.of(context).info,
                                checkboxBorderColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                checkboxBorderRadius:
                                    BorderRadius.circular(4.0),
                                initialized:
                                    _model.checkboxGroupAcidenteValues != null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 150.0),
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
                            color: Color(0xFF04337A),
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
                      ].divide(SizedBox(width: 6.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 400.0, 20.0, 30.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await actions.saveDraftToSQLiteMensal();

                  context.pushNamed(
                    CModificacaoeAlteracaoWidget.routeName,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
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
                      'Salvar e continuar',
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
      ),
    );
  }
}
