part of 'module_bloc.dart';

sealed class ModuleEvent extends Equatable {
  const ModuleEvent();
}

// GetModules
class GetModules extends ModuleEvent {
  final int courseId;
  final String language;

  const GetModules(this.courseId, this.language);

  @override
  List<Object> get props => [courseId, language];
}
