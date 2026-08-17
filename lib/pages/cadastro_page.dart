import 'package:flutter/material.dart';
import '../dados_mock.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  bool esconderSenha = true;
  bool esconderAfirmacao = true;

  void cadastrar(){
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = senhaController.text;
    String confirmaSenha = confirmaSenhaController.text;

    if(nome.isEmpty || email.isEmpty || senha.isEmpty || confirmaSenha.isEmpty){
      mostrarMensagem('Preencha todos os campos');
      return;
    }

    if(!email.contains('@')){
      mostrarMensagem('Digite um e-mail válido');
      return;
    }

    if(senha.length < 4){
      mostrarMensagem('A senha deve ter no mínimo 4 caracteres');
      return;
    }

    if(senha != confirmaSenha){
      mostrarMensagem('As senhas não coincidem');
      return;
    }

    bool emailExiste = false; 

    for(var usuario in usuarios){
      if(usuario['email'] == email){
        emailExiste = true;
        break;
      }
    }

    if(emailExiste){
      mostrarMensagem('O e-mail já está cadastrado');
      return;
    }

    Map<String, String> novoUsuario = {
      'nome': nome,
      'email': email,
      'senha': senha,
    };

    usuarios.add(novoUsuario);

    mostrarMensagem('Usuário cadastrado com sucesso!');

    Navigator.pop(context);
  }

  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      )
    );
  }

    @override
  void dispose(){
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Usuário',
          ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Icon (Icons.person_add, size: 90),
            
            const SizedBox(height: 15),

            const Text(
              'Crie sua conta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite seu nome',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Digite seu email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                   onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  icon: Icon(
                    esconderSenha ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          
            TextField(
              controller: confirmaSenhaController,
              obscureText: esconderAfirmacao,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                hintText: 'Digite sua senha novamente',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                    setState(() {
                      esconderAfirmacao = !esconderAfirmacao;
                    });
                  },
                  icon: Icon(
                    esconderAfirmacao ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: cadastrar,
              icon: Icon(Icons.person_add, size: 18),
              label: const Text('Cadastrar', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8
                  ),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
              ),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text(
                'Voltar para Login',
              ),
              )
          ]
        )
      )
    );
  }
}