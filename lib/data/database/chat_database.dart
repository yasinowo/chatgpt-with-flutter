import 'package:my_chat_gpt/model/massage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChatDatabase {
  static final ChatDatabase instance = ChatDatabase._internal();

  factory ChatDatabase() {
    return instance;
  }

  ChatDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'chat.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            message TEXT,
            isUser INTEGER,
            timestamp TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertMessage(ChatMessage message) async {
    final db = await database;
    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatMessage>> fetchMessages() async {
    final db = await database;
    final maps = await db.query('messages', orderBy: 'timestamp ASC');
    return List.generate(maps.length, (i) {
      return ChatMessage.fromMap(maps[i]);
    });
  }

  Future<void> clearChat() async {
    final db = await database;
    await db.delete('messages');
  }
}
