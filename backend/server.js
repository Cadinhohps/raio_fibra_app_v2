const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
const express = require('express');

const openAiRoutes = require('./routes/openai.routes');
const sgpRoutes = require('./routes/sgp.routes');
const mercadoPagoRoutes = require('./routes/mercado_pago.routes');

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    app: 'Raio Fibra Telecom API',
  });
});

app.use('/openai', openAiRoutes);
app.use('/sgp', sgpRoutes);
app.use('/mercado-pago', mercadoPagoRoutes);

app.listen(port, () => {
  console.log(`Raio Fibra Telecom API rodando na porta ${port}`);
});
