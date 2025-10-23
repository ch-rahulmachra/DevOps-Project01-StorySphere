import { useEffect, useState } from 'react';
import { api } from '../api';
import { useParams, Link } from 'react-router-dom';

export default function StoryDetail(){
  const { id } = useParams();
  const [story, setStory] = useState(null);

  useEffect(()=>{
    api.get(`/stories/${id}`).then(r=>setStory(r.data)).catch(()=>{});
  }, [id]);

  if(!story) return <div className="container">Loading...</div>;

  return (
    <div className="container">
      <h1>{story.title}</h1>
      <p className="story-meta">By {story.User?.username}</p>
      <div className="story-content">{story.content}</div>
      <div className="mt-2">
        <Link to="/">← Back to stories</Link>
      </div>
    </div>
  );
}