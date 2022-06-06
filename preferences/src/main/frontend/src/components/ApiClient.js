import {useAuth} from "./AuthProvider";

const ApiClient = function () {

  let token = null;
  let customerId = null;
  let authHeaders = {};

  let {authData} = useAuth();
  if (authData != null) {
    token = authData.token;
    customerId = authData.customerId;
    authHeaders = {
      "Authorization": "Bearer " + token
    };
  }

  function _request(method, url, body, headers) {
    let options = {
      method: method,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...authHeaders,
        ...headers
      }
    };
    if (method !== "GET" && body !== undefined && body !== null) {
      options.body = JSON.stringify(body);
    }

    return fetch(url, options)
    .then(response => {
      return response.json();
    }).then(jsonResponse => {
      if ("ERROR" === jsonResponse?.status) {
        return Promise.reject(jsonResponse);
      }
      return jsonResponse;
    }).catch((reason) => {
      console.log({reason});
      return Promise.reject(reason);
    });
  }

  function _post(url, data, headers) {
    return _request("POST", url, data, headers);
  }

  function _get(url, data, headers) {
    let query = new URLSearchParams(data);
    let qStr = "?" + query;
    let getUrl = url + qStr;
    if (qStr === "?") {
      getUrl = url
    }
    return _request("GET", getUrl, headers);
  }

  // function _delete(url, data, headers) {
  //   return _request("delete", url, headers);
  // }
  //
  // function _put(url, data, headers) {
  //   return _request("put", url, data, headers);
  // }

  function _patch(url, data, headers) {
    return _request("PATCH", url, data, headers);
  }

  /**
   *
   * @param loginId - User login id
   * @param credentials - Password for signing in
   * @returns {Promise<AuthenticationResponse>}
   */
  this.signIn = function (loginId, credentials) {
    return _post("/api/v1/users/sign-in", {login: loginId, credentials: credentials});
  }

  this.signOut = function () {
    return _post("/api/v1/users/sign-out").catch(() => {
      return null;
    });
  }

  /**
   * Signup user
   * @param {SignUpRequest} form
   * @returns {Promise<SignUpResponse>}
   */
  this.signUp = function (form) {
    return _post("/api/v1/users/sign-up", form);
  }

  /**
   * Update a customer's profile
   * @param customer {Customer} - Customer profile to update;
   * @returns {Promise<Customer>}
   */
  this.updateProfile = function (customer) {
    return _patch("/api/v1/customers/" + customerId, customer);
  }

  /**
   * Get a customer profile
   * @returns {Promise<Customer|*>} Promise to provide profile
   */
  this.getProfile = function () {
    return _get("/api/v1/users/me");
  }

  /**
   * @param {string} login : Login
   * @return {Promise<PasswordResetResponse|void>}
   */
  this.passwordReset = function (login) {
    return _post("/api/v1/users/password-reset", {login: login});
  }

}
export default ApiClient;
/**
 * Customer profile
 * @typedef {Object} Customer
 * @property {number} customerId - Customer Id
 * @property {string} fullName - Full Name
 * @property {string} phoneNumber - Phone Number
 * @property {string} email - Email address
 * @property {boolean} enabled - Is account enabled
 * @property {string} preferredRegion - Preferred Region
 * @property {string} accountStatementDelivery - Statement Delivery Option
 * @property {string} taxFormDelivery - Tax Form Delivery Option
 * @property {string} tradeConfirmation - Trade Confirmation Delivery Option
 * @property {string} subscribeBlog - Subscribe to Blog
 * @property {string} subscribeWebinar - Subscribe to Webinar
 * @property {string} subscribeNewsletter - Subscribe to Newsletter
 */

/**
 * Sign Up Request
 * @typedef {Object} SignUpRequest
 * @property {string} fullName - Full Name
 * @property {string} phoneNumber - Phone Number
 * @property {string} email - Email address
 * @property {string} preferredRegion - Preferred Region
 * @property {string} password - Password
 */

/**
 * Signup Response
 *  @typedef {Object} SignUpResponse
 * @property {string} customerId - Customer ID
 * @property {string} login - Login ID
 */

/**
 * Authentication Request
 * @typedef {Object} AuthenticationRequest
 * @property {string} login - Login
 * @property {string} credentials - Credentials
 */

/**
 * Authentication Response
 * @typedef {Object} AuthenticationResponse
 * @property {string} token - Authentication Token
 * @property {string} type - Token type
 * @property {string} status - Status
 * @property {string} message - Message
 */

/**
 * @typedef {Object} PasswordResetRequest
 * @property {string} login - Login ID
 */

/**
 * @typedef {Object} PasswordResetResponse
 * @property {string} login - Login ID
 * @property {string} password - New Password
 */

/**
 * @typedef {Object} Session
 * @property {string} token
 * @property {number} customerId
 */
