import 'package:flutter/painting.dart';
import 'package:popper_mobile/core/theme/colors.dart';

enum OperationStatus { saved, cached }

extension OperationStatusValues on OperationStatus {
  String get title => this == OperationStatus.saved
      ? 'Завершённые катушки'
      : 'Не загруженные катушки';

  Color get color =>
      Color(this == OperationStatus.saved ? savedColor : cachedColor);
}
