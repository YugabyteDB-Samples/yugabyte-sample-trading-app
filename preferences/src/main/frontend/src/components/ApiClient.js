export default class ApiClient {
  #token = '';
  #loggedIn = false;
  #preferenceId = 0;
  #customerId = 0;


  constructor(token) {
    this.#token = token
    this.#loggedIn = token !== undefined && token.trim() !== '';
  }
  #authHeader(){
    return this.#token === undefined ? {} : {
      "Authorization": "Bearer " + this.#token,
    }
  }

  #_request(method, url, body, headers) {
    return fetch(url, {
      method: method,
      body: body !== undefined ? JSON.stringify(body) : undefined,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...this.#authHeader(),
        ...headers
      }
    }).then(response => response.json())
  }



  post(url, data, headers) {
    return this.#_request("post", url, data, headers);
  }

  get(url, data, headers) {
    let query = new URLSearchParams(data);
    return this.#_request("get", url + "?" + query, headers);
  }

  delete(url, data, headers) {
    return this.#_request("delete", url, headers);
  }

  put(url, data, headers) {
    return this.#_request("put", url, data, headers);
  }

  login(login, credentials){
    return this.post("/api/v1/users/sign-in", {login: login, credentials: credentials})
    .then(response => {
      this.#token = response.token;
      this.#loggedIn = true;
      return response;
    });
  }
  signup(form){
    return this.post("/api/v1/users/sign-up", form);
  }
  updatePreferences(preference){
    return this.post("/api/v1/preferences/#{prefer", preference);
  }
  checkLoginAvailability(login){
    return this.get("/api/v1/users/check-availability", {login: login});
  }

  isLoggedIn(){
    return this.#loggedIn;
  }
  getPreferences(){
    // return this.po
  }

}
