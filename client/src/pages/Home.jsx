import { useEffect, useState } from 'react';
import { api } from '../api';
import { Link } from 'react-router-dom';

export default function Home(){
  const [stories, setStories] = useState([]);
  useEffect(()=>{
    api.get('/stories').then(r=>setStories(r.data)).catch(()=>{});
  }, []);
  return (
    <div className="container">
      <h1>Latest Stories</h1>
      {stories.map(s => (
        <div key={s.id} className="story-card">
          <Link to={`/story/${s.id}`} className="story-title">{s.title}</Link>
          <p className="story-meta">By {s.User?.username || 'Unknown'} on {new Date(s.createdAt).toLocaleString()}</p>
          <p>{s.content.slice(0,200)}{s.content.length>200?'...':''}</p>
        </div>
      ))}
    </div>
  );
}