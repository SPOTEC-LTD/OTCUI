import 'package:flutter/material.dart';

class HomeTabPage extends StatelessWidget {
  Widget _headElement(List<Widget> children) {
    return Container(
      height: 55,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _headCell(String img, String title, String price, String type) {
    return _headElement([
      Container(
        margin: EdgeInsets.only(right: 10),
        width: 29,
        height: 29,
        child: Image.asset(img),
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xff606060),
        ),
      ),
      Spacer(),
      Row(
        textBaseline: TextBaseline.ideographic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff2f52dd),
            ),
          ),
          Text(
            type,
            style: TextStyle(fontSize: 10, color: Color(0xff8b8b8b)),
          )
        ],
      )
    ]);
  }

  Widget _headBGColum(String title, String price) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Color(0xff8c9ee5)),
            ),
            Container(
              width: 1,
              height: 6,
            ),
            Text(price,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _headBG() {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _headBGColum("今日完成订单数", "100"),
          _headBGColum("今日交易佣金(CNY)", "10,000"),
        ],
      ),
    );
  }

  Widget _head() {
    return Container(
        child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipPath(
            clipper: BottomCliper(),
            child: Container(
              color: Color(0xff2f52dd),
              height: 210,
              child: _headBG(),
            )),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          height: 120,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              color: Colors.white,
              child: Column(
                children: [
                  _headCell("assets/iconSell.png", "今日出售额", "10,000", " CNY"),
                  Divider(
                    height: 1,
                  ),
                  _headCell("assets/iconBuy.png", "今日购买额", "1000", " CNY")
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _listCell(String title, String desc) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 3,
                          height: 3,
                          color: Color(0xff73ccff),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                      ),
                      Flexible(
                        child: Text(
                          "出售政策调整123sssaa",
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff494949)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 5,
                  ),
                  Expanded(
                    child: Text(
                      "lsdkjflsdjfl拉科技大拉手肯定积分阿里斯顿会计法拉斯加快递费，，阿里斯顿可减肥啦alk，老师看到就废了",
                      softWrap: false,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xffababab), fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _list(Widget head) {
    var title = Column(
      children: [
        head,
        Container(
          padding: EdgeInsets.only(left: 20),
          height: 50,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 24,
                height: 24,
                child: Image.asset("assets/iconReport.png"),
              ),
              Text(
                "公告",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xff8b8b8b)),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
    var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 99, 6, 1, 2, 3, 1];
    return ListView.builder(
      itemCount: array.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return title;
        }
        return _listCell("$index", "desc");
      },
      //
    );
  }

  Widget _body() {
    return _list(_head());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _body(),
      onRefresh: () async {
        return Future.delayed(Duration(seconds: 2));
      },
    );
  }
}

class BottomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // 路径
    var path = Path();
    // 设置路径的开始点
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);

    // 设置曲线的开始样式
    var firstControlPoint = Offset(size.width / 2, size.height);
    // 设置曲线的结束样式
    var firstEndPont = Offset(size.width, size.height - 50);
    // 把设置的曲线添加到路径里面
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPont.dx, firstEndPont.dy);

    // 设置路径的结束点
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);

    // 返回路径
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
