import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/app_user/app_user_cubit.dart';
import 'package:parttime/features/menu/domain/entities/faq.dart';
import 'package:parttime/features/menu/domain/entities/terms.dart';
import 'package:parttime/features/menu/domain/uscase/delete_user_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/get_contact_us_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/get_faq_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/get_privacy_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/password_eset_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/terms_usecase.dart';
import 'package:parttime/features/menu/domain/uscase/user_logout_usecase.dart';
part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final UserLogOutUsecase _userLogOutUsecase;
  final AppUserCubit _appUserCubit;
  final GetFaqUsecase _getFaqUsecase;
  final GetTermsUsecase _getTermsUsecase;
  final DeleteUserUsecase _deleteUserUsecase;
  final GetPrivacyUsecase _getPrivacyUsecase;
  final PasswordEsetUsecase _passwordEsetUsecase;
  final GetContactUsUsecase _contactUsUsecase;
  MenuBloc({
    required UserLogOutUsecase userLogOutUsecase,
    required AppUserCubit appuserCubit,
    required GetFaqUsecase getFaqUsecase,
    required GetTermsUsecase getTermsUsecase,
    required DeleteUserUsecase deleteUserUsecase,
    required GetPrivacyUsecase getPrivacyUsecase,
    required PasswordEsetUsecase passwordEsetUsecase,
    required GetContactUsUsecase contactUsUsecase,
  })  : _userLogOutUsecase = userLogOutUsecase,
        _appUserCubit = appuserCubit,
        _getFaqUsecase = getFaqUsecase,
        _getTermsUsecase = getTermsUsecase,
        _deleteUserUsecase = deleteUserUsecase,
        _getPrivacyUsecase = getPrivacyUsecase,
        _passwordEsetUsecase = passwordEsetUsecase,
        _contactUsUsecase = contactUsUsecase,
        super(MenuInitial()) {
    on<MenuEvent>((_, emit) => emit(MenuLoading()));
    on<UserLogOutEvent>(_userLogOut);
    on<FAQgetEvent>(_getFAQs);
    on<TermsgetEvent>(_getTerms);
    on<UserDeletedEvent>(_deleteUser);
    on<PrivacygetEvent>(_getPrivacy);
    on<PAsswordResetEvent>(_resetPassword);
    on<ContactUsgetEvent>(_getcontactUs);
  }

  void _userLogOut(UserLogOutEvent event, Emitter<MenuState> emit) async {
    final res = await _userLogOutUsecase.call(UserLogOutParams());

    res.fold((l) => emit(Menufailure(message: l.message)),
        (r) => _emitMenuSuccess(emit));
  }

  void _emitMenuSuccess(
    Emitter<MenuState> emit,
  ) {
    _appUserCubit.updateUser(null);
    emit(MenuInitial());
  }

  void _getFAQs(FAQgetEvent event, Emitter<MenuState> emit) async {
    final res = await _getFaqUsecase.call(FAqParams());

    res.fold(
      (l) => emit(Menufailure(message: l.message)),
      (r) => emit(FAQLoaded(faqs: r)),
    );
  }

  void _getPrivacy(PrivacygetEvent event, Emitter<MenuState> emit) async {
    final res = await _getPrivacyUsecase.call(PrivacyParamas());

    res.fold(
      (l) => emit(Menufailure(message: l.message)),
      (r) => emit(PrivacyLoaded(privacy: r)),
    );
  }

  void _getcontactUs(ContactUsgetEvent event, Emitter<MenuState> emit) async {
    final res = await _contactUsUsecase.call(ContactUsParams());

    res.fold(
      (l) => emit(Menufailure(message: l.message)),
      (r) => emit(ContactUsLoaded(contactus: r)),
    );
  }

  void _getTerms(TermsgetEvent event, Emitter<MenuState> emit) async {
    final res = await _getTermsUsecase.call(TermsParams());

    res.fold(
      (l) => emit(Menufailure(message: l.message)),
      (r) => emit(TermsLoaded(terms: r)),
    );
  }

  void _deleteUser(UserDeletedEvent event, Emitter<MenuState> emit) async {
    final res = await _deleteUserUsecase.call(NoParams(
      reason: event.reason,
    ));

    res.fold(
      (l) => emit(Menufailure(message: l.message)),
      (r) => _userDeleteSuccess(r, emit),
    );
  }

  void _userDeleteSuccess(
    String message,
    Emitter<MenuState> emit,
  ) {
    _appUserCubit.updateUser(null);
    emit(UserDeleted(message: message));
  }

  void _resetPassword(PAsswordResetEvent event, Emitter<MenuState> emit) async {
    final res = await _passwordEsetUsecase.call(PasswordParams(
      email: event.email,
    ));

    res.fold(
      (l) => emit(Menufailure(message: l.message)),
      (r) => emit(PasswordReset(message: r)),
    );
  }
}
