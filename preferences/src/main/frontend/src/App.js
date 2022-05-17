import logo from './logo.svg';
import './App.css';
import {Component} from "react";

class App extends Component {
  state = {
    prefereences: []
  };

  async componentDidMount() {
    const response = await fetch('/api/communication-preferences');
    const body = await response.json()._embedded;
    this.setState({preferences: body});
  }

  render() {
    const {prefereences} = this.state;
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <div className="App-intro">
            <h2>Preferences</h2>
            {prefereences.map(preference =>
              <div key={preference._links.self.href}>
                {preference.customerId} ({preference.tradeForms} / {preference.statementDelivery} / {preference.tradeConfirmation} )
              </div>
            )}
          </div>
        </header>
      </div>
    );
  }
}

export default App;
