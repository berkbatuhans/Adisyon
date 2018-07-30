import 'dart:async';

import 'package:adisyon/auth.dart';
import 'package:adisyon/constants/constants.dart';
import 'package:adisyon/models/restaurantarea.dart';
import 'package:adisyon/screens/Tables/Tables.dart';
import 'package:adisyon/services/api.dart';
import 'package:flutter/material.dart';

class Adisyon extends StatefulWidget {
  Adisyon({Key key, this.auth, this.onSignedOut}) : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  Text title;
  @override
  _AdisyonState createState() => _AdisyonState();
}

class _AdisyonState extends State<Adisyon> with TickerProviderStateMixin {
  List<Tab> _tabs = [];
  TabController _controller;
  List<RestaurantArea> _restaurantArea;
  AdisyonApi _api;
  bool _loadingInProgress;
  void title() async {
    widget.auth.currentUser().then((userId) {
      widget.title = new Text(userId);
    });
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  _getAppBar() {
    return new AppBar(
      title: widget.title ?? new Text("Adisyon"),
      bottom: new TabBar(
        isScrollable: true,
        controller: _controller,
        tabs: _tabs,
        indicatorColor: Colors.white,
      ),
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: _signOut,
        )
      ],
    );
  }

  Future _loadRestaurantArea() async {
    final api = await AdisyonApi.adisyonApi();
    final restaurantarea = await api.getRestaurantArea();
    setState(() {
      _api = api;
      _restaurantArea = restaurantarea;
      _restaurantArea.forEach((i) => _tabs.add(new Tab(
            key: Key(i.name),
            text: i.name,
          )));
      _tabs = _tabs;
    });

    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );

    _controller.addListener(() {
      print('${_controller.index} - Tıklandı');
    });

    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  _reloadTables() async {
    if (_api != null) {
      final restaurantarea = await _api.getRestaurantArea();
      setState(() {
        _restaurantArea = restaurantarea;
        _restaurantArea.forEach((i) => _tabs.add(new Tab(
              key: Key(i.name),
              text: i.name,
            )));
        _tabs = _tabs;
      });
    }
  }

  Future<Null> _handleRefresh() async {
    _reloadTables();
    return new Future<Null>.value();
  }

  @override
  void initState() {
    title();
    _loadRestaurantArea();
    super.initState();
    //_loadingInProgress = true;
  }
  /*void _handleTabSelection() async {
    setState(() {
      print('${_controller.index} - Tıklandı.');
    });
  }*/

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    if (_loadingInProgress == false) {
      return Scaffold(
        appBar: _getAppBar(),
        body: new TabBarView(
          controller: _controller,
          children: createTableWidget(),
        ),
      );
    } else {
      return new Container(
        color: Colors.black,
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }
  }

  createTableWidget() {
    Constants constants = new Constants();
    return _tabs.map((Tab tab) {
      return new TableWidget(
        setColor: null,
        table: constants.allTableGenerate(),
      );
    }).toList();
  }
}
