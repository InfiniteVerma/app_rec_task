const Equipment = require("../models/equipment.model");

exports.insert = (req, res) => {
  console.log(req.body);

  // Validate request
  // TODO
  // if (!req.body.title) {
  //   return res.status(400).send({
  //     message: "Equipment content can not be empty",
  //   });
  // }

  // Create a Equipment
  const equipment = new Equipment({
    title: req.body.title,
    desc: req.body.desc,
    date: req.body.date,
    phoneNumber: req.body.phoneNumber,
    location: req.body.location,
  });

  // Save Equipment in the database
  equipment.save()
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Equipment.",
      });
    });
};

exports.findAll = (req, res) => {

  Equipment.find()
    .then((Equipments) => {
      res.send(Equipments);
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving Equipments.",
      });
    });
};

exports.findOne = (req, res) => {
  Equipment.findById(req.params.EquipmentId)
    .then((Equipment) => {
      if (!Equipment) {
        return res.status(404).send({
          message: "Equipment not found with id " + req.params.EquipmentId,
        });
      }
      res.send(Equipment);
    })
    .catch((err) => {
      if (err.kind === "ObjectId") {
        return res.status(404).send({
          message: "Equipment not found with id " + req.params.EquipmentId,
        });
      }
      return res.status(500).send({
        message: "Error retrieving Equipment with id " + req.params.EquipmentId,
      });
    });
};

exports.delete = (req, res) => {
  Equipment.findByIdAndRemove(req.params.EquipmentId)
    .then((Equipment) => {
      if (!Equipment) {
        return res.status(404).send({
          message: "Equipment not found with id " + req.params.EquipmentId,
        });
      }
      res.send({ message: "Equipment deleted successfully!" });
    })
    .catch((err) => {
      if (err.kind === "ObjectId" || err.name === "NotFound") {
        return res.status(404).send({
          message: "Equipment not found with id " + req.params.EquipmentId,
        });
      }
      return res.status(500).send({
        message: "Could not delete Equipment with id " + req.params.EquipmentId,
      });
    });
};
