
import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/ui/admin/admin_home_screen.dart';
import 'package:appreposteria/src/ui/admin/orders_screen.dart';
import 'package:appreposteria/src/ui/admin/products_list_screen.dart';
import 'package:appreposteria/src/ui/admin/upload_products_screen.dart';
import 'package:appreposteria/src/ui/admin/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';


class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
 late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': AdminHomePage(),
      },
      {
        'page': UsersList(),
      },
      {
        'page': UploadProducts(),
      },
      {
        'page': OrdersScreen(),
      },
      {
        'page': ProductList(),
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
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed),
                                    label: 'Lista de usuarios',

                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  label: 'Agregar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                                    label: 'Pedidos',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                 label: 'Productos',

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
