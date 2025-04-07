import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN TIPOSDERISCOSLIST
Future<List<TiposdeRiscosListRow>> performTiposdeRiscosList(
  Database database,
) {
  final query = '''
Select ID, nome from TIPORISCO;
''';
  return _readQuery(database, query, (d) => TiposdeRiscosListRow(d));
}

class TiposdeRiscosListRow extends SqliteRow {
  TiposdeRiscosListRow(Map<String, dynamic> data) : super(data);

  String? get nome => data['nome'] as String?;
  int get id => data['ID'] as int;
}

/// END TIPOSDERISCOSLIST

/// BEGIN LISTAGENTESFROMID
Future<List<ListAgentesFromIdRow>> performListAgentesFromId(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT nomeAgente, ID FROM AgenteRisco where idTipo = ${id};
''';
  return _readQuery(database, query, (d) => ListAgentesFromIdRow(d));
}

class ListAgentesFromIdRow extends SqliteRow {
  ListAgentesFromIdRow(Map<String, dynamic> data) : super(data);

  String get nomeAgente => data['nomeAgente'] as String;
  int get id => data['ID'] as int;
}

/// END LISTAGENTESFROMID

/// BEGIN SELECTAGENTES
Future<List<SelectAgentesRow>> performSelectAgentes(
  Database database,
) {
  final query = '''
SELECT ID, nomeAgente FROM AgenteRisco
''';
  return _readQuery(database, query, (d) => SelectAgentesRow(d));
}

class SelectAgentesRow extends SqliteRow {
  SelectAgentesRow(Map<String, dynamic> data) : super(data);

  String get nomeAgente => data['nomeAgente'] as String;
  int get id => data['ID'] as int;
}

/// END SELECTAGENTES

/// BEGIN SELECTAVALIADORES
Future<List<SelectAvaliadoresRow>> performSelectAvaliadores(
  Database database,
) {
  final query = '''
select ID, nome, profissao, cargo from avaliadores
''';
  return _readQuery(database, query, (d) => SelectAvaliadoresRow(d));
}

class SelectAvaliadoresRow extends SqliteRow {
  SelectAvaliadoresRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
  String? get profissao => data['profissao'] as String?;
  String get cargo => data['cargo'] as String;
  int get id => data['ID'] as int;
}

/// END SELECTAVALIADORES

/// BEGIN SELECTEMPRESAS
Future<List<SelectEmpresasRow>> performSelectEmpresas(
  Database database,
) {
  final query = '''
SELECT * FROM EMPRESAS;

''';
  return _readQuery(database, query, (d) => SelectEmpresasRow(d));
}

class SelectEmpresasRow extends SqliteRow {
  SelectEmpresasRow(Map<String, dynamic> data) : super(data);

  int get idEmpresas => data['ID_EMPRESAS'] as int;
  String get nome => data['Nome'] as String;
  String get cnpj => data['CNPJ'] as String;
  String? get cidade => data['CIDADE'] as String?;
  String? get estado => data['ESTADO'] as String?;
}

/// END SELECTEMPRESAS

/// BEGIN SELECTEMPRESASESETORES
Future<List<SelectEmpresaseSetoresRow>> performSelectEmpresaseSetores(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT 
    EMPRESAS.Nome AS EmpresaNome,
    EMPRESAS.CNPJ,
    SETORES.NOME AS SetorNome,
    FUNCOES.NOME AS FuncaoNome
FROM 
    EMPRESAS
LEFT JOIN 
    SETORES ON EMPRESAS.ID_EMPRESAS = SETORES.ID_EMPRESAS
LEFT JOIN 
    FUNCOES ON EMPRESAS.ID_EMPRESAS = FUNCOES.ID_EMPRESA
WHERE 
    EMPRESAS.ID_EMPRESAS = ${id};

''';
  return _readQuery(database, query, (d) => SelectEmpresaseSetoresRow(d));
}

class SelectEmpresaseSetoresRow extends SqliteRow {
  SelectEmpresaseSetoresRow(Map<String, dynamic> data) : super(data);

  String get nomeEmpresa => data['nomeEmpresa'] as String;
  String? get cnpj => data['CNPJ'] as String?;
  List<String>? get setores => data['setores'] as List<String>?;
  List<String>? get funcoes => data['funcoes'] as List<String>?;
}

/// END SELECTEMPRESASESETORES

