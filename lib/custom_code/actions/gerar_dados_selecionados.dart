// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert'; // Adicionado para suporte UTF-8

// Função auxiliar para obter a versão do Android
Future<String> _getAndroidVersion() async {
  try {
    final sdkVersion = await MethodChannel('android_info')
        .invokeMethod('getAndroidSdkVersion');
    return sdkVersion.toString();
  } catch (e) {
    return 'Não foi possível determinar';
  }
}

// Função para obter diretório de download
Future<String?> _obterDiretorioDownload() async {
  try {
    if (Platform.isAndroid) {
      // Método direto para Android
      return '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      // No iOS, usamos o diretório de documentos
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  } catch (e) {
    print('Erro ao obter diretório de download: $e');
  }

  // Se tudo falhar, usa o diretório de documentos
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// Função para verificar permissões
Future<bool> _verificarPermissoes() async {
  print('Iniciando verificação de permissões...');

  if (Platform.isAndroid) {
    print('Dispositivo Android detectado.');
    print('Tentando obter versão Android...');
    final androidVersion = await _getAndroidVersion();
    print('Android SDK version: $androidVersion');

    // Permissão de notificação
    print('Solicitando permissão de notificação...');
    await Permission.notification.request();

    // Tente primeiro com a permissão básica de armazenamento
    print('Solicitando permissão básica de armazenamento (storage)...');
    final storageStatus = await Permission.storage.request();
    print('Status da permissão storage: $storageStatus');

    if (storageStatus.isGranted) {
      print('✅ Permissão storage concedida com sucesso!');
      return true;
    } else {
      print('⚠️ Permissão storage não concedida: $storageStatus');

      // Se estamos no Android 11+, tentamos com manageExternalStorage
      print('Tentando permissão avançada manageExternalStorage...');
      final advancedStatus = await Permission.manageExternalStorage.request();
      print('Status da permissão manageExternalStorage: $advancedStatus');

      if (advancedStatus.isGranted) {
        print('✅ Permissão manageExternalStorage concedida com sucesso!');
        return true;
      } else {
        print('❌ Permissão manageExternalStorage negada: $advancedStatus');
        print('❌ Não foi possível obter nenhuma das permissões necessárias.');
        return false;
      }
    }
  } else if (Platform.isIOS) {
    print(
        'Dispositivo iOS detectado - não são necessárias permissões explícitas.');
    return true;
  } else {
    print('Plataforma não suportada: ${Platform.operatingSystem}');
    return true; // Assumimos permissão para outras plataformas como web, Windows, etc.
  }
}

// Nova função auxiliar para gerar arquivos CSV corretamente formatados
Future<File?> _gerarArquivoCSV(
    List<List<dynamic>> dados, String caminhoArquivo) async {
  try {
    // Cria um StringBuffer para construir o conteúdo CSV manualmente
    final StringBuffer conteudoCSV = StringBuffer();

    // Processa cada linha
    for (final linha in dados) {
      final List<String> camposFormatados = [];

      // Formata cada campo na linha adequadamente
      for (final campo in linha) {
        String campoStr = campo?.toString() ?? '';

        // Escapa aspas e envolve campos com aspas se contiverem vírgulas, ponto-e-vírgula ou aspas
        if (campoStr.contains('"') ||
            campoStr.contains(';') ||
            campoStr.contains(',') ||
            campoStr.contains('\n')) {
          campoStr = '"${campoStr.replaceAll('"', '""')}"';
        }

        camposFormatados.add(campoStr);
      }

      // Adiciona a linha formatada ao conteúdo CSV
      conteudoCSV.writeln(
          camposFormatados.join(';')); // Usando ponto-e-vírgula como separador
    }

    // Cria o arquivo com BOM UTF-8 para compatibilidade
    final arquivo = File(caminhoArquivo);

    // Adiciona BOM UTF-8 e escreve o conteúdo
    List<int> bytes = [0xEF, 0xBB, 0xBF]; // BOM UTF-8
    bytes.addAll(utf8.encode(conteudoCSV.toString()));

    await arquivo.writeAsBytes(bytes);
    print('Arquivo CSV gerado com sucesso: $caminhoArquivo');
    return arquivo;
  } catch (e) {
    print('Erro ao gerar arquivo CSV: $e');
    return null;
  }
}

// Tenta abrir a pasta de exportação usando o package open_file
Future<bool> _abrirPasta(String caminho) async {
  try {
    print('Tentando abrir pasta: $caminho');
    final result = await OpenFile.open(caminho);

    if (result.type == ResultType.done) {
      print('Pasta aberta com sucesso!');
      return true;
    } else {
      print('Erro ao abrir pasta: ${result.message}');
      return false;
    }
  } catch (e) {
    print('Exceção ao tentar abrir pasta: $e');
    return false;
  }
}

// Função principal de exportação de dados - mantendo o tipo Future<String>
Future<String> gerarDadosSelecionados(List<String> listaDados) async {
  print('Iniciando exportação com os dados: $listaDados');
  try {
    if (listaDados.isEmpty) {
      print('Lista de dados vazia');
      return 'Por favor, selecione pelo menos um item para exportar.';
    }

    // Verificar permissões
    final permissionsGranted = await _verificarPermissoes();
    if (!permissionsGranted) {
      print('❌ Permissões necessárias não concedidas.');
      return 'Permissão para acessar o armazenamento negada.';
    }
    print('✅ Permissões concedidas, prosseguindo com a exportação...');

    // Criar diretório para os arquivos exportados
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    print('Timestamp: $timestamp');

    // Obter diretório de download
    print('Obtendo diretório de download...');
    final downloadPath = await _obterDiretorioDownload();
    if (downloadPath == null) {
      return 'Não foi possível obter um diretório para salvar os arquivos.';
    }
    print('Diretório de download: $downloadPath');

    final exportDir = Directory('$downloadPath/exports_$timestamp');
    print('Diretório de exportação: ${exportDir.path}');

    if (!await exportDir.exists()) {
      print('Criando diretório...');
      await exportDir.create(recursive: true);
      print('Diretório criado com sucesso');
    }

    // Obter conexão com o banco de dados
    print('Tentando conectar ao banco de dados...');
    final db = await SQLiteManager.instance.database;
    print('Conexão com banco de dados estabelecida');

    // Lista para armazenar caminhos dos arquivos gerados
    final List<String> caminhoArquivos = [];
    int totalRegistros = 0;

    // Processar cada tipo de dado selecionado
    print('Processando dados: ${listaDados.length} itens');
    for (final dado in listaDados) {
      print('Exportando: $dado');
      File? arquivoCSV;

      // Exportar conforme o tipo de dado (usando toLowerCase para evitar problemas de case)
      switch (dado.toLowerCase()) {
        case 'empresas':
          arquivoCSV = await _exportarEmpresas(db, exportDir.path, timestamp);
          break;
        case 'epis':
          arquivoCSV = await _exportarEPIs(db, exportDir.path, timestamp);
          break;
        case 'epcs':
          arquivoCSV = await _exportarEPCs(db, exportDir.path, timestamp);
          break;
        case 'avaliadores':
          arquivoCSV =
              await _exportarAvaliadores(db, exportDir.path, timestamp);
          break;
        case 'agentes':
          arquivoCSV = await _exportarAgentes(db, exportDir.path, timestamp);
          break;
        case 'medidascontrole':
        case 'medidas de controle':
          arquivoCSV =
              await _exportarMedidasControle(db, exportDir.path, timestamp);
          break;
        case 'dadosadicionais':
        case 'dados adicionais':
          arquivoCSV =
              await _exportarDadosAdicionais(db, exportDir.path, timestamp);
          break;
        default:
          print('⚠️ Tipo de dado não reconhecido: $dado');
          break;
      }

      if (arquivoCSV != null) {
        print('Arquivo criado para $dado: ${arquivoCSV.path}');
        caminhoArquivos.add(arquivoCSV.path);
        totalRegistros++;
      } else {
        print('Nenhum arquivo gerado para $dado');
      }
    }

    // Retornar resultado da exportação como String
    if (caminhoArquivos.isNotEmpty) {
      // Tenta abrir a pasta para o usuário
      final pastaAberta = await _abrirPasta(exportDir.path);
      final mensagem =
          'Exportação concluída! ${caminhoArquivos.length} arquivos foram salvos na pasta Downloads/exports_$timestamp';

      if (pastaAberta) {
        return '$mensagem\n\nA pasta foi aberta automaticamente.';
      } else {
        return '$mensagem\n\nNão foi possível abrir a pasta automaticamente. Caminho: ${exportDir.path}';
      }
    } else {
      print('Nenhum arquivo gerado');
      return 'Nenhum dado foi exportado. Talvez as tabelas estejam vazias?';
    }
  } catch (e) {
    print('Erro na exportação: $e');
    return 'Erro durante a exportação: $e';
  }
}

/// Exporta empresas com seus relacionamentos (setores e funções)
Future<File?> _exportarEmpresas(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de empresas...');
  try {
    // Consulta das empresas com suas colunas ajustadas
    print('Executando consulta SQL para empresas...');
    final empresas = await db.rawQuery('''
      SELECT ID_EMPRESAS, Nome, CNPJ, CIDADE, ESTADO
      FROM EMPRESAS
      ORDER BY Nome
    ''');
    print('Resultado da consulta: ${empresas.length} empresas encontradas');

    if (empresas.isEmpty) {
      print('Nenhuma empresa encontrada');
      return null;
    }

    // Preparar dados para CSV com relacionamentos consolidados
    final List<List<dynamic>> rows = [
      // Cabeçalho ajustado para o novo formato
      [
        'ID Empresa',
        'Nome Empresa',
        'CNPJ',
        'Cidade',
        'Estado',
        'Setores',
        'Funções'
      ]
    ];

    // Para cada empresa, buscar seus setores e funções de uma vez
    print('Processando dados relacionados...');
    for (final empresa in empresas) {
      final empresaId = empresa['ID_EMPRESAS'];

      // Buscar todos os setores desta empresa
      final setores = await db.rawQuery('''
        SELECT NOME FROM SETORES
        WHERE idEmpresas = ?
        ORDER BY NOME
      ''', [empresaId]);

      // Buscar todas as funções desta empresa
      final funcoes = await db.rawQuery('''
        SELECT NOME FROM FUNCOES
        WHERE idEmpresa = ?
        ORDER BY NOME
      ''', [empresaId]);

      print(
          'Empresa ${empresa['Nome']}: ${setores.length} setores, ${funcoes.length} funções');

      // Consolidar setores e funções em strings incluindo IDs e nomes
      final setoresStr = setores.map((s) => "${s['NOME']}").join(", ");

      final funcoesStr = funcoes.map((f) => "${f['NOME']}").join(", ");

      // Adicionar apenas uma linha por empresa com todos os dados consolidados
      rows.add([
        empresa['ID_EMPRESAS'],
        empresa['Nome'],
        empresa['CNPJ'],
        empresa['CIDADE'],
        empresa['ESTADO'],
        setoresStr, // Todos os setores em uma string
        funcoesStr // Todas as funções em uma string
      ]);
    }

    print('Gerando arquivo CSV para empresas...');
    // Usar a função para gerar o CSV
    final filePath = '$dirPath/empresas_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar empresas: $e');
    return null;
  }
}

Future<File?> _exportarEPIs(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de EPIs...');
  try {
    print('Executando consulta SQL para EPIs...');
    final epis = await db.rawQuery('''
      SELECT id, nomeEPI, agente_id
      FROM EPIS
      ORDER BY nomeEPI
    ''');
    print('Resultado da consulta: ${epis.length} EPIs encontrados');

    if (epis.isEmpty) {
      print('Nenhum EPI encontrado');
      return null;
    }

    // Cabeçalho e dados ajustados para suas colunas reais
    final List<List<dynamic>> rows = [
      ['ID', 'Nome do EPI', 'ID do Agente', 'Nome do Agente']
    ];

    // Adicionar cada EPI com seu agente associado (se houver)
    print('Processando relações com agentes...');
    for (final epi in epis) {
      final agenteId = epi['agente_id']; // Corrigido: acessar agente_id, não ID
      String nomeAgente = '';

      // Se o EPI tem um agente associado, buscar o nome do agente
      if (agenteId != null) {
        final agentes = await db.rawQuery('''
          SELECT nomeAgente FROM AgenteRisco
          WHERE ID = ?
        ''', [agenteId]);

        if (agentes.isNotEmpty) {
          nomeAgente = agentes.first['nomeAgente'] ??
              ''; // Corrigido: acessar nomeAgente, não nome
        }
      }

      rows.add([epi['id'], epi['nomeEPI'], agenteId ?? '', nomeAgente]);
    }

    print('Gerando arquivo CSV para EPIs...');
    // Usar a nova função para gerar o CSV
    final filePath = '$dirPath/epis_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar EPIs: $e');
    return null;
  }
}

