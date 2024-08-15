part of 'add_cubit_cubit.dart';

@immutable
sealed class AddCubitState {}

final class AddCubitInitial extends AddCubitState {}

final class AddLoading extends AddCubitState {}

final class AddLoaded extends AddCubitState {
  final BannerAd? bannerAd;
  final bool isLoaded;

  AddLoaded({
    required this.bannerAd,
    required this.isLoaded,
  });
}

final class AddError extends AddCubitState {
  final BannerAd? bannerAd;
  final bool isLoaded;

  AddError({
    required this.bannerAd,
    required this.isLoaded,
  });
}
