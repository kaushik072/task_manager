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

  group('Delete task use case testing', () {

    test('UseCase > Delete Task from Database', () async {
      final task = Task(title: 'Test Task', id: "1");

      when(mockDatabase.deleteTask(task)).thenAnswer((_) async {});
      verifyNever(mockDatabase.deleteTask(task));
      final result = await mockDatabase.deleteTask(task);
      verify(mockDatabase.deleteTask(task)).called(1);
    });
  });
}