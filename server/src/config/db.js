import { Sequelize } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASS,
  {
    host: process.env.DB_HOST || "mysql",
    dialect: 'mysql',
    port: process.env.DB_PORT || 3306,
    logging: false,
  }
);

async function connectWithRetry(retries = 10, delay = 2000) {
  for (let i = 0; i < retries; i++) {
    try {
      await sequelize.authenticate();
      console.log('✅ Connected to MySQL successfully');
      return;
    } catch (err) {
      console.log(`❌ Unable to connect. Retrying in ${delay / 1000}s...`);
      await new Promise(res => setTimeout(res, delay));
    }
  }
  console.error('❌ Could not connect to MySQL after multiple attempts.');
}

await connectWithRetry();


export { sequelize };