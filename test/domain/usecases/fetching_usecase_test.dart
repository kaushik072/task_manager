import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_manager/data/datasources/task_datasource.dart';
import 'package:task_manager/domain/model/task_model.dart';
import 'adding_usecase_test.mocks.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final TaskDataSource taskDataSource = TaskDataSource();
  await taskDataSource.database;
  late MockTaskDataSource mockDatabase;

  setUp(() async {
    mockDatabase = MockTaskDataSource();
  });

  group('Get tasks use case testing', () {

    test('UseCase > Get Tasks from Database', () async {
      final List<Task> taskList = [
        Task(title: 'Test Task', id: "1"),
        Task(title: 'Test Task', id: "1")
      ];

      when(mockDatabase.getTask()).thenAnswer((_) async => taskList);
      verifyNever(mockDatabase.getTask());
      final result = await mockDatabase.getTask();
      expect(result, taskList);
      verify(mockDatabase.getTask()).called(1);
    });
  });
}