/// BEGIN SELECTIDEMPRESA
Future<List<SelectIdEmpresaRow>> performSelectIdEmpresa(
  Database database,
) {
  final query = '''
SELECT ID_EMPRESAS
FROM EMPRESAS
ORDER BY ID_EMPRESAS DESC
LIMIT 1;
''';
  return _readQuery(database, query, (d) => SelectIdEmpresaRow(d));
}

class SelectIdEmpresaRow extends SqliteRow {
  SelectIdEmpresaRow(Map<String, dynamic> data) : super(data);

  int get idEmpresas => data['ID_EMPRESAS'] as int;
}

/// END SELECTIDEMPRESA

/// BEGIN SELECTSETORES
Future<List<SelectSetoresRow>> performSelectSetores(
  Database database, {
  int? idEmpresas,
}) {
  final query = '''
SELECT id, NOME  from SETORES where idEmpresas = ${idEmpresas}
''';
  return _readQuery(database, query, (d) => SelectSetoresRow(d));
}

class SelectSetoresRow extends SqliteRow {
  SelectSetoresRow(Map<String, dynamic> data) : super(data);

  String? get nome => data['NOME'] as String?;
  int get id => data['id'] as int;
}

/// END SELECTSETORES

/// BEGIN SELECTEMPRESASNOME
Future<List<SelectEmpresasNomeRow>> performSelectEmpresasNome(
  Database database,
) {
  final query = '''
SELECT ID_EMPRESAS, Nome from EMPRESAS;
''';
  return _readQuery(database, query, (d) => SelectEmpresasNomeRow(d));
}

class SelectEmpresasNomeRow extends SqliteRow {
  SelectEmpresasNomeRow(Map<String, dynamic> data) : super(data);

  String? get nome => data['Nome'] as String?;
  int? get idEmpresas => data['ID_EMPRESAS'] as int?;
}

/// END SELECTEMPRESASNOME

/// BEGIN INSERTEMPRESAID
Future<List<InsertEmpresaIDRow>> performInsertEmpresaID(
  Database database, {
  String? nome,
  String? cnpj,
}) {
  final query = '''
INSERT INTO EMPRESAS (Nome, CNPJ) VALUES ('${nome}', '${cnpj}')
''';
  return _readQuery(database, query, (d) => InsertEmpresaIDRow(d));
}

class InsertEmpresaIDRow extends SqliteRow {
  InsertEmpresaIDRow(Map<String, dynamic> data) : super(data);

  int? get idEmpresas => data['ID_EMPRESAS'] as int?;
}

/// END INSERTEMPRESAID

/// BEGIN SELECTNOMEEMPRESADROP
Future<List<SelectNomeEmpresaDropRow>> performSelectNomeEmpresaDrop(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT Nome FROM EMPRESAS WHERE ID_EMPRESAS = ${id}
''';
  return _readQuery(database, query, (d) => SelectNomeEmpresaDropRow(d));
}

class SelectNomeEmpresaDropRow extends SqliteRow {
  SelectNomeEmpresaDropRow(Map<String, dynamic> data) : super(data);

  String? get nome => data['Nome'] as String?;
}

/// END SELECTNOMEEMPRESADROP

/// BEGIN SELECTTIPORISCODROP
Future<List<SelectTipoRiscoDropRow>> performSelectTipoRiscoDrop(
  Database database, {
  int? id,
}) {
  final query = '''
Select ID, nome from TIPORISCO where ID = ${id}; ;
''';
  return _readQuery(database, query, (d) => SelectTipoRiscoDropRow(d));
}

class SelectTipoRiscoDropRow extends SqliteRow {
  SelectTipoRiscoDropRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
}

/// END SELECTTIPORISCODROP

/// BEGIN SELECTEPIS
Future<List<SelectEPIsRow>> performSelectEPIs(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT ID, nomeEPI 
FROM EPIS 
WHERE agente_id = ${id};
''';
  return _readQuery(database, query, (d) => SelectEPIsRow(d));
}

class SelectEPIsRow extends SqliteRow {
  SelectEPIsRow(Map<String, dynamic> data) : super(data);

  String get nomeEPI => data['nomeEPI'] as String;
  int get id => data['ID'] as int;
}

/// END SELECTEPIS

