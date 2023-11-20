import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/progress_model.dart';

class DBDatasource {
  // open database
  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app.db');
    bool exists = await databaseExists(path);

    // delete existing database to load new data
    // await deleteDatabase(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(url.join("assets", "app.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, version: 1);
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    final db = await open();
    return db.query('courses');
  }

  Future<List<Map<String, dynamic>>> getModules(
      int courseId, String language) async {
    final db = await open();
    final modules = await db.rawQuery('''
        SELECT 
          modules.id,
          name,
          description,
          language_code,
          course_id,
          progress.finished_lesson as finished_lesson
        FROM modules 
        LEFT JOIN progress 
        ON progress.module_id = modules.module_id 
        WHERE language_code = '$language'
        AND course_id = '$courseId'
        ''');
    return modules;
  }

  Future<Map<String, dynamic>> getModule(int moduleId) async {
    final db = await open();
    final module = await db.rawQuery('''
        SELECT 
          modules.id,
          name,
          description,
          language_code,
          course_id,
          progress.finished_lesson as finished_lesson
        FROM modules 
        LEFT JOIN progress 
        ON modules.id = progress.module_id
        WHERE modules.id = '$moduleId'
        ''');
    return module.first;
  }

  Future<List<Map<String, dynamic>>> getLessons(
      int moduleId, String language) async {
    final db = await open();
    final lessons = await db.query('lessons',
        where: 'module_id =?', whereArgs: [moduleId], orderBy: 'position ASC');
    return lessons;
  }

  Future updateProgress({
    required Progress progress,
  }) async {
    final db = await open();
    return db.update(
        'progress',
        {
          'module_id': progress.moduleId,
          'finished_lesson': progress.finishedLesson
        },
        where: 'module_id = ?',
        whereArgs: [progress.moduleId]);
  }

  Future<Map<String, dynamic>> getProgress(int moduleId) async {
    final db = await open();
    final progress = await db.query(
      'progress',
      where: 'module_id = ?',
      whereArgs: [moduleId],
    );
    return progress.first;
  }

  Future<Map<String, dynamic>> setOrGetProgress(int moduleId) async {
    final db = await open();
    var result = await db.query(
      'progress',
      where: 'module_id = ?',
      whereArgs: [moduleId],
    );
    if (result.isEmpty) {
      await db.insert(
        'progress',
        {'module_id': moduleId, 'finished_lesson': 0},
      );
      return <String, dynamic>{'module_id': moduleId, 'finished_lesson': 0};
    } else {
      return result.first;
    }
  }
}
