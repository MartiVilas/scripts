// ==== EJERCICIO 1 ====
use catalogo
db.createCollection("productos")
db.productos.insertMany([
  { name: "MacBook Pro" },
  { name: "MacBook Air" },
  { name: "MacBook" }
])
db.productos.find()

// ==== EJERCICIO 2 ====
db.productos.find()
db.productos.find({ name: "MacBook Air" })

// ==== EJERCICIO 3 ====
var cursor = db.productos.find()
while (cursor.hasNext()) { printjson(cursor.next()) }

// ==== EJERCICIO 4 ====
db.productos.insertMany([
  { name: "iPhone 8" },
  { name: "iPhone 6s" },
  { name: "iPhone X" },
  { name: "iPhone SE" },
  { name: "iPhone 7" }
])

// ==== EJERCICIO 5 ====
db.productos.drop()
db.dropDatabase()
use catalogo
db.productos.insertMany([
  { name: "MacBook Pro" },
  { name: "MacBook Air" },
  { name: "MacBook" }
])

// ==== EJERCICIO 6 ====
// mongoimport --db catalogo --collection productos --drop --file assets/db/fixtures/products.json --jsonArray

// ==== EJERCICIO 7 ====
db.productos.find({ name: 1, price: 1 })
db.productos.find({ categories: { $all: ["macbook", "notebook"] } })
db.productos.find({ categories: "notebook" })

// ==== EJERCICIO 8 ====
db.productos.find({ price: 2399 }, { name: 1, _id: 0 })
db.productos.find({ categories: "iphone" }, { categories: 0 })

// ==== EJERCICIO 9 ====
db.productos.find({ price: { $gt: 2000 } })
db.productos.find({ price: { $lt: 500 } })
db.productos.find({ price: { $lte: 500 } })
db.productos.find({ price: { $gte: 1000 } })

// ==== EJERCICIO 10 ====
db.productos.find({ $and: [ { stock: 200 }, { categories: "iphone" } ] })
db.productos.find({ $or: [ { price: 329 }, { categories: "notebook" } ] })

// ==== EJERCICIO 11 ====
db.productos.updateOne({ name: "Mac mini" }, { $set: { stock: 50 } })
db.productos.updateOne({ name: "iPhone X" }, { $set: { stock: 25, price: 1200 } })

// ==== EJERCICIO 12 ====
db.productos.updateOne({ name: "iPad Pro" }, { $addToSet: { categories: "prime" } })
db.productos.updateOne({ name: "iPad Pro" }, { $pull: { categories: "prime" } })

// ==== EJERCICIO 13 ====
db.productos.deleteMany({ categories: "tv" })
db.productos.deleteOne({ name: "Apple Watch Series 1" })
db.productos.find({ name: "Apple Watch Series 3" }, { _id: 1 })

// ==== EJERCICIO 14 ====
// mongoimport --db catalogo --collection productos --drop --file assets/db/fixtures/products.json --jsonArray

// ==== EJERCICIO 15 ====
db.productos.find().sort({ price: 1 })
db.productos.find().sort({ price: -1 })
db.productos.find().sort({ stock: -1 })

// ==== EJERCICIO 16 ====
db.productos.find({}, { name: 1, _id: 0 }).limit(2)
db.productos.find({}, { name: 1, _id: 0 }).sort({ name: 1 }).limit(5)
db.productos.find({}, { name: 1, _id: 0 }).sort({ name: -1 }).limit(5)

// ==== EJERCICIO 17 ====
// Página 1
db.productos.find().skip(0).limit(5)
// Página 2
db.productos.find().skip(5).limit(5)