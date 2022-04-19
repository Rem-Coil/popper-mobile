part of 'scanned_entity.dart';

enum EntityType { bobbin }

extension ToEntity on String {
  EntityType toEntityType() {
    switch (this) {
      case 'bobbin':
        return EntityType.bobbin;
      default:
        throw const NoSuchEntityTypeException();
    }
  }
}

extension ToString on EntityType {
  String get simpleName {
    switch (this) {
      case EntityType.bobbin:
        return 'bobbin';
      default:
        throw const NoSuchEntityTypeException();
    }
  }
}
