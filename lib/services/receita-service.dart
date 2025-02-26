import 'package:receititas/db/ingrediente_dao.dart';
import 'package:receititas/db/receita_dao.dart';

import '../models/receita.dart';


class ReceitaService {
  final ReceitaDao _receitaDao = ReceitaDao();
  final IngredienteDao _ingredienteDao = IngredienteDao();

  Future<int> adicionarReceita(Receita receita) async {
    int receitaId = await _receitaDao.inserirReceita(receita);
    for (var ingrediente in receita.ingredientes) {
      ingrediente.receitaId = receitaId;
      await _ingredienteDao.inserirIngrediente(ingrediente);
    }
    return receitaId;
  }

  Future<List<Receita>> listarReceitas() async {
    List<Receita> receitas = await _receitaDao.listarReceitas();
    for (var receita in receitas) {
      receita.ingredientes = await _ingredienteDao.listarIngredientes(receita.id!);
    }
    return receitas;
  }

  Future<void> deletarReceita(int id) async {
    await _receitaDao.deletarReceita(id);
  }

  Future<void> editarReceita(Receita receita) async {
    await _receitaDao.editarReceita(receita);

    // Atualiza os ingredientes associados à receita
    for (var ingrediente in receita.ingredientes) {
      ingrediente.receitaId = receita.id!;
      await _ingredienteDao.editarIngrediente(ingrediente);
    }
  }
}