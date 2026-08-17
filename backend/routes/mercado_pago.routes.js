const express = require('express');

const router = express.Router();

router.post('/pix', async (req, res) => {
  return res.json({
    id: 'teste_pix_001',
    status: 'pending',
    qr_code: '00020126360014BR.GOV.BCB.PIX0114teste@pix.com520400005303986540599.905802BR5925RAIO FIBRA TELECOM6009SAO PAULO62070503***6304ABCD',
    qr_code_base64: '',
    ticket_url: '',
  });
});

router.get('/pagamento/:id', async (req, res) => {
  return res.json({
    id: req.params.id,
    status: 'pending',
    status_detail: 'pending_waiting_payment',
  });
});

module.exports = router;