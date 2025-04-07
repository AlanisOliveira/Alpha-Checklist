// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'dart:convert'; // Para lidar com UTF-8
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ImportarEmpresasWidget extends StatefulWidget {
  const ImportarEmpresasWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ImportarEmpresasWidget> createState() => _ImportarEmpresasWidgetState();
}

class _ImportarEmpresasWidgetState extends State<ImportarEmpresasWidget> {
  // Estados do widget
  File? arquivoSelecionado;
  String? nomeArquivo;
  List<List<dynamic>>? dadosPrevia;
  bool isLoading = false;
  String statusMensagem = '';
  double progressoImportacao = 0;

  // Delimitador detectado do arquivo
  String delimitadorDetectado = ';';

  // Opção para tratamento de duplicados
  String opcaoDuplicados = 'atualizar_inserir'; // Valor padrão otimizado

  @override
  void initState() {
    super.initState();
    statusMensagem = 'Pronto para importar. Selecione um arquivo CSV.';
  }

  // Método para selecionar arquivo
  Future<void> _selecionarArquivo() async {
    try {
      // Verificar permissões
      final permissao = await _verificarPermissoes();
      if (!permissao) {
        setState(() {
          statusMensagem = 'Permissão para acessar arquivos negada.';
        });
        return;
      }

      // Selecionar arquivo CSV
      FilePickerResult? resultado = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (resultado != null && resultado.files.single.path != null) {
        final arquivo = File(resultado.files.single.path!);

        setState(() {
          arquivoSelecionado = arquivo;
          nomeArquivo = resultado.files.single.name;
          statusMensagem = 'Arquivo selecionado: $nomeArquivo';
          dadosPrevia = null; // Limpar prévia anterior
        });

        // Carregar prévia automaticamente
        await _carregarPrevia();
      }
    } catch (e) {
      setState(() {
        statusMensagem = 'Erro ao selecionar arquivo: $e';
      });
    }
  }

