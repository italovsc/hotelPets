// backend/models/Pet.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const Pet = sequelize.define('Pet', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4, // gera UUID se não enviado
    primaryKey: true,
  },
  nomeTutor: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  contatoTutor: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  especie: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  raca: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  dataEntrada: {
    type: DataTypes.DATEONLY,
    allowNull: false,
  },
  dataSaidaPrevista: {
    type: DataTypes.DATEONLY,
    allowNull: true,
  },
});

module.exports = Pet;
