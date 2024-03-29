import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/task_model.dart';
import '../../domain/repository/task_repository.dart';
import '../bloc/task_bloc.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskRepository taskRepository;

  const AddTaskDialog({Key? key, required this.taskRepository})
      : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.close)),
          ],
        ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text('Add Task'),
          ),
        ],
      ),
      content: Form(
          key: formKey,
        child: TextFormField(
          cursorColor: Colors.blue,
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: "Title",
            hintText: "Enter title...",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              labelStyle: textStyle(),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,width: 2))),
          validator: (value){
            if(value == null || value.isEmpty){
              return "enter the title";
            }
            return null;
          },
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            key: const Key('addTask'),
            onTap: () {
              if(formKey.currentState!.validate()){
              final title = textEditingController.text;
                final task = Task(id: DateTime.now().toString(), title: title);
                context.read<TaskBloc>().add(AddTaskEvent(task));
                Navigator.pop(context);}
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Text(
                  'Add task',
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 16, color: Colors.blue);
  }
}