/// Exporta dados de EPCs
Future<File?> _exportarEPCs(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de EPCs...');
  try {
    print('Executando consulta SQL para EPCs...');
    final epcs = await db.rawQuery('''
      SELECT id, nome, idAgente
      FROM epcs
      ORDER BY nome
    ''');
    print('Resultado da consulta: ${epcs.length} EPCs encontrados');

    if (epcs.isEmpty) {
      print('Nenhum EPC encontrado');
      return null;
    }

    // Cabeçalho e dados ajustados para as colunas reais
    final List<List<dynamic>> rows = [
      ['ID', 'Nome do EPC', 'ID do Agente', 'Nome do Agente']
    ];

    // Adicionar cada EPC com informações do agente associado (se houver)
    print('Processando relações com agentes...');
    for (final epc in epcs) {
      final agenteId = epc['idAgente']; // Corrigido: usar idAgente em vez de ID
      String nomeAgente = '';

      // Se o EPC tem um agente associado, buscar o nome do agente
      if (agenteId != null) {
        final agentes = await db.rawQuery('''
          SELECT nomeAgente FROM AgenteRisco
          WHERE ID = ?
        ''', [agenteId]);

        if (agentes.isNotEmpty) {
          nomeAgente = agentes.first['nomeAgente'] ?? '';
        }
      }

      rows.add([epc['id'], epc['nome'], agenteId ?? '', nomeAgente]);
    }

    print('Gerando arquivo CSV para EPCs...');
    // Usar a função para gerar o CSV
    final filePath = '$dirPath/epcs_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar EPCs: $e');
    return null;
  }
}

