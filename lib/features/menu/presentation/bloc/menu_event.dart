part of 'menu_bloc.dart';

@immutable
sealed class MenuEvent {}

final class UserLogOutEvent extends MenuEvent {}

final class FAQgetEvent extends MenuEvent {}

final class TermsgetEvent extends MenuEvent {}

final class PrivacygetEvent extends MenuEvent {}

final class ContactUsgetEvent extends MenuEvent {}

final class UserDeletedEvent extends MenuEvent {
  final String reason;

  UserDeletedEvent({
    required this.reason,
  });
}

final class PAsswordResetEvent extends MenuEvent {
  final String email;

  PAsswordResetEvent({
    required this.email,
  });
}
