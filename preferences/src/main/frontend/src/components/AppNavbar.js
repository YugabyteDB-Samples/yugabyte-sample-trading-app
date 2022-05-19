import logo from '../logo192.png';

import React, {Component} from 'react';
import {
  Nav, Navbar, NavDropdown
} from 'react-bootstrap';

class AppNavbar extends Component {
  constructor(props) {
    super(props);
    this.state = {isOpen: false};
    this.toggle = this.toggle.bind(this);
  }
  toggle() {
    this.setState({
      isOpen: !this.state.isOpen
    });
  }

  render() {
    return (<Navbar expand="lg">
          <Navbar.Brand href="/home">
            <img src={logo} height='30'
                 className="d-inline-block align-top"
                 alt="Trading Home Logo"/>
            <span>TradeX</span>
          </Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav"/>
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="me-auto">
              <Nav.Link href="/dashboard">Dashboard</Nav.Link>
              <Nav.Link href="/market">Market Data</Nav.Link>
              <Nav.Link href="/preferences">Preferences</Nav.Link>
              <Nav.Link href="/login">Login</Nav.Link>
              <Nav.Link href="/logout">Logout</Nav.Link>
            </Nav>
            <Nav className="ms-auto">
              <NavDropdown title="About Yugabyte" id="basic-nav-dropdown">
                <NavDropdown.Item target="_blank" href="https://yugabyte.com">Yugabyte Home</NavDropdown.Item>
                <NavDropdown.Item target="_blank" href="https://cloud.yugabyte.com">YugabyteDB Managed</NavDropdown.Item>
                <NavDropdown.Item target="_blank" href="https://university.yugabyte.com">Yugabyte University</NavDropdown.Item>
                <NavDropdown.Divider/>
                <NavDropdown.Item target="_blank" href="https://github.com/yugabyte">Github</NavDropdown.Item>
                <NavDropdown.Item target="_blank" href="https://communityinviter.com/apps/yugabyte-db/register">Slack</NavDropdown.Item>
              </NavDropdown>
            </Nav>
          </Navbar.Collapse>
      </Navbar>);
  }
}

export default AppNavbar;
