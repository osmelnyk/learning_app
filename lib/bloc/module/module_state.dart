part of 'module_bloc.dart';

sealed class ModulesState extends Equatable {
  const ModulesState({modules = const []});
}

final class ModulesInitial extends ModulesState {
  @override
  List<Object> get props => [];
}

final class ModulesLoading extends ModulesState {
  @override
  List<Object> get props => [];
}

final class ModulesLoaded extends ModulesState {
  final List<Module> modules;
  const ModulesLoaded({this.modules = const []});

  @override
  List<Object> get props => [modules];
}

final class ModulesLoadingError extends ModulesState {
  final String message;
  const ModulesLoadingError(this.message);
  @override
  List<Object> get props => [message];
}

final class ModuleLoading extends ModulesState {
  @override
  List<Object> get props => [];
}

final class ModuleLoaded extends ModulesState {
  final Module module;
  const ModuleLoaded(this.module);

  @override
  List<Object> get props => [module];
}
