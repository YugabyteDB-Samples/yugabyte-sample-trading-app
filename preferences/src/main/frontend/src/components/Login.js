import React, {Component} from 'react';
import {Stack} from 'react-bootstrap';

export default class Login extends Component {
  render() {
    return (
      <Stack gap={2} className="col-md-5 mx-auto">
      <form>
          <h3>Sign In</h3>
          <div className="mb-3">
            <label>Email address</label>
            <input
              type="email"
              className="form-control"
              placeholder="Enter email"
            />
          </div>
          <div className="mb-3">
            <label>Password</label>
            <input
              type="password"
              className="form-control"
              placeholder="Enter password"
            />
          </div>
          <div className="mb-3">
            <div className="custom-control custom-checkbox">
              <input
                type="checkbox"
                className="custom-control-input"
                id="customCheck1"
              />
              <label className="custom-control-label" htmlFor="customCheck1">
                Remember me
              </label>
            </div>
          </div>
          <div className="d-grid">
            <button type="submit" className="btn btn-primary">
              Submit
            </button>
          </div>

          <span className="forgot-password text-right">
            Forgot <a href="/forgot-password">password?</a>
          </span>
        <span> OR </span>
        <span className="forgot-password text-right">
          <a href="/signup">Signup Now</a>
        </span>

      </form>
      </Stack>
    );
  }
}
