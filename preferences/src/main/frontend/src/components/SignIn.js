import * as React from "react";
import {useState} from "react";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Link from "@mui/material/Link";
import Grid from "@mui/material/Grid";
import Box from "@mui/material/Box";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import Typography from "@mui/material/Typography";
import {useHref} from "react-router-dom";
import PageLayout from "./PageLayout";
import ApiClient from "./ApiClient";
import {Navigate} from "react-router";


export default function SignIn(props) {
  /**
   * @type ApiClient
   * */
  const api = props.api;

  let [phase, setPhase] = useState("enter")
  let [login, setLogin] = useState(props.login);
  let [password, setPassword] = useState(props.password);
  let [loggedIn, setLoggedIn] = useState(props.loggedIn);
  const onLogin = props.onLogin || function(){};


  const handleSubmit = (event) => {
    event.preventDefault();
    setPhase("processing")
    api.login(login, password)
      .finally(()=>{
        setPhase("enter")
      })
      .then((response) => {
        console.log(response);
        onLogin(response);
        setLoggedIn(true);
      })
  };
  const linksBar = (
    <Grid container>
      <Grid item xs>
        <Link href={useHref("/forgot-password")} variant="body2">
          Forgot password?
        </Link>
      </Grid>
      <Grid item>
        <Link href={useHref("/sign-up")} variant="body2">
          {"Don't have an account? Sign Up"}
        </Link>
      </Grid>
    </Grid>
  );
  if(loggedIn){
    return <Navigate to="/user-home" />
  }else {
    return (
      <PageLayout icon={<LockOutlinedIcon/>} title={"Sign in"} minHeight={"300"}>
        <Box sx={{mt: 1, display: phase === "processing" ? 'block' : 'none'}}>
          <Grid container>
            <Grid item xs={12}>
              <Typography component="h6" variant="h6">
                Processing...
              </Typography>
            </Grid>
          </Grid>
        </Box>
        <Box component="form" onSubmit={handleSubmit} noValidate sx={{mt: 1, display: phase === "enter" ? 'block' : 'none'}}>
          <TextField margin="normal" required fullWidth id="email" label="Email Address" name="email" autoComplete="email" autoFocus value={login} onChange={e => setLogin(e.target.value)}/>
          <TextField margin="normal" required fullWidth name="password" label="Password" type="password" id="password" autoComplete="current-password" value={password}
                     onChange={e => setPassword(e.target.value)}/>
          <FormControlLabel control={<Checkbox value="remember" color="primary"/>} label="Remember me"/>
          <Button type="submit" fullWidth variant="contained" sx={{mt: 3, mb: 2}}>
            Sign In
          </Button>
          {linksBar}
        </Box>
      </PageLayout>);
  }
}

SignIn.defaultProps ={
  login: "test1@gmail.com",
  password: "Password#123",
  loggedIn: false
}
