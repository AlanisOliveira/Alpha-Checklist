import 'package:flutter/material.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _nomeEmpresaPreselecao =
          prefs.getString('ff_nomeEmpresaPreselecao') ?? _nomeEmpresaPreselecao;
    });
    _safeInit(() {
      _listadePreselecoes =
          prefs.getStringList('ff_listadePreselecoes')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _listadePreselecoes;
    });
    _safeInit(() {
      _isSearched = prefs.getBool('ff_isSearched') ?? _isSearched;
    });
    _safeInit(() {
      _Listapreselecaoquimico =
          prefs.getStringList('ff_Listapreselecaoquimico') ??
              _Listapreselecaoquimico;
    });
    _safeInit(() {
      _ListaPreSelecaoBiologico =
          prefs.getStringList('ff_ListaPreSelecaoBiologico') ??
              _ListaPreSelecaoBiologico;
    });
    _safeInit(() {
      _ListaPreSelecaoErgonomico =
          prefs.getStringList('ff_ListaPreSelecaoErgonomico') ??
              _ListaPreSelecaoErgonomico;
    });
    _safeInit(() {
      _ListaPreSelecaoAcidente =
          prefs.getStringList('ff_ListaPreSelecaoAcidente') ??
              _ListaPreSelecaoAcidente;
    });
    _safeInit(() {
      _listaFisicosMensal =
          prefs.getStringList('ff_listaFisicosMensal') ?? _listaFisicosMensal;
    });
    _safeInit(() {
      _listaQuimicoMensais =
          prefs.getStringList('ff_listaQuimicoMensais') ?? _listaQuimicoMensais;
    });
    _safeInit(() {
      _listaBiologicosMensais =
          prefs.getStringList('ff_listaBiologicosMensais') ??
              _listaBiologicosMensais;
    });
    _safeInit(() {
      _listaErgonomicosMensais =
          prefs.getStringList('ff_listaErgonomicosMensais') ??
              _listaErgonomicosMensais;
    });
    _safeInit(() {
      _listaAcidentesMensais =
          prefs.getStringList('ff_listaAcidentesMensais') ??
              _listaAcidentesMensais;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// Página de descrição de ambiente de trabalho
  List<String> _ambienteTagList = [];
  List<String> get ambienteTagList => _ambienteTagList;
  set ambienteTagList(List<String> value) {
    _ambienteTagList = value;
  }

  void addToAmbienteTagList(String value) {
    ambienteTagList.add(value);
  }

  void removeFromAmbienteTagList(String value) {
    ambienteTagList.remove(value);
  }

  void removeAtIndexFromAmbienteTagList(int index) {
    ambienteTagList.removeAt(index);
  }

  void updateAmbienteTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ambienteTagList[index] = updateFn(_ambienteTagList[index]);
  }

  void insertAtIndexInAmbienteTagList(int index, String value) {
    ambienteTagList.insert(index, value);
  }

  /// Página de descrição de ambiente de trabalho
  List<String> _PisoTagList = [];
  List<String> get PisoTagList => _PisoTagList;
  set PisoTagList(List<String> value) {
    _PisoTagList = value;
  }

  void addToPisoTagList(String value) {
    PisoTagList.add(value);
  }

  void removeFromPisoTagList(String value) {
    PisoTagList.remove(value);
  }

  void removeAtIndexFromPisoTagList(int index) {
    PisoTagList.removeAt(index);
  }

  void updatePisoTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    PisoTagList[index] = updateFn(_PisoTagList[index]);
  }

  void insertAtIndexInPisoTagList(int index, String value) {
    PisoTagList.insert(index, value);
  }

  /// Página de descrição de ambiente de trabalho
  List<String> _ParedeTagList = [];
  List<String> get ParedeTagList => _ParedeTagList;
  set ParedeTagList(List<String> value) {
    _ParedeTagList = value;
  }

  void addToParedeTagList(String value) {
    ParedeTagList.add(value);
  }

  void removeFromParedeTagList(String value) {
    ParedeTagList.remove(value);
  }

  void removeAtIndexFromParedeTagList(int index) {
    ParedeTagList.removeAt(index);
  }

  void updateParedeTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ParedeTagList[index] = updateFn(_ParedeTagList[index]);
  }

  void insertAtIndexInParedeTagList(int index, String value) {
    ParedeTagList.insert(index, value);
  }

  /// Página de descrição de ambiente de trabalho
  List<String> _CoberturaTagList = [];
  List<String> get CoberturaTagList => _CoberturaTagList;
  set CoberturaTagList(List<String> value) {
    _CoberturaTagList = value;
  }

  void addToCoberturaTagList(String value) {
    CoberturaTagList.add(value);
  }

  void removeFromCoberturaTagList(String value) {
    CoberturaTagList.remove(value);
  }

  void removeAtIndexFromCoberturaTagList(int index) {
    CoberturaTagList.removeAt(index);
  }

  void updateCoberturaTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    CoberturaTagList[index] = updateFn(_CoberturaTagList[index]);
  }

  void insertAtIndexInCoberturaTagList(int index, String value) {
    CoberturaTagList.insert(index, value);
  }

  /// Página de descrição de ambiente de trabalho
  List<String> _IluminacaoTagList = [];
  List<String> get IluminacaoTagList => _IluminacaoTagList;
  set IluminacaoTagList(List<String> value) {
    _IluminacaoTagList = value;
  }

  void addToIluminacaoTagList(String value) {
    IluminacaoTagList.add(value);
  }

  void removeFromIluminacaoTagList(String value) {
    IluminacaoTagList.remove(value);
  }

  void removeAtIndexFromIluminacaoTagList(int index) {
    IluminacaoTagList.removeAt(index);
  }

  void updateIluminacaoTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    IluminacaoTagList[index] = updateFn(_IluminacaoTagList[index]);
  }

  void insertAtIndexInIluminacaoTagList(int index, String value) {
    IluminacaoTagList.insert(index, value);
  }

  /// Página de descrição de ambiente de trabalho
  List<String> _VentilacaoTagList = [];
  List<String> get VentilacaoTagList => _VentilacaoTagList;
  set VentilacaoTagList(List<String> value) {
    _VentilacaoTagList = value;
  }

  void addToVentilacaoTagList(String value) {
    VentilacaoTagList.add(value);
  }

  void removeFromVentilacaoTagList(String value) {
    VentilacaoTagList.remove(value);
  }

  void removeAtIndexFromVentilacaoTagList(int index) {
    VentilacaoTagList.removeAt(index);
  }

  void updateVentilacaoTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    VentilacaoTagList[index] = updateFn(_VentilacaoTagList[index]);
  }

  void insertAtIndexInVentilacaoTagList(int index, String value) {
    VentilacaoTagList.insert(index, value);
  }

  List<String> _PoliticasList = [];
  List<String> get PoliticasList => _PoliticasList;
  set PoliticasList(List<String> value) {
    _PoliticasList = value;
  }

  void addToPoliticasList(String value) {
    PoliticasList.add(value);
  }

  void removeFromPoliticasList(String value) {
    PoliticasList.remove(value);
  }

  void removeAtIndexFromPoliticasList(int index) {
    PoliticasList.removeAt(index);
  }

  void updatePoliticasListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    PoliticasList[index] = updateFn(_PoliticasList[index]);
  }

  void insertAtIndexInPoliticasList(int index, String value) {
    PoliticasList.insert(index, value);
  }

  List<String> _PavimentoList = [];
  List<String> get PavimentoList => _PavimentoList;
  set PavimentoList(List<String> value) {
    _PavimentoList = value;
  }

  void addToPavimentoList(String value) {
    PavimentoList.add(value);
  }

  void removeFromPavimentoList(String value) {
    PavimentoList.remove(value);
  }

  void removeAtIndexFromPavimentoList(int index) {
    PavimentoList.removeAt(index);
  }

  void updatePavimentoListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    PavimentoList[index] = updateFn(_PavimentoList[index]);
  }

  void insertAtIndexInPavimentoList(int index, String value) {
    PavimentoList.insert(index, value);
  }

  List<String> _MaquinaseEquipamentosList = [];
  List<String> get MaquinaseEquipamentosList => _MaquinaseEquipamentosList;
  set MaquinaseEquipamentosList(List<String> value) {
    _MaquinaseEquipamentosList = value;
  }

  void addToMaquinaseEquipamentosList(String value) {
    MaquinaseEquipamentosList.add(value);
  }

  void removeFromMaquinaseEquipamentosList(String value) {
    MaquinaseEquipamentosList.remove(value);
  }

  void removeAtIndexFromMaquinaseEquipamentosList(int index) {
    MaquinaseEquipamentosList.removeAt(index);
  }

  void updateMaquinaseEquipamentosListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    MaquinaseEquipamentosList[index] =
        updateFn(_MaquinaseEquipamentosList[index]);
  }

  void insertAtIndexInMaquinaseEquipamentosList(int index, String value) {
    MaquinaseEquipamentosList.insert(index, value);
  }

  List<String> _ProtecaoIncendioList = [];
  List<String> get ProtecaoIncendioList => _ProtecaoIncendioList;
  set ProtecaoIncendioList(List<String> value) {
    _ProtecaoIncendioList = value;
  }

  void addToProtecaoIncendioList(String value) {
    ProtecaoIncendioList.add(value);
  }

  void removeFromProtecaoIncendioList(String value) {
    ProtecaoIncendioList.remove(value);
  }

  void removeAtIndexFromProtecaoIncendioList(int index) {
    ProtecaoIncendioList.removeAt(index);
  }

  void updateProtecaoIncendioListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ProtecaoIncendioList[index] = updateFn(_ProtecaoIncendioList[index]);
  }

  void insertAtIndexInProtecaoIncendioList(int index, String value) {
    ProtecaoIncendioList.insert(index, value);
  }

  String _outrosProgramas = '';
  String get outrosProgramas => _outrosProgramas;
  set outrosProgramas(String value) {
    _outrosProgramas = value;
  }

  String _Setor = '';
  String get Setor => _Setor;
  set Setor(String value) {
    _Setor = value;
  }

  List<String> _Funcao = [];
  List<String> get Funcao => _Funcao;
  set Funcao(List<String> value) {
    _Funcao = value;
  }

  void addToFuncao(String value) {
    Funcao.add(value);
  }

  void removeFromFuncao(String value) {
    Funcao.remove(value);
  }

  void removeAtIndexFromFuncao(int index) {
    Funcao.removeAt(index);
  }

  void updateFuncaoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    Funcao[index] = updateFn(_Funcao[index]);
  }

  void insertAtIndexInFuncao(int index, String value) {
    Funcao.insert(index, value);
  }

  String _nomePDF = '';
  String get nomePDF => _nomePDF;
  set nomePDF(String value) {
    _nomePDF = value;
  }

  String _nomeEmpresa = '';
  String get nomeEmpresa => _nomeEmpresa;
  set nomeEmpresa(String value) {
    _nomeEmpresa = value;
  }

  String _Avaliador = '';
  String get Avaliador => _Avaliador;
  set Avaliador(String value) {
    _Avaliador = value;
  }

  List<String> _NomeColaboradores = [];
  List<String> get NomeColaboradores => _NomeColaboradores;
  set NomeColaboradores(List<String> value) {
    _NomeColaboradores = value;
  }

  void addToNomeColaboradores(String value) {
    NomeColaboradores.add(value);
  }

  void removeFromNomeColaboradores(String value) {
    NomeColaboradores.remove(value);
  }

  void removeAtIndexFromNomeColaboradores(int index) {
    NomeColaboradores.removeAt(index);
  }

  void updateNomeColaboradoresAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    NomeColaboradores[index] = updateFn(_NomeColaboradores[index]);
  }

  void insertAtIndexInNomeColaboradores(int index, String value) {
    NomeColaboradores.insert(index, value);
  }

  String _nomeAgenteAvaliacao = '';
  String get nomeAgenteAvaliacao => _nomeAgenteAvaliacao;
  set nomeAgenteAvaliacao(String value) {
    _nomeAgenteAvaliacao = value;
  }

  String _DescColaboradores = '';
  String get DescColaboradores => _DescColaboradores;
  set DescColaboradores(String value) {
    _DescColaboradores = value;
  }

  String _DescAgravos = '';
  String get DescAgravos => _DescAgravos;
  set DescAgravos(String value) {
    _DescAgravos = value;
  }

  String _DescEPIs = '';
  String get DescEPIs => _DescEPIs;
  set DescEPIs(String value) {
    _DescEPIs = value;
  }

  dynamic _DadosRiscos;
  dynamic get DadosRiscos => _DadosRiscos;
  set DadosRiscos(dynamic value) {
    _DadosRiscos = value;
  }

  String _DescricaoRisco = '';
  String get DescricaoRisco => _DescricaoRisco;
  set DescricaoRisco(String value) {
    _DescricaoRisco = value;
  }

  List<String> _TipoDeAmbiente = [];
  List<String> get TipoDeAmbiente => _TipoDeAmbiente;
  set TipoDeAmbiente(List<String> value) {
    _TipoDeAmbiente = value;
  }

  void addToTipoDeAmbiente(String value) {
    TipoDeAmbiente.add(value);
  }

  void removeFromTipoDeAmbiente(String value) {
    TipoDeAmbiente.remove(value);
  }

  void removeAtIndexFromTipoDeAmbiente(int index) {
    TipoDeAmbiente.removeAt(index);
  }

  void updateTipoDeAmbienteAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    TipoDeAmbiente[index] = updateFn(_TipoDeAmbiente[index]);
  }

  void insertAtIndexInTipoDeAmbiente(int index, String value) {
    TipoDeAmbiente.insert(index, value);
  }

  List<dynamic> _ListadeRiscos = [];
  List<dynamic> get ListadeRiscos => _ListadeRiscos;
  set ListadeRiscos(List<dynamic> value) {
    _ListadeRiscos = value;
  }

  void addToListadeRiscos(dynamic value) {
    ListadeRiscos.add(value);
  }

  void removeFromListadeRiscos(dynamic value) {
    ListadeRiscos.remove(value);
  }

  void removeAtIndexFromListadeRiscos(int index) {
    ListadeRiscos.removeAt(index);
  }

  void updateListadeRiscosAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    ListadeRiscos[index] = updateFn(_ListadeRiscos[index]);
  }

  void insertAtIndexInListadeRiscos(int index, dynamic value) {
    ListadeRiscos.insert(index, value);
  }

  bool _delete = false;
  bool get delete => _delete;
  set delete(bool value) {
    _delete = value;
  }

  bool _cancel = false;
  bool get cancel => _cancel;
  set cancel(bool value) {
    _cancel = value;
  }

  List<dynamic> _Assinaturas = [];
  List<dynamic> get Assinaturas => _Assinaturas;
  set Assinaturas(List<dynamic> value) {
    _Assinaturas = value;
  }

  void addToAssinaturas(dynamic value) {
    Assinaturas.add(value);
  }

  void removeFromAssinaturas(dynamic value) {
    Assinaturas.remove(value);
  }

  void removeAtIndexFromAssinaturas(int index) {
    Assinaturas.removeAt(index);
  }

  void updateAssinaturasAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    Assinaturas[index] = updateFn(_Assinaturas[index]);
  }

  void insertAtIndexInAssinaturas(int index, dynamic value) {
    Assinaturas.insert(index, value);
  }

  List<String> _imagemLista = [];
  List<String> get imagemLista => _imagemLista;
  set imagemLista(List<String> value) {
    _imagemLista = value;
  }

  void addToImagemLista(String value) {
    imagemLista.add(value);
  }

  void removeFromImagemLista(String value) {
    imagemLista.remove(value);
  }

  void removeAtIndexFromImagemLista(int index) {
    imagemLista.removeAt(index);
  }

  void updateImagemListaAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    imagemLista[index] = updateFn(_imagemLista[index]);
  }

  void insertAtIndexInImagemLista(int index, String value) {
    imagemLista.insert(index, value);
  }

  String _tempoUtilizado = '';
  String get tempoUtilizado => _tempoUtilizado;
  set tempoUtilizado(String value) {
    _tempoUtilizado = value;
  }

  String _base64lmage = '';
  String get base64lmage => _base64lmage;
  set base64lmage(String value) {
    _base64lmage = value;
  }

  String _descricaoImagem = '';
  String get descricaoImagem => _descricaoImagem;
  set descricaoImagem(String value) {
    _descricaoImagem = value;
  }

  String _Base64Signature = '';
  String get Base64Signature => _Base64Signature;
  set Base64Signature(String value) {
    _Base64Signature = value;
  }

  String _nomeColaboradorSignature = '';
  String get nomeColaboradorSignature => _nomeColaboradorSignature;
  set nomeColaboradorSignature(String value) {
    _nomeColaboradorSignature = value;
  }

  List<String> _setoresCadastro = [];
  List<String> get setoresCadastro => _setoresCadastro;
  set setoresCadastro(List<String> value) {
    _setoresCadastro = value;
  }

  void addToSetoresCadastro(String value) {
    setoresCadastro.add(value);
  }

  void removeFromSetoresCadastro(String value) {
    setoresCadastro.remove(value);
  }

  void removeAtIndexFromSetoresCadastro(int index) {
    setoresCadastro.removeAt(index);
  }

  void updateSetoresCadastroAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    setoresCadastro[index] = updateFn(_setoresCadastro[index]);
  }

  void insertAtIndexInSetoresCadastro(int index, String value) {
    setoresCadastro.insert(index, value);
  }

  List<String> _funcoesCadastro = [];
  List<String> get funcoesCadastro => _funcoesCadastro;
  set funcoesCadastro(List<String> value) {
    _funcoesCadastro = value;
  }

  void addToFuncoesCadastro(String value) {
    funcoesCadastro.add(value);
  }

  void removeFromFuncoesCadastro(String value) {
    funcoesCadastro.remove(value);
  }

  void removeAtIndexFromFuncoesCadastro(int index) {
    funcoesCadastro.removeAt(index);
  }

  void updateFuncoesCadastroAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    funcoesCadastro[index] = updateFn(_funcoesCadastro[index]);
  }

  void insertAtIndexInFuncoesCadastro(int index, String value) {
    funcoesCadastro.insert(index, value);
  }

  List<String> _ListaPreselecaoFisico = [];
  List<String> get ListaPreselecaoFisico => _ListaPreselecaoFisico;
  set ListaPreselecaoFisico(List<String> value) {
    _ListaPreselecaoFisico = value;
  }

  void addToListaPreselecaoFisico(String value) {
    ListaPreselecaoFisico.add(value);
  }

  void removeFromListaPreselecaoFisico(String value) {
    ListaPreselecaoFisico.remove(value);
  }

  void removeAtIndexFromListaPreselecaoFisico(int index) {
    ListaPreselecaoFisico.removeAt(index);
  }

  void updateListaPreselecaoFisicoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ListaPreselecaoFisico[index] = updateFn(_ListaPreselecaoFisico[index]);
  }

  void insertAtIndexInListaPreselecaoFisico(int index, String value) {
    ListaPreselecaoFisico.insert(index, value);
  }

  String _nomeEmpresaPreselecao = '';
  String get nomeEmpresaPreselecao => _nomeEmpresaPreselecao;
  set nomeEmpresaPreselecao(String value) {
    _nomeEmpresaPreselecao = value;
    prefs.setString('ff_nomeEmpresaPreselecao', value);
  }

  List<dynamic> _listadePreselecoes = [];
  List<dynamic> get listadePreselecoes => _listadePreselecoes;
  set listadePreselecoes(List<dynamic> value) {
    _listadePreselecoes = value;
    prefs.setStringList(
        'ff_listadePreselecoes', value.map((x) => jsonEncode(x)).toList());
  }

  void addToListadePreselecoes(dynamic value) {
    listadePreselecoes.add(value);
    prefs.setStringList('ff_listadePreselecoes',
        _listadePreselecoes.map((x) => jsonEncode(x)).toList());
  }

  void removeFromListadePreselecoes(dynamic value) {
    listadePreselecoes.remove(value);
    prefs.setStringList('ff_listadePreselecoes',
        _listadePreselecoes.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromListadePreselecoes(int index) {
    listadePreselecoes.removeAt(index);
    prefs.setStringList('ff_listadePreselecoes',
        _listadePreselecoes.map((x) => jsonEncode(x)).toList());
  }

  void updateListadePreselecoesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    listadePreselecoes[index] = updateFn(_listadePreselecoes[index]);
    prefs.setStringList('ff_listadePreselecoes',
        _listadePreselecoes.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInListadePreselecoes(int index, dynamic value) {
    listadePreselecoes.insert(index, value);
    prefs.setStringList('ff_listadePreselecoes',
        _listadePreselecoes.map((x) => jsonEncode(x)).toList());
  }

  String _nomeUpdateAgente = '';
  String get nomeUpdateAgente => _nomeUpdateAgente;
  set nomeUpdateAgente(String value) {
    _nomeUpdateAgente = value;
  }

  int _idAgente = 0;
  int get idAgente => _idAgente;
  set idAgente(int value) {
    _idAgente = value;
  }

  String _espacoConfinado = '';
  String get espacoConfinado => _espacoConfinado;
  set espacoConfinado(String value) {
    _espacoConfinado = value;
  }

  String _treinamentoNR33 = '';
  String get treinamentoNR33 => _treinamentoNR33;
  set treinamentoNR33(String value) {
    _treinamentoNR33 = value;
  }

  DateTime? _dataNr33;
  DateTime? get dataNr33 => _dataNr33;
  set dataNr33(DateTime? value) {
    _dataNr33 = value;
  }

  String _descricaoNR33 = '';
  String get descricaoNR33 => _descricaoNR33;
  set descricaoNR33(String value) {
    _descricaoNR33 = value;
  }

  String _trabalhoAltura = '';
  String get trabalhoAltura => _trabalhoAltura;
  set trabalhoAltura(String value) {
    _trabalhoAltura = value;
  }

  String _treinamentoNR35 = '';
  String get treinamentoNR35 => _treinamentoNR35;
  set treinamentoNR35(String value) {
    _treinamentoNR35 = value;
  }

  String _descricaoNR35 = '';
  String get descricaoNR35 => _descricaoNR35;
  set descricaoNR35(String value) {
    _descricaoNR35 = value;
  }

  DateTime? _dataNR35;
  DateTime? get dataNR35 => _dataNR35;
  set dataNR35(DateTime? value) {
    _dataNR35 = value;
  }

  String _trabalhoEletricidade = '';
  String get trabalhoEletricidade => _trabalhoEletricidade;
  set trabalhoEletricidade(String value) {
    _trabalhoEletricidade = value;
  }

  String _treinamentoNR10 = '';
  String get treinamentoNR10 => _treinamentoNR10;
  set treinamentoNR10(String value) {
    _treinamentoNR10 = value;
  }

  String _descricaoNR10 = '';
  String get descricaoNR10 => _descricaoNR10;
  set descricaoNR10(String value) {
    _descricaoNR10 = value;
  }

  String _conducaoVeiculos = '';
  String get conducaoVeiculos => _conducaoVeiculos;
  set conducaoVeiculos(String value) {
    _conducaoVeiculos = value;
  }

  String _treinamentoDirecao = '';
  String get treinamentoDirecao => _treinamentoDirecao;
  set treinamentoDirecao(String value) {
    _treinamentoDirecao = value;
  }

  String _descricaoDirecao = '';
  String get descricaoDirecao => _descricaoDirecao;
  set descricaoDirecao(String value) {
    _descricaoDirecao = value;
  }

  String _operacaoEquipamento = '';
  String get operacaoEquipamento => _operacaoEquipamento;
  set operacaoEquipamento(String value) {
    _operacaoEquipamento = value;
  }

  String _treinamentoOperacao = '';
  String get treinamentoOperacao => _treinamentoOperacao;
  set treinamentoOperacao(String value) {
    _treinamentoOperacao = value;
  }

  DateTime? _dataDirecao;
  DateTime? get dataDirecao => _dataDirecao;
  set dataDirecao(DateTime? value) {
    _dataDirecao = value;
  }

  DateTime? _dataNR10;
  DateTime? get dataNR10 => _dataNR10;
  set dataNR10(DateTime? value) {
    _dataNR10 = value;
  }

  DateTime? _dataOperacao;
  DateTime? get dataOperacao => _dataOperacao;
  set dataOperacao(DateTime? value) {
    _dataOperacao = value;
  }

  String _descricaoOperacao = '';
  String get descricaoOperacao => _descricaoOperacao;
  set descricaoOperacao(String value) {
    _descricaoOperacao = value;
  }

  String _aposentadoriaEspecial = '';
  String get aposentadoriaEspecial => _aposentadoriaEspecial;
  set aposentadoriaEspecial(String value) {
    _aposentadoriaEspecial = value;
  }

  List<String> _Possivel = [];
  List<String> get Possivel => _Possivel;
  set Possivel(List<String> value) {
    _Possivel = value;
  }

  void addToPossivel(String value) {
    Possivel.add(value);
  }

  void removeFromPossivel(String value) {
    Possivel.remove(value);
  }

  void removeAtIndexFromPossivel(int index) {
    Possivel.removeAt(index);
  }

  void updatePossivelAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    Possivel[index] = updateFn(_Possivel[index]);
  }

  void insertAtIndexInPossivel(int index, String value) {
    Possivel.insert(index, value);
  }

  String _cartaoIdentificacao = '';
  String get cartaoIdentificacao => _cartaoIdentificacao;
  set cartaoIdentificacao(String value) {
    _cartaoIdentificacao = value;
  }

  String _observacoes = '';
  String get observacoes => _observacoes;
  set observacoes(String value) {
    _observacoes = value;
  }

  String _nomeTipoAvaliacao = '';
  String get nomeTipoAvaliacao => _nomeTipoAvaliacao;
  set nomeTipoAvaliacao(String value) {
    _nomeTipoAvaliacao = value;
  }

  bool _isSearched = false;
  bool get isSearched => _isSearched;
  set isSearched(bool value) {
    _isSearched = value;
    prefs.setBool('ff_isSearched', value);
  }

  dynamic _PreSelecoes;
  dynamic get PreSelecoes => _PreSelecoes;
  set PreSelecoes(dynamic value) {
    _PreSelecoes = value;
  }

  int _idEPC = 0;
  int get idEPC => _idEPC;
  set idEPC(int value) {
    _idEPC = value;
  }

  String _updateEPC = '';
  String get updateEPC => _updateEPC;
  set updateEPC(String value) {
    _updateEPC = value;
  }

  String _updateEPI = '';
  String get updateEPI => _updateEPI;
  set updateEPI(String value) {
    _updateEPI = value;
  }

  int _idEPI = 0;
  int get idEPI => _idEPI;
  set idEPI(int value) {
    _idEPI = value;
  }

  String _updateMedidas = '';
  String get updateMedidas => _updateMedidas;
  set updateMedidas(String value) {
    _updateMedidas = value;
  }

  int _idMedida = 0;
  int get idMedida => _idMedida;
  set idMedida(int value) {
    _idMedida = value;
  }

  List<String> _Listapreselecaoquimico = [];
  List<String> get Listapreselecaoquimico => _Listapreselecaoquimico;
  set Listapreselecaoquimico(List<String> value) {
    _Listapreselecaoquimico = value;
    prefs.setStringList('ff_Listapreselecaoquimico', value);
  }

  void addToListapreselecaoquimico(String value) {
    Listapreselecaoquimico.add(value);
    prefs.setStringList('ff_Listapreselecaoquimico', _Listapreselecaoquimico);
  }

  void removeFromListapreselecaoquimico(String value) {
    Listapreselecaoquimico.remove(value);
    prefs.setStringList('ff_Listapreselecaoquimico', _Listapreselecaoquimico);
  }

  void removeAtIndexFromListapreselecaoquimico(int index) {
    Listapreselecaoquimico.removeAt(index);
    prefs.setStringList('ff_Listapreselecaoquimico', _Listapreselecaoquimico);
  }

  void updateListapreselecaoquimicoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    Listapreselecaoquimico[index] = updateFn(_Listapreselecaoquimico[index]);
    prefs.setStringList('ff_Listapreselecaoquimico', _Listapreselecaoquimico);
  }

  void insertAtIndexInListapreselecaoquimico(int index, String value) {
    Listapreselecaoquimico.insert(index, value);
    prefs.setStringList('ff_Listapreselecaoquimico', _Listapreselecaoquimico);
  }

  List<String> _ListaPreSelecaoBiologico = [];
  List<String> get ListaPreSelecaoBiologico => _ListaPreSelecaoBiologico;
  set ListaPreSelecaoBiologico(List<String> value) {
    _ListaPreSelecaoBiologico = value;
    prefs.setStringList('ff_ListaPreSelecaoBiologico', value);
  }

  void addToListaPreSelecaoBiologico(String value) {
    ListaPreSelecaoBiologico.add(value);
    prefs.setStringList(
        'ff_ListaPreSelecaoBiologico', _ListaPreSelecaoBiologico);
  }

  void removeFromListaPreSelecaoBiologico(String value) {
    ListaPreSelecaoBiologico.remove(value);
    prefs.setStringList(
        'ff_ListaPreSelecaoBiologico', _ListaPreSelecaoBiologico);
  }

  void removeAtIndexFromListaPreSelecaoBiologico(int index) {
    ListaPreSelecaoBiologico.removeAt(index);
    prefs.setStringList(
        'ff_ListaPreSelecaoBiologico', _ListaPreSelecaoBiologico);
  }

  void updateListaPreSelecaoBiologicoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ListaPreSelecaoBiologico[index] =
        updateFn(_ListaPreSelecaoBiologico[index]);
    prefs.setStringList(
        'ff_ListaPreSelecaoBiologico', _ListaPreSelecaoBiologico);
  }

  void insertAtIndexInListaPreSelecaoBiologico(int index, String value) {
    ListaPreSelecaoBiologico.insert(index, value);
    prefs.setStringList(
        'ff_ListaPreSelecaoBiologico', _ListaPreSelecaoBiologico);
  }

  List<String> _ListaPreSelecaoErgonomico = [];
  List<String> get ListaPreSelecaoErgonomico => _ListaPreSelecaoErgonomico;
  set ListaPreSelecaoErgonomico(List<String> value) {
    _ListaPreSelecaoErgonomico = value;
    prefs.setStringList('ff_ListaPreSelecaoErgonomico', value);
  }

  void addToListaPreSelecaoErgonomico(String value) {
    ListaPreSelecaoErgonomico.add(value);
    prefs.setStringList(
        'ff_ListaPreSelecaoErgonomico', _ListaPreSelecaoErgonomico);
  }

  void removeFromListaPreSelecaoErgonomico(String value) {
    ListaPreSelecaoErgonomico.remove(value);
    prefs.setStringList(
        'ff_ListaPreSelecaoErgonomico', _ListaPreSelecaoErgonomico);
  }

  void removeAtIndexFromListaPreSelecaoErgonomico(int index) {
    ListaPreSelecaoErgonomico.removeAt(index);
    prefs.setStringList(
        'ff_ListaPreSelecaoErgonomico', _ListaPreSelecaoErgonomico);
  }

  void updateListaPreSelecaoErgonomicoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ListaPreSelecaoErgonomico[index] =
        updateFn(_ListaPreSelecaoErgonomico[index]);
    prefs.setStringList(
        'ff_ListaPreSelecaoErgonomico', _ListaPreSelecaoErgonomico);
  }

  void insertAtIndexInListaPreSelecaoErgonomico(int index, String value) {
    ListaPreSelecaoErgonomico.insert(index, value);
    prefs.setStringList(
        'ff_ListaPreSelecaoErgonomico', _ListaPreSelecaoErgonomico);
  }

  List<String> _ListaPreSelecaoAcidente = [];
  List<String> get ListaPreSelecaoAcidente => _ListaPreSelecaoAcidente;
  set ListaPreSelecaoAcidente(List<String> value) {
    _ListaPreSelecaoAcidente = value;
    prefs.setStringList('ff_ListaPreSelecaoAcidente', value);
  }

  void addToListaPreSelecaoAcidente(String value) {
    ListaPreSelecaoAcidente.add(value);
    prefs.setStringList('ff_ListaPreSelecaoAcidente', _ListaPreSelecaoAcidente);
  }

  void removeFromListaPreSelecaoAcidente(String value) {
    ListaPreSelecaoAcidente.remove(value);
    prefs.setStringList('ff_ListaPreSelecaoAcidente', _ListaPreSelecaoAcidente);
  }

  void removeAtIndexFromListaPreSelecaoAcidente(int index) {
    ListaPreSelecaoAcidente.removeAt(index);
    prefs.setStringList('ff_ListaPreSelecaoAcidente', _ListaPreSelecaoAcidente);
  }

  void updateListaPreSelecaoAcidenteAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ListaPreSelecaoAcidente[index] = updateFn(_ListaPreSelecaoAcidente[index]);
    prefs.setStringList('ff_ListaPreSelecaoAcidente', _ListaPreSelecaoAcidente);
  }

  void insertAtIndexInListaPreSelecaoAcidente(int index, String value) {
    ListaPreSelecaoAcidente.insert(index, value);
    prefs.setStringList('ff_ListaPreSelecaoAcidente', _ListaPreSelecaoAcidente);
  }

  String _enderecoAvMensal = '';
  String get enderecoAvMensal => _enderecoAvMensal;
  set enderecoAvMensal(String value) {
    _enderecoAvMensal = value;
  }

  String _profissaoAvMensal = '';
  String get profissaoAvMensal => _profissaoAvMensal;
  set profissaoAvMensal(String value) {
    _profissaoAvMensal = value;
  }

  List<String> _modificacoesEmpresaAvMensal = [];
  List<String> get modificacoesEmpresaAvMensal => _modificacoesEmpresaAvMensal;
  set modificacoesEmpresaAvMensal(List<String> value) {
    _modificacoesEmpresaAvMensal = value;
  }

  void addToModificacoesEmpresaAvMensal(String value) {
    modificacoesEmpresaAvMensal.add(value);
  }

  void removeFromModificacoesEmpresaAvMensal(String value) {
    modificacoesEmpresaAvMensal.remove(value);
  }

  void removeAtIndexFromModificacoesEmpresaAvMensal(int index) {
    modificacoesEmpresaAvMensal.removeAt(index);
  }

  void updateModificacoesEmpresaAvMensalAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    modificacoesEmpresaAvMensal[index] =
        updateFn(_modificacoesEmpresaAvMensal[index]);
  }

  void insertAtIndexInModificacoesEmpresaAvMensal(int index, String value) {
    modificacoesEmpresaAvMensal.insert(index, value);
  }

  List<String> _modificacoesEmpresaAvMensal2 = [];
  List<String> get modificacoesEmpresaAvMensal2 =>
      _modificacoesEmpresaAvMensal2;
  set modificacoesEmpresaAvMensal2(List<String> value) {
    _modificacoesEmpresaAvMensal2 = value;
  }

  void addToModificacoesEmpresaAvMensal2(String value) {
    modificacoesEmpresaAvMensal2.add(value);
  }

  void removeFromModificacoesEmpresaAvMensal2(String value) {
    modificacoesEmpresaAvMensal2.remove(value);
  }

  void removeAtIndexFromModificacoesEmpresaAvMensal2(int index) {
    modificacoesEmpresaAvMensal2.removeAt(index);
  }

  void updateModificacoesEmpresaAvMensal2AtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    modificacoesEmpresaAvMensal2[index] =
        updateFn(_modificacoesEmpresaAvMensal2[index]);
  }

  void insertAtIndexInModificacoesEmpresaAvMensal2(int index, String value) {
    modificacoesEmpresaAvMensal2.insert(index, value);
  }

  List<String> _modificacoesEmpresaAvMensal3 = [];
  List<String> get modificacoesEmpresaAvMensal3 =>
      _modificacoesEmpresaAvMensal3;
  set modificacoesEmpresaAvMensal3(List<String> value) {
    _modificacoesEmpresaAvMensal3 = value;
  }

  void addToModificacoesEmpresaAvMensal3(String value) {
    modificacoesEmpresaAvMensal3.add(value);
  }

  void removeFromModificacoesEmpresaAvMensal3(String value) {
    modificacoesEmpresaAvMensal3.remove(value);
  }

  void removeAtIndexFromModificacoesEmpresaAvMensal3(int index) {
    modificacoesEmpresaAvMensal3.removeAt(index);
  }

  void updateModificacoesEmpresaAvMensal3AtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    modificacoesEmpresaAvMensal3[index] =
        updateFn(_modificacoesEmpresaAvMensal3[index]);
  }

  void insertAtIndexInModificacoesEmpresaAvMensal3(int index, String value) {
    modificacoesEmpresaAvMensal3.insert(index, value);
  }

  String _descricaoModificacoes = '';
  String get descricaoModificacoes => _descricaoModificacoes;
  set descricaoModificacoes(String value) {
    _descricaoModificacoes = value;
  }

  bool _isPDFGerado = false;
  bool get isPDFGerado => _isPDFGerado;
  set isPDFGerado(bool value) {
    _isPDFGerado = value;
  }

  List<String> _listaFisicosMensal = [];
  List<String> get listaFisicosMensal => _listaFisicosMensal;
  set listaFisicosMensal(List<String> value) {
    _listaFisicosMensal = value;
    prefs.setStringList('ff_listaFisicosMensal', value);
  }

  void addToListaFisicosMensal(String value) {
    listaFisicosMensal.add(value);
    prefs.setStringList('ff_listaFisicosMensal', _listaFisicosMensal);
  }

  void removeFromListaFisicosMensal(String value) {
    listaFisicosMensal.remove(value);
    prefs.setStringList('ff_listaFisicosMensal', _listaFisicosMensal);
  }

  void removeAtIndexFromListaFisicosMensal(int index) {
    listaFisicosMensal.removeAt(index);
    prefs.setStringList('ff_listaFisicosMensal', _listaFisicosMensal);
  }

  void updateListaFisicosMensalAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listaFisicosMensal[index] = updateFn(_listaFisicosMensal[index]);
    prefs.setStringList('ff_listaFisicosMensal', _listaFisicosMensal);
  }

  void insertAtIndexInListaFisicosMensal(int index, String value) {
    listaFisicosMensal.insert(index, value);
    prefs.setStringList('ff_listaFisicosMensal', _listaFisicosMensal);
  }

  List<String> _listaQuimicoMensais = [];
  List<String> get listaQuimicoMensais => _listaQuimicoMensais;
  set listaQuimicoMensais(List<String> value) {
    _listaQuimicoMensais = value;
    prefs.setStringList('ff_listaQuimicoMensais', value);
  }

  void addToListaQuimicoMensais(String value) {
    listaQuimicoMensais.add(value);
    prefs.setStringList('ff_listaQuimicoMensais', _listaQuimicoMensais);
  }

  void removeFromListaQuimicoMensais(String value) {
    listaQuimicoMensais.remove(value);
    prefs.setStringList('ff_listaQuimicoMensais', _listaQuimicoMensais);
  }

  void removeAtIndexFromListaQuimicoMensais(int index) {
    listaQuimicoMensais.removeAt(index);
    prefs.setStringList('ff_listaQuimicoMensais', _listaQuimicoMensais);
  }

  void updateListaQuimicoMensaisAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listaQuimicoMensais[index] = updateFn(_listaQuimicoMensais[index]);
    prefs.setStringList('ff_listaQuimicoMensais', _listaQuimicoMensais);
  }

  void insertAtIndexInListaQuimicoMensais(int index, String value) {
    listaQuimicoMensais.insert(index, value);
    prefs.setStringList('ff_listaQuimicoMensais', _listaQuimicoMensais);
  }

  List<String> _listaBiologicosMensais = [
    'Vírus',
    'Bactérias',
    'Protozoários',
    'Fungos',
    'Parasitas',
    'Bacilos',
    'Sangue'
  ];
  List<String> get listaBiologicosMensais => _listaBiologicosMensais;
  set listaBiologicosMensais(List<String> value) {
    _listaBiologicosMensais = value;
    prefs.setStringList('ff_listaBiologicosMensais', value);
  }

  void addToListaBiologicosMensais(String value) {
    listaBiologicosMensais.add(value);
    prefs.setStringList('ff_listaBiologicosMensais', _listaBiologicosMensais);
  }

  void removeFromListaBiologicosMensais(String value) {
    listaBiologicosMensais.remove(value);
    prefs.setStringList('ff_listaBiologicosMensais', _listaBiologicosMensais);
  }

  void removeAtIndexFromListaBiologicosMensais(int index) {
    listaBiologicosMensais.removeAt(index);
    prefs.setStringList('ff_listaBiologicosMensais', _listaBiologicosMensais);
  }

  void updateListaBiologicosMensaisAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listaBiologicosMensais[index] = updateFn(_listaBiologicosMensais[index]);
    prefs.setStringList('ff_listaBiologicosMensais', _listaBiologicosMensais);
  }

  void insertAtIndexInListaBiologicosMensais(int index, String value) {
    listaBiologicosMensais.insert(index, value);
    prefs.setStringList('ff_listaBiologicosMensais', _listaBiologicosMensais);
  }

  List<String> _listaErgonomicosMensais = [
    ' Esforço Físico Intenso',
    'Repetitividade',
    ' Levantamento de Peso',
    ' Transporte de Peso',
    ' Postura Inadequada',
    'Monotomia',
    'Controle Rígido de Produtividade',
    ' Imposição de Rítmos Excessivos',
    'Trabalho em turno e Noturno',
    ' Jornada de Trabalho Prolongadas',
    ' Outras Situações causadoras de estresse Físico ou Psiquico'
  ];
  List<String> get listaErgonomicosMensais => _listaErgonomicosMensais;
  set listaErgonomicosMensais(List<String> value) {
    _listaErgonomicosMensais = value;
    prefs.setStringList('ff_listaErgonomicosMensais', value);
  }

  void addToListaErgonomicosMensais(String value) {
    listaErgonomicosMensais.add(value);
    prefs.setStringList('ff_listaErgonomicosMensais', _listaErgonomicosMensais);
  }

  void removeFromListaErgonomicosMensais(String value) {
    listaErgonomicosMensais.remove(value);
    prefs.setStringList('ff_listaErgonomicosMensais', _listaErgonomicosMensais);
  }

  void removeAtIndexFromListaErgonomicosMensais(int index) {
    listaErgonomicosMensais.removeAt(index);
    prefs.setStringList('ff_listaErgonomicosMensais', _listaErgonomicosMensais);
  }

  void updateListaErgonomicosMensaisAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listaErgonomicosMensais[index] = updateFn(_listaErgonomicosMensais[index]);
    prefs.setStringList('ff_listaErgonomicosMensais', _listaErgonomicosMensais);
  }

  void insertAtIndexInListaErgonomicosMensais(int index, String value) {
    listaErgonomicosMensais.insert(index, value);
    prefs.setStringList('ff_listaErgonomicosMensais', _listaErgonomicosMensais);
  }

  List<String> _listaAcidentesMensais = [
    ' Eletricidade',
    ' Iluminação Inadequada',
    'Animais Peçonhentos',
    ' Piso Escorregadio',
    ' Armazenamento Inadequado',
    'Arranjos Físicos Inadequados',
    'Máquinas e Equipamentos sem proteção',
    'Ferramentas inadequadas ou defeituosas',
    'Probabilidade de Incêndio ou Explosão',
    'Outras Situações que poderão contribuir para ocorrência de acidente'
  ];
  List<String> get listaAcidentesMensais => _listaAcidentesMensais;
  set listaAcidentesMensais(List<String> value) {
    _listaAcidentesMensais = value;
    prefs.setStringList('ff_listaAcidentesMensais', value);
  }

  void addToListaAcidentesMensais(String value) {
    listaAcidentesMensais.add(value);
    prefs.setStringList('ff_listaAcidentesMensais', _listaAcidentesMensais);
  }

  void removeFromListaAcidentesMensais(String value) {
    listaAcidentesMensais.remove(value);
    prefs.setStringList('ff_listaAcidentesMensais', _listaAcidentesMensais);
  }

  void removeAtIndexFromListaAcidentesMensais(int index) {
    listaAcidentesMensais.removeAt(index);
    prefs.setStringList('ff_listaAcidentesMensais', _listaAcidentesMensais);
  }

  void updateListaAcidentesMensaisAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listaAcidentesMensais[index] = updateFn(_listaAcidentesMensais[index]);
    prefs.setStringList('ff_listaAcidentesMensais', _listaAcidentesMensais);
  }

  void insertAtIndexInListaAcidentesMensais(int index, String value) {
    listaAcidentesMensais.insert(index, value);
    prefs.setStringList('ff_listaAcidentesMensais', _listaAcidentesMensais);
  }

  List<dynamic> _JSONPreSelecao = [];
  List<dynamic> get JSONPreSelecao => _JSONPreSelecao;
  set JSONPreSelecao(List<dynamic> value) {
    _JSONPreSelecao = value;
  }

  void addToJSONPreSelecao(dynamic value) {
    JSONPreSelecao.add(value);
  }

  void removeFromJSONPreSelecao(dynamic value) {
    JSONPreSelecao.remove(value);
  }

  void removeAtIndexFromJSONPreSelecao(int index) {
    JSONPreSelecao.removeAt(index);
  }

  void updateJSONPreSelecaoAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    JSONPreSelecao[index] = updateFn(_JSONPreSelecao[index]);
  }

  void insertAtIndexInJSONPreSelecao(int index, dynamic value) {
    JSONPreSelecao.insert(index, value);
  }

  dynamic _lista;
  dynamic get lista => _lista;
  set lista(dynamic value) {
    _lista = value;
  }

  int _indice = 0;
  int get indice => _indice;
  set indice(int value) {
    _indice = value;
  }

  int _currentDraftId = 0;
  int get currentDraftId => _currentDraftId;
  set currentDraftId(int value) {
    _currentDraftId = value;
  }

  int _idEmpresa = 0;
  int get idEmpresa => _idEmpresa;
  set idEmpresa(int value) {
    _idEmpresa = value;
  }

  /// TreinamentosRealizados para o questionário da avaliação de risco
  String _treinamentosrealizados = '';
  String get treinamentosrealizados => _treinamentosrealizados;
  set treinamentosrealizados(String value) {
    _treinamentosrealizados = value;
  }

  List<String> _ListaPreselecaoPsicossociais = [];
  List<String> get ListaPreselecaoPsicossociais =>
      _ListaPreselecaoPsicossociais;
  set ListaPreselecaoPsicossociais(List<String> value) {
    _ListaPreselecaoPsicossociais = value;
  }

  void addToListaPreselecaoPsicossociais(String value) {
    ListaPreselecaoPsicossociais.add(value);
  }

  void removeFromListaPreselecaoPsicossociais(String value) {
    ListaPreselecaoPsicossociais.remove(value);
  }

  void removeAtIndexFromListaPreselecaoPsicossociais(int index) {
    ListaPreselecaoPsicossociais.removeAt(index);
  }

  void updateListaPreselecaoPsicossociaisAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ListaPreselecaoPsicossociais[index] =
        updateFn(_ListaPreselecaoPsicossociais[index]);
  }

  void insertAtIndexInListaPreselecaoPsicossociais(int index, String value) {
    ListaPreselecaoPsicossociais.insert(index, value);
  }

  /// Carregamento de dados
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
  }

  /// Medidas Implementadas - Página 6 Avaliação de risco
  String _medidasImplementadas = '';
  String get medidasImplementadas => _medidasImplementadas;
  set medidasImplementadas(String value) {
    _medidasImplementadas = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
