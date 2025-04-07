import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'agentes_select_component_model.dart';
export 'agentes_select_component_model.dart';

class AgentesSelectComponentWidget extends StatefulWidget {
  const AgentesSelectComponentWidget({super.key});

  @override
  State<AgentesSelectComponentWidget> createState() =>
      _AgentesSelectComponentWidgetState();
}

class _AgentesSelectComponentWidgetState
    extends State<AgentesSelectComponentWidget> {
  late AgentesSelectComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgentesSelectComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 15.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'Selecione os agentes',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Inter',
                                color: Color(0xFF14181B),
                                fontSize: 24.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts:
                                    GoogleFonts.asMap().containsKey('Inter'),
                              ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 8.0),
                    child: Text(
                      'Adicione o nome da empresa e os agentes',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap()
                                .containsKey('Plus Jakarta Sans'),
                          ),
                    ),
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        width: double.infinity,
                        height: 82.21,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: false,
                              labelText: 'Empresa',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelMediumFamily),
                                  ),
                              hintText: 'Nome da empresa',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelMediumFamily),
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF04337A),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                            maxLines: 2,
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 4.0, 0.0, 8.0),
                          child: Text(
                            'AGENTES:',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Plus Jakarta Sans'),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 100.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Físicos:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child: FutureBuilder<List<ListAgentesFromIdRow>>(
                            future: SQLiteManager.instance.listAgentesFromId(
                              id: 2,
                            ),
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
                              final checkboxGroupFisicoListAgentesFromIdRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupFisicoListAgentesFromIdRowList
                                        .map((e) => e.nomeAgente)
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.checkboxGroupFisicoValues = val);
                                  FFAppState().ListaPreselecaoFisico = _model
                                      .checkboxGroupFisicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupFisicoValueController ??=
                                    FormFieldController<List<String>>(
                                  [],
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
                            children: [
                              Text(
                                'Químicos',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child: FutureBuilder<List<ListAgentesFromIdRow>>(
                            future: SQLiteManager.instance.listAgentesFromId(
                              id: 3,
                            ),
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
                              final checkboxGroupQuimicoListAgentesFromIdRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupQuimicoListAgentesFromIdRowList
                                        .map((e) => e.nomeAgente)
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.checkboxGroupQuimicoValues = val);
                                  FFAppState().Listapreselecaoquimico = _model
                                      .checkboxGroupQuimicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupQuimicoValueController ??=
                                    FormFieldController<List<String>>(
                                  [],
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
                            children: [
                              Text(
                                'Biológicos',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child: FutureBuilder<List<ListAgentesFromIdRow>>(
                            future: SQLiteManager.instance.listAgentesFromId(
                              id: 4,
                            ),
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
                              final checkboxGroupBiologicoListAgentesFromIdRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupBiologicoListAgentesFromIdRowList
                                        .map((e) => e.nomeAgente)
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model
                                      .checkboxGroupBiologicoValues = val);
                                  FFAppState().ListaPreSelecaoBiologico = _model
                                      .checkboxGroupBiologicoValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupBiologicoValueController ??=
                                    FormFieldController<List<String>>(
                                  [],
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
                            children: [
                              Text(
                                'Ergonômicos',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child: FutureBuilder<List<ListAgentesFromIdRow>>(
                            future: SQLiteManager.instance.listAgentesFromId(
                              id: 5,
                            ),
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
                              final checkboxGroupErgonomicoListAgentesFromIdRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupErgonomicoListAgentesFromIdRowList
                                        .map((e) => e.nomeAgente)
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model
                                      .checkboxGroupErgonomicoValues = val);
                                  FFAppState().ListaPreSelecaoErgonomico =
                                      _model.checkboxGroupErgonomicoValues!
                                          .toList()
                                          .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupErgonomicoValueController ??=
                                    FormFieldController<List<String>>(
                                  [],
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
                            children: [
                              Text(
                                'Acidentes',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child: FutureBuilder<List<ListAgentesFromIdRow>>(
                            future: SQLiteManager.instance.listAgentesFromId(
                              id: 6,
                            ),
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
                              final checkboxGroupAcidenteListAgentesFromIdRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupAcidenteListAgentesFromIdRowList
                                        .map((e) => e.nomeAgente)
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() =>
                                      _model.checkboxGroupAcidenteValues = val);
                                  FFAppState().ListaPreSelecaoAcidente = _model
                                      .checkboxGroupAcidenteValues!
                                      .toList()
                                      .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupAcidenteValueController ??=
                                    FormFieldController<List<String>>(
                                  [],
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
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Psicossociais',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 75.0),
                          child: FutureBuilder<List<ListAgentesFromIdRow>>(
                            future: SQLiteManager.instance.listAgentesFromId(
                              id: 7,
                            ),
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
                              final checkboxGroupPsicossociaisListAgentesFromIdRowList =
                                  snapshot.data!;

                              return FlutterFlowCheckboxGroup(
                                options:
                                    checkboxGroupPsicossociaisListAgentesFromIdRowList
                                        .map((e) => e.nomeAgente)
                                        .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model
                                      .checkboxGroupPsicossociaisValues = val);
                                  FFAppState().ListaPreselecaoPsicossociais =
                                      _model.checkboxGroupPsicossociaisValues!
                                          .toList()
                                          .cast<String>();
                                  safeSetState(() {});
                                },
                                controller: _model
                                        .checkboxGroupPsicossociaisValueController ??=
                                    FormFieldController<List<String>>(
                                  [],
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
                                    _model.checkboxGroupPsicossociaisValues !=
                                        null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().nomeEmpresaPreselecao =
                      _model.textController.text;
                  safeSetState(() {});
                  FFAppState().PreSelecoes = <String, dynamic>{
                    'nomeEmpresa': FFAppState().nomeEmpresaPreselecao,
                    'listaAgente': <String, List<dynamic>?>{
                      'AgentesErgonomicos':
                          FFAppState().ListaPreSelecaoErgonomico,
                      'AgentesAcidentes': FFAppState().ListaPreSelecaoAcidente,
                      'AgentesFisicos': FFAppState().ListaPreselecaoFisico,
                      'AgentesQuimicos': FFAppState().Listapreselecaoquimico,
                      'AgentesBiologicos':
                          FFAppState().ListaPreSelecaoBiologico,
                      'AgentesPsicossociais':
                          FFAppState().ListaPreselecaoPsicossociais,
                    },
                  };
                  safeSetState(() {});
                  FFAppState()
                      .addToListadePreselecoes(FFAppState().PreSelecoes);
                  safeSetState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF04337A),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Salvar',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Inter'),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ),
        ],
      ),
    );
  }
}
