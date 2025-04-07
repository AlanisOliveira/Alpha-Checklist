import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'e_desc_colaboradores_model.dart';
export 'e_desc_colaboradores_model.dart';

class EDescColaboradoresWidget extends StatefulWidget {
  const EDescColaboradoresWidget({super.key});

  @override
  State<EDescColaboradoresWidget> createState() =>
      _EDescColaboradoresWidgetState();
}

class _EDescColaboradoresWidgetState extends State<EDescColaboradoresWidget> {
  late EDescColaboradoresModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EDescColaboradoresModel());

    _model.atividadesDesenvolvidasTextController ??= TextEditingController(
        text: FFAppState().DescColaboradores != null &&
                FFAppState().DescColaboradores != ''
            ? FFAppState().DescColaboradores
            : null);
    _model.atividadesDesenvolvidasFocusNode ??= FocusNode();
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            'DESCRIÇÃO DAS ATIVIDADES QUE OS COLABORADORES DO SETOR DESENVOLVEM\n',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Sen',
                                  color: Color(0xFF32343E),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts:
                                      GoogleFonts.asMap().containsKey('Sen'),
                                ),
                          ),
                        ),
                      ],
                    ),
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
                            controller:
                                _model.atividadesDesenvolvidasTextController,
                            focusNode: _model.atividadesDesenvolvidasFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: Color(0xFF57636C),
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                              alignLabelWithHint: true,
                              hintText: 'Atividades desenvolvidas',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    color: Color(0xFF57636C),
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelMediumFamily),
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
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                            maxLines: 100,
                            maxLength: 1000,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (context,
                                    {required currentLength,
                                    required isFocused,
                                    maxLength}) =>
                                null,
                            validator: _model
                                .atividadesDesenvolvidasTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
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
                      ].divide(SizedBox(width: 6.0)),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 30.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      }
                      FFAppState().DescColaboradores =
                          _model.atividadesDesenvolvidasTextController.text;
                      safeSetState(() {});

                      context.pushNamed(
                        EDescAgravosSaudeWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 15.0, 10.0, 10.0),
                        child: Text(
                          'Salvar e continuar',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
        ),
      ],
    );
  }
}
