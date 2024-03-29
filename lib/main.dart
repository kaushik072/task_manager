import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/data/datasources/task_datasource.dart';
import 'package:task_manager/data/repository_impl/task_repository_impl.dart';
import 'package:task_manager/domain/repository/task_repository.dart';
import 'package:task_manager/presentaion/bloc/task_bloc.dart';
import 'package:task_manager/presentaion/pages/task_list_page.dart';

import 'domain/usecases/adding_usecase.dart';
import 'domain/usecases/deleting_usecase.dart';
import 'domain/usecases/fetching_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final TaskDataSource taskDataSource = TaskDataSource();
  await taskDataSource.initDatabase();
  final TaskRepository taskRepository = TaskRepositoryImpl(taskDataSource);
  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository? taskRepository;

  const MyApp({super.key,  this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      TaskBloc(
        GetTasksUseCase(taskRepository!),
        AddTaskUseCase(taskRepository!),
        DeleteTaskUseCase(taskRepository!),
      )
        ..add(GetTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskListPage(taskRepository: taskRepository!),
        ),
    );
  }
}