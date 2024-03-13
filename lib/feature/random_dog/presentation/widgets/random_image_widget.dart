import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/entities/random_dog_state.dart';
import 'package:flutter_clean_architecture/feature/random_dog/presentation/manager/random_dog_cubit.dart';

class RandomImageWidget extends StatelessWidget {
  const RandomImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<RandomDogCubit, RandomDogState>(
          builder: (context, state) {
        if (state is RandomDogLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is RandomDogErrorState) {
          return Text(
            state.error.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          );
        } else if (state is RandomDogFetchedState) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: state.randomDog,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: Text(
                  "Downloading ${downloadProgress.downloaded}...",
                ),
              ),
              errorWidget: (context, url, error) => Text(
                error.toString(),
              ),
            ),
          );
        } else {
          return const Text(
            "Click on 'Get Random Photo' to view random dog images",
            textAlign: TextAlign.center,
          );
        }
      }),
    );
  }
}
