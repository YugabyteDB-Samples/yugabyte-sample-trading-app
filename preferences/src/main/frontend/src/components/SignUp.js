import * as React from 'react';
import {useState} from 'react';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import {useHref} from 'react-router-dom';
import {InputLabel, Select} from "@mui/material";
import MenuItem from "@mui/material/MenuItem";
import PageLayout from "./PageLayout";
import ApiClient from "./ApiClient";

export default function SignUp() {
  const api = new ApiClient();

  let [firstName, setFirstName] = useState('');
  let [lastName, setLastName] = useState('');
  let [email, setEmail] = useState('');
  let [region, setRegion] = useState('');
  let [password, setPassword] = useState('');
  let [step, setStep] = useState('initial');

  const handleSubmit = (event) => {
    event.preventDefault();
    // const data = new FormData(event.currentTarget);
    const form = {
      firstName, lastName, email, password, preferredRegion: region
    }
    api.signUp(form)
    .then(() => {
      setStep("success");
    });

  }

  let linksBar = (<Grid container justifyContent="flex-end">
    <Grid item>
      <Link href={useHref("/sign-in")} variant="body2">
        Already have an account? Sign in
      </Link>
    </Grid>
  </Grid>);

  if (step === "success") {
    return (<PageLayout icon={<LockOutlinedIcon/>} title={"Sign Up"} maxWidth="sm" description="Sign up successful! Proceed to Sign In now.">
      <Box sx={{mt: 3}}>
        {linksBar}
      </Box>
    </PageLayout>);

  } else if (step === "initial") {
    return (<PageLayout icon={<LockOutlinedIcon/>} title={"Sign Up"} maxWidth="sm">
      <Box component="form" noValidate onSubmit={handleSubmit} sx={{mt: 3}}>
        <Grid container spacing={2}>
          <Grid item xs={12} sm={6}>
            <TextField
              autoComplete="given-name"
              name="firstName"
              required
              fullWidth
              id="firstName"
              label="First Name"
              autoFocus
              onChange={e => setFirstName(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} sm={6}>
            <TextField
              required
              fullWidth
              id="lastName"
              label="Last Name"
              name="lastName"
              autoComplete="family-name"
              onChange={e => setLastName(e.target.value)}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              required
              fullWidth
              id="email"
              label="Email Address"
              name="email"
              autoComplete="email"
              onChange={e => setEmail(e.target.value)}
            />
          </Grid>
          <Grid item xs={12}>
            <InputLabel id="pref_region_lbl">Preferred Region</InputLabel>
            <Select fullWidth
                    labelId="pref_region_lbl"
                    id="demo-simple-select"
                    label="Preferred Region"
                    onChange={e => setRegion(e.target.value)}
            >
              <MenuItem>Please Select</MenuItem>
              <MenuItem value='US'>Americas</MenuItem>
              <MenuItem value='EU'>Europe</MenuItem>
              <MenuItem value='AP'>Asia</MenuItem>
            </Select>
          </Grid>
          <Grid item xs={12}>
            <TextField
              required
              fullWidth
              name="password"
              label="Password"
              type="password"
              id="password"
              autoComplete="new-password"
              onChange={e => setPassword(e.target.value)}
            />
          </Grid>
          <Grid item xs={12}>
            <FormControlLabel
              control={<Checkbox value="allowExtraEmails" color="primary"/>}
              label="I want to receive inspiration, marketing promotions and updates via email."
            />
          </Grid>
        </Grid>
        <Button
          type="submit"
          fullWidth
          variant="contained"
          sx={{mt: 3, mb: 2}}
        >
          Sign Up
        </Button>
        {linksBar}
      </Box>
    </PageLayout>);
  }
}

