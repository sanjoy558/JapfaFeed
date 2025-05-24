import 'package:japfa_feed_application/hive/TrackTargetString.dart';
import 'package:japfa_feed_application/hive/databaseConstant.dart';
import 'package:japfa_feed_application/hive/locationString.dart';
import 'package:japfa_feed_application/hive/pointsTravelledString.dart';
import 'package:japfa_feed_application/hive/visitFeedbackString.dart';
import 'package:japfa_feed_application/hive/visitIdString.dart';
import 'package:japfa_feed_application/responses/PlantResponse.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

//https://github.com/mohaberabi/flutter_sqflite/blob/main/lib/repository/database_repository.dart

class LocalDataBase {
  static final LocalDataBase instance = LocalDataBase._init();

  LocalDataBase._init();

  Database? _database;
  late var path = "";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_database.db');
    return _database!;
  }

  static const tableDailyVisitFlock = """
  CREATE TABLE IF NOT EXISTS UserVisitId (
        tid TEXT PRIMARY key,
        id TEXT
      );""";

  static const tableUserLocation = """
  CREATE TABLE IF NOT EXISTS UserLocation (
        id TEXT PRIMARY key,
        userlatitude TEXT,
        userlongitude TEXT
      );""";

  static const tableDailyTrackTarget = """
  CREATE TABLE IF NOT EXISTS DailyTrackTarget (
  tid TEXT PRIMARY key,
        customerId TEXT,
        id INTEGER,
        status TEXT
      );""";

  static const tableDailyVisitFeedback = """
  CREATE TABLE IF NOT EXISTS DailyVisitFeedback (
  id TEXT PRIMARY key,
        distance DOUBLE,
        flockNumber TEXT,
        latitude DOUBLE,
        longitude DOUBLE,
        operationType TEXT,
        remark TEXT,
        routeId TEXT,
        superVisorId TEXT,
        timeStamp TEXT,
        visitDate TEXT
      );""";


  static const tableDailyPointsTravelled = """
  CREATE TABLE IF NOT EXISTS DailyPoints (
  id TEXT PRIMARY key,
        distance DOUBLE,
        latitude DOUBLE,
        longitude DOUBLE,
        operationType TEXT,
        remark TEXT,
        routeId TEXT,
        superVisorId TEXT,
        timeStamp TEXT,
        visitDate TEXT
      );""";


  static const tableplant = """
  CREATE TABLE IF NOT EXISTS AllPlants (
  id TEXT PRIMARY key,
        plantid DOUBLE,
        name TEXT,
        code TEXT,
        plantCode TEXT,
        person TEXT,
        address TEXT,
        zip TEXT,
        district TEXT
      );""";

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    path = join(dbPath, filePath);

    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute(tableUserLocation);
      await db.execute(tableDailyVisitFeedback);
      await db.execute(tableDailyVisitFlock);
      await db.execute(tableDailyPointsTravelled);
      await db.execute(tableDailyTrackTarget);
      await db.execute(tableplant);
    });
  }

  Future<bool> databaseExists() =>
      databaseFactory.databaseExists(path.toString());


  Future<void> insertTrackTarget({required TrackTargetString todo}) async {
    try {
      final db = await instance?.database;
      await db?.insert(DataBaseConstants.tableTrackTarget, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('new track Target inserted: $todo');
    } catch (e) {
      print('new track Target inserted error : ${e.toString()}');
    }
  }

  Future<List<TrackTargetString>> getAllTrackTarget() async {
    final db = await instance?.database;

    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);

    final result = await db!.query(DataBaseConstants.tableTrackTarget);

    return result!.map((json) => TrackTargetString.fromJson(json)).toList();
  }


  Future<void> insertPointsVisited({required PointsTravelledString todo}) async {
    try {
      final db = await instance?.database;
      await db?.insert(DataBaseConstants.dailyPointsTravelledTable, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('new insertVisitId inserted: $todo');
    } catch (e) {
      print('new insertVisitId inserted error : ${e.toString()}');
    }
  }


  Future<List<PointsTravelledString>> getLastRecordDailyPoints() async {
    final db = await instance?.database;
    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);
    final result = await db!.query(DataBaseConstants.dailyVisitIdTable,
        orderBy: "id DESC",
        limit: 1);
    return result!.map((json) => PointsTravelledString.fromJson(json)).toList();
  }




  Future<List<PointsTravelledString>> getAllPointsTravelled() async {
    final db = await instance?.database;

    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);

    final result = await db!.query(DataBaseConstants.dailyPointsTravelledTable);

    return result!.map((json) => PointsTravelledString.fromJson(json)).toList();
  }



  Future<List<Map<String, dynamic>>> getAllRecords(String tableName) async {
    final db = await database;

    return await db!.query(tableName);
  }

  Future<bool> isTableEmpty(String tableName) async {
    final db = await instance?.database;
    var result = await db!.rawQuery('SELECT COUNT(*) FROM $tableName');
    int? count = Sqflite.firstIntValue(result);
    return count == 0;
  }

  Future<void> insertAllPlants({required PlantResponse todo}) async {
    try {
      final db = await instance?.database;
      await db?.insert(DataBaseConstants.tableplant, todo.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('new plant inserted: $todo');
    } catch (e) {
      print('new plat inserted error : ${e.toString()}');
    }
  }

  Future<List<PlantResponse>> getAllPlants() async {
    final db = await instance?.database;
    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);
    final result = await db!.query(DataBaseConstants.dailyVisitIdTable);
    return result!.map((json) => PlantResponse.fromJson(json)).toList();
  }



  Future<void> insertVisitId({required VisitIdString todo}) async {
    try {
      final db = await instance?.database;
      await db?.insert(DataBaseConstants.dailyVisitIdTable, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('new insertVisitId inserted: $todo');
    } catch (e) {
      print('new insertVisitId inserted error : ${e.toString()}');
    }
  }

  Future<List<VisitIdString>> getAllVisitedIds() async {
    final db = await instance?.database;

    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);

    final result = await db!.query(DataBaseConstants.dailyVisitIdTable);

    return result!.map((json) => VisitIdString.fromJson(json)).toList();
  }

  Future<void> insertLocation({required LocationString todo}) async {
    try {
      final db = await instance?.database;
      await db?.insert(DataBaseConstants.locationTable, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('new location inserted: $todo');
    } catch (e) {
      print('new location inserted error : ${e.toString()}');
    }
  }

  Future<List<LocationString>> getAllUserLocation() async {
    final db = await instance?.database;

    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);

    final result = await db!.query(DataBaseConstants.locationTable);

    return result!.map((json) => LocationString.fromJson(json)).toList();
  }

  Future<void> insertDailyVisitFeedback(
      {required VisitFeedBackString todo}) async {
    try {
      final db = await instance?.database;
      await db?.insert(DataBaseConstants.dailyVisitFeedbackTable, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('new insert DailyVisitFeedback : $todo');
    } catch (e) {
      print('new insert DailyVisitFeedback error : ${e.toString()}');
    }
  }

  Future<List<VisitFeedBackString>> getAllVisitFeedBack() async {
    final db = await instance?.database;

    //final List<Map<String, Object?>> queryResult = await db.query(DataBaseConstants.locationTable);

    final result = await db!.query(DataBaseConstants.dailyVisitFeedbackTable);

    return result!.map((json) => VisitFeedBackString.fromJson(json)).toList();
  }

  Future<bool> query(String textflock) async {
    // get a reference to the database
    final db = await instance?.database;
    // raw query
    List<Map> result = await db!
        .rawQuery('SELECT id FROM UserVisitId WHERE id=?', ['$textflock']);
    // print the results
    result.forEach((row) => print(row));
    print(result.length);
    // {_id: 2, name: Mary, age: 32}
    return result.length > 0 ? true : false;
  }






  Future<void> cleanDatabase(int flag) async {
    try {
      final db = await instance?.database;
      await db!.transaction((txn) async {
        var batch = txn.batch();

        if (flag == 1) {
          batch.delete(DataBaseConstants.dailyVisitFeedbackTable);
        } else if (flag == 2) {
          batch.delete(DataBaseConstants.locationTable);
          batch.delete(DataBaseConstants.dailyVisitIdTable);
        } else {
          batch.delete(DataBaseConstants.tableTrackTarget);
          batch.delete(DataBaseConstants.dailyVisitFeedbackTable);
          batch.delete(DataBaseConstants.locationTable);
          batch.delete(DataBaseConstants.dailyVisitIdTable);
          batch.delete(DataBaseConstants.dailyPointsTravelledTable);
        }
        /* batch.delete(TransfersNames.tableName);
        batch.delete(PlannedTransactionNames.tableName);
        batch.delete(SettingNames.tableName);*/
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  Future<int?> getCount(String table) async {
    //database connection
    Database db = await this.database;
    var x = await db.rawQuery('SELECT COUNT (*) from ${table}');
        int? count = Sqflite.firstIntValue(x);
    return count;
  }
}