/// BEGIN SELECTMEDIDAS
Future<List<SelectMedidasRow>> performSelectMedidas(
  Database database,
) {
  final query = '''
SELECT ID, nome from Medidas 
''';
  return _readQuery(database, query, (d) => SelectMedidasRow(d));
}

class SelectMedidasRow extends SqliteRow {
  SelectMedidasRow(Map<String, dynamic> data) : super(data);

  int get id => data['ID'] as int;
  String? get nome => data['nome'] as String?;
}

/// END SELECTMEDIDAS

/// BEGIN SELECTDADOS
Future<List<SelectDadosRow>> performSelectDados(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT ID, descricao, acoes, riscos, sugestaoInicial from DadosAdicionais  where agente_id = ${id}
''';
  return _readQuery(database, query, (d) => SelectDadosRow(d));
}

class SelectDadosRow extends SqliteRow {
  SelectDadosRow(Map<String, dynamic> data) : super(data);

  int get id => data['ID'] as int;
  String get descricao => data['descricao'] as String;
  String get acoes => data['acoes'] as String;
  String get riscos => data['riscos'] as String;
  String get sugestaoInicial => data['sugestaoInicial'] as String;
}

/// END SELECTDADOS

/// BEGIN SELECTAGENTEDROP
Future<List<SelectAgenteDropRow>> performSelectAgenteDrop(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT ID, nomeAgente from AgenteRisco where ID = ${id}
''';
  return _readQuery(database, query, (d) => SelectAgenteDropRow(d));
}

class SelectAgenteDropRow extends SqliteRow {
  SelectAgenteDropRow(Map<String, dynamic> data) : super(data);

  int get id => data['ID'] as int;
  String get nomeAgente => data['nomeAgente'] as String;
}

/// END SELECTAGENTEDROP

/// BEGIN SELECTEPC
Future<List<SelectEPCRow>> performSelectEPC(
  Database database,
) {
  final query = '''
SELECT nome, MIN(ID) AS ID
FROM epcs
GROUP BY nome
ORDER BY nome ASC;
''';
  return _readQuery(database, query, (d) => SelectEPCRow(d));
}

class SelectEPCRow extends SqliteRow {
  SelectEPCRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
  int get id => data['ID'] as int;
}

/// END SELECTEPC

/// BEGIN SELECTEPCFROMID
Future<List<SelectEPCfromIDRow>> performSelectEPCfromID(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT ID, nome FROM epcs WHERE idAgente = ${id};
''';
  return _readQuery(database, query, (d) => SelectEPCfromIDRow(d));
}

class SelectEPCfromIDRow extends SqliteRow {
  SelectEPCfromIDRow(Map<String, dynamic> data) : super(data);

  String? get nome => data['nome'] as String?;
  int? get id => data['ID'] as int?;
}

/// END SELECTEPCFROMID

/// BEGIN SELECTMEDIDASFROMID
Future<List<SelectMedidasFromIDRow>> performSelectMedidasFromID(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT nome from Medidas where agente_id = ${id}
''';
  return _readQuery(database, query, (d) => SelectMedidasFromIDRow(d));
}

class SelectMedidasFromIDRow extends SqliteRow {
  SelectMedidasFromIDRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
}

/// END SELECTMEDIDASFROMID

/// BEGIN SELECTDESCRICAODADOS
Future<List<SelectDescricaoDadosRow>> performSelectDescricaoDados(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT descricao from DadosAdicionais  where agente_id = ${id}
''';
  return _readQuery(database, query, (d) => SelectDescricaoDadosRow(d));
}

class SelectDescricaoDadosRow extends SqliteRow {
  SelectDescricaoDadosRow(Map<String, dynamic> data) : super(data);

  String? get descricao => data['descricao'] as String?;
}

/// END SELECTDESCRICAODADOS

/// BEGIN SELECTACOESDADOS
Future<List<SelectacoesDadosRow>> performSelectacoesDados(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT acoes from DadosAdicionais  where agente_id = ${id}
''';
  return _readQuery(database, query, (d) => SelectacoesDadosRow(d));
}

class SelectacoesDadosRow extends SqliteRow {
  SelectacoesDadosRow(Map<String, dynamic> data) : super(data);

  String? get acoes => data['acoes'] as String?;
}

/// END SELECTACOESDADOS

