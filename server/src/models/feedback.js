import { DataTypes } from 'sequelize';
import { sequelize } from '../config/db.js';

export const Feedback = sequelize.define('Feedback', {
  email: { type: DataTypes.STRING },
  message: { type: DataTypes.TEXT, allowNull: false },
});
