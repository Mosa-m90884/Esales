import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/GuideProvider.dart'; // تأكد من استيراد Provider
import 'AddGuidePage.dart';
import 'EditGuidePage.dart'; // استيراد صفحة تعديل المرشد

class GuidesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guides = ref.watch(guideListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('المرشدين')),
      body: FutureBuilder(
        future: ref.read(guideListProvider.notifier).fetchGuides(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          return guides.length==0?Center(child: CircularProgressIndicator()): ListView.builder(
            itemCount: guides.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${guides[index].fName} ${guides[index].lName}'),
                subtitle: Text(guides[index].description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditGuidePage(guide: guides[index]),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(guideListProvider.notifier).deleteGuide(guides[index].id);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddGuidePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}