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
RPC_URL=http://127.0.0.1:8545
PRIVATE_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
CONTRACT_ADDRESS=0x5FbDB2315678afecb367f032d93F642f64180aa3
JWT_SECRET=supersecretkey
MONGO_URI=mongodb+srv://@cluster0.ywpdctl.mongodb.net/?appName=Cluster0

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

## 7. Последовательность запуска

1. Hardhat node (`npx hardhat node`)
2. Деплой контракт (`npx hardhat ignition deploy ./ignition/modules/AuditTrailModule.js --network localhost`)
3. Backend (`node index.js`)
4. Flutter (`flutter run`)

Теперь весь проект работает локально, включая backend, blockchain и frontend.

---

## 8. Советы

* Используйте отдельные терминалы для Hardhat node, деплоя контракта и backend.
* Все действия пользователя логируются в локальном blockchain через контракт AuditTrail.
* MongoDB Atlas хранит все данные: Users, Profiles, Records, AccessControl, Appointments.
