
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/task_model.dart';
import '../bloc/task_bloc.dart';

  Widget taskList(BuildContext context,TaskState state) {
        if (state is LoadedState) {
          return ListView.separated(
            separatorBuilder: (context,index)=> const SizedBox(height: 5,),
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(8,8,8,0),
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(task.title,style: const TextStyle(fontSize: 18),),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialogue(context,task);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is ErrorState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: Text('Unknown state'));}
  }

   showDialogue(BuildContext context,Task task){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: const Text("Are you sure want to delete?",style: TextStyle(fontSize: 16),),
        actions: [
          textButton(()=> delete(context, task), "Yes"),
          textButton(()=> Navigator.pop(context), "No"),
        ],
      );
    });

  }

  Widget textButton(Function onTap,String label){
    return TextButton(onPressed: ()=> onTap(),child: Text(label,style: const TextStyle(fontSize: 16,color: Colors.purple),),);
  }

  delete(BuildContext context , Task task){
    context.read<TaskBloc>().add(DeleteTaskEvent(task));
    Navigator.pop(context);
  }
