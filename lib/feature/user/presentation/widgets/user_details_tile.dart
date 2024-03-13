import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/utilities/extensions/string_extensions.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:flutter_clean_architecture/feature/user/domain/use_cases/user_use_cases.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_bloc.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/widgets/user_add_update_dialog.dart';

class UserDetailsTile extends StatelessWidget {
  final int index;
  final User user;

  const UserDetailsTile({
    super.key,
    required this.index,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: Key(index.toString()),
        onDismissed: (direction) {
          context.read<UserBloc>().add(DeleteUserCase(user));
        },
        child: ListTile(
          onTap: () async {
            return showAdaptiveDialog(
              context: context,
              builder: (context) => UserAddUpdateDialog(
                user: user,
              ),
            );
          },
          leading: CircleAvatar(
            radius: 30.0,
            child: Text(
              "${user.firstName} ${user.lastName}".getPlaceHolderName,
              maxLines: 1,
            ),
          ),
          title: Text("${user.firstName} ${user.lastName}"),
          subtitle: Text(user.emailAddress ?? "N/A"),
          trailing: Text(user.phoneNumber ?? "N/A"),
        ),
      ),
    );
  }
}
