import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'modificacoes_empresa_model.dart';
export 'modificacoes_empresa_model.dart';

class ModificacoesEmpresaWidget extends StatefulWidget {
  const ModificacoesEmpresaWidget({super.key});

  @override
  State<ModificacoesEmpresaWidget> createState() =>
      _ModificacoesEmpresaWidgetState();
}

class _ModificacoesEmpresaWidgetState extends State<ModificacoesEmpresaWidget> {
  late ModificacoesEmpresaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModificacoesEmpresaModel());

    _model.textController ??= TextEditingController(
        text: FFAppState().descricaoModificacoes != null &&
                FFAppState().descricaoModificacoes != ''
            ? FFAppState().descricaoModificacoes
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FlutterFlowCheckboxGroup(
                              options: [
                                'ALTERAÇÃO NO LAYOUT',
                                'NOVO RISCO',
                                'ACIDENTE DE TRABALHO'
                              ],
                              onChanged: (val) async {
                                safeSetState(
                                    () => _model.checkboxGroupValues1 = val);
                                FFAppState().modificacoesEmpresaAvMensal =
                                    _model.checkboxGroupValues1!
                                        .toList()
                                        .cast<String>();
                                safeSetState(() {});
                              },
                              controller:
                                  _model.checkboxGroupValueController1 ??=
                                      FormFieldController<List<String>>(
                                List.from(
                                    FFAppState().modificacoesEmpresaAvMensal ??
                                        []),
                              ),
                              activeColor: FlutterFlowTheme.of(context).primary,
                              checkColor: FlutterFlowTheme.of(context).info,
                              checkboxBorderColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return 12.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return 14.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return 16.0;
                                      } else {
                                        return 14.0;
                                      }
                                    }(),
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                              checkboxBorderRadius: BorderRadius.circular(4.0),
                              initialized: _model.checkboxGroupValues1 != null,
                            ),
                          ),
                          Expanded(
                            child: FlutterFlowCheckboxGroup(
                              options: [
                                'DEMISSÃO',
                                'ADMISSÃO',
                                'NÃO HOUVE ALTERAÇÃO'
                              ],
                              onChanged: (val) async {
                                safeSetState(
                                    () => _model.checkboxGroupValues2 = val);
                                FFAppState().modificacoesEmpresaAvMensal2 =
                                    _model.checkboxGroupValues2!
                                        .toList()
                                        .cast<String>();
                                safeSetState(() {});
                              },
                              controller:
                                  _model.checkboxGroupValueController2 ??=
                                      FormFieldController<List<String>>(
                                List.from(
                                    FFAppState().modificacoesEmpresaAvMensal2 ??
                                        []),
                              ),
                              activeColor: FlutterFlowTheme.of(context).primary,
                              checkColor: FlutterFlowTheme.of(context).info,
                              checkboxBorderColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return 12.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return 14.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return 16.0;
                                      } else {
                                        return 14.0;
                                      }
                                    }(),
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                              checkboxBorderRadius: BorderRadius.circular(4.0),
                              initialized: _model.checkboxGroupValues2 != null,
                            ),
                          ),
                          Expanded(
                            child: FlutterFlowCheckboxGroup(
                              options: [
                                'ASO ADMISSIONAL',
                                'ASO DEMISSIONAL',
                                'ASO PERIÓDICO'
                              ],
                              onChanged: (val) async {
                                safeSetState(
                                    () => _model.checkboxGroupValues3 = val);
                                FFAppState().modificacoesEmpresaAvMensal3 =
                                    _model.checkboxGroupValues3!
                                        .toList()
                                        .cast<String>();
                                safeSetState(() {});
                              },
                              controller:
                                  _model.checkboxGroupValueController3 ??=
                                      FormFieldController<List<String>>(
                                List.from(
                                    FFAppState().modificacoesEmpresaAvMensal3 ??
                                        []),
                              ),
                              activeColor: FlutterFlowTheme.of(context).primary,
                              checkColor: FlutterFlowTheme.of(context).info,
                              checkboxBorderColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return 12.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return 14.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return 16.0;
                                      } else {
                                        return 14.0;
                                      }
                                    }(),
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                              checkboxBorderRadius: BorderRadius.circular(4.0),
                              initialized: _model.checkboxGroupValues3 != null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                child: Form(
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
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                            alignLabelWithHint: true,
                            hintText: 'Adicione observações aqui...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts:
                                      GoogleFonts.asMap().containsKey('Roboto'),
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
                                color: Color(0xFF14181B),
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                          maxLines: 100,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) =>
                              null,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        ))
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 500.0, 0.0, 0.0),
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
                FFAppState().descricaoModificacoes = _model.textController.text;
                safeSetState(() {});
                await actions.saveDraftToSQLiteMensal();

                context.pushNamed(
                  ZAssinaturaPageCopyWidget.routeName,
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
        if (responsiveVisibility(
          context: context,
          phone: false,
        ))
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 900.0, 0.0, 0.0),
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
      ],
    );
  }
}