Future<File?> _exportarAvaliadores(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de Avaliadores...');
  try {
    print('Executando consulta SQL para Avaliadores...');
    final avaliadores = await db.rawQuery('''
      SELECT ID, nome, cargo, profissao
      FROM avaliadores
      ORDER BY nome
    ''');
    print(
        'Resultado da consulta: ${avaliadores.length} avaliadores encontrados');

    if (avaliadores.isEmpty) {
      print('Nenhum avaliador encontrado');
      return null;
    }

    // Cabeçalho e dados ajustados para as colunas reais
    final List<List<dynamic>> rows = [
      ['ID', 'Nome', 'Cargo', 'Profissão']
    ];

    for (final avaliador in avaliadores) {
      rows.add([
        avaliador['ID'],
        avaliador['nome'],
        avaliador['cargo'],
        avaliador['profissao']
      ]);
    }

    print('Gerando arquivo CSV para Avaliadores...');
    // Usar a nova função para gerar o CSV
    final filePath = '$dirPath/avaliadores_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar Avaliadores: $e');
    return null;
  }
}

/// Exporta dados de Agentes
Future<File?> _exportarAgentes(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de Agentes...');
  try {
    print('Executando consulta SQL para Agentes...');
    final agentes = await db.rawQuery('''
      SELECT ID, nomeAgente, idTipo
      FROM agenteRisco
      ORDER BY nomeAgente
    ''');
    print('Resultado da consulta: ${agentes.length} agentes encontrados');

    if (agentes.isEmpty) {
      print('Nenhum agente encontrado');
      return null;
    }

    // Cabeçalho e dados ajustados para as colunas reais
    final List<List<dynamic>> rows = [
      ['ID', 'Nome do Agente', 'ID do Tipo', 'Nome do Tipo']
    ];

    print('Processando relações com tipos...');
    for (final agente in agentes) {
      final tipoId = agente['idTipo'];
      String nomeTipo = '';

      // Buscar o nome do tipo de agente
      if (tipoId != null) {
        try {
          final tipos = await db.rawQuery('''
            SELECT nome FROM TIPORISCO
            WHERE ID = ?
          ''', [tipoId]);

          if (tipos.isNotEmpty) {
            nomeTipo = tipos.first['nome'] ?? '';
          }
        } catch (e) {
          print('Erro ao buscar tipo de agente: $e');
        }
      }

      rows.add([agente['ID'], agente['nomeAgente'], tipoId ?? '', nomeTipo]);
    }

    print('Gerando arquivo CSV para Agentes...');
    // Usar a nova função para gerar o CSV
    final filePath = '$dirPath/agentes_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar Agentes: $e');
    return null;
  }
}

