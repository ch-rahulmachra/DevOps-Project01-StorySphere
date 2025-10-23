import { DataTypes } from 'sequelize';
import { sequelize } from '../config/db.js';
import { User } from './user.js';

export const Story = sequelize.define('Story', {
  title: { type: DataTypes.STRING, allowNull: false },
  content: { type: DataTypes.TEXT, allowNull: false },
});

User.hasMany(Story, { onDelete: 'CASCADE' });
Story.belongsTo(User);
