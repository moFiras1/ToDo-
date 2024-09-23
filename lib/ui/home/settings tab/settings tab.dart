import 'package:flutter/material.dart';
import 'package:todo/ui/home/settings%20tab/language_bottom_sheet.dart';
import 'package:todo/ui/home/settings%20tab/theme_bottom_sheet.dart';

class SetteingsTab extends StatefulWidget {
  @override
  State<SetteingsTab> createState() => _SetteingsTabState();
}

class _SetteingsTabState extends State<SetteingsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context)!.colorScheme.onPrimary,
                  border: Border.all(
                      color: Theme.of(context)!.primaryColor, width: 3),
                  shape: BoxShape.rectangle,
                ),
                child: Text('Light')),
          ), //Theme
          SizedBox(
            height: 18,
          ),
          Text(
            'Language',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              showLangBottomSheet();
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                  shape: BoxShape.rectangle,
                ),
                child: Text('English')),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }

  void showLangBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => languageBottomSheet(),
    );
  }
}
