import express from 'express';
import { Story } from '../models/story.js';
import { User } from '../models/user.js';
import { verifyToken } from '../middleware/auth.js';
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const stories = await Story.findAll({ include: User, order: [['createdAt', 'DESC']] });
    res.json(stories);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch stories' });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const story = await Story.findByPk(req.params.id, { include: User });
    if(!story) return res.status(404).json({ error: 'Not found' });
    res.json(story);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch story' });
  }
});

router.post('/', verifyToken, async (req, res) => {
  try {
    const { title, content } = req.body;
    if(!title || !content) return res.status(400).json({ error: 'Missing title/content' });
    const story = await Story.create({ title, content, UserId: req.user.id });
    res.json(story);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create story' });
  }
});

router.put('/:id', verifyToken, async (req, res) => {
  try {
    const story = await Story.findByPk(req.params.id);
    if(!story) return res.status(404).json({ error: 'Not found' });
    if(story.UserId !== req.user.id) return res.status(403).json({ error: 'Not allowed' });
    story.title = req.body.title || story.title;
    story.content = req.body.content || story.content;
    await story.save();
    res.json(story);
  } catch (err) {
    res.status(500).json({ error: 'Failed to update' });
  }
});

router.delete('/:id', verifyToken, async (req, res) => {
  try {
    const story = await Story.findByPk(req.params.id);
    if(!story) return res.status(404).json({ error: 'Not found' });
    if(story.UserId !== req.user.id) return res.status(403).json({ error: 'Not allowed' });
    await story.destroy();
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to delete' });
  }
});

export default router;
