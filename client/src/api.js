import axios from 'axios';
export const api = axios.create({ baseURL: process.env.REACT_APP_SERVER_URL });
// 'http://localhost:80/api'
export const authHeader = () => {
  const t = localStorage.getItem('token');
  return t ? { Authorization: `Bearer ${t}` } : {};
};
