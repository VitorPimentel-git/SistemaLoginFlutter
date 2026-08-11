import 'package:flutter/material.dart';
import '../dados_mock.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool esconderSenha = true;
  
  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      )
    );
  }
  
  void entrar(){
    String email = emailController.text.trim();
    String senha = senhaController.text;

    if(email.isEmpty || senha.isEmpty){
      mostrarMensagem('Preencha todos os campos');
      return;
    }

    Map<String, String>? usuarioEncontrado;

    for(var usuario in usuarios){
      if (
        usuario['email'] == email && 
        usuario['senha'] == senha){
          usuarioEncontrado = usuario;
          break;
      }
    }
    mostrarMensagem('E-mail ou senha incorretos');
  }

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            const Icon(
              Icons.account_circle,
              size: 100,
            ),

            const SizedBox(height: 20),

            const Text(
              'Bem-vindo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Entre com sua conta',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder()
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  icon: Icon(
                    esconderSenha ? Icons.visibility : Icons.visibility_off
                  ), 
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: entrar,
              icon: Icon(Icons.login),
              label: const Text('Entrar'),
            ),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: (){},
              icon: Icon(Icons.person_add),
              label: const Text('Cadastrar'),
            ),
          ],
          
        ),
        )
      );
  }
}