# Raio Fibra Telecom - AI Agent Codex

**Project:** Flutter + Node.js telecom self-service app MVP  
**Language:** Portuguese (UI/comments/variables)  
**Status:** MVP with simulated APIs, ready for production integration

---

## Quick Start for Agents

### 1. Setup Development Environment

```bash
# Terminal 1: Start backend API
cd backend
npm install
npm run dev
# Verify: curl http://localhost:3000/health
```

```bash
# Terminal 2: Run Flutter
flutter pub get
flutter run -d chrome        # Web browser
# OR: flutter run           # Android emulator/device
```

**Key URLs:**
- Flutter Web: `http://localhost:5000` (after `flutter run -d chrome`)
- Backend API: `http://localhost:3000`
- API base URL configured in: [lib/core/api_config.dart](lib/core/api_config.dart)

### 2. Understanding the Architecture

**Three-layer pattern:**

```
Flutter Frontend (lib/) 
  ↓ HTTP requests (services/)
Node.js Backend (backend/)
  ↓ Routes + Services
Mock APIs (simulated, ready to replace)
  ↓ (Future) Real APIs: OpenAI, SGP, Mercado Pago
```

**Frontend structure** ([lib/](lib/)):
- `screens/` - 13 UI pages (Home, Faturas, Suporte, RaioIA, Perfil, etc.)
- `services/` - HTTP layer with fallback mock responses
- `models/` - Typed data models (ClienteModel, FaturaModel, etc.)
- `widgets/` - Reusable UI components
- `theme/` - Material 3, brand orange colors

**Backend structure** ([backend/](backend/)):
- `server.js` - Express app with CORS, routes mounted
- `routes/` - Endpoint definitions for OpenAI, SGP, Mercado Pago
- `services/` - Business logic, mock responses, keyword matching for AI

---

## API Endpoints Reference

| Endpoint | Method | Frontend Caller | Status |
|----------|--------|-----------------|--------|
| `GET /health` | GET | Startup check | ✅ Simulated |
| `POST /openai/chat` | POST | RaioIA screen | 🔄 Keywords → pre-written replies |
| `POST /sgp/cliente` | POST | Home, Perfil | 🔄 CPF → Client info |
| `POST /sgp/faturas` | POST | Faturas screen | 🔄 Client ID → Invoice list |
| `POST /sgp/chamados` | POST | Suporte screen | 🔄 Create ticket |
| `POST /mercado-pago/criar-pagamento` | POST | Faturas (pay button) | 🔄 PIX/checkout URL |
| `GET /mercado-pago/status/:paymentId` | GET | Payment confirmation | 🔄 Status polling |

**All responses currently use mock data.** Routes/services structure remains the same when integrating real APIs.

---

## Key Architectural Patterns

### Pattern 1: Service-Based Architecture with Fallback

Every Dart service follows this pattern:

```dart
// File: lib/services/sgp_service.dart
Future<ClienteModel> buscarClientePorCpf(String cpf) async {
  try {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/sgp/cliente'),
      body: jsonEncode({'cpf': cpf}),
    ).timeout(Duration(seconds: 4));  // ← 4s timeout
    
    if (response.statusCode == 200) {
      return ClienteModel.fromJson(jsonDecode(response.body));
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
  // ← On timeout/error, return mock data
  return _respostaLocal();
}

ClienteModel _respostaLocal() {
  return ClienteModel(
    id: 'CLI001',
    nome: 'Ricardo',
    cpf: '00000000000',
    plano: 'Fibra 500Mbps',
    statusContrato: 'Ativo',
    statusConexao: 'Conectada',
  );
}
```

**Key principle:** App never crashes. Network failures → mock fallback → user sees content.

### Pattern 2: Model Factory Constructors

All data models implement `fromJson()` + `toJson()`:

```dart
class ClienteModel {
  final String id, nome, cpf, plano, statusContrato, statusConexao;
  
  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'],
      nome: json['nome'],
      // ...
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      // ...
    };
  }
}
```

**Use this pattern for all new models.**

### Pattern 3: Responsive Layout with ConstrainedBox

