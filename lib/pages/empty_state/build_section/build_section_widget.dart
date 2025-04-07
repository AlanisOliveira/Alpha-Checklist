import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'build_section_model.dart';
export 'build_section_model.dart';

class BuildSectionWidget extends StatefulWidget {
  const BuildSectionWidget({super.key});

  @override
  State<BuildSectionWidget> createState() => _BuildSectionWidgetState();
}

class _BuildSectionWidgetState extends State<BuildSectionWidget> {
  late BuildSectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BuildSectionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/icons8-trabalho-100.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Estamos trabalhando nesta página!',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineMediumFamily),
                ),
          ),
        ].divide(SizedBox(height: 16.0)),
      ),
    );
  }
}
