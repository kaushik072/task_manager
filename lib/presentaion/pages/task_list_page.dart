import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/repository/task_repository.dart';
import '../bloc/task_bloc.dart';
import '../widgets/add_task_dialogue.dart';
import '../widgets/task_list_widget.dart';

class TaskListPage extends StatefulWidget {
  final TaskRepository taskRepository;

  const TaskListPage({Key? key, required this.taskRepository})
      : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return taskList(context, state);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTaskDialog(taskRepository: widget.taskRepository);
            },
          );
        },
        child: const Icon(Icons.add),
      )
      ,
    );
  }
}


