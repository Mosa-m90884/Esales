import 'package:e_tourism/widget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../tour/BusReportPage.dart';
import '../tour/TourSearchPage.dart';
import 'RegisterTouristPage.dart';
class TouristPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة السائح'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio:5.1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [

            CustomButton( label: 'registerTourist',icon:  Icons.how_to_reg_sharp, onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: registerTouristPage())),
              );
            }),
            CustomButton(label:  'searchTours',icon:  Icons.search,onPressed:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: TourSearchPage())),
              );
            }),
          ],
        ),
      ),
    );
  }

}

