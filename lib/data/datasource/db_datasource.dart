import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBDatasource {
  // open database
  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app.db');
    log(path);
    bool exists = await databaseExists(path);

    // delete existing database to load new data
    await deleteDatabase(path);

    // if (!exists) {
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
    // }
    return await openDatabase(path, version: 2);
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    final db = await open();
    return db.query('courses');
  }

  Future<List<Map<String, dynamic>>> getModules(
      int courseId, String language) async {
    final db = await open();
    final modules =
        await db.query('modules', where: 'course_id =?', whereArgs: [courseId]);
    log(modules.toString());
    return modules;
  }

  Future<List<Map<String, dynamic>>> getLessons(
      int moduleId, String language) async {
    final db = await open();
    return db.query('lessons', where: 'module_id =?', whereArgs: [moduleId]);
  }
}
