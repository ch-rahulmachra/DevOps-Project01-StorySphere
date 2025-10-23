import { useState } from 'react';
import { api } from '../api';

export default function Footer(){
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const submit = async () => {
    try {
      await api.post('/feedback', { email, message });
      alert('Thanks for your feedback!');
      setEmail(''); setMessage('');
    } catch (err) {
      alert('Failed to send feedback');
    }
  };
  return (
    <footer>
      <div className="container footer-content">
        <h3>Website Feedback</h3>
        <input
          type="text"
          placeholder="Your email (optional)"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />
        <input
          type="text"
          placeholder="Your feedback"
          value={message}
          onChange={e => setMessage(e.target.value)}
        />
        <button onClick={submit}>Send</button>
      </div>
    </footer>
  );
}