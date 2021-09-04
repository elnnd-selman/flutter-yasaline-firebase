import 'package:flutter/material.dart';
import 'package:yasaline/color.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class PartItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;

  const PartItem({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //padding
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //ClipRRect
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        //Material
        child: Material(
          color: Colors.white,
          //InkWell
          child: InkWell(
            splashColor: purp,
            //ontab
            onTap: () {},
            //child
            child: Container(
              padding: const EdgeInsets.all(20.0),
              //ExpandablePanel child
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    inkWellBorderRadius: BorderRadius.circular(50),
                    tapHeaderToExpand: false,
                    iconColor: black),
                //row
                header: description.length < 5
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //icon
                            Icon(
                              Icons.text_snippet,
                              color: black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //title
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(color: black, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                //collapsed
                collapsed: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //if not decs then show icon here
                    description.length < 5
                        ? Icon(
                            Icons.text_snippet,
                            color: black,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        //if not decs then show title here
                        description.length < 5
                            ? title
                            : 'Note' ' - $description',
                        softWrap: true,
                        maxLines: description.length < 5 ? null : 2,
                        overflow: TextOverflow.fade,
                        style: description.length < 5
                            ? TextStyle(color: black, fontSize: 14)
                            : TextStyle(
                                color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                expanded: Text(
                  description,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
