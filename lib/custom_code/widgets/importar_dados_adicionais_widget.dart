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

class ImportarDadosAdicionaisWidget extends StatefulWidget {
  const ImportarDadosAdicionaisWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ImportarDadosAdicionaisWidget> createState() =>
      _ImportarDadosAdicionaisWidgetState();
}

class _ImportarDadosAdicionaisWidgetState
    extends State<ImportarDadosAdicionaisWidget> {
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
  String opcaoDuplicados =
      'substituir'; // Opções: 'substituir', 'ignorar', 'adicionar'

  // Mapeamento de agentes para mostrar ao usuário
  Map<int, String> mapaAgentes = {}; // ID -> Nome
  Map<String, int> mapaNomesAgentes = {}; // Nome -> ID (para busca inversa)
  bool agentesCarregados = false;

  @override
  void initState() {
    super.initState();
    // Carregar agentes disponíveis ao iniciar o widget
    _carregarAgentes();
  }

  // Carregar os agentes do banco de dados
  Future<void> _carregarAgentes() async {
    setState(() {
      isLoading = true;
      statusMensagem = 'Carregando agentes disponíveis...';
    });

    try {
      final db = await SQLiteManager.instance.database;

      // Consulta para buscar agentes
      final agentes = await db.query('agenteRisco',
          columns: ['id', 'nomeAgente'], orderBy: 'nomeAgente');

      // Criar mapeamentos ID -> Nome e Nome -> ID
      final mapaPorId = <int, String>{};
      final mapaPorNome = <String, int>{};

      for (final agente in agentes) {
        final id = agente['id'] as int;
        final nome = agente['nomeAgente'] as String;
        mapaPorId[id] = nome;
        mapaPorNome[nome.toLowerCase()] =
            id; // Usar lowercase para busca case-insensitive
      }

      setState(() {
        mapaAgentes = mapaPorId;
        mapaNomesAgentes = mapaPorNome;
        agentesCarregados = true;
        isLoading = false;
        statusMensagem = 'Agentes carregados: ${mapaPorId.length} disponíveis';
      });
    } catch (e) {
      print('Erro ao carregar agentes: $e');
      setState(() {
        isLoading = false;
        statusMensagem = 'Erro ao carregar agentes: $e';
      });
    }
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

    print(
        'Detectando delimitador -> Vírgulas: $virgulas, Ponto-e-vírgulas: $pontoVirgulas');

    // Escolhe o delimitador com mais ocorrências
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
              'Formato de arquivo inválido para Dados Adicionais. Cabeçalhos não correspondem ao esperado.';
          isLoading = false;
        });
        return;
      }

      // Obter prévia (até 5 linhas)
      final previa = linhas.length > 6 ? linhas.sublist(0, 6) : linhas;

      // Enriquecer a prévia com informações dos agentes
      if (agentesCarregados) {
        // Encontrar a coluna de agente (ID ou nome)
        int agenteIndex = -1;
        for (int i = 0; i < previa[0].length; i++) {
          final header = previa[0][i].toString().toLowerCase();
          if (header.contains('id do agente') || header.contains('agente_id')) {
            agenteIndex = i;
            break;
          }
        }

        // Se encontrarmos a coluna de ID do agente, adicionar coluna do nome (se não estiver já presente)
        if (agenteIndex >= 0) {
          bool temNomeAgente = false;
          for (int i = 0; i < previa[0].length; i++) {
            if (previa[0][i]
                .toString()
                .toLowerCase()
                .contains('nome do agente')) {
              temNomeAgente = true;
              break;
            }
          }

          if (!temNomeAgente) {
            // Adicionar cabeçalho para nome do agente
            previa[0].add("Nome do Agente");

            // Para cada linha, adicionar o nome do agente
            for (int i = 1; i < previa.length; i++) {
              if (previa[i].length > agenteIndex) {
                final idStr = previa[i][agenteIndex].toString().trim();
                if (idStr.isNotEmpty) {
                  try {
                    final id = int.parse(idStr);
                    final nome = mapaAgentes[id] ?? "Agente não encontrado";
                    previa[i].add(nome);
                  } catch (e) {
                    previa[i].add("ID inválido");
                  }
                } else {
                  previa[i].add("");
                }
              } else {
                previa[i].add("");
              }
            }
          }
        }
      }

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

  // Validar cabeçalhos para Dados Adicionais
  bool _validarCabecalhos(List<dynamic> cabecalhos) {
    // Campos mínimos necessários para Dados Adicionais
    final camposObrigatorios = ['descricao', 'agente_id'];

    // Campos opcionais
    final camposOpcionais = [
      'id',
      'acoes',
      'riscos',
      'sugestao',
      'sugestaoinicial'
    ];

    print('Validando cabeçalhos: $cabecalhos');

    // Converter cabeçalhos para lowercase para comparação
    final cabecalhosLowercase =
        cabecalhos.map((c) => c.toString().trim().toLowerCase()).toList();

    // Verificar se os campos obrigatórios estão presentes
    for (final campo in camposObrigatorios) {
      bool encontrado = false;
      for (final cabecalho in cabecalhosLowercase) {
        if (cabecalho.contains(campo) ||
            cabecalho.contains(campo.replaceAll('_', ' '))) {
          encontrado = true;
          break;
        }
      }

      if (!encontrado) {
        print('Campo obrigatório não encontrado: $campo');
        return false;
      }
    }

    // Verificar se pelo menos metade dos campos está presente
    int camposEncontrados = 0;
    List<String> todosCampos = [...camposObrigatorios, ...camposOpcionais];

    for (final campo in todosCampos) {
      for (final cabecalho in cabecalhosLowercase) {
        if (cabecalho.contains(campo) ||
            cabecalho.contains(campo.replaceAll('_', ' '))) {
          camposEncontrados++;
          break;
        }
      }
    }

    // Se temos pelo menos 3 dos campos esperados, consideramos válido
    return camposEncontrados >= 3;
  }

  // Obter ID do agente pelo nome
  int? _getAgenteIdPeloNome(String nomeAgente) {
    final nomeNormalizado = nomeAgente.trim().toLowerCase();
    return mapaNomesAgentes[nomeNormalizado];
  }

  // Importar dados
  Future<void> _importarDados() async {
    if (arquivoSelecionado == null || dadosPrevia == null) {
      setState(() {
        statusMensagem = 'Selecione um arquivo válido primeiro.';
      });
      return;
    }

    // Verificar se os agentes foram carregados
    if (!agentesCarregados) {
      await _carregarAgentes();
      if (!agentesCarregados) {
        setState(() {
          statusMensagem =
              'Não foi possível carregar os agentes. Verifique a conexão com o banco de dados.';
        });
        return;
      }
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
      int adicionados = 0;
      int atualizados = 0;
      int ignorados = 0;
      int erros = 0;

      // Identificar colunas para os campos
      final cabecalhos =
          linhas[0].map((c) => c.toString().trim().toLowerCase()).toList();

      int descricaoIdx = -1;
      int acoesIdx = -1;
      int riscosIdx = -1;
      int sugestaoIdx = -1;
      int agenteIdx = -1;

      // Encontrar índices das colunas
      for (int i = 0; i < cabecalhos.length; i++) {
        final cabecalho = cabecalhos[i];
        if (cabecalho.contains('descricao') ||
            cabecalho.contains('descrição')) {
          descricaoIdx = i;
        } else if (cabecalho.contains('acoes') || cabecalho.contains('ações')) {
          acoesIdx = i;
        } else if (cabecalho.contains('riscos')) {
          riscosIdx = i;
        } else if (cabecalho.contains('sugestao') ||
            cabecalho.contains('sugestão')) {
          sugestaoIdx = i;
        } else if (cabecalho.contains('agente_id') ||
            cabecalho.contains('id do agente')) {
          agenteIdx = i;
        }
      }

      if (descricaoIdx == -1 || agenteIdx == -1) {
        setState(() {
          statusMensagem =
              'Não foi possível identificar as colunas obrigatórias no CSV.';
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
          // Garantir que temos as colunas mínimas necessárias
          if (linha.length <= descricaoIdx || linha.length <= agenteIdx) {
            print('Linha $i tem colunas insuficientes: $linha');
            erros++;
            continue;
          }

          // Extrair dados obrigatórios
          final descricao = linha[descricaoIdx].toString().trim();
          final agenteValor = linha[agenteIdx].toString().trim();

          // Extrair dados opcionais (se existirem os índices)
          String acoes = acoesIdx >= 0 && linha.length > acoesIdx
              ? linha[acoesIdx].toString().trim()
              : '';
          String riscos = riscosIdx >= 0 && linha.length > riscosIdx
              ? linha[riscosIdx].toString().trim()
              : '';
          String sugestao = sugestaoIdx >= 0 && linha.length > sugestaoIdx
              ? linha[sugestaoIdx].toString().trim()
              : '';

          // Validação básica
          if (descricao.isEmpty) {
            print('Linha $i tem descrição vazia');
            erros++;
            continue;
          }

          // Processar o agente
          int? agenteId;

          if (agenteValor.isNotEmpty) {
            try {
              agenteId = int.parse(agenteValor);
              if (!mapaAgentes.containsKey(agenteId)) {
                print('Agente não encontrado com ID: $agenteId');
                erros++;
                continue;
              }
            } catch (e) {
              // Não é um número, pode ser o nome do agente
              agenteId = _getAgenteIdPeloNome(agenteValor);
              if (agenteId == null) {
                print('Agente não encontrado com nome: $agenteValor');
                erros++;
                continue;
              }
            }
          }

          // Verificar se o registro já existe (por descrição e agente)
          final existentes = await db.query(
            'DadosAdicionais',
            where: 'descricao = ? AND agente_id = ?',
            whereArgs: [descricao, agenteId],
          );

          // Criar mapa com valores a inserir/atualizar
          final dados = {
            'descricao': descricao,
            'agente_id': agenteId,
            'acoes': acoes.isNotEmpty ? acoes : null,
            'riscos': riscos.isNotEmpty ? riscos : null,
            'sugestaoInicial': sugestao.isNotEmpty ? sugestao : null,
          };

          if (existentes.isNotEmpty) {
            // Registro já existe
            switch (opcaoDuplicados) {
              case 'substituir':
                await db.update(
                  'DadosAdicionais',
                  dados,
                  where: 'ID = ?',
                  whereArgs: [existentes.first['ID']],
                );
                atualizados++;
                break;
              case 'ignorar':
                ignorados++;
                break;
              case 'adicionar':
                // Criar um novo registro
                await db.insert('DadosAdicionais', dados);
                adicionados++;
                break;
            }
          } else {
            // Novo registro
            await db.insert('DadosAdicionais', dados);
            adicionados++;
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
            'Adicionados: $adicionados\n'
            'Atualizados: $atualizados\n'
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
        title: const Text('Importar Dados Adicionais'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status dos agentes
            if (agentesCarregados)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${mapaAgentes.length} agentes disponíveis para importação',
                      ),
                    ),
                  ],
                ),
              )
            else if (isLoading && statusMensagem.contains('agentes'))
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 8),
                    Text('Carregando agentes...'),
                  ],
                ),
              )
            else if (!agentesCarregados)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Não foi possível carregar os agentes. A importação pode falhar.',
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: _carregarAgentes,
                      child: Text('Tentar novamente'),
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
                          Text(
                            dadosPrevia![index + 1][cellIndex].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
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

            // Nota sobre dados adicionais
            if (dadosPrevia != null)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Importante sobre Dados Adicionais:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Os campos obrigatórios são "Descrição" e "ID do Agente". Os demais '
                      'campos (Ações, Riscos e Sugestão Inicial) são opcionais.\n\n'
                      'Certifique-se que os IDs dos agentes correspondam aos existentes no sistema.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),

            // 3. Opções de importação
            Text(
              '3. Definir comportamento para duplicados:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            RadioListTile<String>(
              title: const Text('Substituir registros existentes'),
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
              title: const Text('Ignorar registros existentes'),
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
              title: const Text('Adicionar todos como novos registros'),
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
                  onPressed: isLoading ? null : _importarDados,
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
