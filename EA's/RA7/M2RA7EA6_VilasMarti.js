//EX1
db.movieDetails.find({title: "Star Trek"})
db.movieDetails.deleteOne({title: "Star Trek"})

//EX2
db.movieDetails.find({title: "Love Actually"})
db.movieDetails.deleteOne({title: "Love Actually"})

//Ex3
db.movieDetails.find({rated: "G"})
db.movieDetails.deleteMany({rated: "G"})

//Ex4
db.movieDetails.find({genres: "Western"})
db.movieDetails.deleteMany({genres: "Western"})

//Ex5
db.movieDetails.find({"awards.wins" : 0})
db.movieDetails.deleteMany({
  $or: [
    {"awards.wins": 0},
    {"awards.wins": { $exists: false }}
  ]
})