All screens adapt to web/tablet/mobile:

```dart
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 980),
      child: Column(...),  // Content here
    ),
  );
}
```

This keeps web layout readable (max 980px width) while mobile stretches full screen.

### Pattern 4: Currency Formatting

Brazilian Real format with comma as decimal separator:

```dart
String formatCurrency(double value) {
  return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
}
// Output: "R$ 99,90" instead of "R$ 99.90"
```

---

## Convention Reference

| Aspect | Convention | Example |
|--------|-----------|---------|
| **Naming** | camelCase variables/methods | `buscarClientePorCpf()`, `statusContrato` |
| **Private Dart members** | Leading underscore | `_timeout`, `_respostaLocal()` |
| **async/await** | Used for all HTTP calls | `await http.post(...)` |
| **Error handling** | Try/catch with fallback, never rethrow | See Pattern 1 above |
| **Timeouts** | 4-6 seconds (all services consistent) | `.timeout(Duration(seconds: 4))` |
| **Language** | Portuguese throughout | Variable names, UI strings, comments |
| **Color scheme** | Material 3, brand orange (#FF8C00) | See [lib/theme/app_theme.dart](lib/theme/app_theme.dart) |
| **Button style** | ElevatedButton with orange background | Consistent across app |

---

## Common Development Tasks

### Task 1: Add a New Backend Endpoint

1. **Create route** in [backend/routes/](backend/routes/) (e.g., `backend/routes/new.routes.js`)
2. **Implement service** in [backend/services/](backend/services/) with mock response
3. **Mount route** in [backend/server.js](backend/server.js)
4. **Create Dart service** in [lib/services/](lib/services/) with pattern from Pattern 1
5. **Call from screen** using the service class

**Example:** Adding `/sgp/chamados` endpoint
```javascript
// backend/routes/sgp.routes.js
router.post('/chamados', async (req, res) => {
  const { clienteId, categoria, descricao, prioridade } = req.body;
  const response = await sgpService.criarChamado({ clienteId, ... });
  res.json(response);
});

// backend/services/sgp.service.js
exports.criarChamado = async (data) => {
  return {
    protocolo: 'TCK000123',
    status: 'Aberto',
    sla: '4 horas',
    criadoEm: new Date().toISOString(),
  };
};
```

### Task 2: Add a New Dart Service

1. Create [lib/services/new_service.dart](lib/services/)
2. Implement using Pattern 1 (try/catch + mock fallback)
3. Define a Model class in [lib/models/](lib/models/)
4. Call from screen with `await newService.method()`

**Example:**
```dart
// lib/services/example_service.dart
import 'package:http/http.dart' as http;
import 'package:raio_fibra_app_v2/models/example_model.dart';

class ExampleService {
  final Duration _timeout = const Duration(seconds: 4);

  Future<ExampleModel> fetchData(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/example/$id'),
      ).timeout(_timeout);

      if (response.statusCode == 200) {
        return ExampleModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint('ExampleService error: $e');
    }
    return _mockResponse();
  }

  ExampleModel _mockResponse() {
    return ExampleModel(...);
  }
}
```

### Task 3: Swap Mock Data with Real API

1. Locate mock response in service file (e.g., `_respostaLocal()`)
2. Keep the same Dart/JS interface (don't change method signatures)
3. Replace `return _mockData()` with actual HTTP call to real API
4. Add real credentials to `.env` (backend)
5. Verify response structure matches existing model

**Example:** Connecting real Mercado Pago
```javascript
// Before: Mock response
const paymentId = 'MP_' + Date.now();
return { paymentId, status: 'pending', pixCopiaCola: '...' };

// After: Real API call
const mpResponse = await axios.post('https://api.mercadopago.com/v1/payments', {
  amount: valor,
  payer: { email: clienteEmail },
  // ...
}, { headers: { 'Authorization': `Bearer ${process.env.MERCADO_PAGO_ACCESS_TOKEN}` }});
return { paymentId: mpResponse.data.id, status: mpResponse.data.status, ... };
```

### Task 4: Add New Screen

1. Create screen file in [lib/screens/](lib/screens/) (e.g., `new_screen.dart`)
2. Use StatefulWidget with responsive ConstrainedBox pattern
3. Call services in `initState()` or button callbacks
4. Add route in [lib/main.dart](lib/main.dart) navigation
5. Add BottomNavigationBar entry if it's a main tab

**Tip:** Copy existing screen like [lib/screens/faturas_screen.dart](lib/screens/faturas_screen.dart) as template.

---

## Troubleshooting for Agents

| Problem | Cause | Solution |
|---------|-------|----------|
| "Connection refused" on startup | Backend not running | `cd backend && npm run dev` |
| Service returns mock data consistently | HTTP timeout or backend down | Check backend logs, verify API base URL |
| App crashes with "No Material widget found" | Missing MaterialApp | Check [lib/main.dart](lib/main.dart) structure |
| ConstrainedBox not limiting width on web | Flutter web default | Ensure ConstrainedBox wraps content |
| Currency shows as "99.90" instead of "99,90" | String formatting missing | Use `replaceAll('.', ',')` after `toStringAsFixed(2)` |
| Hardcoded CPF `00000000000` always used | Authentication not implemented | CPF from input currently ignored in mock mode |

---

## File Location Quick Reference

```
c:\raio_fibra_app_v2\
├── lib/                          # Flutter app
│   ├── main.dart                 # Entry point, navigation
│   ├── core/api_config.dart      # API base URL
│   ├── screens/                  # 13 UI pages
│   ├── services/                 # HTTP + mock fallback
│   ├── models/                   # Data classes
│   ├── widgets/                  # UI components
│   ├── theme/app_theme.dart      # Colors, Material 3 config
│   └── controllers/              # Empty (no state mgmt yet)
├── backend/                      # Node.js Express API
│   ├── server.js                 # App server, route mounting
│   ├── routes/                   # Endpoint definitions
│   ├── services/                 # Business logic
│   ├── .env.example              # Environment template
│   └── package.json              # Dependencies
├── pubspec.yaml                  # Flutter dependencies
├── README.md                      # Project overview
└── AGENTS.md                      # This file
```

---

## Testing Checklist (Manual)

Run this before committing:

- [ ] Backend running: `curl http://localhost:3000/health` returns status OK
- [ ] Frontend loads: `flutter run -d chrome` starts without errors
- [ ] Client data loads: Home screen shows "Ricardo" (CPF 00000000000)
- [ ] Faturas page: Shows 3 mock invoices with correct R$ formatting
- [ ] Offline mode: Stop backend, faturas still show with mock data
- [ ] Responsive: Resize browser, content stays readable (ConstrainedBox max 980px)
- [ ] AI chat works: Type "sem internet" in Raio IA, gets pre-written response
- [ ] No crashes: Try all navigation tabs without app crashing

---

## Integration Roadmap (For Production)

1. **Authentication**: Add user login, store JWT, replace hardcoded CPF
2. **Real APIs**: Swap mock responses → actual SGP, OpenAI, Mercado Pago calls
3. **Environment Config**: Create `.env` with real credentials
4. **State Management**: Add Provider/Riverpod to scale beyond current `setState()` MVP
5. **Error Handling**: User-facing error messages for real API failures
6. **CI/CD**: Automate builds, tests, deployment
7. **Security**: Validate payment signatures, CPF validation, SSL certificates

See [README.md](README.md) for more details.

---

## Notes for Agents

- **No authentication yet**: Currently hardcoded to CPF `00000000000` (test user: Ricardo)
- **No real credentials**: `.env` variables exist but empty; ready for production integration
- **No state management**: MVP uses `setState()` only; consider Provider/Riverpod for scaling
- **No automated tests**: Manual testing only; add unit/widget tests before production
- **All APIs simulated**: Routes/service interfaces won't change when integrating real APIs
- **Responsive by design**: App works on mobile, tablet, web via ConstrainedBox pattern
- **Portuguese-first**: All variable names, UI strings, and comments are in Portuguese

---

**Last updated:** August 2026  
**Maintainer:** Raio Fibra Telecom team
