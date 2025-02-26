import 'package:flutter/material.dart';
import 'package:receititas/pages/detalhes_receitas.dart';
import 'package:receititas/services/receita_service.dart'; // Importe o serviço
import '../models/receita.dart'; // Importe o modelo de Receita

class ReceitasFiltradasScreen extends StatefulWidget {
  final String tipo; // Tipo de receita que será passado ao selecionar um tipo

  const ReceitasFiltradasScreen({super.key, required this.tipo});

  @override
  // ignore: library_private_types_in_public_api
  _ReceitasFiltradasScreenState createState() =>
      _ReceitasFiltradasScreenState();
}

class _ReceitasFiltradasScreenState extends State<ReceitasFiltradasScreen> {
  final ReceitaService _receitaService = ReceitaService();
  List<Receita> _receitasFiltradas = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _carregarReceitasFiltradas();
  }

  Future<void> _carregarReceitasFiltradas() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Carregar as receitas filtradas de acordo com o tipo selecionado
      List<Receita> receitas =
          await _receitaService.listarReceitasPorTipo(widget.tipo);

      setState(() {
        _receitasFiltradas = receitas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deletarReceita(int id) async {
    await _receitaService.deletarReceita(id);
    _carregarReceitasFiltradas(); // Recarrega as receitas após exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas de ${widget.tipo}'),
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _receitasFiltradas.isEmpty
              ? Center(child: Text('Nenhuma receita encontrada!'))
              : ListView.builder(
                  itemCount: _receitasFiltradas.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(_receitasFiltradas[index].id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _deletarReceita(_receitasFiltradas[index].id!);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            _receitasFiltradas[index].nome,
                            style: TextStyle(
                              fontFamily: 'DancingScript',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 128, 0),
                            ),
                          ),
                          subtitle: Text('Toque para ver detalhes'),
                          onTap: () {
                            // Navegar para os detalhes da receita
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesReceitaScreen(
                                  receita: _receitasFiltradas[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
