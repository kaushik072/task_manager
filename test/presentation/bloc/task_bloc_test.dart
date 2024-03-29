import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/domain/model/task_model.dart';
import 'package:task_manager/domain/usecases/adding_usecase.dart';
import 'package:task_manager/domain/usecases/deleting_usecase.dart';
import 'package:task_manager/domain/usecases/fetching_usecase.dart';
import 'package:task_manager/presentaion/bloc/task_bloc.dart';
import 'task_bloc_test.mocks.dart';

@GenerateMocks([GetTasksUseCase, AddTaskUseCase], customMocks: [MockSpec<DeleteTaskUseCase>(onMissingStub:  OnMissingStub.returnDefault)])

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Task task1;
  late TaskBloc taskBloc;
  late MockGetTasksUseCase getTasksUseCase;
  late MockAddTaskUseCase addTaskUseCase;
  late MockDeleteTaskUseCase deleteTaskUseCase;


  setUpAll(() async {

    getTasksUseCase = MockGetTasksUseCase();
    addTaskUseCase = MockAddTaskUseCase();
    deleteTaskUseCase = MockDeleteTaskUseCase();
    task1 = Task(id: "1", title: "Test Task");
    taskBloc = TaskBloc(
      getTasksUseCase,
      addTaskUseCase,
      deleteTaskUseCase,
    );

  });

  group('Task bloc testing', () {
    test('UseCase > initially state should be Loading', () async {
     expect(taskBloc.state, LoadingState());
    });

    blocTest<TaskBloc, TaskState>("UseCase > Fetch all stored data",
        build: () {
            when(
                getTasksUseCase.execute()
            ).thenAnswer((_) async => List.empty());
            return taskBloc;
        },
      act: (bloc) => bloc.add(GetTasksEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        LoadedState(List.empty())
      ],
    );

    blocTest<TaskBloc, TaskState>("UseCase > Check Exception",
      build: () {
        when(
            getTasksUseCase.execute()
        ).thenThrow("Database does not initialise");
        return TaskBloc(
          getTasksUseCase,
          addTaskUseCase,
          deleteTaskUseCase,
        );
      },
      act: (bloc) => bloc.add(GetTasksEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ErrorState("Failed to load tasks: Database does not initialise")
      ],
    );



    blocTest<TaskBloc, TaskState>("UseCase > Add Task data",
      build: () {
        when(
            addTaskUseCase.execute(any)
        ).thenAnswer((_) async {});
        when(
            getTasksUseCase.execute()
        ).thenAnswer((_) async => [task1]);
        return TaskBloc(
          getTasksUseCase,
          addTaskUseCase,
          deleteTaskUseCase,
        );
      },
      act: (bloc) => bloc.add(AddTaskEvent(task1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        LoadedState([task1])
      ],
    );

    blocTest<TaskBloc, TaskState>("UseCase > Check Exception on Add",
      build: () {
        when(
            addTaskUseCase.execute(any)
        ).thenAnswer((_) async {});
        when(
            getTasksUseCase.execute()
        ).thenThrow("Database does not initialise");
        return TaskBloc(
          getTasksUseCase,
          addTaskUseCase,
          deleteTaskUseCase,
        );
      },
      act: (bloc) => bloc.add(AddTaskEvent(task1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ErrorState("Failed to load tasks: Database does not initialise")
      ],
    );


    blocTest<TaskBloc, TaskState>("UseCase > Delete Task data",
      build: () {
        when(
            deleteTaskUseCase.execute(any)
        ).thenAnswer((_) async {});
        when(
            getTasksUseCase.execute()
        ).thenAnswer((_) async => List.empty());
        return TaskBloc(
          getTasksUseCase,
          addTaskUseCase,
          deleteTaskUseCase,
        );
      },
      act: (bloc) => bloc.add(DeleteTaskEvent(task1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        LoadedState(List.empty())
      ],
    );

    blocTest<TaskBloc, TaskState>("UseCase > Check Exception on Delete",
      build: () {
        when(
            deleteTaskUseCase.execute(any)
        ).thenAnswer((_) async {});
        when(
            getTasksUseCase.execute()
        ).thenThrow("Database does not initialise");
        return TaskBloc(
          getTasksUseCase,
          addTaskUseCase,
          deleteTaskUseCase,
        );
      },
      act: (bloc) => bloc.add(DeleteTaskEvent(task1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        ErrorState("Failed to load tasks: Database does not initialise")
      ],
    );

  });
}