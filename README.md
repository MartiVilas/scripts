# MongoDB Exemples i Apunts — CFGS DAW Mòdul 2

Aquest repositori conté diversos exercicis i exemples pràctics per aprendre MongoDB des de les operacions més bàsiques (CRUD) fins a consultes complexes amb `aggregate`, `regex`, `project`, `unwind`, etc.

---

## 📁 Contingut del repositori

- `M2RA7EA1_VilasMarti.js` → Exercicis CRUD bàsics amb productes
- `M2RA7EA2_VilasMarti.js` → Consultes condicionals amb `find` i `regex`
- `M2RA7EA5_VilasMarti.js` → Actualització de documents (`$set`, `$push`, `$unset`)
- `M2RA7EA6_VilasMarti.js` → Eliminació de documents (`deleteOne`, `deleteMany`)
- `M2RA7EA7_VilasMarti.js` → Consultes i agregacions amb persones, tags i amics
- `M2RA7EA8_VilasMarti.js` → Consultes i agregacions sobre llibres i restaurants
- `Exemples1. Operacions CRUD.pdf` → Guia completa CRUD i operadors
- `varis.pdf` → Apunts sobre `regex`, `aggregate`, `dot notation` i més

---

## 🧰 CRUD BÀSIC — Nivell Fàcil

### 🟢 Inserir dades
```js
db.people.insertOne({ name: "Anna", age: 27 });
db.people.insertMany([{ name: "Joan", age: 30 }, { name: "Maria", age: 25 }]);
```

### 🔵 Llegir dades
```js
db.people.find(); // Tots els documents
db.people.find({ age: { $gte: 25 } }); // Majors o igual a 25 anys
```

### 🟠 Actualitzar dades
```js
db.people.updateOne({ name: "Anna" }, { $set: { age: 28 } });
db.people.updateOne({ name: "Joan" }, { $push: { tags: "friendly" } });
```

### 🔴 Eliminar dades
```js
db.people.deleteOne({ name: "Joan" });
db.people.deleteMany({ age: { $lt: 20 } });
```

---

## 🧮 AGGREGATE — Nivell Mitjà

### Agrupar per camp i comptar
```js
db.books.aggregate([
  { $group: { _id: "$status", total: { $sum: 1 } } }
]);
```

### Projectar només algunes dades
```js
db.books.aggregate([
  { $project: { title: 1, numAuthors: { $size: "$authors" } } }
]);
```

### Separar arrays (`$unwind`)
```js
db.people.aggregate([
  { $unwind: "$friends" },
  { $project: { nomAmic: "$friends.name" } }
]);
```

### Match després d’un grup
```js
db.restaurants.aggregate([
  { $unwind: "$grades" },
  { $group: { _id: "$grades.score", count: { $sum: 1 } } },
  { $match: { count: { $gt: 60 } } }
]);
```

---

## 🔍 EXPRESSIONS REGULARS (REGEX) — Nivell Mitjà-Alt

### Apunts ràpids (`varis.pdf` + `Exemples1.pdf`):

| Expressió             | Significat                                  |
|-----------------------|---------------------------------------------|
| `/^A/`                | Comença per A                               |
| `/a$/`                | Acaba en "a"                                |
| `/.*abc.*/`           | Conté "abc"                                 |
| `/^.{10,}$/`          | Cadena amb 10 o més caràcters               |
| `/^[A-Za-z].*[A-Za-z]$/` | Comença i acaba amb lletra               |
| `/^622/`              | Comença amb "622" (ex: telèfon mòbil)       |

### Exemples pràctics:

```js
db.students.find({ email: /\.net$/ }); // correus .net

db.students.find({ nom: { $regex: "^[AEIOUaeiou]", $options: "i" } }); // comencen per vocal

db.students.find({ nom: /.*[aeiou].*[aeiou].*[aeiou].*/ }); // com a mínim 3 vocals
```

---

## 🧠 CONSELLS I FUNCIONS UTILS

### Llistat de bases de dades i col·leccions
```js
show dbs
use catalogo
show collections
```

### Iterar amb cursor
```js
var cursor = db.people.find();
while (cursor.hasNext()) printjson(cursor.next());
```

### Ordenar, limitar, pàgines
```js
db.products.find().sort({ price: -1 }).limit(5);
db.products.find().skip(5).limit(5); // pàgina 2
```

---

## ✨ Recomanat per practicar

1. Fes CRUD amb una col·lecció `products`
2. Prova `aggregate` per agrupar `tags` i comptar
3. Fes consultes amb regex: correus, telèfons, noms...
4. Modifica arrays amb `$addToSet`, `$pop`, `$pull`

---

## 🔗 Enllaços útils

- [Documentació oficial MongoDB CRUD](https://docs.mongodb.com/manual/crud/)
- [Operadors de consulta](https://www.mongodb.com/docs/manual/reference/operator/query/)
- [Agregacions](https://www.mongodb.com/docs/manual/aggregation/)

---

## 🧑‍🏫 Autor

**Martí Vilàs Ruano**  
Institut Tecnològic de Barcelona  
CFGS DAW Mòdul 2 · NF4 · MongoDB