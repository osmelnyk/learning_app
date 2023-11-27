import '../datasource/db_datasource.dart';
import '../model/lesson_model.dart';
import '../model/module_model.dart';
import '../model/progress_model.dart';

class DBRepository {
  final DBDatasource _dbDatasource = DBDatasource();

  Future<List<Module>> getModules(int courseId, String language) async {
    final List<Map<String, dynamic>> modules =
        await _dbDatasource.getModules(courseId, language);
    final moduleMaped =
        modules.map((module) => Module.fromMap(module)).toList();
    return moduleMaped;
  }

  Future<Module> getModule(int moduleId) async {
    final Map<String, dynamic> module = await _dbDatasource.getModule(moduleId);
    return Module.fromMap(module);
  }

  Future<List<Lesson>> getLessons(int moduleId, String language) async {
    final List<Map<String, dynamic>> lessons =
        await _dbDatasource.getLessons(moduleId, language);
    return lessons.map((lesson) => Lesson.fromMap(lesson)).toList();
  }

  Future<void> updateProgress(Progress progress) async {
    await _dbDatasource.updateProgress(progress: progress);
  }
}
