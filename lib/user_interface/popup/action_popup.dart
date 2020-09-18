import 'package:flutter/material.dart';

class ActionPopup extends StatelessWidget {
  
  final String title;
  final String text;
  final IconData icon;

  final String acceptMessage;
  final String denyMessage;

  final Function() onAccept;
  final Function() onDecline;

  ActionPopup({this.title = 'Info', this.text = '', this.icon = Icons.info_outline, this.acceptMessage = 'Accept', this.denyMessage: 'Deny', this.onAccept, this.onDecline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 70.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: 35.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 1.0,
                          height: 1.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 35.0,
                        ), onPressed: () { Navigator.pop(context, null); },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: FlatButton(
                            child: Text(acceptMessage),
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              if (onAccept != null)
                                onAccept();

                              Navigator.of(context).pop(true);
                            },
                          ),
                        ),
                      ),

                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: FlatButton(
                            child: Text(denyMessage),
                            onPressed: () {
                              if (onDecline != null)
                                onDecline();

                              Navigator.of(context).pop(false);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 1.0,
              width: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}