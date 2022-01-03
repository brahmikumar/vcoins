import 'dart:io';
import 'package:coins/src/database/profile_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper{
  String tableName = "Profile";
  String id = "id";
  String name = "name";
  String emailId = "emailId";
  String address = "address";

  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    //_databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  // Database initialization
  Database? _database;
  get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    //_database ??= await initializeDatabase();

    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "$directory coins.db";

    return await openDatabase(path, version: 1, onCreate: _create);
  }

  _create(Database database, int version){
    return database.execute("CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $emailId TEXT, $address TEXT)");
  }

  Future<int> insert(ProfileModel profileModel)async{
    Database database =  await this.database;

    var result =  database.insert(tableName, profileModel.toProfileMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getProfileData() async{
    Database database = await this.database;
    return database.query(tableName);
  }

  Future<List<ProfileModel>> getModelFromProfileData() async{
    List<Map<String, dynamic>> profileData = await getProfileData();
    List<ProfileModel> profileModel = [];

    for(int i=0; i< profileData.length; i++){
      profileModel.add(ProfileModel.fromProfileMap(profileData[i]));
    }
    return profileModel;
  }

  Future<int> update(ProfileModel profileModel) async{
    Database database = await this.database;

    return  database.update(tableName, profileModel.toProfileMap());
  }
}