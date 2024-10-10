import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/database/model/taskDao.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/widgets/coustme_text_form_field.dart';

import '../../core/utils/date_formatter.dart';
import '../../database/model/task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var taskTitleController = TextEditingController();

  var taskDescriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
            CustomTextFormField(
              label: 'Task Title',
              KeyBoardType: TextInputType.text,
              controller: taskTitleController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'please enter task title';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              label: 'Task Description',
              KeyBoardType: TextInputType.text,
              controller: taskDescriptionController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'please enter task description';
                } else {
                  return null;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Date',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            InkWell(
              onTap: () {
                chooseTaskDate(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                child: Text(
                  formatDate(finalSelectedDate),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  createTask();
                },
                child: Text('Add Task')),
          ],
        ),
      ),
    );
  }

  void createTask() async {
    var authProvider =
        Provider.of<AppAuthProvider>(context, listen: false); //valid form
    if (formKey.currentState?.validate() == false) return;
    // add task to fire store
    Task task = Task(
      id: authProvider.databaseUser!.id!,
      title: taskTitleController.text,
      description: taskDescriptionController.text,
      taskDate: Timestamp.fromMillisecondsSinceEpoch(
          finalSelectedDate.millisecondsSinceEpoch),
    );

    DialogUtils.ShowLaodingDialog(context, 'creating task...');
    await TasksDao.addTask(task, authProvider.databaseUser!.id!);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: 'Task Created Successfully',
      posActionTitle: 'OK',
      posAction: () {
        Navigator.pop(context);
      },
    );
  }

  var finalSelectedDate = DateTime.now();

  void chooseTaskDate(BuildContext context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (userSelectedDate != null) {
      finalSelectedDate = userSelectedDate;
      setState(() {});
    }
  }
}
