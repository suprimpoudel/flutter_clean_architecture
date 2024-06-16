import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/random_dog/presentation/manager/random_dog_cubit.dart';
import 'package:flutter_clean_architecture/feature/random_dog/presentation/widgets/random_image_widget.dart';

class RandomDogPage extends StatelessWidget {
  const RandomDogPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 0.4,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: const RandomImageWidget(),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Align(
            alignment: Alignment.center,
            child: FilledButton(
              onPressed: () =>
                  context.read<RandomDogCubit>().getRandomDogImage(),
              child: const Text(
                "Get Random Photo",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
