import 'package:sqflite/sqflite.dart';

/// BEGIN INSERTAGENTESFROMID
Future performInsertAgentesFromId(
  Database database, {
  String? nomeAgente,
  int? idTipo,
}) {
  final query = '''
INSERT INTO AgenteRisco (nomeAgente, idTipo) VALUES ('${nomeAgente}', ${idTipo})
''';
  return database.rawQuery(query);
}

/// END INSERTAGENTESFROMID

/// BEGIN INSERTAVALIADORES
Future performInsertAvaliadores(
  Database database, {
  String? nome,
  String? profissao,
  String? cargo,
}) {
  final query = '''
INSERT INTO avaliadores (nome, profissao, cargo) VALUES ('${nome}',  '${profissao}', '${cargo}');
''';
  return database.rawQuery(query);
}

/// END INSERTAVALIADORES

/// BEGIN DELETEEMPRESA
Future performDeleteEmpresa(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM EMPRESAS WHERE ID_EMPRESAS = ${id};
''';
  return database.rawQuery(query);
}

/// END DELETEEMPRESA

/// BEGIN INSERTEMPRESA
Future performInsertEmpresa(
  Database database, {
  String? nome,
  String? cnpj,
}) {
  final query = '''
INSERT INTO EMPRESAS (Nome, CNPJ) VALUES ('${nome}', '${cnpj}')
''';
  return database.rawQuery(query);
}

/// END INSERTEMPRESA

/// BEGIN DELETEAVALIADOR
Future performDeleteAvaliador(
  Database database, {
  int? userId,
}) {
  final query = '''
DELETE FROM avaliadores WHERE ID = ${userId}
''';
  return database.rawQuery(query);
}

/// END DELETEAVALIADOR

/// BEGIN UPDATEAGENTE
Future performUpdateAgente(
  Database database, {
  String? nome,
  int? id,
}) {
  final query = '''
UPDATE AgenteRisco SET nomeAgente = '${nome}' WHERE ID = ${id};
''';
  return database.rawQuery(query);
}

/// END UPDATEAGENTE

/// BEGIN DELETESETORFROMEMPRESA
Future performDeleteSetorFromEmpresa(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM SETORES where id = ${id};
''';
  return database.rawQuery(query);
}

/// END DELETESETORFROMEMPRESA

/// BEGIN INSERTSETOR
Future performInsertSetor(
  Database database, {
  String? nome,
  int? idEmpresas,
}) {
  final query = '''
INSERT INTO SETORES (NOME, idEmpresas) VALUES ('${nome}', ${idEmpresas})
''';
  return database.rawQuery(query);
}

/// END INSERTSETOR

/// BEGIN INSERTFUNCOES
Future performInsertFuncoes(
  Database database, {
  String? nome,
  int? idEmpresa,
}) {
  final query = '''
INSERT INTO FUNCOES (NOME, idEmpresa) VALUES ('${nome}', ${idEmpresa})
''';
  return database.rawQuery(query);
}

/// END INSERTFUNCOES

/// BEGIN DELETEFUNCAOFROMEMPRESA
Future performDeleteFuncaoFromEmpresa(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM FUNCOES WHERE id = ${id}
''';
  return database.rawQuery(query);
}

/// END DELETEFUNCAOFROMEMPRESA

/// BEGIN UPDATEEMPRESA
Future performUpdateEmpresa(
  Database database, {
  String? nome,
  String? cnpj,
  int? id,
  String? cidade,
  String? estado,
}) {
  final query = '''
UPDATE EMPRESAS SET Nome = '${nome}', CNPJ = '${cnpj}', CIDADE = '${cidade}', ESTADO = '${estado}' where ID_EMPRESAS = ${id}
''';
  return database.rawQuery(query);
}

/// END UPDATEEMPRESA

/// BEGIN UPDATEEPCS
Future performUpdateEpcs(
  Database database, {
  String? nome,
  String? id,
}) {
  final query = '''
UPDATE epcs SET nome = '${nome}' where ID = ${id}
''';
  return database.rawQuery(query);
}

/// END UPDATEEPCS

/// BEGIN UPDATEEPIS
Future performUpdateEPIS(
  Database database, {
  String? nomeEPI,
  int? id,
}) {
  final query = '''
update EPIS SET nomeEPI = '${nomeEPI}' where ID = ${id};
''';
  return database.rawQuery(query);
}

/// END UPDATEEPIS

/// BEGIN INSERTEPC
Future performInsertEpc(
  Database database, {
  String? nome,
  int? id,
}) {
  final query = '''
INSERT INTO epcs (nome, idAgente) VALUES ('${nome}', ${id})
''';
  return database.rawQuery(query);
}

/// END INSERTEPC

/// BEGIN DELETEEPC
Future performDeleteEPC(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM epcs where id = ${id};
''';
  return database.rawQuery(query);
}

