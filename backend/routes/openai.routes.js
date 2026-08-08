const express = require('express');
const openAiService = require('../services/openai.service');

const router = express.Router();

router.post('/chat', async (req, res) => {
  const { message, history = [] } = req.body;
  const response = await openAiService.sendChatMessage({ message, history });

  res.json(response);
});

module.exports = router;
