import 'package:bloc/bloc.dart';
import 'package:task_manager/domain/model/task_model.dart';
import 'package:task_manager/domain/usecases/adding_usecase.dart';
import 'package:task_manager/domain/usecases/deleting_usecase.dart';
import 'package:task_manager/domain/usecases/fetching_usecase.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskBloc(this.getTasksUseCase, this.addTaskUseCase, this.deleteTaskUseCase) : super(LoadingState()) {
    on<GetTasksEvent>(onGetTasksEvent);
    on<AddTaskEvent>(onAddTaskEvent);
    on<DeleteTaskEvent>(onDeleteTaskEvent);
  }

  Future onGetTasksEvent(GetTasksEvent event, Emitter<TaskState> emit) async {
    try {
      List<Task> tasks = await getTasksUseCase.execute();

      emit(LoadedState(tasks));
    } catch (e) {
      emit(ErrorState('Failed to load tasks: $e'));
    }
  }

  Future onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await addTaskUseCase.execute(event.task);
      await onGetTasksEvent(GetTasksEvent(), emit);
    } catch (e) {
      emit(ErrorState('Failed to add task: $e'));
    }
  }

  Future onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await deleteTaskUseCase.execute(event.task);

     await onGetTasksEvent(GetTasksEvent(), emit);
    } catch (e) {
      emit(ErrorState('Failed to delete task: $e'));
    }
  }
}
