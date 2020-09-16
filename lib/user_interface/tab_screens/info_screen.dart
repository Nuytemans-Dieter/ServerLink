import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:server_link_client/user_interface/popup/info_popup.dart';
import 'package:server_link_client/user_interface/widgets/info_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _InfoScreenState();
  }
}

class _InfoScreenState extends State<InfoScreen>{

  String _fullVersion;

  @override
  void initState()
  {
    super.initState();

    getVersion();
  }

  void getVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        _fullVersion = packageInfo.appName + ' ' + packageInfo.version + '+' + packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'App information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              ),
            ),
          ),
        ),
        
        InfoTile('App version', 'You are using $_fullVersion', displayLine: true,),
        InfoTile('Creator', 'This app was created for free by a passionate, aspiring software engineer.', displayLine: true,),
        InfoTile('GitHub', 'Press here to view this open source project on GitHub', displayLine: true, 
          onTap: () async {
            const String url = 'https://github.com/Nuytemans-Dieter/ServerLink';
            if (await canLaunch(url))
              launch(url);
            else 
              showDialog(
                context: context,
                child: InfoPopup(
                  title: 'Woops!',
                  text: 'We encountered a problem while redirecting you to our GitHub page:\n$url\n\n Please contact us on the email below if this problem persists.\n magnetar.apps@gmail.com',
                ),
              );
          },
        ),
        InfoTile('Contact', 'magnetar.apps@gmail.com'),
      ],
    );
  }
}