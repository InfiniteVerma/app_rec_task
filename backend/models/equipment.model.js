const mongoose = require("mongoose");

const EquipmentSchema = new mongoose.Schema(
  {
    title: String,
    desc: String,
    date: Date,
    phoneNumber: Number,
    location: {
      type: String,
      enum: [
        "Andaman and Nicobar Islands",
        "Andhra Pradesh",
        "Arunachal Pradesh",
        "Assam",
        "Bihar",
        "Chandigarh",
        "Chhattisgarh",
        "Dadra and Nagar Haveli",
        "Daman and Diu",
        "Delhi",
        "Goa",
        "Gujarat",
        "Haryana",
        "Himachal Pradesh",
        "Jammu and Kashmir",
        "Jharkhand",
        "Karnataka",
        "Kerala",
        "Lakshadweep",
        "Madhya Pradesh",
        "Maharashtra",
        "Manipur",
        "Meghalaya",
        "Mizoram",
        "Nagaland",
        "Orissa",
        "Pondicherry",
        "Punjab",
        "Rajasthan",
        "Sikkim",
        "Tamil Nadu",
        "Telangana",
        "Tripura",
        "Uttaranchal",
        "Uttar Pradesh",
        "West Bengal",
      ],
    },
    type: {
      type: String,
      enum: ["Cylinder", "Medicine", "Food Service", "Delivery Service"],
    },
    img: String,
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Equipment", EquipmentSchema);
