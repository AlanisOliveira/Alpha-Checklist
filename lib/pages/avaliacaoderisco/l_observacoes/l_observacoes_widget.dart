import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'l_observacoes_model.dart';
export 'l_observacoes_model.dart';

class LObservacoesWidget extends StatefulWidget {
  const LObservacoesWidget({super.key});

  @override
  State<LObservacoesWidget> createState() => _LObservacoesWidgetState();
}

class _LObservacoesWidgetState extends State<LObservacoesWidget> {
  late LObservacoesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LObservacoesModel());

    _model.textController ??= TextEditingController(
        text: FFAppState().observacoes != null && FFAppState().observacoes != ''
            ? FFAppState().observacoes
            : null);
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

    return Stack(
      children: [
        Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Observações',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Sen',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        GoogleFonts.asMap().containsKey('Sen'),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F5FA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: Color(0xFF14181B),
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                          alignLabelWithHint: true,
                          hintText:
                              'Devem ser anotadas as informações referentes aos EPI\'s, EPC\'s, medidas de controle, sugestões, descrição, perigo e atividades que geram o risco ambiental.',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF57636C),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Readex Pro'),
                                  ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF121223),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 18.0, 0.0, 0.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: Color(0xFF14181B),
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                        maxLines: 100,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 600.0, 0.0, 0.0),
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
                ].divide(SizedBox(width: 6.0)),
              ),
            ),
          ],
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
                context.pushNamed(
                  ZAssinaturaPageWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );

                FFAppState().observacoes = _model.textController.text;
                safeSetState(() {});
                await actions.saveDraftToSQLite();
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
    );
  }
}
