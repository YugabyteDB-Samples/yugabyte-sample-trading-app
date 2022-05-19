import React, {Component} from 'react';
import {Button, Card, Form} from 'react-bootstrap';

export default class Login extends Component {
  render() {
    return (
      <Card>
        <Form id="login">
          <Card.Header>Sign In</Card.Header>
          <Card.Body>
            <Form.Group controlId="login.email">
              <Form.Label>Email Address</Form.Label>
              <Form.Control type="email" placeholder="Enter email"/>
            </Form.Group>

            <Form.Group controlId="login.password">
              <Form.Label>Password</Form.Label>
              <Form.Control type="password" placeholder="Enter Password"/>
            </Form.Group>
            <Form.Group controlId="login.rememberMe">
              <Form.Label sm={"2"}>Remember Me</Form.Label>
              <Form.Check type="checkbox"/>
            </Form.Group>
          </Card.Body>
          <Card.Footer className="align-content-center">

            <Button size="sm" variant="primary" type="submit">
              Login
            </Button>

          </Card.Footer>
        </Form>
      </Card>
    );
  }
}
