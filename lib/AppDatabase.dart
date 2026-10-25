import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'AppDatabase.g.dart';   //<< This tells flutter where to put the generated code later.

@DriftDatabase(
  include: {'User.drift'},   // << This is your .drift file you wrote
)
class AppDatabase extends _$AppDatabase {

  static AppDatabase instance() => AppDatabase();

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration{
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        await migrator.createAll();
      },
      beforeOpen: (details) async {

      }
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}