import 'package:task_manager/domain/model/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>> gettingTasks();
  Future<void> addingTask(Task task);
  Future<void> deletingTask(Task task);
}
