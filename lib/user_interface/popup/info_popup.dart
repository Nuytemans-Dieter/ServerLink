import 'package:flutter/material.dart';

class InfoPopup extends StatelessWidget{
  
  final String title;
  final String text;

  InfoPopup({this.title: 'Info', this.text: ''});
  
  @override
  Widget build(BuildContext context) {

    double topSpacing = MediaQuery.of(context).size.height/10;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: topSpacing, left: 8.0, right: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [

                  Text(
                    this.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  Text(
                    this.text,
                    textAlign: TextAlign.justify,
                  ),

                  FlatButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text('Got it!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}