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
import {useAuth} from "./AuthProvider";
import {Navigate} from "react-router";

export default function SignIn() {
  const {authData, login} = useAuth();
  let api = new ApiClient(authData);

  let [phase, setPhase] = useState("")
  let [email, setEmail] = useState("ap-user@example.com");
  let [password, setPassword] = useState("Password#123");
  let [error, setError] = useState(null);
  const signedIn = authData != null;
  const handleSubmit = (event) => {
    event.preventDefault();
    setError(null);
    setPhase("processing")

    api.signIn(email, password)
    .then((response) => {
      login(response);
      setPhase("success")
    })
    .catch((reason) => {
      setError(reason.message);
      setPhase("");
    });
  };

  const linksBar = (<Grid container>
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
  </Grid>);

  if (signedIn || phase === "success") {
    return (<Navigate to={"/user-home"} replace="true"/>);
  } else if (phase === "processing") {
    return (<PageLayout icon={<LockOutlinedIcon/>} title={"Sign in"} minHeight={"300"}>
      <Box sx={{mt: 1, display: 'block'}}>
        <Grid container>
          <Grid item xs={12}>
            <Typography component="h6" variant="h6" textAlign="center">
              Processing...
            </Typography>
          </Grid>
        </Grid>
      </Box>
    </PageLayout>);
  } else {
    return (<PageLayout icon={<LockOutlinedIcon/>} title={"Sign In"} minHeight={"300"}>
      <Box component="form" onSubmit={handleSubmit} noValidate sx={{mt: 1, display: 'block'}}>
        {!!error && <>
          <Typography component="p" variant="body1" textAlign="center" color={"error"}>
            Sign In Failed
          </Typography>
          <Typography component="p" variant="body2" textAlign="center" color={"error"}>
            {error}
          </Typography>
        </>
        }

        <TextField margin="normal" required fullWidth id="email" label="Email Address" name="email" autoComplete="email" autoFocus value={email} onChange={e => setEmail(e.target.value)}/>
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
