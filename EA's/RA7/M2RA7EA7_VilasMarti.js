//EA7

db.people.insertMany([
  {
    "name": "Anna",
    "age": 27,
    "city": "Barcelona"
  },
  {
    "name": "Joan",
    "age": 35,
    "city": "Girona"
  }
])

// Exercici 2. Consultes
// a) Persones amb name que acabi en "n", mostra només email
db.people.find(
  { name: /n$/ },
  { _id: 0, email: 1 }
);

// b) Persones amb "qui" o "sunt" en tags, només 8 i en format bonic
db.people.find(
  { tags: { $in: ["qui", "sunt"] } }
).limit(8).pretty();

// c) Persones amb amiga "Serenity Nelson", format bonic
db.people.find(
  { "friends.name": "Serenity Nelson" }
).pretty();

// d) Persones registrades entre 2001 i 2018 i company amb "jam"
db.people.countDocuments({
  registered: {
    $gte: new Date("2001-01-01"),
    $lte: new Date("2018-12-31")
  },
  company: /jam/i
});

// e) Persones que NO tenen "tempor" ni "nulla" a tags, mostra només tags
db.people.find(
  { tags: { $nin: ["tempor", "nulla"] } },
  { _id: 0, tags: 1 }
);

// f) Dones amb 3 amics i no actives, format bonic
db.people.find(
  {
    gender: "female",
    isActive: false,
    "friends.2": { $exists: true },
    "friends.3": { $exists: false }
  }
).pretty();

//Ex3

// a) Afegir camp "longitude": 1 a qui tingui "Berkeley" (case sensitive) a l'adreça
db.people.updateMany(
  { address: { $regex: "Berkeley" } },
  { $set: { longitude: 1 } }
);

// b) Afegir tag "foot" a Bella Carrington
db.people.updateOne(
  { name: "Bella Carrington" },
  { $addToSet: { tags: "foot" } }
);

// c) Afegir amic a Julia Young
db.people.updateOne(
  { name: "Julia Young" },
  { $push: { friends: { id: "1", name: "Trinity Ford" } } }
);

// d) Modificar el segon tag de Ava Miers per "sunt"
db.people.updateOne(
  { name: "Ava Miers" },
  { $set: { "tags.1": "sunt" } }
);

//Ex4

// a) Elimina persones amb "berl" (en minúscules) al nom — case sensitive
db.people.deleteMany({
  name: { $regex: "berl" }
});

// b) Elimina el camp "latitude" de tots els documents
db.people.updateMany(
  { latitude: { $exists: true } },
  { $unset: { latitude: "" } }
);

// c) Elimina el tag "enim" de la persona "Aubrey Calhoun"
db.people.updateOne(
  { name: "Aubrey Calhoun" },
  { $pull: { tags: "enim" } }
);

// d) Elimina l'últim element del camp "tags" de "Caroline Webster"
db.people.updateOne(
  { name: "Caroline Webster" },
  { $pop: { tags: 1 } }
);

//Ex5

// a) Mostrar una llista amb el nom de tots els amics de les persones
db.people.aggregate([
  { $unwind: "$friends" },
  { $project: { _id: 0, nomAmic: "$friends.name" } }
]);

// b) Comptar quantes vegades apareix cada etiqueta (tag)
db.people.aggregate([
  { $unwind: "$tags" },
  { $group: { _id: "$tags", total: { $sum: 1 } } },
  { $sort: { total: -1 } }
]);

// c) Mitjana d’edat dels homes i dones
db.people.aggregate([
  { $group: { _id: "$gender", mitjanaEdat: { $avg: "$age" } } }
]);

// d) Persones amb 7 o més etiquetes, mostrar nom i número d’etiquetes
db.people.aggregate([
  { $project: { name: 1, numTags: { $size: "$tags" } } },
  { $match: { numTags: { $gte: 7 } } }
]);
