import 'package:flutter/material.dart';
import 'package:server_link_client/user_interface/tab_screen_wrapper.dart';
import 'package:server_link_client/user_interface/tab_screens/info_screen.dart';
import 'package:server_link_client/user_interface/tab_screens/profile_screen.dart';
import 'package:server_link_client/user_interface/tab_screens/servers_screen.dart';

class ScreenHolder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScreenHolderState();
  }
}

class _ScreenHolderState extends State<ScreenHolder> with SingleTickerProviderStateMixin{
  
  List< TabScreenWrapper > screens;
  TabController _tabController;

  @override
  void initState()
  {
    super.initState();

    screens = new List< TabScreenWrapper >();
    screens.add(
      new TabScreenWrapper('Servers', ServersScreen())
    );
    screens.add(
      new TabScreenWrapper('Profile', ProfileScreen()),
    );
    screens.add(
      new TabScreenWrapper('Info', InfoScreen()),
    );

    _tabController = TabController(
      length: screens.length,
      initialIndex: 1,
      vsync: this,
    );

    // _tabController.addListener(() {
      
    // });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ServerLink'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget> [
            for (TabScreenWrapper wrapper in screens)
              Tab(text: wrapper.tabName)
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          for (TabScreenWrapper wrapper in screens)
            wrapper.child,
        ],
      ),
    );
  }
}