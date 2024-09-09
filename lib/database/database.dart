import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  Database? _db;

  Future<Database?> get db async {
    _db ??= await initdb();
    return _db;
  }

  Future<void> deletemyDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'nectar.db');
    await deleteDatabase(path);
    print('Database deleted at $path');
  }

  Future<Database> initdb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'nectar.db');
    Database mydb = await openDatabase(
      path,
      version: 5, // Updated version to trigger the upgrade
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Database upgraded from version $oldVersion to $newVersion");

    if (oldVersion < 5) {
      await db.execute('''
      ALTER TABLE Users ADD COLUMN firebase_id TEXT;
    ''');
      print("firebase_id column added to Users table");
      // Create the new Favorites table when upgrading to version 4
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        phone_number TEXT,
        date_of_birth TEXT,
        gender TEXT CHECK(gender IN ('Male', 'Female', 'Other')),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    ''');

    await db.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        image_url TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE Products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        image_url TEXT,
        price REAL NOT NULL,
        category_id INTEGER,
        rating INTEGER CHECK (rating BETWEEN 1 AND 5),
        description TEXT,
        FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE Cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        product_id INTEGER,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE Orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        total_price REAL NOT NULL,
        status TEXT DEFAULT 'Pending',
        FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE OrderItems (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        product_id INTEGER,
        quantity INTEGER NOT NULL,
        price_at_time_of_order REAL NOT NULL,
        FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE Offers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE BestSelling (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
      );
    ''');

    // Add Favorites table to onCreate for new databases
    await db.execute('''
      CREATE TABLE Favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        product_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
      );
    ''');
  }

  Future<int> insert(String sql, List<dynamic> arguments) async {
    Database? mydb = await db;
    if (mydb == null) {
      throw StateError("Database is not initialized");
    }
    return await mydb.rawInsert(sql, arguments);
  }

  Future<List<Map<String, dynamic>>> getdata(String sql,
      [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    if (mydb == null) {
      throw StateError("Database is not initialized");
    }
    return await mydb.rawQuery(sql, arguments);
  }

  Future<int> delete(String sql, [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    if (mydb == null) {
      throw StateError("Database is not initialized");
    }
    return await mydb.rawDelete(sql, arguments);
  }

  Future<int> update(String sql, [List<dynamic>? arguments]) async {
    Database? mydb = await db;
    if (mydb == null) {
      throw StateError("Database is not initialized");
    }
    return await mydb.rawUpdate(sql, arguments);
  }

  Future<void> close() async {
    Database? mydb = await db;
    if (mydb != null) {
      await mydb.close();
      _db = null;
    }
  }
}
