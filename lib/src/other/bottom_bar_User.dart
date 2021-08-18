
import 'package:appreposteria/src/other/colors.dart';

import 'package:appreposteria/src/ui/store/Search_Screen.dart';
import 'package:appreposteria/src/ui/store/cart_screen.dart';
import 'package:appreposteria/src/ui/store/order_screen.dart';
import 'package:appreposteria/src/ui/store/storehome_screen.dart';
import 'package:appreposteria/src/ui/user/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';


class BottomBarUser extends StatefulWidget {
  @override
  _BottomBarUserState createState() => _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
 late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePage(),
      },
      {
        'page': ShoppingCartWidget(),
      },
      {
        'page': SearchScreen(),
      },
      {
        'page': OrderScreen(),
      },
      {
        'page': ProfileUI2(),
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
              color: AppColors.kCategorypinkColor,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: AppColors.kCategorypink2Color,
              currentIndex: _selectedPageIndex,
              unselectedItemColor: Colors.grey.shade700,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Mdi.cart),
                  label: 'Carrito',

                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  label: 'Buscar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                  label: 'Mis Pedidos',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                 label: 'Mi Perfil',

                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.kCategorypinkColor,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Añadir Producto',
          elevation: 4,
          child: Icon(Mdi.plus),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }

}
