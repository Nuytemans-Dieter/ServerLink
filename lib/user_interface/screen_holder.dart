import 'package:flutter/material.dart';
import 'package:server_link_client/user_interface/tab_screen_wrapper.dart';
import 'package:server_link_client/user_interface/tab_screens/info_screen.dart';
import 'package:server_link_client/user_interface/tab_screens/profile_screen.dart';
import 'package:server_link_client/user_interface/tab_screens/servers_screen.dart';

class ScreenHolder extends StatefulWidget {
  
  final Color tabTextColor = Colors.white;
  
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
      initialIndex: 0,
      vsync: this,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ServerLink MC',
          style: TextStyle(
            color: widget.tabTextColor,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget> [
            for (TabScreenWrapper wrapper in screens)
              Tab(
                child: Text(
                  wrapper.tabName,
                  style: TextStyle(
                    color: widget.tabTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: widget.tabTextColor,
        ),
        onPressed: () {print('Add server');},
      ),
    );
  }
}