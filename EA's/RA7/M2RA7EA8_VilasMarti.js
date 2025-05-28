// 1) Mostrar llibres amb mínim 5 autors
db.books.find({ "authors.4": { $exists: true } })

// 2) Llibres ordenats per número d’autors de forma descendent
db.books.aggregate([
  { $project: { title: 1, numAuthors: { $size: "$authors" } } },
  { $sort: { numAuthors: -1 } }
])

// 3) Mostrar ISBN per cada status
db.books.aggregate([
  { $group: { _id: "$status", isbns: { $addToSet: "$isbn" } } }
])

// 4) Nombre de valoracions "grades" per restaurant
db.restaurants.aggregate([
  { $project: { name: 1, numGrades: { $size: "$grades" } } }
])

// 5) Comptar quantes vegades apareix cada score
db.restaurants.aggregate([
  { $unwind: "$grades" },
  { $group: { _id: "$grades.score", count: { $sum: 1 } } },
  { $sort: { count: -1 } }
])

// 6) Comptar quantes vegades el score ha sigut 11
db.restaurants.aggregate([
  { $unwind: "$grades" },
  { $match: { "grades.score": 11 } },
  { $count: "num_scores_11" }
])

// 7) Comptar scores amb més de 60 aparicions
db.restaurants.aggregate([
  { $unwind: "$grades" },
  { $group: { _id: "$grades.score", count: { $sum: 1 } } },
  { $match: { count: { $gt: 60 } } },
  { $sort: { count: -1 } }
])

// 8) Tipus de cuina per barri
db.restaurants.aggregate([
  { $group: { _id: "$borough", cuisines: { $addToSet: "$cuisine" } } },
  { $sort: { _id: 1 } }
])

// 9) Noms dels carrers per cada codi postal
db.restaurants.aggregate([
  { $group: { _id: "$address.zipcode", streets: { $addToSet: "$address.street" } } },
  { $sort: { _id: 1 } }
])

// 10) Quants restaurants hi ha per codi postal
db.restaurants.aggregate([
  { $group: { _id: "$address.zipcode", numRestaurants: { $sum: 1 } } },
  { $sort: { numRestaurants: -1 } }
])
