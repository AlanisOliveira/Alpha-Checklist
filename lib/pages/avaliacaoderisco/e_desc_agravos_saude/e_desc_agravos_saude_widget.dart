import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/avaliacaoderisco/f_desc_agravos/f_desc_agravos_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'e_desc_agravos_saude_model.dart';
export 'e_desc_agravos_saude_model.dart';

class EDescAgravosSaudeWidget extends StatefulWidget {
  const EDescAgravosSaudeWidget({super.key});

  static String routeName = 'E-DescAgravosSaude';
  static String routePath = '/eDescAgravosSaude';

  @override
  State<EDescAgravosSaudeWidget> createState() =>
      _EDescAgravosSaudeWidgetState();
}

class _EDescAgravosSaudeWidgetState extends State<EDescAgravosSaudeWidget> {
  late EDescAgravosSaudeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EDescAgravosSaudeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF04337A),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: AppBar(
            backgroundColor: Color(0xFF04337A),
            automaticallyImplyLeading: false,
            actions: [],
            elevation: 0.0,
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 1174.0,
              decoration: BoxDecoration(
                color: Color(0xFF04337A),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AVALIAÇÃO DE RISCO',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Sen',
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts:
                                        GoogleFonts.asMap().containsKey('Sen'),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Descrição dos possíveis agravos à saúde',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Sen',
                                    color: Color(0xFFF8F8F8),
                                    fontSize: 15.0,
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
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 150.0, 0.0, 0.0),
              child: wrapWithModel(
                model: _model.fDescAgravosModel,
                updateCallback: () => safeSetState(() {}),
                child: FDescAgravosWidget(),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              phone: false,
            ))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(
                      DDescColaboradoresDevWidget.routeName,
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
                    width: 43.0,
                    height: 43.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/icons8-voltar-48.png',
                        width: 48.0,
                        height: 48.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
            ))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(DDescColaboradoresDevWidget.routeName);
                  },
                  child: Container(
                    width: 33.0,
                    height: 33.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/icons8-voltar-48.png',
                        width: 48.0,
                        height: 48.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
