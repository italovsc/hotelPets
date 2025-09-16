
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const sequelize = require('./db');
const Pet = require('./models/Pet');
const petsRoutes = require('./routes/pets');

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use('/pets', petsRoutes);

const PORT = 3000;

(async () => {
  try {
    await sequelize.authenticate();
    console.log('Conexão com DB OK.');

    // Em dev: alterar esquema sem perder tudo. Se quiser recriar completamente use { force: true }
    await sequelize.sync({ alter: true });
    console.log('Sincronização concluída (tabelas atualizadas).');

    app.listen(PORT, () => {
      console.log(`Servidor rodando em http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error('Erro ao iniciar servidor / DB:', err);
    process.exit(1);
  }
})();
