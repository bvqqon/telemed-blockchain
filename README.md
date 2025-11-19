# TeleMed Backend + Blockchain

Этот проект — backend для телемедицинской платформы TeleMed с blockchain аудитом. Он включает:

* Node.js + Express API
* MongoDB Atlas для хранения пользователей, профилей, медицинских записей, назначений и контроля доступа
* Hardhat локальный blockchain для хранения audit log
* JWT авторизация и роль-based access control

---

## 1. Предварительные условия

* Node.js v18+
* npm
* Git
* MongoDB Atlas (создать базу и получить URI)
* Hardhat (`npm install --save-dev hardhat`)
* Flutter (для фронтенда, не обязательно для backend)

---

## 2. Клонирование проекта

```bash
git clone https://github.com/bvqqon/telemed-backend.git
cd telemed-backend-blockchain
```

---

## 3. Установка зависимостей

```bash
npm install
```

---

## 4. Настройка `.env`

Создай файл `.env` в корне проекта с содержимым:

```
MONGO_URI=<MongoDB Atlas URI>
PRIVATE_KEY=<любой приватный ключ для Hardhat local>
RPC_URL=http://127.0.0.1:8545
CONTRACT_ADDRESS=
JWT_SECRET=supersecretkey
PORT=3000
```

> CONTRACT_ADDRESS можно оставить пустым, Hardhat сгенерирует новый адрес при деплое.

---

## 5. Запуск локального blockchain через Hardhat

1.1 Установка Hardhat (если ещё не установлен)

В корне проекта установите Hardhat как dev-зависимость:

```bash
npm install --save-dev hardhat
```

1. Запусти локальную сеть Hardhat:

```bash
npx hardhat node
```

* Это создаст локальные аккаунты с тестовыми ETH и откроет RPC на `http://127.0.0.1:8545`.

2. В другой терминальной вкладке деплой контракта:

```bash
npx hardhat run scripts/deploy.js --network localhost
```

* После деплоя скопируй адрес контракта и вставь его в `.env`:

```
CONTRACT_ADDRESS=<адрес контракта>
```

---

## 6. Запуск backend

```bash
node index.js
```

* Сервер запущен на `http://localhost:3000`
* Swagger UI доступен на `http://localhost:3000/docs`

---

## 7. Тестирование API

Примеры curl:

* Регистрация пользователя:

```bash
curl -X POST http://localhost:3000/auth/register \
-H "Content-Type: application/json" \
-d '{"email":"doctor1@example.com","password":"123456","role":"doctor"}'
```

* Логин:

```bash
curl -X POST http://localhost:3000/auth/login \
-H "Content-Type: application/json" \
-d '{"email":"doctor1@example.com","password":"123456"}'
```

* Создание медицинской записи (JWT в Authorization):

```bash
curl -X POST http://localhost:3000/records \
-H "Authorization: Bearer <JWT_TOKEN>" \
-H "Content-Type: application/json" \
-d '{"patientId":"<id>", "diagnosis":"Flu", "notes":"Take rest"}'
```

---

## 8. Настройка Flutter

1. Клонируй Flutter проект.
2. В коде Flutter установи `baseURL` на локальный backend:

```dart
const String baseURL = "http://localhost:3000";
```

3. Запусти Flutter:

```bash
flutter pub get
flutter run
```

---

## 9. Последовательность запуска

1. Hardhat node (`npx hardhat node`)
2. Деплой контракт (`npx hardhat run scripts/deploy.js --network localhost`)
3. Backend (`node index.js`)
4. Flutter (`flutter run`)

Теперь весь проект работает локально, включая backend, blockchain и frontend.

---

## 10. Советы

* Используйте отдельные терминалы для Hardhat node, деплоя контракта и backend.
* Все действия пользователя логируются в локальном blockchain через контракт AuditTrail.
* MongoDB Atlas хранит все данные: Users, Profiles, Records, AccessControl, Appointments.
