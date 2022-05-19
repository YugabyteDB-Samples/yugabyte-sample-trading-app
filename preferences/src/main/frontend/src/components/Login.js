import React, {Component} from 'react';
import {Button, ButtonGroup, Form, Row, Stack, ToggleButton} from 'react-bootstrap';

export default class Login extends Component {
  render() {
    return (
      <Stack gap={2} className="col-md-5 mx-auto">
        <h3>Sign In</h3>
        <Form id="login">

          <Form.Group as={Row} className="mb-3" controlId="login.email">
            <Form.Label sm="2">Email Address</Form.Label>
            <Form.Control sm="10" type="email" placeholder="Enter email"/>
          </Form.Group>

          <Form.Group as={Row} className="mb-3" controlId="login.password">
            <Form.Label sm="2">Password</Form.Label>
            <Form.Control sm="10" type="password" placeholder="Enter Password"/>
          </Form.Group>


          <ButtonGroup className="mb-3">
            <ToggleButton type="checkbox"
                          className="mb-2">Remember Me</ToggleButton>
          </ButtonGroup>
        </Form>
        <Row className="mv-3">
          <Button sm="2" className="mv4" variant="primary" type="submit">
            Login
          </Button>

        </Row>
        <Row className="mb-3">
          <span className="forgot-password text-right">
            Forgot <a href="/forgot-password">password?</a>
          </span>
          <span> OR </span>
          <span className="forgot-password text-right">
          <a href="/signup">Signup Now</a>
        </span>

        </Row>
        <Form.Group as={Row} className="mb-3" controlId="login.remember_me">
          <Form.Control type="checkbox"></Form.Control>
          <Form.Label sm="10">Remember Me</Form.Label>
        </Form.Group>

      </Stack>
    )
      ;
  }
}