/// END DELETEEPC

/// BEGIN INSERTEPI
Future performInsertEPI(
  Database database, {
  String? nome,
  int? id,
}) {
  final query = '''
INSERT INTO EPIS (nomeEPI, agente_id) VALUES ('${nome}', ${id})
''';
  return database.rawQuery(query);
}

/// END INSERTEPI

/// BEGIN DELETEEPI
Future performDeleteEPI(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM EPIS where id = ${id};
''';
  return database.rawQuery(query);
}

/// END DELETEEPI

/// BEGIN INSERTMEDIDAS
Future performInsertMedidas(
  Database database, {
  String? nome,
  int? id,
}) {
  final query = '''
INSERT INTO Medidas (nome, agente_id) VALUES ('${nome}', ${id}) 
''';
  return database.rawQuery(query);
}

/// END INSERTMEDIDAS

/// BEGIN DELETEMEDIDAS
Future performDeleteMedidas(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM Medidas where ID = ${id}
''';
  return database.rawQuery(query);
}

/// END DELETEMEDIDAS

/// BEGIN UPDATEMEDIDAS
Future performUpdateMedidas(
  Database database, {
  String? nome,
  int? id,
}) {
  final query = '''
update Medidas SET nome = '${nome}' where ID = ${id};
''';
  return database.rawQuery(query);
}

/// END UPDATEMEDIDAS

/// BEGIN INSERTDESCRICAODADOS
Future performInsertDescricaoDados(
  Database database, {
  String? descricao,
  int? id,
}) {
  final query = '''
insert into DadosAdicionais (descricao, agente_id) values ('${descricao}', ${id})
''';
  return database.rawQuery(query);
}

/// END INSERTDESCRICAODADOS

/// BEGIN INSERTACOES
Future performInsertacoes(
  Database database, {
  String? acoes,
  int? id,
}) {
  final query = '''
insert into DadosAdicionais (acoes, agente_id) values ('${acoes}', ${id})
''';
  return database.rawQuery(query);
}

/// END INSERTACOES

/// BEGIN INSERTSUGESTAO
Future performInsertSugestao(
  Database database, {
  String? sugestao,
  int? id,
}) {
  final query = '''
insert into DadosAdicionais (sugestaoInicial, agente_id) values ('${sugestao}', ${id})
''';
  return database.rawQuery(query);
}

/// END INSERTSUGESTAO

/// BEGIN INSERTRISCOS
Future performInsertRiscos(
  Database database, {
  String? riscos,
  int? id,
}) {
  final query = '''
insert into DadosAdicionais (riscos, agente_id) values ('${riscos}', ${id})
''';
  return database.rawQuery(query);
}

/// END INSERTRISCOS

/// BEGIN DELETARPDF
Future performDeletarPDF(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM pdfGerado where id = ${id}
''';
  return database.rawQuery(query);
}

/// END DELETARPDF

/// BEGIN DELETARASSINATURA
Future performDeletarAssinatura(
  Database database, {
  int? id,
}) {
  final query = '''
 DELETE FROM assinaturas where ID = ${id}
''';
  return database.rawQuery(query);
}

/// END DELETARASSINATURA

/// BEGIN INSERTEPIGERAL
Future performInsertEPIGeral(
  Database database, {
  String? nome,
}) {
  final query = '''
INSERT INTO EPIS (nomeEPI) VALUES ('${nome}')
''';
  return database.rawQuery(query);
}

/// END INSERTEPIGERAL

/// BEGIN INSERTEPCGERAL
Future performInsertEpcGeral(
  Database database, {
  String? nome,
}) {
  final query = '''
INSERT INTO epcs (nome) VALUES ('${nome}')
''';
  return database.rawQuery(query);
}

/// END INSERTEPCGERAL
