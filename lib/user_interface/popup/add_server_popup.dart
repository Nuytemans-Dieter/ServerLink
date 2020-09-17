import 'package:flutter/material.dart';

class AddServerPopup extends StatefulWidget{
  
  final Function(String ip, String port) onSubmit;

  AddServerPopup({this.onSubmit});

  @override
  State<StatefulWidget> createState() {
    return _AddServerPopupState();
  }

}

class _AddServerPopupState extends State<AddServerPopup> {
  
  String _ip = '';
  String _port = '';

  TextEditingController _ipFieldController;

  @override
  void initState()
  {
    super.initState();

    _ipFieldController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    double topSpacing = MediaQuery.of(context).size.height/10;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: topSpacing, left: 8.0, right: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Title
                  Text(
                    'Add a server',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),


                  // Input server IP
                  Text(
                    'Server IP',
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ipFieldController,
                    maxLength: 15,
                    onTap: () {
                      _ipFieldController.selection = TextSelection.fromPosition(TextPosition(offset: _ipFieldController.text.length));
                    },
                    enableInteractiveSelection: false,
                    onChanged: (String value) async {
                      
                      // This await is required to be able to add a character to the controller
                      await new Future.delayed(const Duration(milliseconds: 1));

                      // Detect back button usage
                      if (value.length < _ip.length)
                      {
                        String lastIpChar = _ip.substring( _ip.length-1 );
                        if (lastIpChar == '.' && _ip.length > 1)
                        {
                          _ipFieldController.text = _ip.substring(0, _ip.length-2);

                          // Move the cursor to the right
                          _ipFieldController.selection = TextSelection.fromPosition(TextPosition(offset: _ipFieldController.text.length));
                        }

                        _ip = _ipFieldController.text;
                        return;
                      }

                      String numbersOnly = value.replaceAll('.', '');
                      String addedChar = _ipFieldController.text.substring( _ipFieldController.text.length-1 );
                      int numDots = '.'.allMatches(_ipFieldController.text).length;

                      // Only allow . and numbers as input
                      if (addedChar != '.' && double.tryParse( addedChar ) == null)
                      {
                        _ipFieldController.text = _ip;
                        _ipFieldController.selection = TextSelection.fromPosition(TextPosition(offset: _ipFieldController.text.length));
                        return;
                      }

                      // Handle user-dot setting
                      if (addedChar == '.')
                      {
                        List<String> parts = _ipFieldController.text.split('.');
                        String totalIp = '';
                        for (String part in parts)
                        {
                          if (part != '')
                          {
                            for (int i = part.length; i < 3; i++) {
                              totalIp += 0.toString();
                            }
                            totalIp += part + '.';
                          }
                        }

                        if (numDots > 3)
                        {
                          totalIp = _ipFieldController.text.substring(0, _ip.length);
                        }

                        _ipFieldController.text = totalIp;
                        _ipFieldController.selection = TextSelection.fromPosition(TextPosition(offset: _ipFieldController.text.length));
                      }

                      // Handle automatic dot setting
                      if (numbersOnly.length % 3 == 0 && numDots < 3) {

                        // Add a dot 
                        if (addedChar != '.')
                          _ipFieldController.text += '.';
                        
                        // Move the cursor to the right
                        _ipFieldController.selection = TextSelection.fromPosition(TextPosition(offset: _ipFieldController.text.length));
                      }
                      
                      // Keep the ip variable up to date
                      _ip = _ipFieldController.text;
                    },
                  ),

                  SizedBox(
                    height: 15.0,
                  ),

                  // Input server port
                  Text(
                    'Server port (not the same as in Minecraft)',
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: width / 1.5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      onChanged: (String value) => _port = value,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context), 
                        child: Text(
                          'Cancel',
                        ),
                      ),

                      FlatButton(
                        onPressed: () {
                          if (widget.onSubmit != null)
                            widget.onSubmit(_ip, _port);
                          Navigator.pop(context);
                        }, 
                        child: Text(
                          'Add server',
                          style: TextStyle(
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    ],
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