/// BEGIN SELECTFROMDADOS
Future<List<SelectFromDadosRow>> performSelectFromDados(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT * FROM DadosAdicionais where agente_id = ${id}
''';
  return _readQuery(database, query, (d) => SelectFromDadosRow(d));
}

class SelectFromDadosRow extends SqliteRow {
  SelectFromDadosRow(Map<String, dynamic> data) : super(data);

  String? get acoes => data['acoes'] as String?;
  String? get riscos => data['riscos'] as String?;
  String? get descricao => data['descricao'] as String?;
  String? get sugestaoInicial => data['sugestaoInicial'] as String?;
}

/// END SELECTFROMDADOS

/// BEGIN SELECTSUGESTAO
Future<List<SelectSugestaoRow>> performSelectSugestao(
  Database database, {
  int? id,
}) {
  final query = '''
select sugestaoInicial, agente_id from DadosAdicionais where agente_id = ${id};
''';
  return _readQuery(database, query, (d) => SelectSugestaoRow(d));
}

class SelectSugestaoRow extends SqliteRow {
  SelectSugestaoRow(Map<String, dynamic> data) : super(data);

  String? get sugestaoInicial => data['sugestaoInicial'] as String?;
}

/// END SELECTSUGESTAO

/// BEGIN SELECTARQUIVOS
Future<List<SelectArquivosRow>> performSelectArquivos(
  Database database,
) {
  final query = '''
SELECT nome, caminho_pdf, data_criacao, ID from Documentos
''';
  return _readQuery(database, query, (d) => SelectArquivosRow(d));
}

class SelectArquivosRow extends SqliteRow {
  SelectArquivosRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
  String get caminhoPdf => data['caminho_pdf'] as String;
  String? get dataCriacao => data['data_criacao'] as String?;
}

/// END SELECTARQUIVOS

/// BEGIN SELECTFUNCOES
Future<List<SelectFuncoesRow>> performSelectFuncoes(
  Database database, {
  int? idEmpresa,
}) {
  final query = '''
SELECT id, NOME  FROM FUNCOES where idEmpresa = ${idEmpresa}
''';
  return _readQuery(database, query, (d) => SelectFuncoesRow(d));
}

class SelectFuncoesRow extends SqliteRow {
  SelectFuncoesRow(Map<String, dynamic> data) : super(data);

  int get id => data['id'] as int;
  String get nome => data['NOME'] as String;
}

/// END SELECTFUNCOES

/// BEGIN SELECTPROFISSAO
Future<List<SelectProfissaoRow>> performSelectProfissao(
  Database database, {
  String? nome,
}) {
  final query = '''
select profissao from avaliadores where nome = '${nome}'
''';
  return _readQuery(database, query, (d) => SelectProfissaoRow(d));
}

class SelectProfissaoRow extends SqliteRow {
  SelectProfissaoRow(Map<String, dynamic> data) : super(data);

  String? get profissao => data['profissao'] as String?;
}

/// END SELECTPROFISSAO

/// BEGIN SELECTPDFS
Future<List<SelectPdfsRow>> performSelectPdfs(
  Database database,
) {
  final query = '''
SELECT id, nome, data_criacao, tipo FROM pdfGerado ORDER BY id DESC LIMIT 4
''';
  return _readQuery(database, query, (d) => SelectPdfsRow(d));
}

class SelectPdfsRow extends SqliteRow {
  SelectPdfsRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
  String get dataCriacao => data['data_criacao'] as String;
  int get id => data['id'] as int;
  String get tipo => data['tipo'] as String;
}

/// END SELECTPDFS

/// BEGIN EMPRESASCOMASSINATURAS
Future<List<EmpresasComAssinaturasRow>> performEmpresasComAssinaturas(
  Database database,
) {
  final query = '''
SELECT 
  EMPRESAS.ID_EMPRESAS AS id_empresa,
  EMPRESAS.Nome AS nome_empresa,
  COUNT(assinaturas.ID) AS total_assinaturas
FROM EMPRESAS
INNER JOIN assinaturas 
  ON EMPRESAS.ID_EMPRESAS = assinaturas.ID_EMPRESA  
  GROUP BY EMPRESAS.ID_EMPRESAS, EMPRESAS.Nome;
''';
  return _readQuery(database, query, (d) => EmpresasComAssinaturasRow(d));
}

class EmpresasComAssinaturasRow extends SqliteRow {
  EmpresasComAssinaturasRow(Map<String, dynamic> data) : super(data);

  int get idEmpresa => data['id_empresa'] as int;
  String get nomeEmpresa => data['nome_empresa'] as String;
  int get totalAssinaturas => data['total_assinaturas'] as int;
}

/// END EMPRESASCOMASSINATURAS

/// BEGIN ULTIMASASSINATURAS
Future<List<UltimasAssinaturasRow>> performUltimasAssinaturas(
  Database database,
) {
  final query = '''
SELECT 
  ID,
  nomeColaborador,
  assinatura,
  CASE
    WHEN (strftime('%s', 'now') - strftime('%s', data_assinatura)) < 60 THEN 'há alguns segundos'
    WHEN (strftime('%s', 'now') - strftime('%s', data_assinatura)) < 3600 THEN 'há ' || CAST((strftime('%s', 'now') - strftime('%s', data_assinatura)) / 60 AS INTEGER) || ' minutos'
    WHEN (strftime('%s', 'now') - strftime('%s', data_assinatura)) < 86400 THEN 'há ' || CAST((strftime('%s', 'now') - strftime('%s', data_assinatura)) / 3600 AS INTEGER) || ' horas'
    ELSE 'há ' || CAST((strftime('%s', 'now') - strftime('%s', data_assinatura)) / 86400 AS INTEGER) || ' dias'
  END AS tempo_relativo
FROM assinaturas
ORDER BY data_assinatura DESC
LIMIT 8;
''';
  return _readQuery(database, query, (d) => UltimasAssinaturasRow(d));
}

class UltimasAssinaturasRow extends SqliteRow {
  UltimasAssinaturasRow(Map<String, dynamic> data) : super(data);

  String get nomeColaborador => data['nomeColaborador'] as String;
  String get tempoRelativo => data['tempo_relativo'] as String;
  int get id => data['ID'] as int;
  String get assinatura => data['assinatura'] as String;
}

/// END ULTIMASASSINATURAS

/// BEGIN SELECTASSINATURAS
Future<List<SelectAssinaturasRow>> performSelectAssinaturas(
  Database database, {
  int? idEmpresa,
}) {
  final query = '''
select nomeColaborador, assinatura, ID, data_assinatura from assinaturas where ID_EMPRESA = ${idEmpresa}
''';
  return _readQuery(database, query, (d) => SelectAssinaturasRow(d));
}

class SelectAssinaturasRow extends SqliteRow {
  SelectAssinaturasRow(Map<String, dynamic> data) : super(data);

  String get nomeColaborador => data['nomeColaborador'] as String;
  String get assinatura => data['assinatura'] as String;
  int get id => data['ID'] as int;
}

/// END SELECTASSINATURAS

/// BEGIN SELECTASSINATURASEMPRESAS
Future<List<SelectAssinaturasEmpresasRow>> performSelectAssinaturasEmpresas(
  Database database, {
  String? searchText,
}) {
  final query = '''
SELECT 
  Assinaturas.ID, 
  Assinaturas.nomeColaborador, 
  Assinaturas.assinatura, 
  EMPRESAS.Nome AS nome_empresa
FROM assinaturas 
JOIN EMPRESAS ON EMPRESAS.ID_EMPRESAS = Assinaturas.ID_EMPRESA
WHERE 
  '${searchText}' = '' -- Se não houver pesquisa, essa condição é sempre verdadeira
  OR Assinaturas.nomeColaborador LIKE '%${searchText}%' -- Filtra pelo nome do colaborador
  OR EMPRESAS.Nome LIKE '%${searchText}%' -- Filtra pelo nome da empresa
ORDER BY Assinaturas.data_assinatura DESC;
''';
  return _readQuery(database, query, (d) => SelectAssinaturasEmpresasRow(d));
}

class SelectAssinaturasEmpresasRow extends SqliteRow {
  SelectAssinaturasEmpresasRow(Map<String, dynamic> data) : super(data);

  int get id => data['ID'] as int;
  String get nomeColaborador => data['nomeColaborador'] as String;
  String get nomeEmpresa => data['nome_empresa'] as String;
  String get assinatura => data['assinatura'] as String;
}

/// END SELECTASSINATURASEMPRESAS

/// BEGIN SEARCHEMPRESAS
Future<List<SearchEmpresasRow>> performSearchEmpresas(
  Database database, {
  String? searchText,
}) {
  final query = '''
SELECT * FROM Empresas 
WHERE nome LIKE '%${searchText}%'
   OR estado LIKE '%${searchText}%' 
   OR cidade LIKE '%${searchText}%'

''';
  return _readQuery(database, query, (d) => SearchEmpresasRow(d));
}

class SearchEmpresasRow extends SqliteRow {
  SearchEmpresasRow(Map<String, dynamic> data) : super(data);

  String get nome => data['Nome'] as String;
  int get idEmpresas => data['ID_EMPRESAS'] as int;
  String? get cnpj => data['CNPJ'] as String?;
  String? get cidade => data['CIDADE'] as String?;
  String? get estado => data['ESTADO'] as String?;
}

/// END SEARCHEMPRESAS

/// BEGIN SELECTPDFS
Future<List<SelectPDFsRow>> performSelectPDFs(
  Database database, {
  String? searchText,
  String? selectedFilter,
}) {
  final query = '''
SELECT nome, tipo, id, data_criacao 
FROM pdfGerado 
WHERE nome LIKE '%${searchText}%' 
AND (
    '${selectedFilter}' = '' 
    OR '${selectedFilter}' IS NULL 
    OR CASE '${selectedFilter}' 
        WHEN 'Hoje' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) = DATE('now', 'localtime')
        WHEN 'Esta semana' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) >= DATE('now', 'weekday 0', '-6 days')
        WHEN 'Este Mês' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) >= DATE('now', 'start of month')
        WHEN 'Este ano' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) >= DATE('now', 'start of year')
        ELSE 1=1
    END
)
ORDER BY id DESC;
''';
  return _readQuery(database, query, (d) => SelectPDFsRow(d));
}

class SelectPDFsRow extends SqliteRow {
  SelectPDFsRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
  int get id => data['id'] as int;
  String get dataCriacao => data['data_criacao'] as String;
  String? get tipo => data['tipo'] as String?;
}

/// END SELECTPDFS

/// BEGIN SELECTEPI
Future<List<SelectEPIRow>> performSelectEPI(
  Database database,
) {
  final query = '''
