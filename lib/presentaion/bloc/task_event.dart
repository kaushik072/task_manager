part of 'task_bloc.dart';


abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  DeleteTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}
