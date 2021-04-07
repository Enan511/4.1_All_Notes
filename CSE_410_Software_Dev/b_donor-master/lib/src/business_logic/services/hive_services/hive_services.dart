import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveServices {
  static var _box;

  // initialize the box
  static init() async{
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox('user-data');
  }

  // add integer data to box
  static addIntegerData({@required String name, @required int data}){
    _box.put(name, data);
  }
  // add String data to box
  static addStringData({@required String name, @required String data}){
    _box.put(name, data);
  }
  // get data from box
  static getData({@required String name}){
    return _box.get(name);
  }
  // clear all data of box
  static logOut(){
    _box.delete('id');
    _box.delete('email');
    _box.delete('phone');
    _box.delete('name');
  }
} 