/// Exporta dados de Medidas de Controle
Future<File?> _exportarMedidasControle(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de Medidas de Controle...');
  try {
    print('Executando consulta SQL para Medidas de Controle...');
    final medidas = await db.rawQuery('''
      SELECT ID, nome, agente_id
      FROM Medidas
      ORDER BY nome
    ''');
    print('Resultado da consulta: ${medidas.length} medidas encontradas');

    if (medidas.isEmpty) {
      print('Nenhuma medida encontrada');
      return null;
    }

    // Cabeçalho e dados ajustados para as colunas reais
    final List<List<dynamic>> rows = [
      ['ID', 'Nome da Medida', 'ID do Agente', 'Nome do Agente']
    ];

    print('Processando relações com agentes...');
    for (final medida in medidas) {
      final agenteId = medida['agente_id'];
      String nomeAgente = '';

      // Buscar informações do agente relacionado, se existir
      if (agenteId != null) {
        try {
          final agentes = await db.rawQuery('''
            SELECT nomeAgente FROM agenteRisco
            WHERE id = ?
          ''', [agenteId]);

          if (agentes.isNotEmpty) {
            nomeAgente = agentes.first['nomeAgente'] ?? '';
          }
        } catch (e) {
          print('Erro ao buscar agente: $e');
        }
      }

      rows.add([medida['ID'], medida['nome'], agenteId ?? '', nomeAgente]);
    }

    print('Gerando arquivo CSV para Medidas de Controle...');
    // Usar a nova função para gerar o CSV
    final filePath = '$dirPath/medidas_controle_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar Medidas de Controle: $e');
    return null;
  }
}

