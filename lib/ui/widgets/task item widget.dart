import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/date_formatter.dart';
import 'package:todo/database/model/task.dart';
import 'package:todo/database/model/taskDao.dart';
import 'package:todo/providers/app_auth_provider.dart';

class TaskItemWidget extends StatefulWidget {
  Task task;

  TaskItemWidget({required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        extentRatio: 0.2,

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              myTaskDelete();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 65,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: 20,
              ), // Diveder
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.task.title ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400),
                    ), //title
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.task.description ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ), //description
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          size: 20,
                        ),
                        Text(
                          formatDate(widget.task.taskDate!.toDate()) ?? '',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ), //date
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void myTaskDelete() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    await TasksDao.deleteTask(authProvider.databaseUser!.id!, widget.task.id!);
  }
}
