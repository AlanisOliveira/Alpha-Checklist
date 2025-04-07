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

class ImportarAvaliadoresWidget extends StatefulWidget {
  const ImportarAvaliadoresWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ImportarAvaliadoresWidget> createState() =>
      _ImportarAvaliadoresWidgetState();
}

class _ImportarAvaliadoresWidgetState extends State<ImportarAvaliadoresWidget> {
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
              'Formato de arquivo inválido para Avaliadores. Verifique o modelo adequado.';
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

    // Verificar se temos pelo menos 3 colunas
    if (cabecalhosNormalizados.length < 3) {
      print('Número insuficiente de colunas: ${cabecalhosNormalizados.length}');
      return false;
    }

    // Verificar se contém as colunas necessárias
    bool temNome = cabecalhosNormalizados.any(
        (c) => c == 'nome' || c == 'nomeavaliador' || c == 'nome_avaliador');

    bool temCargo = cabecalhosNormalizados
        .any((c) => c == 'cargo' || c == 'funcao' || c == 'função');

    bool temProfissao = cabecalhosNormalizados.any(
        (c) => c == 'profissao' || c == 'profissão' || c == 'especialidade');

    print(
        'Tem nome: $temNome, Tem cargo: $temCargo, Tem profissão: $temProfissao');

    // Arquivo é válido se tiver pelo menos essas colunas
    return temNome && temCargo && temProfissao;
  }

  // Diálogo de confirmação antes da importação
  Future<bool> _confirmarImportacao() async {
    String mensagem = 'Avaliadores novos serão adicionados.';

    // Adicionar informação sobre duplicados
    switch (opcaoDuplicados) {
      case 'atualizar_inserir':
        mensagem +=
            '\n\nAvaliadores com nomes já existentes: serão atualizados com o novo cargo e profissão.';
        break;
      case 'substituir':
        mensagem +=
            '\n\nAvaliadores com nomes já existentes: serão atualizados com o novo cargo e profissão.';
        break;
      case 'ignorar':
        mensagem +=
            '\n\nAvaliadores com nomes já existentes: serão ignorados (mantidos como estão).';
        break;
      case 'adicionar':
        mensagem +=
            '\n\nAvaliadores com nomes já existentes: serão adicionados como novos registros (permitindo duplicatas).';
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
      int adicionados = 0;
      int atualizados = 0;
      int ignorados = 0;
      int erros = 0;

      // Identificar índices das colunas
      List<String> cabecalhos =
          linhas[0].map((c) => c.toString().toLowerCase().trim()).toList();

      int nomeIndex = cabecalhos.indexWhere(
          (c) => c == 'nome' || c == 'nomeavaliador' || c == 'nome_avaliador');

      int cargoIndex = cabecalhos
          .indexWhere((c) => c == 'cargo' || c == 'funcao' || c == 'função');

      int profissaoIndex = cabecalhos.indexWhere(
          (c) => c == 'profissao' || c == 'profissão' || c == 'especialidade');

      print(
          'Índices: Nome=$nomeIndex, Cargo=$cargoIndex, Profissão=$profissaoIndex');

      if (nomeIndex < 0 || cargoIndex < 0 || profissaoIndex < 0) {
        setState(() {
          statusMensagem =
              'Formato do arquivo inválido. Certifique-se de que há colunas para Nome, Cargo e Profissão.';
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
          // Encontrar o maior índice necessário
          int maiorIndice = nomeIndex;
          if (cargoIndex > maiorIndice) maiorIndice = cargoIndex;
          if (profissaoIndex > maiorIndice) maiorIndice = profissaoIndex;

          if (linha.length <= maiorIndice) {
            print('Linha $i não tem colunas suficientes');
            erros++;
            continue;
          }

          // Extrair dados
          final nome = linha[nomeIndex].toString().trim();
          final cargo = linha[cargoIndex].toString().trim();
          final profissao = linha[profissaoIndex].toString().trim();

          // Validação básica
          if (nome.isEmpty) {
            print('Linha $i tem nome vazio');
            erros++;
            continue;
          }

          // LÓGICA DE TRATAMENTO DE DUPLICADOS
          switch (opcaoDuplicados) {
            case 'atualizar_inserir':
              // Verificar se o avaliador já existe por nome
              final existentes = await db.query(
                'avaliadores',
                where: 'nome = ?',
                whereArgs: [nome],
              );

              if (existentes.isNotEmpty) {
                // Atualiza se já existir
                await db.update(
                  'avaliadores',
                  {
                    'cargo': cargo,
                    'profissao': profissao,
                  },
                  where: 'id = ?',
                  whereArgs: [existentes.first['id']],
                );
                atualizados++;
              } else {
                // Insere se for novo
                await db.insert('avaliadores', {
                  'nome': nome,
                  'cargo': cargo,
                  'profissao': profissao,
                });
                adicionados++;
              }
              break;

            case 'substituir':
              // Verificar se o avaliador já existe por nome
              final existentes = await db.query(
                'avaliadores',
                where: 'nome = ?',
                whereArgs: [nome],
              );

              if (existentes.isNotEmpty) {
                // Atualiza se já existir
                await db.update(
                  'avaliadores',
                  {
                    'cargo': cargo,
                    'profissao': profissao,
                  },
                  where: 'id = ?',
                  whereArgs: [existentes.first['id']],
                );
                atualizados++;
              } else {
                // Insere se for novo
                await db.insert('avaliadores', {
                  'nome': nome,
                  'cargo': cargo,
                  'profissao': profissao,
                });
                adicionados++;
              }
              break;

            case 'ignorar':
              // Verificar se o avaliador já existe por nome
              final existentes = await db.query(
                'avaliadores',
                where: 'nome = ?',
                whereArgs: [nome],
              );

              if (existentes.isNotEmpty) {
                // Ignora se já existir
                ignorados++;
              } else {
                // Insere se for novo
                await db.insert('avaliadores', {
                  'nome': nome,
                  'cargo': cargo,
                  'profissao': profissao,
                });
                adicionados++;
              }
              break;

            case 'adicionar':
              // Sempre adiciona como novo, independente se já existe
              await db.insert('avaliadores', {
                'nome': nome,
                'cargo': cargo,
                'profissao': profissao,
              });
              adicionados++;
              break;
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
        title: const Text('Importar Avaliadores'),
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
                    'O arquivo CSV deve conter colunas para: Nome, Cargo e Profissão.\n'
                    'IDs serão gerados automaticamente pelo sistema.',
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
              '3. Como lidar com avaliadores já existentes:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            RadioListTile<String>(
              title: const Text('Atualizar existentes e inserir novos'),
              subtitle: const Text(
                  'Comportamento recomendado: atualiza avaliadores existentes e adiciona novos'),
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
              subtitle: const Text(
                  'Atualiza cargo e profissão de avaliadores com mesmo nome'),
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
              title: const Text('Ignorar avaliadores já existentes'),
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
