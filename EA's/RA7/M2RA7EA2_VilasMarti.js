db.Students.find({ genere: "Home" });

db.Students.find({ genere: "Dona" });

db.Students.find({ any_naixement: 1993 });

db.Students.find({ genere: "Home", any_naixement: 1993 });

db.Students.find({ any_naixement: { $gte: 1990, $lte: 1999 } });

db.Students.find({ genere: "Home", any_naixement: { $lt: 1990 } });

db.Students.find({ genere: "Dona", any_naixement: { $lt: 1990 } });

db.Students.find({ genere: "Dona", any_naixement: { $gte: 1980, $lte: 1989 } });

db.Students.find({ genere: "Home", any_naixement: { $gte: 1980, $lte: 1989 } });

db.Students.find({ genere: "Dona", any_naixement: { $gte: 1980, $lte: 1989 } });

db.Students.find({ any_naixement: { $ne: 1985 } });

db.Students.find({ any_naixement: { $in: [1970, 1980, 1990] } });

db.Students.find({ any_naixement: { $nin: [1970, 1980, 1990] } });

db.Students.find({ $expr: { $eq: [ { $mod: [ "$any_naixement", 2 ] }, 0 ] } });

db.Students.find({ $expr: { $eq: [ { $mod: [ "$any_naixement", 10 ] }, 0 ] } });

db.Students.find({ telefon_auxiliar: { $exists: true, $ne: "" } });

db.Students.find({ $or: [ { segon_cognom: { $exists: false } }, { segon_cognom: "" } ] });

db.Students.find({
  telefon_auxiliar: { $exists: true, $ne: "" },
  $or: [ { segon_cognom: { $exists: false } }, { segon_cognom: "" } ]
});

db.Students.find({ email: /\.net$/ });

db.Students.find({ nom: { $regex: "^[AEIOUaeiou]", $options: "i" } });

db.Students.find({ $expr: { $gt: [ { $strLenCP: "$nom" }, 13 ] } });

db.Students.find({ nom: /.*[aeiouAEIOU].*[aeiouAEIOU].*[aeiouAEIOU].*[aeiouAEIOU].*/ });

db.Students.find({ dni: { $regex: "^[A-Za-z]" } });

db.Students.find({ dni: { $regex: "^[A-Za-z].*[A-Za-z]$" } });

db.Students.find({ telefon: { $regex: "^622" } });