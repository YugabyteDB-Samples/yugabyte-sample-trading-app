import React, {Component} from 'react'
import {Button, Form, Stack} from "react-bootstrap";

export default class ForgotPassword extends Component {
  render() {
    return (
      <Form>
        <Stack gap={2} className="col-md-5 mx-auto">
        <h3>Forgot Password</h3>
          <label className="form-label">Email address</label>
          <input
            type="email"
            className="form-control"
            placeholder="Enter email"
          />
          <Button type="submit" variant="primary">
            Request Password Reset
          </Button>
        </Stack>
      </Form>
    )
  }
}

