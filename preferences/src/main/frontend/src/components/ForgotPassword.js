import {Button, TextField} from "@mui/material";
import Grid from "@mui/material/Grid";
import Link from "@mui/material/Link";
import {Box} from "@mui/system";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import {useHref} from "react-router-dom";

import React from "react";
import PageLayout from "./PageLayout";

export default function ForgotPassword() {
  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    console.log({
      email: data.get("email"),
    });
  };

  return (
    <PageLayout icon={<LockOutlinedIcon/>} title={"Forgot Password"} minHeight={"300"}>
      <Box component="form" onSubmit={handleSubmit} noValidate sx={{mt: 1}}>
        <TextField margin="normal" required fullWidth id="email" label="Email Address" name="email" autoComplete="email" autoFocus style={{width: "100%", minWidth: 400}}/>
        <Button type="submit" fullWidth variant="contained" sx={{mt: 3, mb: 2}}>
          Reset Password
        </Button>
      </Box>
      <Grid container>
        <Grid item xs>
          <Link href={useHref("/sign-in")} variant="body2">
            Back to Sign In
          </Link>
        </Grid>
        <Grid item>
          <Link href={useHref("/sign-up")} variant="body2">
            {"Don't have an account? Sign Up"}
          </Link>
        </Grid>
      </Grid>
    </PageLayout>
  )
    ;
}
