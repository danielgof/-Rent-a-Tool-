import React from 'react';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import RegistrationPage from './pages/RegistrationPage';
import ProtectedRouts from './components/ProtectedRoutes.jsx';

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        <header className="App-header">
          <Routes>
            <Route exact path="/" element={<LoginPage />} />
            <Route exact path="/registration" element={<RegistrationPage />} />
            <Route element={<ProtectedRouts isAuth={true} />}>
              <Route exact path="/home" element={<HomePage />} />
            </Route>        
          </Routes>
        </header>
      </div>
    </BrowserRouter>
  );
}

export default App;
