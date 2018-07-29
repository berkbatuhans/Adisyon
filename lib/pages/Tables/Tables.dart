import 'package:adisyon/models/table.dart';
import 'package:adisyon/pages/Order/Order.dart';
import 'package:adisyon/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:adisyon/enums/Enum.dart';

class TableWidget extends StatefulWidget {
  final Color setColor;
  final List<Tables> table;

  const TableWidget({Key key, @required this.setColor, @required this.table})
      : super(key: key);

  @override
  _TableWidgetState createState() {
    return new _TableWidgetState();
  }
}

class _TableWidgetState extends State<TableWidget> {
  createTableWidget() {
    return widget.table.map((Tables table) {
      return InkWell(
        onTap: () {
          _navigateToOrder(table);
        },
        child: new ConstrainedBox(
          constraints: new BoxConstraints.expand(height: 100.0),
          child: new Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(17.5),
            ),
            color: table.empty == isEmty.Empty
                ? Colors.green[900]
                : Colors.red[900],
            elevation: 5.0,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    new Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        new Padding(
                            padding: EdgeInsets.only(left: 12.5, top: 12.5),
                            child: new Icon(
                              table.empty == isEmty.Full
                                  ? Icons.restaurant_menu
                                  : Icons.restaurant,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    new Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(right: 12.5, top: 12.5),
                          child: new Icon(
                            Icons.room_service,
                            color: table.ready == isReady.Ready
                                ? Colors.redAccent
                                : Colors.lightGreenAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                new Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    new Text(
                      table.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  _navigateToOrder(Tables tables) {
    Navigator.of(context).push(new FadePageRoute(
        builder: (c) {
          return new Order(table: tables);
        },
        settings: new RouteSettings()));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: widget.setColor,
      child: new Scrollbar(
        child: GridView.count(
          mainAxisSpacing: 5.0,
          padding: EdgeInsets.all(7.5),
          childAspectRatio: 1.45,
          crossAxisSpacing: 0.0,
          crossAxisCount: 3,
          children: createTableWidget(),
        ),
      ),
    );
  }
}
