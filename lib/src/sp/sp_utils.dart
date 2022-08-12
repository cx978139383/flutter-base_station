import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_station/src/extensions/extension_map.dart';
import 'package:base_station/src/extensions/extension_list.dart';
import '../../base_station.dart';

/// sp存储工具类，适合存储轻量级数据，不建议存储json长字符串
class SpUtils {


  SpUtils._();
  static late SharedPreferences _prefs;

  /// 初始化，必须要初始化
  /// 多次调用不会多次初始化SharedPreferences
  static Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  /// 判断是否存在key的数据
  static bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  /// put object.
  /// 存储object类型数据
  static Future<bool> putObject(String key, Object value) {
    return _prefs.setString(key, json.encode(value));
  }

  /// 获取sp中key的map数据
  static Map? getObject(String key) {
    String? _data = _prefs.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// put object list.
  /// 存储sp中key的list集合
  static Future<bool> putObjectList(String key, List<Object> list) {
    List<String> _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return _prefs.setStringList(key, _dataList);
  }

  /// get object list.
  /// 获取sp中key的list集合
  static List<Map>? getObjectList(String key) {
    List<String>? dataLis = _prefs.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    }).toList();
  }

  /// get string.
  /// 获取sp中key的字符串
  static String getString(String key, {String defValue = ''}) {
    return _prefs.getString(key) ?? defValue;
  }

  /// put string.
  /// 存储sp中key的字符串
  static Future<bool> putString(String key, String value) {
    return _prefs.setString(key, value);
  }

  /// get bool.
  /// 获取sp中key的布尔值
  static bool getBool(String key, {bool defValue = false}) {
    return _prefs.getBool(key) ?? defValue;
  }

  /// put bool.
  /// 存储sp中key的布尔值
  static Future<bool> putBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  /// get int.
  /// 获取sp中key的int值
  static int getInt(String key, {int defValue = 0}) {
    return _prefs.getInt(key) ?? defValue;
  }

  /// put int.
  /// 存储sp中key的int值
  static Future<bool> putInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  /// get double.
  /// 获取sp中key的double值
  static double getDouble(String key, {double defValue = 0.0}) {
    return _prefs.getDouble(key) ?? defValue;
  }

  /// put double.
  /// 存储sp中key的double值
  static Future<bool> putDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  /// get string list.
  /// 获取sp中key的list<String>值
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    return _prefs.getStringList(key) ?? defValue;
  }

  /// put string list.
  /// 存储sp中key的list<String>值
  static Future<bool> putStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  /// 获取sp中key的map值
  static Map getStringMap(String key) {
    String? jsonString = _prefs.getString(key);
    Map map = json.decode(jsonString!);
    return map;
  }

  /// 存储sp中key的map值
  static Future<bool> putStringMap(String key, Map value) {
    var jsonMapString = value.toJsonString();
    return _prefs.setString(key, jsonMapString);
  }

  /// 存储sp中key的list值
  static Future<bool> putStringList2(String key, List value) {
    var jsonMapString = value.toJsonString();
    return _prefs.setString(key, jsonMapString);
  }

  /// get dynamic.
  /// 获取sp中key的dynamic值
  static dynamic getDynamic(String key) {
    return _prefs.get(key);
  }

  /// get keys.
  /// 获取sp中所有的key
  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  /// remove.
  /// 移除sp中key的值
  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  /// clear.
  /// 清除sp
  static Future<bool> clear() {
    return _prefs.clear();
  }


  /// 遍历打印sp的key和value
  static void forEach(){
    Set<String> keys = getKeys();
    Iterator<String> iterator = keys.iterator;
    while(iterator.moveNext()){
      var key = iterator.current;
      var value = get(Uri.parse(key));
      Log.info("key : $key , value : $value");
    }
  }

}