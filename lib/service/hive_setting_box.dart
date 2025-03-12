import 'package:hive/hive.dart';
import 'package:only_for_me/service/log_service.dart';

class SettingBox {
  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('settingBox');
  }

  static void storeData(bool isIntro) {
    if (!_isBoxInitialized()) return;
    _box.put('isIntro', isIntro);
  }

  static bool getData() {
    if (!_isBoxInitialized()) return false;
    return _box.get('isIntro', defaultValue: false);
  }

  static void deleteData() {
    if (!_isBoxInitialized()) return;
    _box.delete('isIntro');
  }

  static bool _isBoxInitialized() {
    if (!_box.isOpen) {
      LogService.w("Error: Box is not initialized. Call SettingBox.init() first.");
      return false;
    }
    return true;
  }
}
