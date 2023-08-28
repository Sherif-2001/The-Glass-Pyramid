import 'package:glass_pyramid/models/next.dart';
import 'package:glass_pyramid/models/skill.dart';
import 'package:sqflite/sqflite.dart';

const String scenesTable = "scenes";
const String skillsTable = "skills";

class DatabaseHelper {
  static Future _createTables(Database database) async {
    await database.execute('''
CREATE TABLE $scenesTable(
  id INTEGER,
  name TEXT
)
''');
    await database.execute('''
CREATE TABLE $skillsTable(
  intel INTEGER,
  charisma INTEGER,
  strength INTEGER
)
''');
  }

  static Future<Database> _getDatabase() async {
    return openDatabase(
      "database.db",
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  static void closeDatabase() async {
    final database = await _getDatabase();
    if (!database.isOpen) return;
    await database.close();
  }

  // ----------------------- Skills Methods -------------------------

  static Future loadSkillsValues() async {
    final database = await _getDatabase();
    final maps = await database.query(skillsTable);
    if (maps.isEmpty) return null;
    return Skill.fromJson(maps.first);
  }

  static Future saveSkillsValues(Skill skill) async {
    final database = await _getDatabase();
    final dataMaps = await database.query(skillsTable);
    if (dataMaps.isEmpty) {
      database.insert(skillsTable, skill.toJson());
    } else {
      database.update(skillsTable, skill.toJson());
    }
  }

  // ------------------------ Current Scene Methods -------------------

  static Future loadCurrentScene() async {
    final database = await _getDatabase();
    final maps = await database.query(scenesTable);
    if (maps.isEmpty) return null;
    return NextScene.fromJson(maps.first);
  }

  static Future saveCurrentScene(NextScene scene) async {
    final database = await _getDatabase();
    final dataMaps = await database.query(scenesTable);
    if (dataMaps.isEmpty) {
      database.insert(scenesTable, scene.toJson());
    } else {
      database.update(scenesTable, scene.toJson());
    }
  }
}
