# Pet-Hotel Deluxe — App Flutter + Node.js (SQLite)

## Descrição:
Aplicativo mobile para controle de hospedagem de pets (cadastrar, visualizar, editar, excluir). Frontend em Flutter; backend em Node.js + Express + Sequelize + SQLite.

## Pré-requisitos:
Flutter SDK\
Node.js (>=14) + npm

## Instalação (backend)
cd "C: ..\pets\backend"\
npm install\
*(opcional: remover BD antigo:\
 PowerShell/Linux/Mac: rm database.sqlite\
 CMD do Windows: del database.sqlite)*\
node server.js\
*servidor roda em http://localhost:3000*

## Instalação (frontend) (recomendo usar Android Studio para executar esse protótipo)
cd "C: ..\pets"\
flutter pub get\
*ajustar baseUrl em lib/main.dart:*\
*Android emulator -> http://10.0.2.2:3000*<br>
*iOS simulator -> http://localhost:3000*<br>
*Device físico (celular com depuração USB) -> use o IP da máquina (http://192.168.y.y:3000) ou adb reverse*\
flutter run

## Estrutura do Projeto:
### Front-End:
lib/\
|-models/\
|-providers/\
|-screens/\
|-services/\
|-utils/\
|-widgets/\
|-app_routes.dart\
|-main.dart\
|-theme.dart
  
### Back-End:
backend/\
|-models/\
|-node_modules/\
|-routes/\
|-db.js\
|-package.json\
|-package-lock.json\
|-server.js

## Demo do App:
<img src="./pets/assets/images/demo_hotelPets.gif" width="25%" height="25%"/>

## Observações:
Banco SQLite local: backend/database.sqlite. Usei sequelize.sync({ alter: true })\
(Para produção oficial acho mais robusto usar Postgres/MySQL)
