import 'package:task_manager/domain/model/task_model.dart';
import 'package:task_manager/domain/repository/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future execute(Task task) {
    return repository.deletingTask(task);
  }
}
