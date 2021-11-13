import 'package:flutter/material.dart';
import 'HomePage.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            SizedBox(height: 30),
            _createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePageItem(
                              selectedIndex: 0,
                            )),
                  );
                }),
            _createDrawerItem(
                icon: Icons.video_camera_back_outlined,
                text: 'Media',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePageItem(
                              selectedIndex: 1,
                            )),
                  );
                }),
            _createDrawerItem(
                icon: Icons.favorite_rounded,
                text: 'Give',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePageItem(
                              selectedIndex: 2,
                            )),
                  );
                }),
            _createDrawerItem(
                icon: Icons.connect_without_contact,
                text: 'Connect',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePageItem(
                              selectedIndex: 3,
                            )),
                  );
                }),
            _createDrawerItem(
                icon: Icons.event_available_outlined,
                text: 'Events',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePageItem(
                              selectedIndex: 4,
                            )),
                  );
                }),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 3,
            // ),
            // ListTile(
            //   title: Center(child: Text('Powered by FaithPays')),
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         fit: BoxFit.scaleDown,
      //         image: AssetImage('assets/images/ekm.png'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //SizedBox(height: 30),
          Image.asset(
            "assets/images/TCC-Logo.png",
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),

      // Stack(
      //   children: <Widget>[
      //     Positioned(
      //       bottom: 12.0,
      //       left:30,
      //       child: Center(
      //         child: Text(
      //          "",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 14,
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 28,
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.0),
            child: Text(text,
                style: TextStyle(
                  fontSize: 18,
                )),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
// class Routes {
//   static const String contacts = ContactsPage.routeName;
//   static const String events = EventsPage.routeName;
//   static const String notes = NotesPage.routeName;
// }