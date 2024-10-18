import 'package:e_tourism/model/driver.dart';

import 'AddDriverPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/DriverProvider.dart';
class DriversPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drivers = ref.watch(driverListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('السائقين')),
      body: FutureBuilder(
        future: ref.read(driverListProvider.notifier).fetchDrivers(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${drivers[index].fName} ${drivers[index].lName}'),
                subtitle: Text(drivers[index].plateNumber),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // اذهب إلى صفحة تعديل السائق
                        Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => DriverFormPage(driver: drivers[index],)
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(driverListProvider.notifier).deleteDriver(drivers[index].id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // اذهب إلى صفحة إضافة سائق جديد
          Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => DriverFormPage(driver: Driver.empty(),)
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}