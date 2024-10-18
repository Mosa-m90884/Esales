import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/TourProvider.dart';
import '../../model/tour.dart';
import 'addUpdateTour.dart';

class ToursPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tours = ref.watch(tourListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('الجولات السياحية')),
      body: FutureBuilder(
        future: ref.read(tourListProvider.notifier).fetchTours(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: tours.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('جولة ${tours[index].id}'),
                subtitle: Text('سعر: ${tours[index].price}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // اذهب إلى صفحة تعديل الجولة
                       Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => TourFormPage(tour:tours[index]),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(tourListProvider.notifier)
                            .deleteTour(tours[index].id);
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
          // اذهب إلى صفحة إضافة جولة جديدة
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TourFormPage(tour:  Tour.empty()
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
