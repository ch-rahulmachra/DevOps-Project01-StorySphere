# StorySphere - Full Project (Frontend + Backend)

This archive contains a minimal full-stack StorySphere app:
- server/ : Node.js + Express + Sequelize (MySQL)
- client/ : React app (React Router, Axios)

Quick start:

1. Backend
   - cd server
   - cp .env.example .env   (edit DB credentials and JWT_SECRET)
   - npm install
   - npm run dev

2. Frontend
   - cd client
   - npm install
   - npm start

Note: You must have MySQL running and provide DB credentials in server/.env
