part of 'is_firsttime_cubit.dart';

@immutable
sealed class IsFirsttimeState {}

final class IsFirsttimeInitial extends IsFirsttimeState {
  final bool? isFirsttime;

  IsFirsttimeInitial({
    this.isFirsttime = true,
  });
}

final class IsFirsttime extends IsFirsttimeState {
  final bool? isFirsttime;

  IsFirsttime({
    required this.isFirsttime,
  });
}
