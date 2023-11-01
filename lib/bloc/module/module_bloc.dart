import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/data/repository/db_repository.dart';
import '../../data/model/module_model.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  ModuleBloc() : super(ModuleInitial()) {
    on<GetModules>((event, emit) async {
      emit(ModuleLoading());
      try {
        final modules =
            await DBRepository().getModules(event.courseId, event.language);
        emit(ModuleLoaded(modules));
      } catch (e) {
        log("Error: ${e.toString()}");
        emit(ModuleLoadingError(e.toString()));
      }
    });
  }
}
