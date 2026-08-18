const express = require('express');
const axios = require('axios');
const FormData = require('form-data');

const router = express.Router();

const SGP_BASE_URL = 'https://demo.sgp.net.br';
const SGP_CPF_CNPJ = '68.857.751/0001-62';
const SGP_SENHA = 'centraldoassinante';

async function buscarContratosSgp() {
  const form = new FormData();

  form.append('cpfcnpj', SGP_CPF_CNPJ);
  form.append('senha', SGP_SENHA);

  const response = await axios.post(
    `${SGP_BASE_URL}/api/central/contratos`,
    form,
    {
      headers: form.getHeaders(),
      timeout: 10000,
    },
  );

  return response.data;
}

async function buscarFaturasSgp(contrato) {
  const form = new FormData();

  form.append('cpfcnpj', SGP_CPF_CNPJ);
  form.append('senha', SGP_SENHA);
  form.append('contrato', String(contrato));

  const response = await axios.post(
    `${SGP_BASE_URL}/api/central/fatura2via/`,
    form,
    {
      headers: form.getHeaders(),
      timeout: 10000,
    },
  );

  return response.data;
}

router.get('/cliente/:cpf', async (req, res) => {
  try {
    const dados = await buscarContratosSgp();

    if (!dados.auth || !Array.isArray(dados.contratos)) {
      return res.status(404).json({
        erro: 'Cliente não encontrado no SGP Demo',
        resposta: dados,
      });
    }

    const contrato = dados.contratos[0];

    return res.json({
      id: `CLI-${contrato.contrato}`,
      nome: contrato.razaosocial || 'Cliente SGP Demo',
      cpf: contrato.cpfcnpj,
      contrato: contrato.contrato,
      plano: contrato.planointernet || 'Plano não informado',
      valorPlano: contrato.planointernet_valor,
      status: String(contrato.status || '').trim(),
      statusConexao: String(contrato.status || '').trim() === 'Ativo'
        ? 'Online'
        : 'Bloqueado',
      vencimento: contrato.vencimento,
      endereco: contrato.endereco_instalacao,
      contratos: dados.contratos,
    });
  } catch (error) {
    console.error('Erro ao buscar cliente no SGP Demo:', error.message);

    return res.status(500).json({
      erro: 'Erro ao buscar cliente no SGP Demo',
      detalhe: error.message,
    });
  }
});

router.get('/faturas/:clienteId', async (req, res) => {
  try {
    const dados = await buscarContratosSgp();

    if (!dados.auth || !Array.isArray(dados.contratos)) {
      return res.status(404).json({
        erro: 'Contratos não encontrados no SGP Demo',
        resposta: dados,
      });
    }

    const contrato = dados.contratos[0];
    const faturasSgp = await buscarFaturasSgp(contrato.contrato);

    const listaBase = Array.isArray(faturasSgp)
      ? faturasSgp
      : Array.isArray(faturasSgp.faturas)
        ? faturasSgp.faturas
        : Array.isArray(faturasSgp.titulos)
          ? faturasSgp.titulos
          : [];

    if (listaBase.length === 0) {
      return res.json([
        {
          id: `FAT-${contrato.contrato}`,
          clienteId: req.params.clienteId,
          contrato: contrato.contrato,
          competencia: 'Fatura SGP Demo',
          valor: `R$ ${Number(contrato.planointernet_valor || 0)
            .toFixed(2)
            .replace('.', ',')}`,
          vencimento: `Dia ${contrato.vencimento}`,
          status: String(contrato.status || '').trim() === 'Suspenso'
            ? 'Pendente'
            : 'Em aberto',
          estaPago: false,
          sgpOriginal: faturasSgp,
        },
      ]);
    }

    const faturas = listaBase.map((fatura, index) => {
      const valor =
        fatura.valor ||
        fatura.valor_total ||
        fatura.valorpago ||
        contrato.planointernet_valor ||
        0;

      const status =
        fatura.status ||
        fatura.situacao ||
        fatura.status_fatura ||
        'Em aberto';

      return {
        id: fatura.id || fatura.titulo || fatura.numero || `FAT-${index + 1}`,
        clienteId: req.params.clienteId,
        contrato: contrato.contrato,
        competencia:
          fatura.competencia ||
          fatura.demonstrativo ||
          fatura.referencia ||
          `Fatura ${index + 1}`,
        valor:
          typeof valor === 'number'
            ? `R$ ${valor.toFixed(2).replace('.', ',')}`
            : String(valor),
        vencimento:
          fatura.vencimento ||
          fatura.data_vencimento ||
          fatura.datavencimento ||
          `Dia ${contrato.vencimento}`,
        status,
        estaPago: String(status).toLowerCase().includes('pago'),
        link:
          fatura.link ||
          fatura.link_fatura ||
          fatura.url ||
          fatura.pdf ||
          null,
        linhaDigitavel:
          fatura.linhadigitavel ||
          fatura.linha_digitavel ||
          fatura.codigo_barras ||
          null,
        sgpOriginal: fatura,
      };
    });

    return res.json(faturas);
  } catch (error) {
    console.error('Erro ao buscar faturas no SGP Demo:', error.message);

    return res.status(500).json({
      erro: 'Erro ao buscar faturas no SGP Demo',
      detalhe: error.message,
    });
  }
});

router.get('/status/:clienteId', async (req, res) => {
  try {
    const dados = await buscarContratosSgp();

    if (!dados.auth || !Array.isArray(dados.contratos)) {
      return res.status(404).json({
        erro: 'Cliente não encontrado no SGP Demo',
        resposta: dados,
      });
    }

    const contrato = dados.contratos[0];
    const status = String(contrato.status || '').trim();

    return res.json({
      clienteId: req.params.clienteId,
      status,
      statusConexao: status === 'Ativo' ? 'Online' : 'Bloqueado',
      plano: contrato.planointernet,
      contrato: contrato.contrato,
    });
  } catch (error) {
    console.error('Erro ao buscar status no SGP Demo:', error.message);

    return res.status(500).json({
      erro: 'Erro ao buscar status no SGP Demo',
      detalhe: error.message,
    });
  }
});

router.post('/chamados', (req, res) => {
  const {
    clienteId = 'CLI-308',
    categoria = 'Suporte técnico',
    descricao = '',
    prioridade = 'Normal',
  } = req.body || {};

  return res.json({
    protocolo: `SGP-DEMO-${Date.now()}`,
    clienteId,
    categoria,
    descricao,
    prioridade,
    status: 'Aberto',
    sla: prioridade === 'Alta' ? 'até 2h úteis' : 'até 4h úteis',
    criadoEm: new Date().toISOString(),
    origem: 'SGP Demo simulado',
  });
});

module.exports = router;