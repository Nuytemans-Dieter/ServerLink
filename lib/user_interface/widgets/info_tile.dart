import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget{
  
  final String title;
  final String description;

  final bool displayLine;
  final VoidCallback onTap;

  InfoTile(this.title, this.description, {this.displayLine: false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          if (onTap != null)
            onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 10.0,
              ),

              Text(
                this.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                ),
              ),

              SizedBox(
                height: 5.0,
              ),

              Text(
                this.description
              ),

              SizedBox(
                height: 10.0,
              ),

              if (displayLine)
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.black,
                ),
            ],
          ),
        ),
      ),
    );
  }

}