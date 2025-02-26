import 'package:receititas/db/database_helper.dart';
import 'package:receititas/models/receita.dart';

class ReceitaDao {
  final dbHelper = DataHelper.instance;

  // Método para inserir uma nova receita
  Future<int> inserirReceita(Receita receita) async {
    final db = await dbHelper.database;
    return await db.insert('receitas', receita.toMap());
  }

  // Método para listar todas as receitas (sem filtro)
  Future<List<Receita>> listarReceitas() async {
    final db = await dbHelper.database;
    final resultado = await db.query('receitas');
    return resultado.map((json) => Receita.fromMap(json)).toList();
  }

  // Método para listar receitas filtradas por tipo
  Future<List<Receita>> listarReceitasPorTipo(String tipo) async {
    final db = await dbHelper.database;
    final resultado = await db.query(
      'receitas',
      where: 'tipoReceita = ?', // Filtra pela coluna "tipo"
      whereArgs: [
        tipo
      ], // Passa o tipo da receita (Refeição, Sobremesa, Bebida)
    );
    return resultado.map((json) => Receita.fromMap(json)).toList();
  }

  // Método para deletar uma receita pelo ID
  Future<int> deletarReceita(int id) async {
    final db = await dbHelper.database;
    return await db.delete('receitas', where: 'id = ?', whereArgs: [id]);
  }

  // Método para editar uma receita existente
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
