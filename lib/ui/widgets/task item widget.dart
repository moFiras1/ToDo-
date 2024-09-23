import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 65,
              decoration: BoxDecoration(
                  color: Theme.of(context)!.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              width: 8,
            ), // Diveder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [Text('task Title'), Text('task description')],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context)!.primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
