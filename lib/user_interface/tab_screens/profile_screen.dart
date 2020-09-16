import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen>{

  String displayname = 'Anonymous user';

  TextEditingController _nameTextController = TextEditingController();

  void saveName(String newName)
  {
    setState(() {
      displayname = newName;
    });
  }

  @override
  void initState()
  {
    super.initState();

    _nameTextController.text = displayname;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Profile settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          Text('Displayname'),

          // Name input field
          TextFormField(
            controller: _nameTextController,
            onEditingComplete: () {
              saveName( _nameTextController.text );
            },
          ),

          // Save buttin
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              tooltip: 'Save',
              icon: Icon(
                Icons.check,
                color: Colors.green.shade400,
              ), 
              onPressed: () {
                saveName( _nameTextController.text );
              }
            ),
          ),
        ],
      ),
    );
  }
}