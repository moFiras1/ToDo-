import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/Theme/app_Theme.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/home/AddTaskBottomSheet.dart';
import 'package:todo/ui/home/settings%20tab/settings%20tab.dart';
import 'package:todo/ui/home/tasks_tab/task%20tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int selectedIndex = 0;
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(authProvider.databaseUser!.userName!),
        actions: [
          IconButton(
              onPressed: () {
                DialogUtils.showMessageDialog(context,
                    message: 'Are you sure you want to sign out',
                    posActionTitle: 'Comfirm', posAction: () {
                  logOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.LoginRoute);
                }, negActionTitle: 'Cancel');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.lightPrimaryColor,
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TasksTab(), SetteingsTab()];

  void logOut() {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    authProvider.signOut();
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
