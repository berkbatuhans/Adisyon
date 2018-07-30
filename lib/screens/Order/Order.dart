import 'package:adisyon/constants/constants.dart';
import 'package:adisyon/models/category.dart';
import 'package:adisyon/models/choice.dart';
import 'package:flutter/material.dart';
import 'package:adisyon/models/table.dart';

class Order extends StatefulWidget {
  final Tables table;

  const Order({Key key, this.table}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin {
  List<Tab> _tabs;
  TabController _controller;
  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  flatList() {
    Constants constants = new Constants();
    for (var item in constants.mutfaklar().reversed) {
      return new Text(item);
    }
    /*constants.mutfaklar().forEach((item){
      return _flatWidget.add(items(new Category(name: item, color: ColorCode.color6)));
    }
    );*/
  }

  FlatButton items(Category cat) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        print(cat.name);
      },
      color: cat.color,
      child: new Text(
        cat.name,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  _gridCategories() {
    Constants category = Constants();
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 3.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      //controller: new ScrollController(keepScrollOffset: true),
      //reverse: false,
      addAutomaticKeepAlives: true,
      physics: ScrollPhysics(),
      children: [flatList()],
    );
  }

  Widget _actions() {
    return PopupMenuButton<Choice>(
      onSelected: _select,
      itemBuilder: (BuildContext context) {
        return choices.skip(2).map((Choice choice) {
          return PopupMenuItem<Choice>(
            value: choice,
            child: Text(choice.title),
            enabled: false,
          );
        }).toList();
      },
    );
  }


  Widget _orderProduct() => new LayoutBuilder(
    builder: (context,constraints) => new Column(
      children: <Widget>[
        new Container(
          child: new Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: new Container(
              constraints: new BoxConstraints(maxHeight: 150.0, maxWidth: constraints.maxWidth),
              child: new Scrollbar(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: new GridView.count(
                    shrinkWrap: false,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 3,
                    children: <Widget>[
                      items(new Category(name: "Mutfak - 1", color: Colors.red)),
                      items(new Category(name: "Mutfak - 2", color: Colors.red)),
                      items(new Category(name: "Mutfak - 3", color: Colors.red)),
                      items(new Category(name: "Mutfak - 4", color: Colors.red)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    )
  );
  List<Widget> _orderMenu() {
    return _tabs.map((Tab tab) {
      return new Row(
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.up,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        //children: <Widget>[_gridCategories()],
        children: <Widget>[
          new Container(
            color: Colors.red,
            child: new Text(widget.table.name),
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Sipariş - ${widget.table.name}"),
        actions: <Widget>[_actions()],
        bottom: new TabBar(
          tabs: _tabs,
          controller: _controller,
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        //children: _orderMenu(),
        children: <Widget>[_orderProduct()],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = [
      new Tab(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Icon(Icons.restaurant_menu),
                  new Text(" MENÜ"),
                ],
              ),
            )
          ],
        ),
      ),
      new Tab(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Icon(Icons.shopping_basket),
                  new Text(" ADİSYON"),
                ],
              ),
            )
          ],
        ),
      )
    ];

    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
