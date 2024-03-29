import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/data/datasources/task_datasource.dart';
import 'package:task_manager/data/repository_impl/task_repository_impl.dart';
import 'package:task_manager/domain/repository/task_repository.dart';
import 'package:task_manager/main.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_manager/presentaion/widgets/add_task_dialogue.dart';

void main() async {
  final TaskDataSource taskDataSource = TaskDataSource();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final TaskRepository taskRepository = TaskRepositoryImpl(taskDataSource);

  testWidgets('Verify add user button present on ActiveUsers page',
          (WidgetTester tester) async {

        await tester.pumpWidget(MyApp(taskRepository: taskRepository));

        var fab = find.byType(FloatingActionButton);

        expect(fab, findsOneWidget);
      });

  testWidgets(
      'Verify that title input widgets are present on the add task Dialog',
          (WidgetTester tester) async {
        //Arrange - Pump AddTaskDialog() widget to tester
        await tester.pumpWidget(MaterialApp(home:AddTaskDialog(taskRepository: taskRepository)));

        //Act - Find TextFormField by type
        var textField = find.byType(TextFormField);

        //Assert - Check that exactly 1 Text input widgets are present
        expect(textField, findsOneWidget);
      });

  testWidgets(
      'Verify that `Add task` button widgets are present on the add task Dialog',
          (WidgetTester tester) async {
        //Arrange - Pump AddTaskDialog() widget to tester
        await tester.pumpWidget(MaterialApp(home:AddTaskDialog(taskRepository: taskRepository)));

        //Act - Find button by type
        var textField = find.text('Add task');

        //Assert - Check that exactly button widgets are present
        expect(textField, findsOneWidget);
      });

  testWidgets('Verify that the Add Task button adds task to database',
          (WidgetTester tester) async {
        await tester.pumpWidget(MyApp(taskRepository: taskRepository));

        var fab = find.byType(FloatingActionButton);

        await tester.tap(fab);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        var textField = find.byType(TextFormField);

        await tester.enterText(textField, "My First Task");

        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        var submitButton = find.byKey(const Key('addTask'));

        await tester.tap(submitButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 700));

        var addedText = find.textContaining("Task");
        expect(addedText, findsOneWidget);

      });
}