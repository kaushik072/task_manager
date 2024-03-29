import 'package:task_manager/data/datasources/task_datasource.dart';
import 'package:task_manager/domain/model/task_model.dart';
import 'package:task_manager/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> gettingTasks() {
    return dataSource.getTask();
  }

  @override
  Future<void> addingTask(Task task) {
    return dataSource.addTask(task);
  }

  @override
  Future<void> deletingTask(Task task) {
    return dataSource.deleteTask(task);
  }
}