/// Exporta Dados Adicionais
Future<File?> _exportarDadosAdicionais(
    dynamic db, String dirPath, String timestamp) async {
  print('Iniciando exportação de Dados Adicionais...');
  try {
    print('Executando consulta SQL para Dados Adicionais...');
    final dados = await db.rawQuery('''
      SELECT ID, descricao, acoes, riscos, sugestaoInicial, agente_id
      FROM DadosAdicionais
      ORDER BY ID  
    ''');
    print(
        'Resultado da consulta: ${dados.length} dados adicionais encontrados');

    if (dados.isEmpty) {
      print('Nenhum dado adicional encontrado');
      return null;
    }

    // Cabeçalho e dados ajustados para as colunas reais
    final List<List<dynamic>> rows = [
      [
        'ID',
        'Descrição',
        'Ações',
        'Riscos',
        'Sugestão Inicial',
        'ID do Agente',
        'Nome do Agente'
      ]
    ];

    print('Processando relações com agentes...');
    for (final dado in dados) {
      final agenteId = dado['agente_id'];
      String nomeAgente = '';

      // Buscar o nome do agente relacionado, se existir
      if (agenteId != null) {
        try {
          final agentes = await db.rawQuery('''
            SELECT nomeAgente FROM agenteRisco
            WHERE id = ?
          ''', [agenteId]);

          if (agentes.isNotEmpty) {
            nomeAgente = agentes.first['nomeAgente'] ?? '';
          }
        } catch (e) {
          print('Erro ao buscar agente: $e');
        }
      }

      rows.add([
        dado['ID'],
        dado['descricao'] ?? '',
        dado['acoes'] ?? '',
        dado['riscos'] ?? '',
        dado['sugestaoInicial'] ?? '',
        agenteId ?? '',
        nomeAgente
      ]);
    }

    print('Gerando arquivo CSV para Dados Adicionais...');
    // Usar a nova função para gerar o CSV
    final filePath = '$dirPath/dados_adicionais_$timestamp.csv';
    return await _gerarArquivoCSV(rows, filePath);
  } catch (e) {
    print('Erro ao exportar Dados Adicionais: $e');
    return null;
  }
}
