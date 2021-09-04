import 'package:flutter/material.dart';
import 'package:yasaline/color.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class MatterItem extends StatelessWidget {
  final String matter;
  final String lawId;
  final String id;
  final String title;
  final String? description;
  final List? part;
  const MatterItem(
      {Key? key,
      required this.matter,
      required this.lawId,
      required this.id,
      required this.title,
      this.description,
      this.part})
      : super(key: key);

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
            onTap: () {
              //goto there matters
              if (part != null && part!.isNotEmpty) {
                context.vRouter.toNamed(
                  '/matter',
                  pathParameters: {'id': id, 'lawId': lawId},
                );
              }
            },
            //child
            child: Container(
              padding: const EdgeInsets.all(20.0),
              //ExpandablePanel child
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    inkWellBorderRadius: BorderRadius.circular(50),
                    tapHeaderToExpand: false,
                    iconColor: purp),
                //row
                header: description == null || description!.length < 5
                    ? null
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: purp,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(children: [
                              const FaIcon(
                                FontAwesomeIcons.gavel,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              //
                              Text(
                                'Matter $matter',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //titl
                          Text(
                            title,
                            style: TextStyle(color: black, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                //collapsed
                collapsed: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //if not decs then show icon here
                    description == null || description!.length < 5
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: purp,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(children: [
                              const FaIcon(
                                FontAwesomeIcons.gavel,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              //
                              Text(
                                'Matter $matter',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        //if not decs then show title here
                        description == null || description!.length < 5
                            ? title
                            : 'Note' ' - $description',
                        softWrap: true,
                        maxLines: description == null || description!.length < 5
                            ? null
                            : 2,
                        overflow: TextOverflow.fade,
                        style: description == null || description!.length < 5
                            ? TextStyle(color: black, fontSize: 14)
                            : TextStyle(
                                color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                expanded: Text(
                  description == null || description!.isEmpty
                      ? ''
                      : description!,
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
