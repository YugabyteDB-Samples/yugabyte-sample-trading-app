import * as React from "react";
import Avatar from "@mui/material/Avatar";
import Button from "@mui/material/Button";
import CssBaseline from "@mui/material/CssBaseline";
import TextField from "@mui/material/TextField";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Link from "@mui/material/Link";
import Grid from "@mui/material/Grid";
import Box from "@mui/material/Box";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import { useHref } from "react-router-dom";
import {useState} from "react";

export default function SignIn(props, context) {
  let [phase, setPhase] = useState("enter")
  const handleSubmit = (event) => {
    event.preventDefault();
    setPhase("processing")
    const data = new FormData(event.currentTarget);
    const url = "/api/v1/users/sign-in";
    const body = new URLSearchParams();
    for (const pair of data) {
      body.append(pair[0], pair[1]);
    }

    fetch(url, {
      method: 'post',
      body: body,
    })
    .then(()=>{
      setPhase("enter");
      context.history.push("user-home");
    })
    .catch(console.log);
    // console.log({
    //   email: data.get("email"),
    //   password: data.get("password"),
    // });
    // setTimeout(()=>{setPhase("enter")}, 2000);
  };

  return (
    <Container  component="main" maxWidth="xs" >
      <CssBaseline />

      <Box
        sx={{
          marginTop: 8,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
        }}
      >
        <Avatar sx={{ m: 1,color: 'primary' }}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h5" variant="h5">
          Sign in
        </Typography>
        <Box sx={{ mt: 1, display: phase === "processing" ? 'block': 'none' }} >
          <Grid container>
            <Grid item xs={12}>
              <Typography component="h6" variant="h6">
                Processing...
              </Typography>
            </Grid>
          </Grid>
        </Box>
        <Box component="form" onSubmit={handleSubmit} noValidate sx={{ mt: 1,  display: phase === "enter" ? 'block': 'none' }} >
          <TextField margin="normal" required fullWidth id="email" label="Email Address" name="email" autoComplete="email" autoFocus />
          <TextField margin="normal" required fullWidth name="password" label="Password" type="password" id="password" autoComplete="current-password" />
          <FormControlLabel control={<Checkbox value="remember" color="primary" />} label="Remember me" />
          <Button type="submit" fullWidth variant="contained" sx={{ mt: 3, mb: 2 }}>
            Sign In
          </Button>
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
        </Box>
      </Box>
    </Container>);
}
