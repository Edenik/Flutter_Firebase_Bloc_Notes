import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_notes/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_notes/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(context, state),
        );
      },
    );
  }

  Stack _buildBody(BuildContext context, AuthState authState) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Youre Notes'),
              ),
              leading: IconButton(
                icon: authState is Authenticated
                    ? Icon(Icons.exit_to_app)
                    : Icon(Icons.account_circle),
                iconSize: 28.0,
                onPressed: () => authState is Authenticated
                    ? context.bloc<AuthBloc>().add(Logout())
                    : print('go to login'),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.brightness_4),
                    onPressed: () => print('change theme'))
              ],
            ),
            NotesGrid(),
          ],
        )
      ],
    );
  }
}
