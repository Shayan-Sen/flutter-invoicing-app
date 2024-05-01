//Imports
// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//unnecesary import: import 'package:sqflite/sqlite_api.dart';
import 'exceptions.dart';
import 'backendvar.dart';
//MODELS

class ProductModel {
  final int id;
  final String hsnCode;
  final String company;
  final String productName;
  final double price;
  final MUnits measure;

  ProductModel({
    this.id = 0,
    required this.hsnCode,
    required this.company,
    required this.productName,
    required this.price,
    required this.measure,
  });

  ProductModel.fromRow(Map<String, Object?> map)
      : id = map["id"] as int,
        hsnCode = map["hsn_code"] as String,
        company = map["company"] as String,
        productName = map["product_name"] as String,
        price = map["price"] as double,
        measure = MUnits.values.byName(map["units"] as String);

  @override
  bool operator ==(covariant ProductModel other);

  @override
  int get hashCode =>
      [id, hsnCode, company, productName, price, measure].hashCode;
  @override
  String toString() {
    return "ProductModel[id : $id , hsn_code : $hsnCode, company : $company, product_name : $productName, price : $price , units : ${measure.name} ]";
  }
}

class StockModel {
  final int productId;
  final int id;
  final int quantity;

  StockModel({
    this.id = 0,
    required this.productId,
    required this.quantity,
  });

  StockModel.fromRow(Map<String, Object?> map)
      : id = map["id"] as int,
        productId = map["productID"] as int,
        quantity = map["quantity"] as int;

  @override
  bool operator ==(covariant StockModel other);

  @override
  int get hashCode => [id, productId, quantity].hashCode;

  @override
  String toString() =>
      "StockModel[id : $id , productID: $productId, quantity : $quantity]";
}

class Log {
  final int id;
  final int productId;
  final int quantity;
  final DateTime time;
  final Status status;

  Log(
      {this.id = 0,
      required this.status,
      required this.productId,
      required this.quantity,
      required this.time});

  Log.fromRow(Map<String, Object?> map)
      : id = map["id"] as int,
        status = Status.values.byName(map["status"] as String),
        productId = map["productID"] as int,
        quantity = map["quantity"] as int,
        time = DateTime.parse(map["time_"] as String);
  @override
  String toString() =>
      "Log[ id : $id , status : ${status.name}, productID : $productID, quantity : $quantity , time : $time]";
}

//API
class DBapi {
  Database? db_;

  void returnDbState1() {
    print(db_);
  }

  // ignore: unused_element
  Database _getDatabaseorThrow() {
    final db = db_;
    if (db == null) {
      throw DatabaseNotFoundException();
    } else {
      return db;
    }
  }

  Future<void> open() async {
    if (db_ != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docPath = await getApplicationCacheDirectory();
      //wriae
      print(docPath.path);
      final dbPath = join(docPath.path, database);
      final dB = await openDatabase(dbPath);
      await dB.execute(createProductTable);
      await dB.execute(createStockTable);
      await dB.execute(createLogTable);
      db_ = dB;
    } on MissingPlatformDirectoryException {
      throw UnableToGetPathException();
    }
  }

  Future<void> close() async {
    final dB = db_;
    if (dB == null) {
      throw DatabaseNotFoundException();
    } else {
      await dB.close();
      db_ = null;
    }
  }

//productmodel functions
  Future<void> putProduct({required ProductModel vmodel}) async {
    final dB = _getDatabaseorThrow();

    //db variables
    final hsn = vmodel.hsnCode;
    final comp = vmodel.company;
    final pname = vmodel.productName;
    final price = vmodel.price;
    final units = vmodel.measure.name;

    //ifExists variable
    final ifExists = await dB.query(productTable,
        where: 'product_name = ? and units = ?',
        whereArgs: [pname.toLowerCase(), units.toLowerCase()],
        limit: 1);

    //function execute
    if (ifExists.isNotEmpty) {
      throw ProductTypeExistsException();
    } else {
      await dB.insert(productTable, {
        hsNCode: hsn,
        cOmpany: comp,
        productTName: pname,
        pricE: price,
        uNits: units
      });
    }
  }