  // Verificar permissões para Android moderno
  Future<bool> _verificarPermissoes() async {
    if (Platform.isAndroid) {
      try {
        // Verificar versão do Android para usar a abordagem correta
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        int sdkVersion = androidInfo.version.sdkInt;

        print('Versão do Android (SDK): $sdkVersion');

        if (sdkVersion >= 30) {
          // Android 11+
          // Para Android 11+, usamos MANAGE_EXTERNAL_STORAGE para acesso completo
          // ou confiamos no SAF (Storage Access Framework) do FilePicker
          final status = await Permission.manageExternalStorage.status;

          if (status.isDenied) {
            // Mostrar diálogo explicando a necessidade da permissão
            final solicitarPermissao = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Permissão necessária'),
                    content: Text(
                        'Para importar arquivos CSV, o aplicativo precisa de permissão para '
                        'acessar arquivos no seu dispositivo. Esta permissão é usada apenas '
                        'para selecionar o arquivo CSV que você deseja importar.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('CANCELAR'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('CONTINUAR'),
                      ),
                    ],
                  ),
                ) ??
                false;

            if (solicitarPermissao) {
              await Permission.manageExternalStorage.request();
              // FilePicker ainda funcionará mesmo sem esta permissão
              return true;
            } else {
              return false;
            }
          }
          // Mesmo se a permissão for negada, o FilePicker funcionará via SAF
          return true;
        } else if (sdkVersion >= 29) {
          // Android 10
          // Para Android 10, verificamos storage
          final status = await Permission.storage.status;
          if (status.isDenied) {
            final result = await Permission.storage.request();
            return result.isGranted;
          }
          return status.isGranted;
        } else {
          // Android 9 e inferior
          // Abordagem tradicional
          final result = await Permission.storage.request();
          return result.isGranted;
        }
      } catch (e) {
        print('Erro ao verificar versão do Android: $e');
        // Tentar abordagem padrão se houver erro na detecção
        final result = await Permission.storage.request();
        return result.isGranted;
      }
    }

    // iOS e outras plataformas não precisam desta permissão específica
    return true;
  }

  // Remover BOM UTF-8 se presente
  String _removerBOMUTF8(String conteudo) {
    // Verifica se o conteúdo começa com BOM UTF-8 e remove
    if (conteudo.isNotEmpty && conteudo.codeUnitAt(0) == 0xFEFF) {
      return conteudo.substring(1);
    }
    return conteudo;
  }

  // Detectar delimitador do CSV
  String _detectarDelimitador(String conteudo) {
    // Conta ocorrências de possíveis delimitadores na primeira linha
    int primeiraLinha = conteudo.indexOf('\n');
    if (primeiraLinha == -1) primeiraLinha = conteudo.length;

    String amostra = conteudo.substring(0, primeiraLinha);

    int virgulas = ','.allMatches(amostra).length;
    int pontoVirgulas = ';'.allMatches(amostra).length;
    int tabs = '\t'.allMatches(amostra).length;

    print(
        'Detectando delimitador -> Vírgulas: $virgulas, Ponto-e-vírgulas: $pontoVirgulas, Tabs: $tabs');

    // Escolhe o delimitador com mais ocorrências
    if (tabs > virgulas && tabs > pontoVirgulas) return '\t';
    return virgulas > pontoVirgulas ? ',' : ';';
  }

  // Carregar prévia dos dados
  Future<void> _carregarPrevia() async {
    if (arquivoSelecionado == null) return;

    setState(() {
      isLoading = true;
      statusMensagem = 'Carregando prévia...';
    });

    try {
      // Ler conteúdo do arquivo
      print('Lendo arquivo: ${arquivoSelecionado!.path}');
      String conteudo = await arquivoSelecionado!.readAsString();

      // Remover BOM UTF-8 se presente
      conteudo = _removerBOMUTF8(conteudo);

      // Detectar delimitador
      delimitadorDetectado = _detectarDelimitador(conteudo);
      print('Delimitador detectado: "$delimitadorDetectado"');

      // Mostrar amostra do conteúdo para debug
      int tamanhoAmostra = conteudo.length > 100 ? 100 : conteudo.length;
      print('Amostra do conteúdo: ${conteudo.substring(0, tamanhoAmostra)}');

      // Converter para linhas CSV com o delimitador detectado
      final linhas = CsvToListConverter(
        fieldDelimiter: delimitadorDetectado,
        shouldParseNumbers: false,
        eol: '\n',
      ).convert(conteudo);

      print('Linhas extraídas: ${linhas.length}');
      if (linhas.isNotEmpty) {
        print('Cabeçalhos encontrados: ${linhas[0]}');
      }

      // Validar cabeçalhos
      if (linhas.isEmpty) {
        setState(() {
          statusMensagem = 'Arquivo CSV vazio ou mal formatado.';
          isLoading = false;
        });
        return;
      }

      if (!_validarCabecalhos(linhas[0])) {
        setState(() {
          statusMensagem =
              'Formato de arquivo inválido para Empresas. Verifique o modelo adequado.';
          isLoading = false;
        });
        return;
      }

      // Obter prévia (até 5 linhas)
      final previa = linhas.length > 6 ? linhas.sublist(0, 6) : linhas;

      setState(() {
        dadosPrevia = previa;
        isLoading = false;
        statusMensagem =
            'Prévia carregada. ${linhas.length - 1} registros encontrados. Delimitador: "$delimitadorDetectado"';
      });
    } catch (e) {
      print('ERRO ao processar arquivo: $e');
      setState(() {
        statusMensagem = 'Erro ao processar arquivo: $e';
        isLoading = false;
      });
    }
  }

  // Validar cabeçalhos do arquivo
  bool _validarCabecalhos(List<dynamic> cabecalhos) {
    // Converte todos os cabeçalhos para uma forma normalizada
    List<String> cabecalhosNormalizados =
        cabecalhos.map((c) => c.toString().trim().toLowerCase()).toList();

    print('Cabeçalhos normalizados: $cabecalhosNormalizados');

    // Verificar se temos pelo menos 4 colunas
    if (cabecalhosNormalizados.length < 4) {
      print('Número insuficiente de colunas: ${cabecalhosNormalizados.length}');
      return false;
    }

    // Verificar se contém as colunas necessárias
    bool temNome = cabecalhosNormalizados.any((c) =>
        c == 'nome empresa' ||
        c == 'nomeempresa' ||
        c == 'nome_empresa' ||
        c == 'nome');

    bool temCnpj = cabecalhosNormalizados.any((c) => c == 'cnpj');

    bool temCidade = cabecalhosNormalizados.any((c) => c == 'cidade');

    bool temEstado =
        cabecalhosNormalizados.any((c) => c == 'estado' || c == 'uf');

    bool temSetores = cabecalhosNormalizados
        .any((c) => c == 'setores' || c == 'setor' || c == 'setores_empresa');

    bool temFuncoes = cabecalhosNormalizados.any((c) =>
        c == 'funções' || c == 'funcoes' || c == 'funcao' || c == 'função');

    print('Tem nome: $temNome, Tem CNPJ: $temCnpj, Tem cidade: $temCidade, ' +
        'Tem estado: $temEstado, Tem setores: $temSetores, Tem funções: $temFuncoes');

    // Arquivo é válido se tiver os campos básicos (nome, cnpj, cidade, estado)
    return temNome && temCnpj && temCidade && temEstado;
  }

  // Diálogo de confirmação antes da importação
  Future<bool> _confirmarImportacao() async {
    String mensagem =
        'Empresas novas serão adicionadas, junto com seus setores e funções.';

    // Adicionar informação sobre duplicados
    switch (opcaoDuplicados) {
      case 'atualizar_inserir':
        mensagem +=
            '\n\nEmpresas com nomes já existentes: serão atualizadas com os novos dados e relacionamentos.';
        break;
      case 'substituir':
        mensagem +=
            '\n\nEmpresas com nomes já existentes: serão atualizadas com os novos dados e relacionamentos.';
        break;
      case 'ignorar':
        mensagem +=
            '\n\nEmpresas com nomes já existentes: serão ignoradas (mantidas como estão).';
        break;
      case 'adicionar':
        mensagem +=
            '\n\nEmpresas com nomes já existentes: serão adicionadas como novos registros (permitindo duplicatas).';
        break;
    }

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirmar importação'),
            content: Text(mensagem),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('CANCELAR'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('CONFIRMAR'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Importar dados
  Future<void> _importarDados() async {
    if (arquivoSelecionado == null || dadosPrevia == null) {
      setState(() {
        statusMensagem = 'Selecione um arquivo válido primeiro.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      progressoImportacao = 0;
      statusMensagem = 'Iniciando importação...';
    });

    try {
      // Ler todo o conteúdo
      String conteudo = await arquivoSelecionado!.readAsString();

      // Remover BOM UTF-8 se presente
      conteudo = _removerBOMUTF8(conteudo);

      // Usar o delimitador detectado previamente
      final linhas = CsvToListConverter(
        fieldDelimiter: delimitadorDetectado,
        shouldParseNumbers: false,
        eol: '\n',
      ).convert(conteudo);

      if (linhas.length <= 1) {
        setState(() {
          statusMensagem = 'Arquivo não possui dados para importar.';
          isLoading = false;
        });
        return;
      }

      // Obter conexão com banco de dados
      final db = await SQLiteManager.instance.database;

      // Contadores para feedback
      int empresasAdicionadas = 0;
      int empresasAtualizadas = 0;
      int setoresAdicionados = 0;
      int funcoesAdicionadas = 0;
      int ignorados = 0;
      int erros = 0;

      // Identificar índices das colunas
      List<String> cabecalhos =
          linhas[0].map((c) => c.toString().toLowerCase().trim()).toList();

      int nomeEmpresaIndex = cabecalhos.indexWhere((c) =>
          c == 'nome empresa' ||
          c == 'nomeempresa' ||
          c == 'nome_empresa' ||
          c == 'nome');

      int cnpjIndex = cabecalhos.indexWhere((c) => c == 'cnpj');

      int cidadeIndex = cabecalhos.indexWhere((c) => c == 'cidade');

      int estadoIndex =
          cabecalhos.indexWhere((c) => c == 'estado' || c == 'uf');

      int setoresIndex = cabecalhos.indexWhere(
          (c) => c == 'setores' || c == 'setor' || c == 'setores_empresa');

      int funcoesIndex = cabecalhos.indexWhere((c) =>
          c == 'funções' || c == 'funcoes' || c == 'funcao' || c == 'função');

      print('Índices: Nome=$nomeEmpresaIndex, CNPJ=$cnpjIndex, Cidade=$cidadeIndex, ' +
          'Estado=$estadoIndex, Setores=$setoresIndex, Funções=$funcoesIndex');

      if (nomeEmpresaIndex < 0 ||
          cnpjIndex < 0 ||
          cidadeIndex < 0 ||
          estadoIndex < 0) {
        setState(() {
          statusMensagem =
              'Formato do arquivo inválido. Certifique-se de que há colunas para Nome da Empresa, CNPJ, Cidade e Estado.';
          isLoading = false;
        });
        return;
      }

      // Processar registros (pular cabeçalho)
      for (int i = 1; i < linhas.length; i++) {
        // Atualizar progresso
        setState(() {
          progressoImportacao = i / (linhas.length - 1);
          statusMensagem = 'Processando registro $i de ${linhas.length - 1}...';
        });

        try {
          final linha = linhas[i];

          // Verificar se a linha tem o tamanho mínimo necessário
          int maiorIndiceBasico = nomeEmpresaIndex;
          if (cnpjIndex > maiorIndiceBasico) maiorIndiceBasico = cnpjIndex;
          if (cidadeIndex > maiorIndiceBasico) maiorIndiceBasico = cidadeIndex;
          if (estadoIndex > maiorIndiceBasico) maiorIndiceBasico = estadoIndex;

          if (linha.length <= maiorIndiceBasico) {
            print('Linha $i não tem colunas suficientes');
            erros++;
            continue;
          }

          // Extrair dados básicos da empresa
          final nomeEmpresa = linha[nomeEmpresaIndex].toString().trim();
          final cnpj = linha[cnpjIndex].toString().trim();
          final cidade = linha[cidadeIndex].toString().trim();
          final estado = linha[estadoIndex].toString().trim();

          // Extrair setores e funções se disponíveis
          List<String> setores = [];
          if (setoresIndex >= 0 && linha.length > setoresIndex) {
            final setoresTexto = linha[setoresIndex].toString().trim();
            if (setoresTexto.isNotEmpty) {
              setores = setoresTexto
                  .split(',')
                  .map((s) => s.trim())
                  .where((s) => s.isNotEmpty)
                  .toList();
            }
          }

          List<String> funcoes = [];
          if (funcoesIndex >= 0 && linha.length > funcoesIndex) {
            final funcoesTexto = linha[funcoesIndex].toString().trim();
            if (funcoesTexto.isNotEmpty) {
              funcoes = funcoesTexto
                  .split(',')
                  .map((s) => s.trim())
                  .where((s) => s.isNotEmpty)
                  .toList();
            }
          }

          // Validação básica
          if (nomeEmpresa.isEmpty) {
            print('Linha $i tem nome de empresa vazio');
            erros++;
            continue;
          }

          // LÓGICA DE IMPORTAÇÃO DE EMPRESA
          int idEmpresaInserida = -1;

          switch (opcaoDuplicados) {
            case 'atualizar_inserir':
            case 'substituir':
              // Verificar se a empresa já existe por nome
              final empresasExistentes = await db.query(
                'EMPRESAS',
                where: 'Nome = ?',
                whereArgs: [nomeEmpresa],
              );

              if (empresasExistentes.isNotEmpty) {
                // Atualiza se já existir
                await db.update(
                  'EMPRESAS',
                  {
                    'CNPJ': cnpj,
                    'CIDADE': cidade,
                    'ESTADO': estado,
                  },
                  where: 'ID_EMPRESAS = ?',
                  whereArgs: [empresasExistentes.first['ID_EMPRESAS']],
                );
                idEmpresaInserida =
                    empresasExistentes.first['ID_EMPRESAS'] as int;
                empresasAtualizadas++;
              } else {
                // Insere se for nova
                idEmpresaInserida = await db.insert('EMPRESAS', {
                  'Nome': nomeEmpresa,
                  'CNPJ': cnpj,
                  'CIDADE': cidade,
                  'ESTADO': estado,
                });
                empresasAdicionadas++;
              }
              break;

            case 'ignorar':
              // Verificar se a empresa já existe por nome
              final empresasExistentes = await db.query(
                'EMPRESAS',
                where: 'Nome = ?',
                whereArgs: [nomeEmpresa],
              );

              if (empresasExistentes.isNotEmpty) {
                // Ignora se já existir
                idEmpresaInserida =
                    empresasExistentes.first['ID_EMPRESAS'] as int;
                ignorados++;
              } else {
                // Insere se for nova
                idEmpresaInserida = await db.insert('EMPRESAS', {
                  'Nome': nomeEmpresa,
                  'CNPJ': cnpj,
                  'CIDADE': cidade,
                  'ESTADO': estado,
                });
                empresasAdicionadas++;
              }
              break;

            case 'adicionar':
              // Sempre adiciona como nova
              idEmpresaInserida = await db.insert('EMPRESAS', {
                'Nome': nomeEmpresa,
                'CNPJ': cnpj,
                'CIDADE': cidade,
                'ESTADO': estado,
              });
              empresasAdicionadas++;
              break;
          }

          // Se conseguimos obter um ID de empresa válido, prossiga com setores e funções
          if (idEmpresaInserida > 0) {
            // INSERIR SETORES
            for (String nomeSetor in setores) {
              if (nomeSetor.isEmpty) continue;

              // Verificar se o setor já existe para esta empresa
              final setoresExistentes = await db.query(
                'SETORES',
                where: 'NOME = ? AND idEmpresas = ?',
                whereArgs: [nomeSetor, idEmpresaInserida],
              );

              if (setoresExistentes.isEmpty || opcaoDuplicados == 'adicionar') {
                // Inserir novo setor
                await db.insert('SETORES', {
                  'NOME': nomeSetor,
                  'idEmpresas': idEmpresaInserida,
                });
                setoresAdicionados++;
              }
            }

            // INSERIR FUNÇÕES
            for (String nomeFuncao in funcoes) {
              if (nomeFuncao.isEmpty) continue;

              // Verificar se a função já existe para esta empresa
              final funcoesExistentes = await db.query(
                'FUNCOES',
                where: 'NOME = ? AND idEmpresa = ?',
                whereArgs: [nomeFuncao, idEmpresaInserida],
              );

              if (funcoesExistentes.isEmpty || opcaoDuplicados == 'adicionar') {
                // Inserir nova função
                await db.insert('FUNCOES', {
                  'NOME': nomeFuncao,
                  'idEmpresa': idEmpresaInserida,
                });
                funcoesAdicionadas++;
              }
            }
          }
        } catch (e) {
          print('Erro ao processar linha $i: $e');
          erros++;
        }
      }

      // Concluir
      setState(() {
        isLoading = false;
        progressoImportacao = 1.0;
        statusMensagem = 'Importação concluída!\n'
            'Empresas adicionadas: $empresasAdicionadas\n'
            'Empresas atualizadas: $empresasAtualizadas\n'
            'Setores adicionados: $setoresAdicionados\n'
            'Funções adicionadas: $funcoesAdicionadas\n'
            'Ignorados: $ignorados\n'
            'Erros: $erros';
      });
    } catch (e) {
      print('ERRO durante a importação: $e');
      setState(() {
        isLoading = false;
        statusMensagem = 'Erro durante a importação: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar Empresas'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner informativo sobre modelo
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Formato do arquivo de importação:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'O arquivo CSV deve conter colunas para: Nome Empresa, CNPJ, Cidade, Estado, ' +
                        'Setores e Funções.\n\n' +
                        'Nos campos "Setores" e "Funções", liste os itens separados por vírgulas.\n' +
                        'Exemplo: "Setor 1, Setor 2, Setor 3"',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),

            // 1. Seleção do arquivo
            Text(
              '1. Selecione o arquivo CSV',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : _selecionarArquivo,
                  child: const Text('Selecionar arquivo'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    nomeArquivo ?? 'Nenhum arquivo selecionado',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (arquivoSelecionado != null)
                  Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Prévia dos dados
            Text(
              '2. Verifique os dados',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (isLoading && dadosPrevia == null)
              Center(child: CircularProgressIndicator())
            else if (dadosPrevia != null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: List.generate(
                    dadosPrevia![0].length,
                    (index) => DataColumn(
                      label: Text(dadosPrevia![0][index].toString()),
                    ),
                  ),
                  rows: List.generate(
                    dadosPrevia!.length > 1 ? dadosPrevia!.length - 1 : 0,
                    (index) => DataRow(
                      cells: List.generate(
                        dadosPrevia![0].length,
                        (cellIndex) => DataCell(
                          Text(cellIndex < dadosPrevia![index + 1].length
                              ? dadosPrevia![index + 1][cellIndex].toString()
                              : ''),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Selecione um arquivo para visualizar a prévia'),
              ),

            // 3. Opções de importação
            const SizedBox(height: 24),
            Text(
              '3. Como lidar com empresas já existentes:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            RadioListTile<String>(
              title: const Text('Atualizar existentes e inserir novas'),
              subtitle: const Text(
                  'Comportamento recomendado: atualiza empresas existentes e adiciona novas'),
              value: 'atualizar_inserir',
              groupValue: opcaoDuplicados,
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        opcaoDuplicados = value!;
                      });
                    },
            ),
            RadioListTile<String>(
              title: const Text('Atualizar dados (manter 1 registro)'),
              subtitle:
                  const Text('Atualiza informações de empresas com mesmo nome'),
              value: 'substituir',
              groupValue: opcaoDuplicados,
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        opcaoDuplicados = value!;
                      });
                    },
            ),
            RadioListTile<String>(
              title: const Text('Ignorar empresas já existentes'),
              subtitle:
                  const Text('Mantém o registro existente sem alterações'),
              value: 'ignorar',
              groupValue: opcaoDuplicados,
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        opcaoDuplicados = value!;
                      });
                    },
            ),
            RadioListTile<String>(
              title: const Text('Permitir duplicatas'),
              subtitle: const Text('Insere novo registro mesmo com mesmo nome'),
              value: 'adicionar',
              groupValue: opcaoDuplicados,
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        opcaoDuplicados = value!;
                      });
                    },
            ),
            const SizedBox(height: 24),

            // 4. Botões de ação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (await _confirmarImportacao()) {
                            _importarDados();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('IMPORTAR DADOS'),
                ),
                OutlinedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text('CANCELAR'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 5. Progresso e status
            if (isLoading || progressoImportacao > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Progresso:'),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progressoImportacao,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text('${(progressoImportacao * 100).toStringAsFixed(1)}%'),
                ],
              ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              width: double.infinity,
              child: Text(
                statusMensagem,
                style: const TextStyle(fontFamily: 'Courier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
