part of 'menu_bloc.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}

final class MenuLoading extends MenuState {}

final class FAQLoaded extends MenuState {
  final FAQ faqs;

  FAQLoaded({
    required this.faqs,
  });
}

final class TermsLoaded extends MenuState {
  final Terms terms;

  TermsLoaded({
    required this.terms,
  });
}

final class PrivacyLoaded extends MenuState {
  final Map<String, dynamic> privacy;

  PrivacyLoaded({
    required this.privacy,
  });
}

final class ContactUsLoaded extends MenuState {
  final Map<String, dynamic> contactus;

  ContactUsLoaded({
    required this.contactus,
  });
}

final class Menufailure extends MenuState {
  final String message;

  Menufailure({
    required this.message,
  });
}

final class UserDeleted extends MenuState {
  final String message;

  UserDeleted({
    required this.message,
  });
}

final class PasswordReset extends MenuState {
  final String message;

  PasswordReset({
    required this.message,
  });
}
