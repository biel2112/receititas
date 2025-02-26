import 'package:receititas/db/ingrediente_dao.dart';
import 'package:receititas/models/ingrediente.dart';

class IngredienteService {
  final IngredienteDao _ingredienteDao = IngredienteDao();

  Future<int> adicionarIngrediente(Ingrediente ingrediente) async {
    return await _ingredienteDao.inserirIngrediente(ingrediente);
  }

  Future<List<Ingrediente>> listarIngredientes(int receitaId) async {
    return await _ingredienteDao.listarIngredientes(receitaId);
  }

  Future<void> deletarIngrediente(int id) async {
    await _ingredienteDao.deletarIngrediente(id);
  }

  Future<void> editarIngrediente(Ingrediente ingrediente) async {
    await _ingredienteDao.editarIngrediente(ingrediente);
  }
}
