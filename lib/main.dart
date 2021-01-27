import 'package:flutter/material.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                        color: Colors.green,
                        iconSize: 32,
                        icon: Icon(Icons.account_circle),
                        onPressed: () {}),
                    Spacer(),
                    IconButton(
                        color: Colors.brown,
                        iconSize: 32,
                        icon: Icon(Icons.backpack),
                        onPressed: () {}),
                    Spacer(),
                    IconButton(
                        color: Colors.blue,
                        iconSize: 32,
                        icon: Icon(Icons.add_moderator),
                        onPressed: () {}),
                    Spacer(),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            )));
  }
}

// Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(
//               tabs: [
//                 Tab(icon: Icon(Icons.directions_car)),
//                 Tab(icon: Icon(Icons.directions_transit)),
//                 Tab(icon: Icon(Icons.directions_bike)),
//               ],
//             ),
//             title: Text('Tabs Demo'),
//           ),
//           body: TabBarView(
//             children: [
//               Icon(Icons.directions_car),
//               Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//             ],
//           ),
//         ),
//       ),
