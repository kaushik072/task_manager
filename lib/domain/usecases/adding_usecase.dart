
import 'package:task_manager/domain/model/task_model.dart';
import 'package:task_manager/domain/repository/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future execute(Task task) {
    return repository.addingTask(task);
  }
}
