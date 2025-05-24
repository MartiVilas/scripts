//EA5
db.movieDetails.findOne(
  { title: "The Hobbit: An Unexpected Journey" },
  { title: 1, synopsis: 1, _id: 0 }
)


db.movieDetails.updateOne(
  { title: "The Hobbit: An Unexpected Journey" },
  { $set: { synopsis: "A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug." } }
)

db.movieDetails.findOne(
  { title: "The Hobbit: An Unexpected Journey" },
  { title: 1, synopsis: 1, _id: 0 }
)


// 2
db.movieDetails.find(
  { title: "Pulp Fiction" },
  { title: 1, actors: 1, _id: 0 }
)

db.movieDetails.updateOne(
  { title: "Pulp Fiction" },
  { $push: { actors: "Samuel L. Jackson" } }
)

db.movieDetails.find(
  { title: "Pulp Fiction" },
  { title: 1, actors: 1, _id: 0 }
)

//Ex3
db.movieDetails.updateMany({}, {$unset : {type: 1}})


//Ex4

db.movieDetails.find({
title: "The World Is Not Enough"
})

db.movieDetails.updateOne(
  { title: "The World Is Not Enough" },
  { $set: { "writers.4": "Bruce Harris" }
})


//Ex5

db.movieDetails.find({
title: "Whisper of the Heart"
})

db.movieDetails.updateOne(
{title: "Whisper of the Heart"},
{$pop: {genres: 1}})