SELECT DISTINCT nomeEPI, ID from EPIS ORDER BY nomeEPI ASC
''';
  return _readQuery(database, query, (d) => SelectEPIRow(d));
}

class SelectEPIRow extends SqliteRow {
  SelectEPIRow(Map<String, dynamic> data) : super(data);

  String? get nomeEPI => data['nomeEPI'] as String?;
  int get id => data['ID'] as int;
}

/// END SELECTEPI

/// BEGIN SELECTMEDIDA
Future<List<SelectMedidaRow>> performSelectMedida(
  Database database,
) {
  final query = '''
SELECT DISTINCT nome from Medidas ORDER BY nome ASC
''';
  return _readQuery(database, query, (d) => SelectMedidaRow(d));
}

class SelectMedidaRow extends SqliteRow {
  SelectMedidaRow(Map<String, dynamic> data) : super(data);

  String? get nome => data['nome'] as String?;
}

/// END SELECTMEDIDA

/// BEGIN SELECTTIPOPDF
Future<List<SelectTipoPDFRow>> performSelectTipoPDF(
  Database database, {
  String? searchText,
  String? selectedFilter,
  String? tipoPDF,
}) {
  final query = '''
SELECT nome, tipo, id, data_criacao 
FROM pdfGerado 
WHERE nome LIKE '%${searchText}%' 
AND ('${tipoPDF}' = '' OR '${tipoPDF}' IS NULL OR tipo = '${tipoPDF}')
AND (
    '${selectedFilter}' = '' 
    OR '${selectedFilter}' IS NULL 
    OR CASE '${selectedFilter}' 
        WHEN 'Hoje' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) = DATE('now', 'localtime')
        WHEN 'Esta semana' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) >= DATE('now', 'weekday 0', '-6 days')
        WHEN 'Este Mês' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) >= DATE('now', 'start of month')
        WHEN 'Este ano' THEN DATE(SUBSTR(data_criacao, 7, 4) || '-' || SUBSTR(data_criacao, 4, 2) || '-' || SUBSTR(data_criacao, 1, 2)) >= DATE('now', 'start of year')
        ELSE 1=1
    END
)
ORDER BY id DESC;
''';
  return _readQuery(database, query, (d) => SelectTipoPDFRow(d));
}

class SelectTipoPDFRow extends SqliteRow {
  SelectTipoPDFRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
  String? get tipo => data['tipo'] as String?;
  int get id => data['id'] as int;
  String get dataCriacao => data['data_criacao'] as String;
}

/// END SELECTTIPOPDF

/// BEGIN SELECTFISICOSAVMENSAL
Future<List<SelectFisicosAvMensalRow>> performSelectFisicosAvMensal(
  Database database,
) {
  final query = '''
