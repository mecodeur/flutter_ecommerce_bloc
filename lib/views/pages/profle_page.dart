import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_bloc/controllers/auth_bloc/auth_bloc.dart';

import '../widgets/main_button.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 20),
              child: MainButton(text: 'Log Out', onTap: () {
                BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
              }),
            )
          ],
        );
      },
    );
  }

}