import 'package:task_manager/domain/model/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database == null) await initDatabase();
    return _database!;
  }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Task>> getTask() async {
    final List<Map<String, dynamic>> maps = await _database!.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
      );
    });
  }

  Future<void> addTask(Task task) async {
    await _database!.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(Task task) async {
    await _database!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
