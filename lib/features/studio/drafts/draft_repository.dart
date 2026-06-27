library;

import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../entities/project.dart';

part 'draft_repository.g.dart';

class DraftProjects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withDefault(const Constant('Untitled'))();
  TextColumn get json => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  TextColumn get coverPath => text().nullable()();
  IntColumn get stage => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [DraftProjects])
class StudioDraftDatabase extends _$StudioDraftDatabase {
  StudioDraftDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}

class DraftRepository {
  DraftRepository() : _db = _lazy();

  static Future<StudioDraftDatabase> _lazy() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'studio_drafts.sqlite'));
    return StudioDraftDatabase(NativeDatabase.createInBackground(file));
  }

  late final Future<StudioDraftDatabase> _db;
  bool _initialised = false;

  Future<void> initialize() async {
    if (_initialised) return;
    await _db;
    _initialised = true;
  }

  Future<StudioDraftDatabase> get _resolved => _db;

  Future<void> save(StudioProject project) async {
    final db = await _resolved;
    final now = DateTime.now();
    await db.into(db.draftProjects).insertOnConflictUpdate(
          DraftProjectsCompanion.insert(
            id: project.id,
            name: Value(project.name),
            json: jsonEncode(project.toJson()),
            createdAt: project.createdAt,
            updatedAt: Value(now),
            coverPath: Value(project.coverPath),
            stage: Value(project.stage.index),
          ),
        );
  }

  Future<List<StudioProject>> list() async {
    final db = await _resolved;
    final rows = await (db.select(db.draftProjects)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
    return rows.map(_decode).whereType<StudioProject>().toList();
  }

  Future<StudioProject?> load(String id) async {
    final db = await _resolved;
    final row = await (db.select(db.draftProjects)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _decode(row);
  }

  Future<void> delete(String id) async {
    final db = await _resolved;
    await (db.delete(db.draftProjects)..where((t) => t.id.equals(id))).go();
  }

  StudioProject? _decode(DraftProject row) {
    try {
      return StudioProject.fromJson(
          jsonDecode(row.json) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  Future<void> dispose() async {
    final db = await _resolved;
    await db.close();
  }
}
