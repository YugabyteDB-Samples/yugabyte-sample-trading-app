import React, {Component} from 'react';
import Home from './components/Home';
import {BrowserRouter, Routes, Route} from "react-router-dom";
import Dashboard from "./components/Dashboard";
import Login from "./components/Login";
import Logout from "./components/Logout";
import Portfolio from "./components/Portfolio";
import MarketData from "./components/MarketData";
import Preferences from "./components/Preferences";
import AppNavbar from "./components/AppNavbar";

class App extends Component {
  render() {
    return (
      <BrowserRouter>
        <AppNavbar />
        <div className='bg-light text-dark pt-5' style={{height: '100vh'}}>
          <div className='container'>
            <Routes>
              <Route path='/' exact={true} element={<Home/>}/>
              <Route path='/home' exact={true} element={<Home/>}/>
              <Route path='/dashboard' exact={true} element={<Dashboard/>}/>
              <Route path='/login' exact={true} element={<Login/>}/>
              <Route path='/logout' exact={true} element={<Logout/>}/>
              <Route path='/portfolio' exact={true} element={<Portfolio/>}/>
              <Route path='/market' exact={true} element={<MarketData/>}/>
              <Route path='/preferences' exact={true} element={<Preferences/>}/>
            </Routes>
          </div>
        </div>
      </BrowserRouter>
    )
  }
}

export default App;
