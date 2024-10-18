import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_tourism/controller/TourProvider.dart';
import '../../model/tour.dart';
import 'TourDetailPage.dart';

class TourSearchPage extends ConsumerStatefulWidget {
  @override
  _TourSearchPageState createState() => _TourSearchPageState();
}

class _TourSearchPageState extends ConsumerState<TourSearchPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // إعادة تحميل بيانات الجولات عند دخول الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(tourListProvider2); // تحديث المزود
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('بحث عن جولة'),
        backgroundColor: Colors.teal, // تغيير لون الخلفية
      ),
      body: Container(
        color: Colors.grey[100], // لون خلفية الصفحة
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'ابحث عن جولة',
                  labelStyle: TextStyle(color: Colors.teal), // لون نص العلامة
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.teal), // أيقونة البحث
                ),
                onChanged: (value) {
               setState(() {
                 searchController.text= value;
               });
                },
              ),
            ),
            Expanded(
              child: ref.watch(tourListProvider2).when(
                data: (tours) {
                  // تصفية الجولات بناءً على نص البحث
                  final filteredTours = tours.where((tour) {
                    return tour.id.contains(   searchController.text);
                  }).toList();

                  return filteredTours.isEmpty
                      ? Center(child: Text('لا توجد جولات متاحة.', style: TextStyle(color: Colors.teal)))
                      : ListView.builder(
                    itemCount: filteredTours.length,
                    itemBuilder: (context, index) {
                      final tour = filteredTours[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 4,
                        child: ListTile(
                          title: Text('جولة: ${tour.id}', style: TextStyle(color: Colors.teal)),
                          subtitle: Text('السعر: ${tour.price}', style: TextStyle(color: Colors.grey[700])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TourDetailPage(tour: tour),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('حدث خطأ: $error', style: TextStyle(color: Colors.red))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}