SELECT * FROM AgentesAvMensal WHERE AgenteTipo = 'Físico';
''';
  return _readQuery(database, query, (d) => SelectFisicosAvMensalRow(d));
}

class SelectFisicosAvMensalRow extends SqliteRow {
  SelectFisicosAvMensalRow(Map<String, dynamic> data) : super(data);

  String? get agenteTipo => data['AgenteTipo'] as String?;
  String? get nomeRisco => data['NomeRisco'] as String?;
}

/// END SELECTFISICOSAVMENSAL

/// BEGIN SELECTQUIMICOAVMENSAL
Future<List<SelectQuimicoAvMensalRow>> performSelectQuimicoAvMensal(
  Database database,
) {
  final query = '''
SELECT * FROM AgentesAvMensal WHERE AgenteTipo = 'Químico';
''';
  return _readQuery(database, query, (d) => SelectQuimicoAvMensalRow(d));
}

class SelectQuimicoAvMensalRow extends SqliteRow {
  SelectQuimicoAvMensalRow(Map<String, dynamic> data) : super(data);

  String? get agenteTipo => data['AgenteTipo'] as String?;
  String? get nomeRisco => data['NomeRisco'] as String?;
}

/// END SELECTQUIMICOAVMENSAL

/// BEGIN SELECTBIOLOGICOSAVMENSAL
Future<List<SelectBiologicosAvMensalRow>> performSelectBiologicosAvMensal(
  Database database,
) {
  final query = '''
