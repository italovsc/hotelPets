// backend/routes/pets.js
const express = require('express');
const router = express.Router();
const Pet = require('../models/Pet');

// CREATE
router.post('/', async (req, res) => {
  try {
    console.log('POST /pets recebido -> body:', req.body); // <--- log do request body
    const pet = await Pet.create(req.body);
    console.log('Pet criado:', pet.toJSON()); // <--- log do pet criado
    res.status(201).json(pet);
  } catch (err) {
    console.error('POST /pets error:', err); // log de erro
    res.status(400).json({ error: err.message });
  }
});

// READ ALL
router.get('/', async (req, res) => {
  try {
    const pets = await Pet.findAll();
    console.log('GET /pets -> retornando', pets.length, 'itens'); // <--- log do resultado
    res.json(pets);
  } catch (err) {
    console.error('GET /pets error:', err); // log de erro
    res.status(500).json({ error: err.message });
  }
});

// READ ONE
router.get('/:id', async (req, res) => {
  try {
    console.log(`GET /pets/${req.params.id} recebido`); // log da requisição
    const pet = await Pet.findByPk(req.params.id);
    if (pet) {
      console.log('GET /pets/:id -> encontrado:', pet.toJSON());
      res.json(pet);
    } else {
      console.log('GET /pets/:id -> não encontrado:', req.params.id);
      res.status(404).json({ error: 'Pet não encontrado' });
    }
  } catch (err) {
    console.error('GET /pets/:id error:', err);
    res.status(500).json({ error: err.message });
  }
});

// UPDATE
router.put('/:id', async (req, res) => {
  try {
    console.log(`PUT /pets/${req.params.id} -> body:`, req.body);
    const pet = await Pet.findByPk(req.params.id);
    if (!pet) {
      console.log('PUT /pets/:id -> não encontrado:', req.params.id);
      return res.status(404).json({ error: 'Pet não encontrado' });
    }
    await pet.update(req.body);
    console.log('PUT /pets/:id -> atualizado:', pet.toJSON());
    res.json(pet);
  } catch (err) {
    console.error('PUT /pets/:id error:', err);
    res.status(400).json({ error: err.message });
  }
});

// DELETE
router.delete('/:id', async (req, res) => {
  try {
    console.log(`DELETE /pets/${req.params.id} recebido`);
    const pet = await Pet.findByPk(req.params.id);
    if (!pet) {
      console.log('DELETE /pets/:id -> não encontrado:', req.params.id);
      return res.status(404).json({ error: 'Pet não encontrado' });
    }
    await pet.destroy();
    console.log('DELETE /pets/:id -> removido:', req.params.id);
    res.status(200).json({ message: 'Pet removido' });
  } catch (err) {
    console.error('DELETE /pets/:id error:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
