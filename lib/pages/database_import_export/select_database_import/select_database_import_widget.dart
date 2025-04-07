import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_database_import_model.dart';
export 'select_database_import_model.dart';

class SelectDatabaseImportWidget extends StatefulWidget {
  const SelectDatabaseImportWidget({super.key});

  @override
  State<SelectDatabaseImportWidget> createState() =>
      _SelectDatabaseImportWidgetState();
}

class _SelectDatabaseImportWidgetState
    extends State<SelectDatabaseImportWidget> {
  late SelectDatabaseImportModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectDatabaseImportModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Container(
          width: 100.0,
          height: 200.0,
          child: custom_widgets.ImprovedDbImport(
            width: 100.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
