import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/database_import_export/select_dados_importar_component/select_dados_importar_component_widget.dart';
import '/pages/database_import_export/select_database_import/select_database_import_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'database_page_widget.dart' show DatabasePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DatabasePageModel extends FlutterFlowModel<DatabasePageWidget> {
  ///  Local state fields for this page.
  /// Lista de dados que o usuário que exportar
  List<String> listaDadosExportar = [];
  void addToListaDadosExportar(String item) => listaDadosExportar.add(item);
  void removeFromListaDadosExportar(String item) =>
      listaDadosExportar.remove(item);
  void removeAtIndexFromListaDadosExportar(int index) =>
      listaDadosExportar.removeAt(index);
  void insertAtIndexInListaDadosExportar(int index, String item) =>
      listaDadosExportar.insert(index, item);
  void updateListaDadosExportarAtIndex(int index, Function(String) updateFn) =>
      listaDadosExportar[index] = updateFn(listaDadosExportar[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // State field(s) for Checkbox widget.
  bool? checkboxValue4;
  // State field(s) for Checkbox widget.
  bool? checkboxValue5;
  // State field(s) for Checkbox widget.
  bool? checkboxValue6;
  // State field(s) for Checkbox widget.
  bool? checkboxValue7;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
