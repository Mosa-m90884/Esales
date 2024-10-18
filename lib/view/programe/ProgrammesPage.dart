import '../../model/program.dart';
import 'addUpdateProgramme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/ProgrammeProvider.dart';
class ProgrammesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programmes = ref.watch(programmeListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('البرامج السياحية')),
      body: FutureBuilder(
        future: ref.read(programmeListProvider.notifier).fetchProgrammes(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: programmes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(programmes[index].name),
                subtitle: Text(programmes[index].type),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // اذهب إلى صفحة تعديل البرنامج
                        Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => ProgrammeFormPage(programme:programmes[index]),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(programmeListProvider.notifier).deleteProgramme(programmes[index].id);
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
          // اذهب إلى صفحة إضافة برنامج جديد
          Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => ProgrammeFormPage(programme:Programme.empty()),
          ));
          print('object');

        },
        child: Icon(Icons.add),
      ),
    );
  }
}