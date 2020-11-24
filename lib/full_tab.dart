import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:otcui/homeTabPage.dart';

class FullTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullTabState();
  }
}

class FullTabState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  int selected = 0;
  TabController _tabController;
  FullTabState() {
    _tabController = TabController(length: 4, vsync: this);
  }
  Widget _appBar() {
    return AppBar(
      title: Text("泰达OTC"),
      elevation: 0,
      leading: FlatButton(
        child: Image.asset("assets/user.png"),
        onPressed: () {},
      ),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTabPage(),
          Container(
            child: Text("2"),
          ),
          Container(
            child: Text("3"),
          ),
          Container(
            child: Text("4"),
          )
        ],
      ),
      bottomNavigationBar: BottomTab(selected, (index) {
        setState(() {
          selected = index;
          _tabController.index = selected;
        });
      }),
    );

    /*
    floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    */
  }
}

class BottomTab extends StatelessWidget {
  final int selected;
  final void Function(int) choosed;
  BottomTab(this.selected, this.choosed);
  Widget _item(String img, String title, int index) {
    var textColor = Color(0xff787878);
    var imgTitle = img + ".png";
    if (index == selected) {
      textColor = Color(0xff2f52dd);
      imgTitle = img + "_selected.png";
    }
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        height: 74,
        child: FlatButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 25,
                child: Image.asset(imgTitle),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: textColor),
              )
            ],
          ),
          onPressed: () {
            choosed(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0, -1), // changes position of shadow
            ),
          ]),
          height: 82,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _item("assets/tab_home", "首页", 0),
              _item("assets/tab_order", "订单", 1),
              Container(
                width: 74,
                height: 74,
              ),
              _item("assets/tab_rewards", "奖励", 2),
              _item("assets/tab_wallet", "钱包", 3),
            ],
          ),
        ),
        Container(
          height: 82,
          child: OverflowBox(
            minWidth: 74,
            maxHeight: 100,
            child: CustomPaint(
              painter: BottomTabShadow(),
              child: ClipPath(
                clipper: BottomTabCliper(),
                child: Container(
                  height: 100,
                  width: 74,
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        width: 10,
                        height: 5,
                      ),
                      ClipOval(
                        child: Container(
                          width: 74,
                          height: 74,
                          color: Color(0xff2f52dd),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 17,
                                height: 26,
                                child: Image.asset("assets/start.png"),
                              ),
                              Text(
                                "开始交易",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Path _tabPath(Size size) {
  var path = Path();
  path.moveTo(10, 9);
  var firstControlPoint = Offset(size.width / 2, -9);
  var firstEndPont = Offset(size.width - 10, 9);
  path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
      firstEndPont.dx, firstEndPont.dy);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.close();
  return path;
}

class BottomTabShadow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var shadow = Shadow(
        color: Colors.grey.withOpacity(0.1),
        offset: Offset(0, -1),
        blurRadius: 0);
    var paint = shadow.toPaint();
    var path = _tabPath(size).shift(shadow.offset);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BottomTabCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 9);
    path.lineTo(10, 9);
    var firstControlPoint = Offset(size.width / 2, -9);
    var firstEndPont = Offset(size.width - 10, 9);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPont.dx, firstEndPont.dy);
    path.lineTo(size.width - 10, 9);
    path.lineTo(size.width, 9);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
