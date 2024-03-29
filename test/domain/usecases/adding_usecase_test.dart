import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_manager/data/datasources/task_datasource.dart';
import 'package:task_manager/domain/model/task_model.dart';
import 'adding_usecase_test.mocks.dart';

@GenerateMocks([TaskDataSource])
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

  group('Add task use case testing', () {

    test('UseCase > Add Task to Database', () async {
      final task = Task(title: 'Test Task', id: "1");

      when(mockDatabase.addTask(task)).thenAnswer((_) async {});
      verifyNever(mockDatabase.addTask(task));
      final result = await mockDatabase.addTask(task);
      verify(mockDatabase.addTask(task)).called(1);
    });
  });
}