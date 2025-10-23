import { Link } from 'react-router-dom';

export default function Navbar(){
  const logged = !!localStorage.getItem('token');
  return (
    <nav>
      <div className="container navbar-content">
        <Link to="/" className="logo">StorySphere</Link>
        <div className="nav-links">
          <Link to="/write">Write</Link>
          {logged ? (
            <button onClick={() => { localStorage.removeItem('token'); window.location='/'; }}>Logout</button>
          ) : (
            <>
              <Link to="/login">Login</Link>
              <Link to="/register">Register</Link>
            </>
          )}
        </div>
      </div>
    </nav>
  );
}