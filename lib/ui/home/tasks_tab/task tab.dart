import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/model/taskDao.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/widgets/task%20item%20widget.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AppAuthProvider>(context);

    return Column(
      children: [
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.transparent,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              selectedBackgroundColor: Theme.of(context).primaryColor,
              compactMode: true,
              weekDaySelectedColor: Theme.of(context).primaryColor,
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.SHORT,
              backgroundColor: Theme.of(context)!.primaryColor,
              headerTextColor: Colors.black),
          onChangeDateTime: (datetime) {
            selectedDate = datetime.toDateTime();
            setState(() {});
            print(datetime.getDate());
          },
        ),
        StreamBuilder(
          stream: TasksDao.getAllTasksRealTime(
              authprovider.databaseUser!.id!, selectedDate!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            var taskList = snapshot.data?.docs
                .map(
                  (docSnapShot) => docSnapShot.data(),
                )
                .toList();
            return Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) =>
                  TaskItemWidget(task: taskList![index]),
              itemCount: taskList?.length ?? 0,
            ));
          },
        )
      ],
    );
  }
}
