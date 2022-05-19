import logo from '../logo192.png';

import React, {Component} from 'react';
import {Container, Nav, Navbar, NavDropdown} from 'react-bootstrap';
import {NavLink} from "react-router-dom";

export default class AppNavbar extends Component {
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
    return (
      <Container fluid={true}>
        <Navbar expand="lg">
          <Navbar.Brand href="#/home">
            <img src={logo} height='30'
                 className="d-inline-block align-top"
                 alt="Trading Home Logo"/>
            <span>TradeX</span>
          </Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav"/>
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="me-auto">
              <NavLink  className="nav-link" activeClassName="is-active" to="/dashboard">Dashboard</NavLink>
              <NavLink  className="nav-link" activeClassName="is-active" to="/market">Market Data</NavLink>
              <NavLink  className="nav-link" activeClassName="is-active" to="/preferences">Preferences</NavLink>
              <NavLink  className="nav-link" activeClassName="is-active" to="/login">Login</NavLink>
              <NavLink  className="nav-link" activeClassName="is-active" to="/logout">Logout</NavLink>
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
        </Navbar>
      </Container>
    );
  }
}

