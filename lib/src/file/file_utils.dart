import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:base_station/base_station.dart';

class FileUtils {

  /// 临时目录: /data/user/0/com.yc.utils/cache
  /// 获取一个临时目录(缓存)，系统可以随时清除。
  static Future<String?> getTempDir() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      return tempDir.path;
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  /// 文档目录: /data/user/0/com.yc.utils/xxx
  /// 获取应用程序的目录，用于存储只有它可以访问的文件。只有当应用程序被删除时，系统才会清除目录。
  static Future<String?> getAppDocDir() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      return appDocDir.path;
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  ///获取APP应用目录下的文件
  static Future<File?> getAppFile(String fileName) async {
    //获取存储路径
    final filePath = await getAppDocDir();
    if(filePath == null){
      return null;
    }
    //或者file对象（操作文件记得导入import 'dart:io'）
    return File(filePath + "/" + fileName);
  }

  ///获取存在文件中的数据，默认读到应用程序的目录
  ///使用async、await，返回是一个Future对象
  static Future<String?> readStringDir(String fileName) async {
    try {
      final file = await getAppFile(fileName);
      return await file!.readAsString();
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  /// 写入json文件，默认写到应用程序的目录
  /// ex 常用于日志手机
  static Future<File?> writeJsonFileDir(Object obj, String fileName) async {
    try {
      final file = await getAppFile(fileName);
      return await file!.writeAsString(json.encode(obj));
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  ///利用文件存储字符串，默认写到应用程序的目录
  static Future<File?> writeStringDir(String string , String filePath) async {
    try {
      final file = await getAppFile(filePath);
      return await file!.writeAsString(string);
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  ///清除缓存数据
  static Future<bool> clearFileDataDir(String fileName) async{
    try {
      final file = await getAppFile(fileName);
      file!.writeAsStringSync("");
      return true;
    } catch (err) {
      Log.error(err.toString());
      return false;
    }
  }

  ///删除缓存文件
  static Future<bool> deleteFileDataDir(String fileName) async{
    try {
      final file = await getAppFile(fileName);
      file!.delete();
      return true;
    } catch (err) {
      Log.error(err.toString());
      return false;
    }
  }

  ///下面这些方法需要传递自定义存储路径-----------------------------------------------

  ///创建file文件
  static File readFile(filePath) {
    return File('$filePath');
  }

  /// 写入json文件，自定义路径
  static Future<File?> writeJsonCustomFile(Object obj, String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.writeAsString(json.encode(obj));
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  ///利用文件存储字符串，自定义路径
  static Future<File?> writeStringFile(String string , String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.writeAsString(string);
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  ///获取自定义路径文件存中的数据
  ///使用async、await，返回是一个Future对象
  static Future<String?> readStringCustomFile(String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.readAsString();
    } catch (err) {
      Log.error(err.toString());
      return null;
    }
  }

  ///清除缓存数据
  static Future<bool> clearFileData(String filePath) async{
    try {
      final file = readFile(filePath);
      file.writeAsStringSync("");
      return true;
    } catch (err) {
      Log.error(err.toString());
      return false;
    }
  }

  ///删除缓存文件
  static Future<bool> deleteFileData(String filePath) async{
    try {
      final file = readFile(filePath);
      file.delete();
      return true;
    } catch (err) {
      Log.error(err.toString());
      return false;
    }
  }

}