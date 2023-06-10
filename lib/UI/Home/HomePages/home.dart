import 'package:flutter/material.dart';
import 'customIcons.dart';
import 'data.dart';
import 'dart:math';
import '../../Styles/AppStyles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomePageState extends State<HomePage> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Mindful Activties",
                  style: headerTextStyle,
                ),
              ],
            ),

            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: images.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            ),
            //   Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text("Take a deep breath",
            //           style: TextStyle(
            //             color: Colors.black54,
            //             fontSize: 30.0,
            //             fontFamily: "Montserrat-Medium",
            //             letterSpacing: 1.0,
            //           )),

            //     ],
            //   ),
            // ),

            // SizedBox(
            //   height: 20.0,
            // ),
//             SingleChildScrollView(

//               scrollDirection: Axis.horizontal,
//               child:
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[

//                   Padding(
//                     padding: EdgeInsets.only(left: 18.0),
//                     child:
//                              ClipRRect(
//                       borderRadius: BorderRadius.circular(20.0),
//                       child:

//                           Stack(

//                     children: <Widget>[
//                        ColorFiltered(
//   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken),
//   child: Image.asset("assets/games_01.jpg",width: 296.0, height: 222.0,
//                           fit: BoxFit.fill),
// )  ,

//                       Positioned(child:Text("Mindful Games",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 30.0,
//                                       fontFamily: "Poppins-Bold")),top: 80,left: 20,),

//                     ],
//                   ),
//                     ),

//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 18.0,right: 18),
//                     child:

//                    ClipRRect(
//                       borderRadius: BorderRadius.circular(20.0),
//                       child:

//                           Stack(

//                     children: <Widget>[
//                        ColorFiltered(
//   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken),
//   child: Image.asset("assets/image_06.jpg",width: 296.0, height: 222.0,
//                           fit: BoxFit.cover),
// )  ,

//                       Positioned(child:Text("Live Events",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 30.0,
//                                       fontFamily: "Poppins-Bold")),top: 80,left: 55,),

//                     ],
//                   ),
//                     ),

//                   )
//                 ],
//               ),
//               ),

//               SizedBox(
//                 height: 30.0,
//               ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList =  [];

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.25), BlendMode.darken),
                        child: Image.asset(
                          images[i],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(title[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontFamily: "Poppins-Medium")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
