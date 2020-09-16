import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadServerTile extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    
    double imageSize = MediaQuery.of(context).size.width / 6;

    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Server image
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Container(
                  height: imageSize,
                  width: imageSize,
                  color: Colors.black,
                ),
              ),

              // Server info: name and MOTD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    child: Text(
                      'Server name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    child: Text(
                      'Server MOTD here :-)'
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
  
}