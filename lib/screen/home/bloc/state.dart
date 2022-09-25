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

  Widget get page => _pages[currentPage].page;

  List<PageModel> get items => _pages;
}
