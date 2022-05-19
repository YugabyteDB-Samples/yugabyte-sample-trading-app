import {Component} from "@types/react";

export default class CommunicationPreferences extends Component {
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

    return (
      <div className="App">
        <header className="App-header">
        </header>
        <div className="App-intro">
          <h2>Communication Preferences</h2>
          {communicationPreferences.map(preference =>
            <div key={preference._links.self.href} data-key={preference._links.self.href}>
              {preference.customerId} ({preference.tradeForms} / {preference.statementDelivery} / {preference.tradeConfirmation} )
            </div>
          )}
        </div>
      </div>
    );
  }
}

