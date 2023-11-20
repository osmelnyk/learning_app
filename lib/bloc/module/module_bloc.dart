import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/data/repository/db_repository.dart';
import '../../data/model/module_model.dart';
import '../../data/model/progress_model.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModulesState> {
  ModuleBloc() : super(ModulesInitial()) {
    on<GetModules>((event, emit) async {
      emit(ModulesLoading());
      try {
        final modules =
            await DBRepository().getModules(event.courseId, event.language);
        emit(ModulesLoaded(modules: modules));
        log('modules get: ${state.toString()}');
      } catch (e) {
        log("Error: ${e.toString()}");
        emit(ModulesLoadingError(e.toString()));
      }
    });

    on<GetModule>((event, emit) async {
      try {
        final module = await DBRepository().getModule(event.moduleId);
        emit(ModuleLoaded(module));
      } catch (e) {
        log("Error: ${e.toString()}");
        emit(ModulesLoadingError(e.toString()));
      }
    });

    on<SetProgress>((event, emit) async {
      final state = this.state;
      if (state is ModulesLoaded) {
        await DBRepository().updateProgress(event.progress);
        List<Module> modules = List.from(state.modules);
        int indexToChange = modules
            .indexWhere((element) => element.id == event.progress.moduleId);
        if (indexToChange != -1) {
          Module itemToChange = modules[indexToChange];
          Module updatedItem = itemToChange.copyWith(
              finishedLesson: event.progress.finishedLesson);

          modules[indexToChange] = updatedItem;
        }

        emit(ModulesLoaded(modules: modules));
      }
    });
  }
}
