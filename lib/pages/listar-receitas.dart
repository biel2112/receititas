import 'package:flutter/material.dart';
import 'package:receititas/pages/cadastrar-receita.dart';
import 'package:receititas/pages/detalhes-receitas.dart';
import 'package:receititas/pages/editar-receita.dart';
import 'package:receititas/services/receita-service.dart';
import '../models/receita.dart';

class ListaReceitasScreen extends StatefulWidget {
  @override
  _ListaReceitasScreenState createState() => _ListaReceitasScreenState();
}

class _ListaReceitasScreenState extends State<ListaReceitasScreen> {
  final ReceitaService _receitaService = ReceitaService();
  List<Receita> _receitas = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _carregarReceitas();
  }

  Future<void> _carregarReceitas() async {
    setState(() {
      _isLoading = true; // Defina uma variável de controle para o carregamento
    });

    // Exibe o CircularProgressIndicator por um tempo máximo (exemplo: 3 segundos)
    await Future.delayed(Duration(seconds: 2));

    List<Receita> receitas = await _receitaService.listarReceitas();
    setState(() {
      _receitas = receitas;
      _isLoading = false; // Finaliza o carregamento
    });
  }

  void _abrirCadastroReceita() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroReceitaScreen(),
      ),
    );
    _carregarReceitas(); // Recarrega a lista ao voltar
  }

  void _editarReceita(int index) async {
    // Navega para a tela de edição, passando a receita a ser editada
    Receita receitaEditada = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarReceitaScreen(receita: _receitas[index]),
      ),
    );

    if (receitaEditada != null) {
      // Atualiza a lista de receitas com a edição
      setState(() {
        _receitas[index] = receitaEditada;
      });

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Receita editada com sucesso!')),
      );
    }
  }

  // Função para excluir uma receita
  void _excluirReceita(int index) async {
    // Exclui a receita do banco de dados
    await _receitaService.deletarReceita(_receitas[index].id!);

    // Atualiza a lista de receitas após a exclusão
    setState(() {
      _receitas.removeAt(index); // Remove da lista após a exclusão
    });

    // Exibe uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receita excluída com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas', style: TextStyle(fontFamily: 'DancingScript', fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Color.fromARGB(255, 255, 250, 209),
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: _receitas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_receitas[index].id.toString()),
                    direction: DismissDirection.endToStart, // Define a direção para deslizar
                    onDismissed: (direction) {
                      _excluirReceita(index); // Exclui a receita
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
                        borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Sombra suave
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          _receitas[index].nome,
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 128, 0),
                          ),
                        ),
                        subtitle: Text(
                          'Toque para ver detalhes',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Color.fromARGB(255, 255, 128, 0)),
                          onPressed: () => _editarReceita(index), // Abre o formulário de edição
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesReceitaScreen(
                                  receita: _receitas[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastroReceita,
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Adicionar Receita',
      ),
    );
  }
}
