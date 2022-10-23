import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:walkthrough/modules/home/pages/index.dart';
import 'package:walkthrough/modules/loginProf/models/prof_model.dart';
import 'package:walkthrough/modules/novoLogin/controllers/controller.dart';
import 'package:walkthrough/shared/components/campo_form/campo_form.dart';

class NovoLogin extends StatefulWidget {
  final UserProf user;

  const NovoLogin({Key? key, required this.user}) : super(key: key);

  @override
  State<NovoLogin> createState() => _NovoLoginState();
}

class _NovoLoginState extends State<NovoLogin> {
  final _controller = NovoLoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Atualize seus dados!',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CampoForm(
                label: 'Nome',
                controller: _controller.nome,
              ),
              CampoForm(
                label: 'Email',
                controller: _controller.email,
              ),
              Row(
                children: [
                  const Text(
                    'Assinale caso queira alterar a sua senha: ',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                  Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 2.0, color: Colors.deepPurple),
                      ),
                      activeColor: Colors.deepPurple,
                      value: _controller.hasSenha,
                      onChanged: (value) {
                        setState(() {
                          _controller.hasSenha = !_controller.hasSenha;
                        });
                      }),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.atualizaDados(
                      sucesso: (usuario) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(usuario: usuario ?? UserProf())));
                      },
                      falha: (motivo) {
                        MotionToast.error(
                          title: const Text(
                            'Erro',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          description: Text(motivo),
                          animationType: AnimationType.fromLeft,
                          position: MotionToastPosition.top,
                          barrierColor: Colors.black.withOpacity(0.3),
                          width: 300,
                          height: 80,
                          dismissable: true,
                        ).show(context);
                      },
                      usuario: widget.user);
                },
                child: const Text('Atualizar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
