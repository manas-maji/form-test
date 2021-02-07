import 'package:flutter/material.dart';

import 'forms/cold_rolled_steel_form.dart';
import 'forms/hot_rolled_steel_form.dart';

class BrowseProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Browse Products')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            SizedBox(
              height: 16.0,
            ),
            ListTile(
              title: Text('Hot Rolled Steels'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HotRolledSteelForm();
                }));
              },
            ),
            ListTile(
              title: Text('Cold Rolled Steels'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ColdRolledSteelForm();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
