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


class GetModule extends ModuleEvent {
  final int moduleId;

  const GetModule(this.moduleId);

  @override
  List<Object> get props => [moduleId];
}

class SetProgress extends ModuleEvent {
  final Progress progress;
  // final String language;

  const SetProgress(this.progress);

  @override
  List<Object> get props => [progress];
}