import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_notes/blocs/blocs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.of(context).pop();
            } else if (state.isFailure) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text(state.errorMessage),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        )
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Stack _buildBody(LoginState state) {
    return Stack(
      children: <Widget>[
        _buildForm(state),
        state.isSubmitting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  ListView _buildForm(LoginState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          style: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.always,
          validator: (_) =>
              !state.isEmailValid && _emailController.text.isNotEmpty
                  ? 'Invalid Email'
                  : null,
          onChanged: (val) =>
              context.bloc<LoginBloc>().add(EmailChanged(email: val)),
        ),
        const SizedBox(
          height: 40.0,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          autovalidateMode: AutovalidateMode.always,
          validator: (_) =>
              !state.isPasswordValid && _passwordController.text.isNotEmpty
                  ? 'Password must be at least 6 characters.'
                  : null,
          onChanged: (val) =>
              context.bloc<LoginBloc>().add(PasswordChanged(password: val)),
        ),
        const SizedBox(
          height: 50.0,
        ),
        FlatButton(
          padding: const EdgeInsets.all(12.0),
          color: Colors.black,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: state.isFormValid
              ? () => context.bloc<LoginBloc>().add(LoginPressed(
                  email: _emailController.text,
                  password: _passwordController.text))
              : null,
          child: Text('Login'),
        ),
        const SizedBox(
          height: 40.0,
        ),
        FlatButton(
          padding: const EdgeInsets.all(12.0),
          color: Colors.black,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: state.isFormValid
              ? () => context.bloc<LoginBloc>().add(SignupPressed(
                  email: _emailController.text,
                  password: _passwordController.text))
              : null,
          child: Text('Sign Up'),
        )
      ],
    );
  }
}
