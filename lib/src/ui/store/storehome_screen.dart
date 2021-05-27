import 'package:appreposteria/src/model/user_model.dart';
import 'package:appreposteria/src/other/colors.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class HomePage extends StatefulWidget {
  static const String route = "/HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height, width;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {},//TODO,
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomNavItem(0, Mdi.home),
              _buildBottomNavItem(1, Mdi.cart),
              _buildBottomNavItem(2, Mdi.shoppingOutline),
              _buildBottomNavItem(3, Mdi.accountSettings),
            ],
          ),
        ),
        body: _buildBody(constraints),
      );
      }
    );
  }

  _buildBottomNavItem(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        this._currentIndex = index;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: index == _currentIndex ? AppColors.kCategorypinkColor : Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          child: Icon(
            icon,
            color: index == _currentIndex
                ? Colors.white
                : AppColors.kCategorypinkColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

}
 _buildBody (constraints){
      var height = constraints.maxHeight;
      var width = constraints.maxWidth;
      return SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: 0.05 * height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                        '',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: AppColors.kCategorypinkColor,
                          backgroundImage: AssetImage("images/male_avatar.png"),                          
                        ),
                        
                      ],
                    ),
                  )
                ),
                 _buildRichText(),
                Container(
                  height: 0.56 * height,
                  width: width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [

                    ],
                  ),
                ),
              ]
            )
          ]
        )
       );   

 }
    _buildRichText() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 30,
            ),
            children: [
              TextSpan(
                  text: "Productos",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black)),
            ]),
      ),
    );
  }

