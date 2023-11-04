import '../datasource/db_datasource.dart';
import '../model/lesson_model.dart';
import '../model/module_model.dart';

class DBRepository {
  final DBDatasource _dbDatasource = DBDatasource();

  Future<List<Module>> getModules(int courseId, String language) async {
    final List<Map<String, dynamic>> modules =
        await _dbDatasource.getModules(courseId, language);
    return modules.map((module) => Module.fromMap(module)).toList();
  }

  Future<List<Lesson>> getLessons(int moduleId, String language) async {
    final List<Map<String, dynamic>> lessons =
        await _dbDatasource.getLessons(moduleId, language);
    return lessons.map((lesson) => Lesson.fromMap(lesson)).toList();
  }
}
