import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/presentation/widgets/loading_circular_progress.dart';
import 'package:flutter_clean_architecture/common/presentation/widgets/pagination_loading_widget.dart';
import 'package:flutter_clean_architecture/common/utilities/extensions/context_extension.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';
import 'package:flutter_clean_architecture/feature/user/domain/entities/user_state.dart';
import 'package:flutter_clean_architecture/feature/user/domain/use_cases/user_use_cases.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_bloc.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/widgets/user_details_tile.dart';

class UserListingPage extends StatefulWidget {
  const UserListingPage({super.key});

  @override
  State<UserListingPage> createState() => _UserListingPageState();
}

class _UserListingPageState extends State<UserListingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<UserBloc>().add(ClearAndFetchUserCase());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<UserBloc>().add(LoadMoreUserCase());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = [];

    return BlocConsumer<UserBloc, UserState>(listener: (context, state) {
      if (state is UserClearState) {
        users.clear();
      } else if (state is UserListErrorState) {
        context.handleException(state.error);
      } else if (state is UserAddState) {
        context.displaySnackbar("Successfully added user");
        users.insert(0, state.user);
      } else if (state is UserDataFetchedState) {
        users.addAll(state.users);
      } else if (state is UserDeleteState) {
        context
            .displaySnackbar("Successfully deleted user with id ${state.id}");
        users.removeWhere((element) => element.id == state.id);
      } else if (state is UserUpdateState) {
        var index = users.indexWhere((element) => element.id == state.user.id);
        if (index != -1) {
          context.displaySnackbar("Successfully updated user");
          users[index] = state.user;
        }
      }
    }, builder: (context, state) {
      return Stack(
        children: [
          state is UserListLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : users.isEmpty
                  ? const Center(
                      child: Text(
                        "No Users Found, Click on '+' icon to add one",
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              var user = users[index];
                              return UserDetailsTile(
                                index: index,
                                user: user,
                              );
                            },
                            itemCount: users.length,
                          ),
                        ),
                        if (state is UserPaginationLoadingState)
                          const SizedBox(
                            height: 15.0,
                          ),
                        if (state is UserPaginationLoadingState)
                          const PaginationLoadingWidget(),
                        if (state is UserPaginationLoadingState)
                          const SizedBox(
                            height: 15.0,
                          ),
                      ],
                    ),
          if (state is UserLoadingState) const LoadingCircularProgress(),
        ],
      );
    });
  }
}
