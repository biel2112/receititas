import 'package:receititas/db/database_helper.dart';
import 'package:receititas/models/ingrediente.dart';

class IngredienteDao {
  final dbHelper = DataHelper.instance;

  Future<int> inserirIngrediente(Ingrediente ingrediente) async {
    final db = await dbHelper.database;
    return await db.insert('ingredientes', ingrediente.toMap());
  }

  Future<List<Ingrediente>> listarIngredientes(int receitaId) async {
    final db = await dbHelper.database;
    final resultado = await db.query(
      'ingredientes',
      where: 'receita_id = ?',
      whereArgs: [receitaId],
    );
    return resultado.map((json) => Ingrediente.fromMap(json)).toList();
  }

  Future<int> deletarIngrediente(int id) async {
    final db = await dbHelper.database;
    return await db.delete('ingredientes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editarIngrediente(Ingrediente ingrediente) async {
    final db = await dbHelper.database;
    return await db.update(
      'ingredientes',
      ingrediente.toMap(),
      where: 'id = ?',
      whereArgs: [ingrediente.id],
    );
  }
}