  Future<List<ProductModel>> getProduct(
      {String? hsn_code,
      String? company,
      String? product_name,
      double? price,
      MUnits? units}) async {
    final db = _getDatabaseorThrow();
    //
    List<Object?> list = [hsn_code, company, product_name, price, units?.name];
    List<String> listx = [
      "hsn_code",
      "company",
      "product_name",
      "price",
      "units"
    ];
    List<String> list1 = [];
    List<Object>? list2 = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i] != null) {
        list1.add("${listx[i]} = ?");
        list2.add(list[i]!);
      }
    }
    String? string1 = (list1.length == 0) ? null : list1.join(" and ");
    list2 = (list2.isEmpty) ? null : list2;
    //
    final results =
        await db.query(productTable, where: string1, whereArgs: list2);
    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      return (results.map<ProductModel>((e) => ProductModel.fromRow(e)))
          .toList();
    }
  }

  Future<void> deleteProduct({required ProductModel vmodel}) async {
    final db = _getDatabaseorThrow();

    final results = await db.query(productTable,
        where: "id= ?", whereArgs: [vmodel.id], limit: 1);
    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      await db.delete(productTable, where: "id = ?", whereArgs: [vmodel.id]);
    }
  }

//stockmodel api functions
  Future<void> putStock({required StockModel vmodel}) async {
    final db = _getDatabaseorThrow();
    final results = await db.query(stockTable,
        where: "productID = ?", whereArgs: [vmodel.productId], limit: 1);
    if (results.isNotEmpty) {
      final StockModel x = StockModel.fromRow(results.first);
      final qty = x.quantity + vmodel.quantity;
      await db.update(stockTable, {"quantity": qty},
          where: "productID = ?", whereArgs: [vmodel.productId]);
    } else {
      await db.insert(
          stockTable, {productID: vmodel.productId, quantiTY: vmodel.quantity});
    }
  }

  Future<List<StockModel>> getStock(
      {int? id, int? productID, int? quantity}) async {
    final db = _getDatabaseorThrow();
    List<Object?> list = [id, productID, quantity];
    List<String> listx = ["id", "productID", "quantity"];
    List<String> list1 = [];
    List<Object>? list2 = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i] != null) {
        list1.add("${listx[i]} = ?");
        list2.add(list[i]!);
      }
    }
    String? string1 = (list1.length == 0) ? null : list1.join(" and ");
    list2 = (list2.isEmpty) ? null : list2;
    final results =
        await db.query(stockTable, where: string1, whereArgs: list2);

    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      return (results.map<StockModel>((e) => StockModel.fromRow(e))).toList();
    }
  }

  Future<StockModel> retriveStock({required StockModel vmodel}) async {
    final db = _getDatabaseorThrow();
    final results = await db.query(stockTable,
        where: "$productID = ?", whereArgs: [vmodel.productId]);
    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      final StockModel instancemodel = StockModel.fromRow(results.first);
      if (instancemodel.quantity >= vmodel.quantity) {
        final StockModel newModel = StockModel(
            id: instancemodel.id,
            productId: instancemodel.productId,
            quantity: (instancemodel.quantity - vmodel.quantity));
        await db.update(stockTable, {quantiTY: newModel.quantity},
            where: "$productID = ?", whereArgs: [instancemodel.productId]);
        return newModel;
      } else {
        throw ExcededMarginException();
      }
    }
  }

//log api functions
  Future<StockModel?> addLog({required Log logmodel}) async {
    final db = _getDatabaseorThrow();
    final time = logmodel.time.toString().substring(0, 19);
    await db.insert(logTable, {
      sTATUS: logmodel.status.name,
      productID: logmodel.productId,
      quantiTY: logmodel.quantity,
      timE: time
    });
    final StockModel stock =
        StockModel(productId: logmodel.productId, quantity: logmodel.quantity);
    if (logmodel.status == Status.arrival) {
      await putStock(vmodel: stock);
      return null;
    } else {
      final StockModel p = await retriveStock(vmodel: stock);
      return p;
    }
  }
//do implement a get log function
}
