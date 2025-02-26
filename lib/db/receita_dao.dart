import 'package:receititas/db/database_helper.dart';
import 'package:receititas/models/receita.dart';

class ReceitaDao {
  final dbHelper = DataHelper.instance;

  Future<int> inserirReceita(Receita receita) async {
    final db = await dbHelper.database;
    return await db.insert('receitas', receita.toMap());
  }

  Future<List<Receita>> listarReceitas() async {
    final db = await dbHelper.database;
    final resultado = await db.query('receitas');
    return resultado.map((json) => Receita.fromMap(json)).toList();
  }

  Future<int> deletarReceita(int id) async {
    final db = await dbHelper.database;
    return await db.delete('receitas', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editarReceita(Receita receita) async {
    final db = await dbHelper.database;
    return await db.update(
      'receitas',
      receita.toMap(),
      where: 'id = ?',
      whereArgs: [receita.id],
    );
  }
  
}
