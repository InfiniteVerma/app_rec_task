module.exports = (app) => {
  const equipment = require("../controllers/equipment.controller.js");

  // insert new equipment
  app.post("/equipment", equipment.insert);

  // retrieve all equipment
  app.get("/equipment", equipment.findAll);

  // retrieve single equipment
  app.get("/equipment/:EquipmentId", equipment.findOne);

  // delete equipment
  app.delete("/equipment/:EquipmentId", equipment.delete);
};
