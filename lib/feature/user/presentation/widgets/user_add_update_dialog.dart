import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/presentation/widgets/custom_labelled_text_field.dart';
import 'package:flutter_clean_architecture/common/utilities/extensions/context_extension.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_state.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_event.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_bloc.dart';

class UserAddUpdateDialog extends StatefulWidget {
  final User? user;

  const UserAddUpdateDialog({super.key, this.user});

  @override
  State<UserAddUpdateDialog> createState() => _UserAddUpdateDialogState();
}

class _UserAddUpdateDialogState extends State<UserAddUpdateDialog> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    if (widget.user != null) {
      var user = widget.user!;
      _firstNameController.text = user.firstName ?? "";
      _lastNameController.text = user.lastName ?? "";
      _emailController.text = user.emailAddress ?? "";
      _phoneNumberController.text = user.phoneNumber ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(
        widget.user?.id == null ? "Add User" : "Update User",
      ),
      content: Container(
        constraints: BoxConstraints(
          maxHeight: height * 0.5,
        ),
        child:
            BlocConsumer<UserBloc, UserState>(listener: (context, state) async {
          if (state is UserErrorState) {
            context.handleException(state.error);
          } else if (state is UserAddState || state is UserUpdateState) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomLabelledTextField(
                  label: "First Name",
                  hintText: "Enter first name",
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: _firstNameController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomLabelledTextField(
                  label: "Last Name",
                  hintText: "Enter last name",
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: _lastNameController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomLabelledTextField(
                  label: "Email",
                  hintText: "Enter email address",
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomLabelledTextField(
                  length: 10,
                  label: "Phone Number",
                  hintText: "Enter phone number",
                  controller: _phoneNumberController,
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.go,
                  isDigitOnlyWithNoDecimal: true,
                  onFieldSubmitted: (value) => _addUpdateUser(),
                ),
              ],
            ),
          );
        }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _addUpdateUser(),
          child: Text(
            widget.user?.id == null ? "Save" : "Update",
          ),
        ),
      ],
    );
  }

  void _addUpdateUser() {
    var user = User(
      id: widget.user?.id,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      emailAddress: _emailController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
    );

    context.read<UserBloc>().add(AddUpdateEvent(user));
  }
}
