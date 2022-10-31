import 'package:basalt/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class MultiPurposeCourseCard extends StatefulWidget {
  const MultiPurposeCourseCard({
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final onTap;

  @override
  State<MultiPurposeCourseCard> createState() => _MultiPurposeCourseCardState();
}

class _MultiPurposeCourseCardState extends State<MultiPurposeCourseCard> {
  bool isPressedDown = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: Feedback.wrapForTap(() async {
            setState(() {
              isPressedDown = true;
            });
            await Future.delayed(Duration(milliseconds: 300));
            widget.onTap();
            setState(() {
              isPressedDown = false;
            });
          }, context),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title.trim().toLowerCase().titleCase,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      if (widget.subTitle.length > 0)
                        Column(
                          children: [
                            SizedBox(height: 4),
                            Text(
                              widget.subTitle,
                              style: TextStyle(
                                color:  Color(0xAA000000),
                                fontSize: 12.0,
                                fontStyle: FontStyle.italic,
                                height: 1.2,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                SizedBox(width: 24.0),


              ],
            ),
          ),
        ),
      ],
    );
  }
}
