import express from 'express';
import { Feedback } from '../models/feedback.js';
const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { email, message } = req.body;
    if(!message) return res.status(400).json({ error: 'Message required' });
    await Feedback.create({ email, message });
    res.json({ message: 'Thanks for your feedback!' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to submit feedback' });
  }
});

export default router;
