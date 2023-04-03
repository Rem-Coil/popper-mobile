part of 'bloc.dart';

final _pages = <PageModel>[
  OperationsPage.model,
  SettingsPage.model,
];

@immutable
class PagesControllerState {
  const PagesControllerState.initial() : currentPage = 0;

  const PagesControllerState.change(this.currentPage);

  final int currentPage;

  PageModel get page => _pages[currentPage];

  List<PageModel> get items => _pages;
}