SELECT * FROM AgentesAvMensal WHERE AgenteTipo = 'Biológico';
''';
  return _readQuery(database, query, (d) => SelectBiologicosAvMensalRow(d));
}

class SelectBiologicosAvMensalRow extends SqliteRow {
  SelectBiologicosAvMensalRow(Map<String, dynamic> data) : super(data);

  String? get agenteTipo => data['AgenteTipo'] as String?;
  String? get nomeRisco => data['NomeRisco'] as String?;
}

/// END SELECTBIOLOGICOSAVMENSAL

/// BEGIN SELECTERGONOMICOAVMENSAL
Future<List<SelectErgonomicoAvMensalRow>> performSelectErgonomicoAvMensal(
  Database database,
) {
  final query = '''
SELECT * FROM AgentesAvMensal WHERE AgenteTipo = 'Ergonômico';
''';
  return _readQuery(database, query, (d) => SelectErgonomicoAvMensalRow(d));
}

class SelectErgonomicoAvMensalRow extends SqliteRow {
  SelectErgonomicoAvMensalRow(Map<String, dynamic> data) : super(data);

  String? get agenteTipo => data['AgenteTipo'] as String?;
  String? get nomeRisco => data['NomeRisco'] as String?;
}

/// END SELECTERGONOMICOAVMENSAL

/// BEGIN SELECTACIDENTEAVMENSAL
Future<List<SelectAcidenteAvMensalRow>> performSelectAcidenteAvMensal(
  Database database,
) {
  final query = '''
SELECT * FROM AgentesAvMensal WHERE AgenteTipo = 'Acidente';
''';
  return _readQuery(database, query, (d) => SelectAcidenteAvMensalRow(d));
}

class SelectAcidenteAvMensalRow extends SqliteRow {
  SelectAcidenteAvMensalRow(Map<String, dynamic> data) : super(data);

  String? get agenteTipo => data['AgenteTipo'] as String?;
  String? get nomeRisco => data['NomeRisco'] as String?;
}

/// END SELECTACIDENTEAVMENSAL

/// BEGIN SELECTEPCAV
Future<List<SelectEPCAvRow>> performSelectEPCAv(
  Database database,
) {
  final query = '''
SELECT DISTINCT nome  FROM epcs ORDER BY nome ASC
''';
  return _readQuery(database, query, (d) => SelectEPCAvRow(d));
}

class SelectEPCAvRow extends SqliteRow {
  SelectEPCAvRow(Map<String, dynamic> data) : super(data);

  String get nome => data['nome'] as String;
}

/// END SELECTEPCAV
