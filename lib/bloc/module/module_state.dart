part of 'module_bloc.dart';

sealed class ModuleState extends Equatable {
  const ModuleState();
}

final class ModuleInitial extends ModuleState {
  @override
  List<Object> get props => [];
}

final class ModuleLoading extends ModuleState {
  @override
  List<Object> get props => [];
}

final class ModuleLoaded extends ModuleState {
  final List<Module> modules;
  const ModuleLoaded(this.modules);

  @override
  List<Object> get props => [modules];
}

final class ModuleLoadingError extends ModuleState {
  final String message;
  const ModuleLoadingError(this.message);
  @override
  List<Object> get props => [message];
}
