import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'alpha_consultoria',
      'sqliteAlphaAp.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<TiposdeRiscosListRow>> tiposdeRiscosList() =>
      performTiposdeRiscosList(
        _database,
      );

  Future<List<ListAgentesFromIdRow>> listAgentesFromId({
    int? id,
  }) =>
      performListAgentesFromId(
        _database,
        id: id,
      );

  Future<List<SelectAgentesRow>> selectAgentes() => performSelectAgentes(
        _database,
      );

  Future<List<SelectAvaliadoresRow>> selectAvaliadores() =>
      performSelectAvaliadores(
        _database,
      );

  Future<List<SelectEmpresasRow>> selectEmpresas() => performSelectEmpresas(
        _database,
      );

  Future<List<SelectEmpresaseSetoresRow>> selectEmpresaseSetores({
    int? id,
  }) =>
      performSelectEmpresaseSetores(
        _database,
        id: id,
      );

  Future<List<SelectIdEmpresaRow>> selectIdEmpresa() => performSelectIdEmpresa(
        _database,
      );

  Future<List<SelectSetoresRow>> selectSetores({
    int? idEmpresas,
  }) =>
      performSelectSetores(
        _database,
        idEmpresas: idEmpresas,
      );

  Future<List<SelectEmpresasNomeRow>> selectEmpresasNome() =>
      performSelectEmpresasNome(
        _database,
      );

  Future<List<InsertEmpresaIDRow>> insertEmpresaID({
    String? nome,
    String? cnpj,
  }) =>
      performInsertEmpresaID(
        _database,
        nome: nome,
        cnpj: cnpj,
      );

  Future<List<SelectNomeEmpresaDropRow>> selectNomeEmpresaDrop({
    int? id,
  }) =>
      performSelectNomeEmpresaDrop(
        _database,
        id: id,
      );

  Future<List<SelectTipoRiscoDropRow>> selectTipoRiscoDrop({
    int? id,
  }) =>
      performSelectTipoRiscoDrop(
        _database,
        id: id,
      );

  Future<List<SelectEPIsRow>> selectEPIs({
    int? id,
  }) =>
      performSelectEPIs(
        _database,
        id: id,
      );

  Future<List<SelectMedidasRow>> selectMedidas() => performSelectMedidas(
        _database,
      );

  Future<List<SelectDadosRow>> selectDados({
    int? id,
  }) =>
      performSelectDados(
        _database,
        id: id,
      );

  Future<List<SelectAgenteDropRow>> selectAgenteDrop({
    int? id,
  }) =>
      performSelectAgenteDrop(
        _database,
        id: id,
      );

  Future<List<SelectEPCRow>> selectEPC() => performSelectEPC(
        _database,
      );

  Future<List<SelectEPCfromIDRow>> selectEPCfromID({
    int? id,
  }) =>
      performSelectEPCfromID(
        _database,
        id: id,
      );

  Future<List<SelectMedidasFromIDRow>> selectMedidasFromID({
    int? id,
  }) =>
      performSelectMedidasFromID(
        _database,
        id: id,
      );

  Future<List<SelectDescricaoDadosRow>> selectDescricaoDados({
    int? id,
  }) =>
      performSelectDescricaoDados(
        _database,
        id: id,
      );

  Future<List<SelectacoesDadosRow>> selectacoesDados({
    int? id,
  }) =>
      performSelectacoesDados(
        _database,
        id: id,
      );

  Future<List<SelectFromDadosRow>> selectFromDados({
    int? id,
  }) =>
      performSelectFromDados(
        _database,
        id: id,
      );

  Future<List<SelectSugestaoRow>> selectSugestao({
    int? id,
  }) =>
      performSelectSugestao(
        _database,
        id: id,
      );

  Future<List<SelectArquivosRow>> selectArquivos() => performSelectArquivos(
        _database,
      );

  Future<List<SelectFuncoesRow>> selectFuncoes({
    int? idEmpresa,
  }) =>
      performSelectFuncoes(
        _database,
        idEmpresa: idEmpresa,
      );

  Future<List<SelectProfissaoRow>> selectProfissao({
    String? nome,
  }) =>
      performSelectProfissao(
        _database,
        nome: nome,
      );

  Future<List<SelectPdfsRow>> selectPdfs() => performSelectPdfs(
        _database,
      );

  Future<List<EmpresasComAssinaturasRow>> empresasComAssinaturas() =>
      performEmpresasComAssinaturas(
        _database,
      );

  Future<List<UltimasAssinaturasRow>> ultimasAssinaturas() =>
      performUltimasAssinaturas(
        _database,
      );

  Future<List<SelectAssinaturasRow>> selectAssinaturas({
    int? idEmpresa,
  }) =>
      performSelectAssinaturas(
        _database,
        idEmpresa: idEmpresa,
      );

  Future<List<SelectAssinaturasEmpresasRow>> selectAssinaturasEmpresas({
    String? searchText,
  }) =>
      performSelectAssinaturasEmpresas(
        _database,
        searchText: searchText,
      );

  Future<List<SearchEmpresasRow>> searchEmpresas({
    String? searchText,
  }) =>
      performSearchEmpresas(
        _database,
        searchText: searchText,
      );

  Future<List<SelectPDFsRow>> selectPDFs({
    String? searchText,
    String? selectedFilter,
  }) =>
      performSelectPDFs(
        _database,
        searchText: searchText,
        selectedFilter: selectedFilter,
      );

  Future<List<SelectEPIRow>> selectEPI() => performSelectEPI(
        _database,
      );

  Future<List<SelectMedidaRow>> selectMedida() => performSelectMedida(
        _database,
      );

  Future<List<SelectTipoPDFRow>> selectTipoPDF({
    String? searchText,
    String? selectedFilter,
    String? tipoPDF,
  }) =>
      performSelectTipoPDF(
        _database,
        searchText: searchText,
        selectedFilter: selectedFilter,
        tipoPDF: tipoPDF,
      );

  Future<List<SelectFisicosAvMensalRow>> selectFisicosAvMensal() =>
      performSelectFisicosAvMensal(
        _database,
      );

  Future<List<SelectQuimicoAvMensalRow>> selectQuimicoAvMensal() =>
      performSelectQuimicoAvMensal(
        _database,
      );

  Future<List<SelectBiologicosAvMensalRow>> selectBiologicosAvMensal() =>
      performSelectBiologicosAvMensal(
        _database,
      );

  Future<List<SelectErgonomicoAvMensalRow>> selectErgonomicoAvMensal() =>
      performSelectErgonomicoAvMensal(
        _database,
      );

  Future<List<SelectAcidenteAvMensalRow>> selectAcidenteAvMensal() =>
      performSelectAcidenteAvMensal(
        _database,
      );

  Future<List<SelectEPCAvRow>> selectEPCAv() => performSelectEPCAv(
        _database,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future insertAgentesFromId({
    String? nomeAgente,
    int? idTipo,
  }) =>
      performInsertAgentesFromId(
        _database,
        nomeAgente: nomeAgente,
        idTipo: idTipo,
      );

  Future insertAvaliadores({
    String? nome,
    String? profissao,
    String? cargo,
  }) =>
      performInsertAvaliadores(
        _database,
        nome: nome,
        profissao: profissao,
        cargo: cargo,
      );

  Future deleteEmpresa({
    int? id,
  }) =>
      performDeleteEmpresa(
        _database,
        id: id,
      );

  Future insertEmpresa({
    String? nome,
    String? cnpj,
  }) =>
      performInsertEmpresa(
        _database,
        nome: nome,
        cnpj: cnpj,
      );

  Future deleteAvaliador({
    int? userId,
  }) =>
      performDeleteAvaliador(
        _database,
        userId: userId,
      );

  Future updateAgente({
    String? nome,
    int? id,
  }) =>
      performUpdateAgente(
        _database,
        nome: nome,
        id: id,
      );

  Future deleteSetorFromEmpresa({
    int? id,
  }) =>
      performDeleteSetorFromEmpresa(
        _database,
        id: id,
      );

  Future insertSetor({
    String? nome,
    int? idEmpresas,
  }) =>
      performInsertSetor(
        _database,
        nome: nome,
        idEmpresas: idEmpresas,
      );

  Future insertFuncoes({
    String? nome,
    int? idEmpresa,
  }) =>
      performInsertFuncoes(
        _database,
        nome: nome,
        idEmpresa: idEmpresa,
      );

  Future deleteFuncaoFromEmpresa({
    int? id,
  }) =>
      performDeleteFuncaoFromEmpresa(
        _database,
        id: id,
      );

  Future updateEmpresa({
    String? nome,
    String? cnpj,
    int? id,
    String? cidade,
    String? estado,
  }) =>
      performUpdateEmpresa(
        _database,
        nome: nome,
        cnpj: cnpj,
        id: id,
        cidade: cidade,
        estado: estado,
      );

  Future updateEpcs({
    String? nome,
    String? id,
  }) =>
      performUpdateEpcs(
        _database,
        nome: nome,
        id: id,
      );

  Future updateEPIS({
    String? nomeEPI,
    int? id,
  }) =>
      performUpdateEPIS(
        _database,
        nomeEPI: nomeEPI,
        id: id,
      );

  Future insertEpc({
    String? nome,
    int? id,
  }) =>
      performInsertEpc(
        _database,
        nome: nome,
        id: id,
      );

  Future deleteEPC({
    int? id,
  }) =>
      performDeleteEPC(
        _database,
        id: id,
      );

  Future insertEPI({
    String? nome,
    int? id,
  }) =>
      performInsertEPI(
        _database,
        nome: nome,
        id: id,
      );

  Future deleteEPI({
    int? id,
  }) =>
      performDeleteEPI(
        _database,
        id: id,
      );

  Future insertMedidas({
    String? nome,
    int? id,
  }) =>
      performInsertMedidas(
        _database,
        nome: nome,
        id: id,
      );

  Future deleteMedidas({
    int? id,
  }) =>
      performDeleteMedidas(
        _database,
        id: id,
      );

  Future updateMedidas({
    String? nome,
    int? id,
  }) =>
      performUpdateMedidas(
        _database,
        nome: nome,
        id: id,
      );

  Future insertDescricaoDados({
    String? descricao,
    int? id,
  }) =>
      performInsertDescricaoDados(
        _database,
        descricao: descricao,
        id: id,
      );

  Future insertacoes({
    String? acoes,
    int? id,
  }) =>
      performInsertacoes(
        _database,
        acoes: acoes,
        id: id,
      );

  Future insertSugestao({
    String? sugestao,
    int? id,
  }) =>
      performInsertSugestao(
        _database,
        sugestao: sugestao,
        id: id,
      );

  Future insertRiscos({
    String? riscos,
    int? id,
  }) =>
      performInsertRiscos(
        _database,
        riscos: riscos,
        id: id,
      );

  Future deletarPDF({
    int? id,
  }) =>
      performDeletarPDF(
        _database,
        id: id,
      );

  Future deletarAssinatura({
    int? id,
  }) =>
      performDeletarAssinatura(
        _database,
        id: id,
      );

  Future insertEPIGeral({
    String? nome,
  }) =>
      performInsertEPIGeral(
        _database,
        nome: nome,
      );

  Future insertEpcGeral({
    String? nome,
  }) =>
      performInsertEpcGeral(
        _database,
        nome: nome,
      );

  /// END UPDATE QUERY CALLS
}
