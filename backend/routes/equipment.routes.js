const multer = require("multer");

// setup multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  },
});

const upload =  multer({storage: storage}).single('img');

module.exports = (app) => {
  const equipment = require("../controllers/equipment.controller.js");

  // insert new equipment
  app.post("/equipment", upload, equipment.insert);

  // retrieve all equipment
  app.get("/equipment", equipment.findAll);

  // retrieve single equipment
  app.get("/equipment/:EquipmentId", equipment.findOne);

  // delete equipment
  app.delete("/equipment/:EquipmentId", equipment.delete);
};
