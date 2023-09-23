import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> createDataBase() async {
    return await openDatabase(
      'Servers.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE Servers (id INTEGER PRIMARY KEY, name TEXT, ip TEXT , defaultServer BOOLEAN)')
            .then((value) {
        }).catchError((error) {
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
      },
    );
  }

  Future<void> insertToDataBase({
    required String name,
    required String ip,
    required bool defaultServer,
    required Database database,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Servers(name, ip, defaultServer) VALUES("$name", "$ip", "$defaultServer")')
          .then((value) {
      }).catchError((error) {
      });
    });
  }

  Future<void> updateData({
    required String name,
    required String ip,
    required bool defaultServer,
    required Database database,
    required int id,
  }) async {
    await database.rawUpdate(
      'UPDATE Servers SET name = ? , ip = ? , defaultServer = ? WHERE id = ?',
      [name, ip, '$defaultServer', '$id'],
    );
  }

  Future<void> updateDefaultServer({
    required bool defaultServer,
    required Database database,
    required int id,
  }) async {
    await database.rawUpdate(
      'UPDATE Servers SET defaultServer = ? WHERE id = ?',
      ['$defaultServer', '$id'],
    );
  }

  Future<void> deleteData({
    required int id,
    required Database database,
  }) async {
    await database.rawDelete('DELETE FROM Servers WHERE id = ?', [id]);
  }

  Future<List<dynamic>> getDataFromDataBase(database) async {
   return await database.rawQuery('SELECT * FROM Servers');
  }
}
