import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/backend/sqlite/sqlite_manager.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => HomePageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => HomePageWidget(),
        ),
        FFRoute(
          name: HomePageWidget.routeName,
          path: HomePageWidget.routePath,
          builder: (context, params) => HomePageWidget(),
        ),
        FFRoute(
          name: JChecklistWidget.routeName,
          path: JChecklistWidget.routePath,
          builder: (context, params) => JChecklistWidget(),
        ),
        FFRoute(
          name: GerenciamentoEPIGeralWidget.routeName,
          path: GerenciamentoEPIGeralWidget.routePath,
          builder: (context, params) => GerenciamentoEPIGeralWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DDescColaboradoresDevWidget.routeName,
          path: DDescColaboradoresDevWidget.routePath,
          builder: (context, params) => DDescColaboradoresDevWidget(),
        ),
        FFRoute(
          name: DocumentosWidget.routeName,
          path: DocumentosWidget.routePath,
          builder: (context, params) => DocumentosWidget(),
        ),
        FFRoute(
          name: GerenciamentoEPCWidget.routeName,
          path: GerenciamentoEPCWidget.routePath,
          builder: (context, params) => GerenciamentoEPCWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AHeaderAvaliacaoDraftWidget.routeName,
          path: AHeaderAvaliacaoDraftWidget.routePath,
          builder: (context, params) => AHeaderAvaliacaoDraftWidget(),
        ),
        FFRoute(
          name: ConfiguracoesWidget.routeName,
          path: ConfiguracoesWidget.routePath,
          builder: (context, params) => ConfiguracoesWidget(),
        ),
        FFRoute(
          name: AssinaturasRealizadasEmpresaWidget.routeName,
          path: AssinaturasRealizadasEmpresaWidget.routePath,
          builder: (context, params) => AssinaturasRealizadasEmpresaWidget(
            nomeEmpresa: params.getParam(
              'nomeEmpresa',
              ParamType.String,
            ),
            idEmpresa: params.getParam(
              'idEmpresa',
              ParamType.int,
            ),
            countAssinatura: params.getParam(
              'countAssinatura',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: EDescAgravosSaudeWidget.routeName,
          path: EDescAgravosSaudeWidget.routePath,
          builder: (context, params) => EDescAgravosSaudeWidget(),
        ),
        FFRoute(
          name: AHeaderAvaliacaoWidget.routeName,
          path: AHeaderAvaliacaoWidget.routePath,
          builder: (context, params) => AHeaderAvaliacaoWidget(),
        ),
        FFRoute(
          name: AssinaturasBDWidget.routeName,
          path: AssinaturasBDWidget.routePath,
          builder: (context, params) => AssinaturasBDWidget(),
        ),
        FFRoute(
          name: BAgentesWidget.routeName,
          path: BAgentesWidget.routePath,
          builder: (context, params) => BAgentesWidget(),
        ),
        FFRoute(
          name: FDescMedidasWidget.routeName,
          path: FDescMedidasWidget.routePath,
          builder: (context, params) => FDescMedidasWidget(),
        ),
        FFRoute(
          name: CDescAmbienteTrabalhoWidget.routeName,
          path: CDescAmbienteTrabalhoWidget.routePath,
          builder: (context, params) => CDescAmbienteTrabalhoWidget(),
        ),
        FFRoute(
          name: GerenciamentoEPCGeralWidget.routeName,
          path: GerenciamentoEPCGeralWidget.routePath,
          builder: (context, params) => GerenciamentoEPCGeralWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: BPolticaeProgramasdeSegurancaWidget.routeName,
          path: BPolticaeProgramasdeSegurancaWidget.routePath,
          builder: (context, params) => BPolticaeProgramasdeSegurancaWidget(),
        ),
        FFRoute(
          name: AvalidoresVisualizarWidget.routeName,
          path: AvalidoresVisualizarWidget.routePath,
          builder: (context, params) => AvalidoresVisualizarWidget(),
        ),
        FFRoute(
          name: GEpisWidget.routeName,
          path: GEpisWidget.routePath,
          builder: (context, params) => GEpisWidget(),
        ),
        FFRoute(
          name: AvalidoresCadastroWidget.routeName,
          path: AvalidoresCadastroWidget.routePath,
          builder: (context, params) => AvalidoresCadastroWidget(),
        ),
        FFRoute(
          name: CModificacaoeAlteracaoWidget.routeName,
          path: CModificacaoeAlteracaoWidget.routePath,
          builder: (context, params) => CModificacaoeAlteracaoWidget(),
        ),
        FFRoute(
          name: TelaInicialWidget.routeName,
          path: TelaInicialWidget.routePath,
          builder: (context, params) => TelaInicialWidget(),
        ),
        FFRoute(
          name: GerenciamentoMedidasWidget.routeName,
          path: GerenciamentoMedidasWidget.routePath,
          builder: (context, params) => GerenciamentoMedidasWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: KObservacaoWidget.routeName,
          path: KObservacaoWidget.routePath,
          builder: (context, params) => KObservacaoWidget(),
        ),
        FFRoute(
          name: SobreWidget.routeName,
          path: SobreWidget.routePath,
          builder: (context, params) => SobreWidget(),
        ),
        FFRoute(
          name: GerenciamentoEPIAgenteWidget.routeName,
          path: GerenciamentoEPIAgenteWidget.routePath,
          builder: (context, params) => GerenciamentoEPIAgenteWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: GerenciamentoDadosWidget.routeName,
          path: GerenciamentoDadosWidget.routePath,
          builder: (context, params) => GerenciamentoDadosWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: GerenciamentoAgenteWidget.routeName,
          path: GerenciamentoAgenteWidget.routePath,
          builder: (context, params) => GerenciamentoAgenteWidget(
            nome: params.getParam(
              'nome',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: HTipoderiscoWidget.routeName,
          path: HTipoderiscoWidget.routePath,
          builder: (context, params) => HTipoderiscoWidget(),
        ),
        FFRoute(
          name: PreSelecoesWidget.routeName,
          path: PreSelecoesWidget.routePath,
          builder: (context, params) => PreSelecoesWidget(),
        ),
        FFRoute(
          name: AHeaderAvaliacaoMensalDraftWidget.routeName,
          path: AHeaderAvaliacaoMensalDraftWidget.routePath,
          builder: (context, params) => AHeaderAvaliacaoMensalDraftWidget(),
        ),
        FFRoute(
          name: TiposDeAvaliacoesWidget.routeName,
          path: TiposDeAvaliacoesWidget.routePath,
          builder: (context, params) => TiposDeAvaliacoesWidget(),
        ),
        FFRoute(
          name: DNomeColaboradoresWidget.routeName,
          path: DNomeColaboradoresWidget.routePath,
          builder: (context, params) => DNomeColaboradoresWidget(),
        ),
        FFRoute(
          name: SelectAssinaturasPageWidget.routeName,
          path: SelectAssinaturasPageWidget.routePath,
          builder: (context, params) => SelectAssinaturasPageWidget(),
        ),
        FFRoute(
          name: EmpresasWidget.routeName,
          path: EmpresasWidget.routePath,
          builder: (context, params) => EmpresasWidget(),
        ),
        FFRoute(
          name: AHeaderAvaliacaoMensalWidget.routeName,
          path: AHeaderAvaliacaoMensalWidget.routePath,
          builder: (context, params) => AHeaderAvaliacaoMensalWidget(),
        ),
        FFRoute(
          name: EmpresaFormsAvaliacaoWidget.routeName,
          path: EmpresaFormsAvaliacaoWidget.routePath,
          builder: (context, params) => EmpresaFormsAvaliacaoWidget(),
        ),
        FFRoute(
          name: CadastroRiscoWidget.routeName,
          path: CadastroRiscoWidget.routePath,
          builder: (context, params) => CadastroRiscoWidget(),
        ),
        FFRoute(
          name: ZAssinaturaPageCopyWidget.routeName,
          path: ZAssinaturaPageCopyWidget.routePath,
          builder: (context, params) => ZAssinaturaPageCopyWidget(),
        ),
        FFRoute(
          name: ZAssinaturaPageWidget.routeName,
          path: ZAssinaturaPageWidget.routePath,
          builder: (context, params) => ZAssinaturaPageWidget(),
        ),
        FFRoute(
          name: DatabasePageWidget.routeName,
          path: DatabasePageWidget.routePath,
          builder: (context, params) => DatabasePageWidget(),
        ),
        FFRoute(
          name: AvaliadoresPickWidget.routeName,
          path: AvaliadoresPickWidget.routePath,
          builder: (context, params) => AvaliadoresPickWidget(),
        ),
        FFRoute(
          name: EmpresasPickWidget.routeName,
          path: EmpresasPickWidget.routePath,
          builder: (context, params) => EmpresasPickWidget(),
        ),
        FFRoute(
          name: AgentesPickWidget.routeName,
          path: AgentesPickWidget.routePath,
          builder: (context, params) => AgentesPickWidget(),
        ),
        FFRoute(
          name: EPISPickWidget.routeName,
          path: EPISPickWidget.routePath,
          builder: (context, params) => EPISPickWidget(),
        ),
        FFRoute(
          name: EPCSPickWidget.routeName,
          path: EPCSPickWidget.routePath,
          builder: (context, params) => EPCSPickWidget(),
        ),
        FFRoute(
          name: MedidasPickWidget.routeName,
          path: MedidasPickWidget.routePath,
          builder: (context, params) => MedidasPickWidget(),
        ),
        FFRoute(
          name: DadosAdicionaisPickWidget.routeName,
          path: DadosAdicionaisPickWidget.routePath,
          builder: (context, params) => DadosAdicionaisPickWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
