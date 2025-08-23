import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  bool isHeart = false;
  final String title ;
  CustomAppBar({super.key, this.isHeart = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Color(0xff01727A)),
            ),
            Spacer(),
            isHeart
                ? Icon(Icons.favorite_border_outlined, color: Color(0xff01727A), size: 25)
                : Stack(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Color(0xff01727A),
                        size: 25,
                      ),
                      Positioned(
                        top: 2,
                        right: 1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(width: 15),
          ],
        ),
        Divider(thickness: 1,
          color: Color(0xffA0A0A0).withOpacity(0.5),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
