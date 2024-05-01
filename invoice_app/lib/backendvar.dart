//Constants,Variables and Enums
enum MUnits { pcs, box }

enum Status { arrival, departure }

const database = "billing.db";
const productTable = "product";
const stockTable = "Stock";
const logTable = "Log";
const productID = "productID";
const quantiTY = "quantity";
const iD = "id";
const hsNCode = "hsn_code";
const cOmpany = "company";
const productTName = "product_name";
const pricE = "price";
const uNits = "units";
const sTATUS = "status";
const timE = "time_";
//create tables
const createProductTable = '''
CREATE TABLE IF NOT EXISTS "product" (
	"id"	INTEGER NOT NULL UNIQUE,
	"hsn_code"	TEXT NOT NULL,
	"company"	TEXT,
	"product_name"	TEXT,
	"price"	REAL,
	"units"	TEXT CHECK("units" IN ("box", "pcs")),
	PRIMARY KEY("id" AUTOINCREMENT)
); ''';

const createLogTable = '''
CREATE TABLE IF NOT EXISTS "Log" (
	"id"	INTEGER NOT NULL UNIQUE,
	"status"	TEXT CHECK("status" IN ("arrival", "departure")),
	"productID"	INTEGER for,
	"quantity"	INTEGER,
	"time_"	TEXT DEFAULT (datetime('now', 'localtime')),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("productID") REFERENCES "product"("id")
);''';

const createStockTable = '''
CREATE TABLE IF NOT EXISTS "Stock" (
	"id"	INTEGER NOT NULL UNIQUE,
	"productID"	INTEGER,
	"quantity"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("productID") REFERENCES "product"("id")
);''';
// create tables

var jsonData = [];




/*

UNUSED FUNCTIONS :

------------------------------------------------------------------------
  Future<StockModel> updateStock(
      {required StockModel oldmodel,
      int? productID,
      int? quantity}) async {
    final db = _getDatabaseorThrow();
    final results = await db.query(stockTable,
        where: "id = ?", whereArgs: [oldmodel.id], limit: 1);
    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      //id = (id == null) ? oldmodel.id : id;
      productID = (productID == null) ? oldmodel.productId : productID;
      quantity = (quantity == null) ? oldmodel.quantity : quantity;
      StockModel newmodel = StockModel(
          id: oldmodel.id,
          productId: productID,
          quantity: quantity,);

      await db.update(stockTable,
          {"productID": productID, "quantity": quantity},
          where: "id = ?", whereArgs: [oldmodel.id]);
      return newmodel;
    }
  }
  
  
  
  
  Future<void> deleteStock({required StockModel vmodel}) async {
    final db = _getDatabaseorThrow();
    final results = await db.query(stockTable,
        where: "id = ?", whereArgs: [vmodel.id], limit: 1);
    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      await db.delete(stockTable, where: "id = ?", whereArgs: [vmodel.id]);
    }
  }



    Future<ProductModel> updateProduct(
      {required ProductModel oldmodel,
      String? hsn,
      String? company,
      String? productname,
      double? price,
      MUnits? units}) async {
    final db = _getDatabaseorThrow();

    final results = await db.query(productTable,
        where: "id  = ?", whereArgs: [oldmodel.id], limit: 1);

    if (results.isEmpty) {
      throw RowsNotFoundException();
    } else {
      hsn = (hsn == null) ? oldmodel.hsnCode : hsn;
      company = (company == null) ? oldmodel.company : company;
      productname = (productname == null) ? oldmodel.productName : productname;
      price = (price == null) ? oldmodel.price : price;
      units = (units == null) ? oldmodel.measure : units;
      final newmodel = ProductModel(
          id: oldmodel.id,
          hsnCode: hsn,
          company: company,
          productName: productname,
          price: price,
          measure: units);
      await db.update(
          productTable,
          {
            hsNCode: newmodel.hsnCode,
            cOmpany: newmodel.company,
            productTName: newmodel.productName,
            pricE: newmodel.price,
            uNits: units.name //((newmodel.measure == MUnits.box) ? box : pcs)
          },
          where: "id = ?",
          whereArgs: [oldmodel.id]);
      return newmodel;
    }
  }
------------------------------------------------------------------------------------------
  */