import 'package:task_manager/domain/model/task_model.dart';
import 'package:task_manager/domain/repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> execute() {
    return repository.gettingTasks();
  }
}
