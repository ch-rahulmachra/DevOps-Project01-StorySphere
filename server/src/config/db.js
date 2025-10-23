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

try {
  await sequelize.authenticate();
  console.log('✅ Connected to MySQL successfully');
} catch (error) {
  console.error('❌ Unable to connect to the database:', error);
}

export { sequelize };