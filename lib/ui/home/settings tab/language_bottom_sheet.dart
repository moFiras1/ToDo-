import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class languageBottomSheet extends StatefulWidget {
  @override
  State<languageBottomSheet> createState() => _languageBottomSheetState();
}

class _languageBottomSheetState extends State<languageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bulidSlectedLang('English'),
          SizedBox(
            height: 18,
          ),
          bulidUnSlectedLang('Arabic')
        ],
      ),
    );
  }

  Widget bulidSlectedLang(String selectedLang) {
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedLang,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
          size: 28,
        )
      ],
    );
  }

  Widget bulidUnSlectedLang(String unSelectedLang) {
    return Text(
      unSelectedLang,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 18),
    );
  }
}
