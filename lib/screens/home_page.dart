import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcstore/screens/setting.dart';
import 'package:tcstore/services/authentication.dart';
import 'package:tcstore/services/database.dart';
import 'package:tcstore/widgets/items_tab.dart';
import 'package:tcstore/widgets/orders_tab.dart';

import 'add_item.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Items'),
  Tab(text: 'Orders'),
];

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final CollectionReference _db =
        DatabaseService(uid: _auth.uid!).userCollection;

    return FutureBuilder<DocumentSnapshot>(
      future: _db.doc(_auth.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(body: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Scaffold(body: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data();
          return HomePage(data: data);
        }
        return const Scaffold(body: Text("loading"));
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Icon(
                  Icons.store,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    '   ' + data['shop name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(15),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, AddItem.routeName);
                  },
                  child: const Text(
                    'Add Item',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Setting.routeName);
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black87,
            bottom: TabBar(
              tabs: tabs,
              labelColor: Colors.white,
              indicatorColor: Colors.cyan[900],
            ),
          ),
          body: const TabBarView(
            children: [
              ItemsTab(),
              OrdersTab(),
            ],
          ),
        );
      }),
    );
  }
}
