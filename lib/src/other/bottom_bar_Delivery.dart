
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/ui/Delivery/Delivery_HomeScreen.dart';
import 'package:appreposteria/src/ui/Delivery/Delivery_OrdersScreen.dart';
import 'package:appreposteria/src/ui/Delivery/Delivery_ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';


class BottomBarDelivery extends StatefulWidget {
  @override
  _BottomBarDeliveryState createState() => _BottomBarDeliveryState();
}

class _BottomBarDeliveryState extends State<BottomBarDelivery> {
 late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': DeliveryHomeScreen(),
      },
      {
        'page': DeliveryOrdersScreen(),
      },
      {
        'page': DeliveryProfileScreen(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: AppColors.kWhiteColor,
              selectedItemColor: AppColors.kCategorypinkColor,
              currentIndex: _selectedPageIndex,
              unselectedItemColor: Colors.grey.shade700,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Mdi.emailCheckOutline),
                  label: 'Buscar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                  label: 'Mis Pedidos',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
