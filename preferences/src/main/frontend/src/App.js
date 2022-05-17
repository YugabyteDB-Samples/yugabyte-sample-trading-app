import logo from './logo.svg';
import './App.css';
import {Component} from "react";

class App extends Component {
  state = {
    preferences: []
  };

  async componentDidMount() {
    const response = await fetch('/api/communication-preferences');
    const body = await response.json();
    this.setState({preferences: body._embedded});
  }

  render() {

    let preferences = this.state.preferences;
    let communicationPreferences = preferences.communicationPreferences || [];
    console.log(preferences);

    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <div className="App-intro">
            <h2>Communication Preferences</h2>
            {communicationPreferences.map(preference =>
              <div key={preference._links.self.href} data-key={preference._links.self.href}>
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
