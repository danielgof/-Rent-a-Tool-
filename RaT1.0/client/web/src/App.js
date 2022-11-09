import React from 'react';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import RegistrationPage from './pages/RegistrationPage';
import ProtectedRouts from './components/ProtectedRoutes.jsx';
import OfferPage from './pages/OfferPage';
import RequestPage from './pages/RequestPage';

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
              <Route exact path="/offers" element={<OfferPage />} />
              <Route exact path="/requests" element={<RequestPage />} />
            </Route>        
          </Routes>
        </header>
      </div>
    </BrowserRouter>
  );
}

export default App;
