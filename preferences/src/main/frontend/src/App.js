import './App.css';
import {Component} from "react";
import {BrowserRouter as Router, Route, Routes,} from "react-router-dom";
import Preferences from "./Preferences";
import Home from "./Home";

class App extends Component {
  render() {
    return (
      <Router>
        <Routes>
          <Route path='/' exact={true} component={Home}/>
          <Route path='/preferences' exact={true} component={Preferences}/>
        </Routes>
      </Router>
    )
  }
}

export default App;


