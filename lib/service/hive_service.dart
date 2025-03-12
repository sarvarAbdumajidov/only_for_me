import 'package:hive/hive.dart';
import 'package:only_for_me/model/couple_model.dart';

class HiveService {
  static var box = Hive.box("questionsBox");

  static void storeData(Couple couple) {
    box.put(couple.id, couple.toJson());
  }

  static Couple? loadData(String id) {
    var coupleData = box.get(id);
    if (coupleData != null) {
      return Couple.fromJson(coupleData);
    } else {
      return null;
    }
  }

  static void removeCouple(String id) {
    box.delete(id);
  }

  static List<Couple> getAllCouples() {
    List<Couple> coupleList = [];
    Map<dynamic, dynamic> storedCouples = box.toMap();
    storedCouples.forEach((key, value) {
      coupleList.add(Couple.fromJson(value));
    });
    return coupleList;
  }
}
