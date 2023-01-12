import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/ui/home/ui/pages/operations/operations_page.dart';
import 'package:popper_mobile/ui/home/ui/pages/settings/settings.dart';
import 'package:popper_mobile/ui/home/ui/widgets/navigation_bar.dart';

part 'event.dart';

part 'state.dart';

@injectable
class PagesControllerBloc
    extends Bloc<PagesControllerEvent, PagesControllerState> {
  PagesControllerBloc() : super(const PagesControllerState.initial()) {
    on<ChangeScreenEvent>(
      (event, emit) => emit(PagesControllerState.change(event.index)),
    );
  }
}
