// backend/db.js
const { Sequelize } = require('sequelize');

// arquivo SQLite local
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: './database.sqlite',
  logging: false,
});

module.exports = sequelize;
