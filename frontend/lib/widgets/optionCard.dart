import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

class optionCard extends StatefulWidget {
  const optionCard({Key? key}) : super(key: key);

  @override
  State<optionCard> createState() => _optionCardState();
}

class _optionCardState extends State<optionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: SizedBox(
            width: 300, // determines the size of the card
            height: 100,
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 20, 0)),
                Text(
                  'Initiate a new request',
                  style: TextStyle(
                      color: Color(0xff24A979), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
                // Icon(Icons.), //
                Icon(
                  MdiIcons.plusCircle,
                  color: Color(0xff24A979),
                ),
                //
              ],
            )),
      ),
    );
  }
}
