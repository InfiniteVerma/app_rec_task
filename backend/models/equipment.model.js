const mongoose = require("mongoose");

const EquipmentSchema = mongoose.Schema(
  {
    title: String,
    desc: String,
    date: Date,
    phoneNumber: Number,
    location: String,
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Equipment", EquipmentSchema);
