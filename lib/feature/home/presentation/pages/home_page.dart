import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/home/domain/use_cases/tab_toggle_use_case.dart';
import 'package:flutter_clean_architecture/feature/home/presentation/manager/tab_bloc.dart';
import 'package:flutter_clean_architecture/feature/random_dog/presentation/pages/random_dog_page.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/pages/user_listing_page.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/widgets/user_add_update_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, int>(builder: (context, currentIndex) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Clean Architecture"),
          actions: currentIndex == 1 && Platform.isIOS
              ? [
                  IconButton(
                    onPressed: () async {
                      return await showCupertinoDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const UserAddUpdateDialog(),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ]
              : null,
        ),
        body:
            currentIndex == 0 ? const RandomDogPage() : const UserListingPage(),
        floatingActionButton: currentIndex == 1 && Platform.isAndroid
            ? FloatingActionButton(
                onPressed: () async {
                  return await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => const UserAddUpdateDialog(),
                  );
                },
                child: const Icon(
                  Icons.add,
                ),
              )
            : null,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            context.read<TabBloc>().add(
                  index == 0 ? APITabToggleCase() : DatabaseTabToggleCase(),
                );
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.wifi),
              icon: Icon(Icons.wifi_2_bar),
              label: 'Network Call',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.folder_copy),
              icon: Icon(Icons.folder),
              label: 'Database Call',
            ),
          ],
        ),
      );
    });
  }
}
