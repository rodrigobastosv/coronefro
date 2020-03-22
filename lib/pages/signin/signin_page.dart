import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronefro/pages/pacientes/list/bloc/bloc.dart';
import 'package:coronefro/pages/pacientes/list/pacientes_list_page.dart';
import 'package:coronefro/pages/signin/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SigninBloc, SigninState>(
        listener: (_, state) {
          if (state is SigninSuccess) {
            Navigator.of(_).pushReplacement(
              MaterialPageRoute(
                builder: (__) => Provider.value(
                  value: state.firebaseUser,
                  child: BlocProvider<PacientesListBloc>(
                    create: (_) => PacientesListBloc(
                      firestore: Firestore.instance,
                    )..add(CarregaPacientes()),
                    child: PacientesListPage(),
                  ),
                ),
              ),
            );
          }
          if (state is SigninFailed) {
            Scaffold.of(_).showSnackBar(
              SnackBar(
                content: Text('E-mail ou senha inválidos'),
              ),
            );
          }
        },
        builder: (_, state) => Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'E-mail',
                  ),
                  validator: (email) =>
                      email.isEmpty ? 'Campo Obrigatório' : null,
                  onSaved: (email) => _email = email,
                ),
                SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (password) =>
                      password.isEmpty ? 'Campo Obrigatório' : null,
                  onSaved: (password) => _password = password,
                ),
                SizedBox(height: 14),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      context
                          .bloc<SigninBloc>()
                          .add(SigninUser(_email, _password));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
