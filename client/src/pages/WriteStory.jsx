import { useState } from 'react';
import { api, authHeader } from '../api';
import { useNavigate } from 'react-router-dom';

export default function WriteStory(){
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const nav = useNavigate();

  const submit = async () => {
    try {
      await api.post('/stories', { title, content }, { headers: authHeader() });
      alert('Published!');
      nav('/');
    } catch (err) {
      alert('Failed to publish. Are you logged in?');
    }
  };

  return (
    <div className="container">
      <h1>Write a Story</h1>
      <input type="text" placeholder="Title" value={title} onChange={e => setTitle(e.target.value)} />
      <textarea placeholder="Your story..." value={content} onChange={e => setContent(e.target.value)} />
      <button onClick={submit}>Publish</button>
    </div>
  );
}