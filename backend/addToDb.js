const Equipment = require("./models/equipment.model");
const { indiaStates, types } = require("./constdata");
const dbConfig = require("./config/database.config.js");
const mongoose = require("mongoose");

mongoose.Promise = global.Promise;

// Connecting to the database
mongoose
  .connect(dbConfig.url, {
    useNewUrlParser: true,
  })
  .then(() => {
    console.log("Successfully connected to the database");
  })
  .catch((err) => {
    console.log("Could not connect to the database. Exiting now...", err);
    process.exit();
  });


findAll = () => {
  Equipment.find()
    .then((Equipments) => {
      console.log(Equipments.length);
    })
    .catch((err) => {
      console.log("Some error occurred while retrieving Equipments.");
    });
};

insert = async (obj) => {
  const equipment = new Equipment(obj);

  // Save Equipment in the database
  equipment
    .save()
    .then((data) => {
      console.log("Inserted");
    })
    .catch((err) => {
      console.log("Some error occurred while creating the Equipment.");
    });
};

insertIntoDb = async (x, y) => {
  for (var i = 3; i < indiaStates.length; i++) {
    var obj = {};

    for (var j = 0; j < 2; j++) {
      obj = {
        title: "Title " + indiaStates[i].substr(3, 5),
        desc: "Desc" + indiaStates[i].substr(0, 5),
        date: "2020-01-20",
        phoneNumber: Math.floor(Math.random() * 10000000000),
        location: indiaStates[i],
        img: "uploads/dcw1.png",

        type: types[Math.floor(Math.random() * 4)],
      };
      console.log(obj)
      insert(obj);
    }
  }
};

insertIntoDb(3, 5);
