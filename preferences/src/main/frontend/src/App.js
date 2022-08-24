import React, {useState} from "react";
import {HashRouter as Router, Route, Routes, useHref} from "react-router-dom";
import {createTheme, Link, Typography} from "@mui/material";
import Box from "@mui/material/Box";
import CssBaseline from "@mui/material/CssBaseline";
import ThemeProvider from '@mui/system/ThemeProvider';
import "fontsource-roboto";
import AppHeader from "./components/AppHeader";
import SignUp from "./components/SignUp";
import ForgotPassword from "./components/ForgotPassword";
import NotFound from "./components/NotFound";
import Home from "./components/Home";
import SignIn from "./components/SignIn";
import SignOut from "./components/SignOut";
import UserHome from "./components/UserHome";
import Grid from "@mui/material/Grid";
import Settings from "./components/Settings";
import {useAuth} from "./components/AuthProvider";

let theme = createTheme({
  palette: {
    mode: "dark"
  },
});

theme = createTheme(theme, {
  palette: {
    info: {
      main: theme.palette.secondary.main,
    },
  },
});

export default function App() {
  let {authData} = useAuth();
  let [signedIn] = useState(authData != null);

  return (<ThemeProvider theme={theme}>
    <Box sx={{display: "flex"}}>
      <CssBaseline/>
      <Router>
        <AppHeader/>
        <Box component="article"
             sx={{flexGrow: 1, height: "100vh", pt: 4, overflow: "auto", backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]),}}>
          <Routes>
            <Route exact="true" path="/" render={!signedIn} element={<SignIn/>}/> 
            <Route exact="true" path="home" element={<Home/>}/>
            <Route exact="true" path="error" element={<NotFound/>}/>
            <Route exact="true" path="sign-out" render={signedIn} element={<SignOut/>}/>
            <Route exact="true" path="forgot-password" render={!signedIn} element={<ForgotPassword/>}/>
            <Route exact="true" path="sign-up" render={!signedIn} element={<SignUp/>}/>
            <Route exact="true" path="sign-in" render={!signedIn} element={<SignIn/>}/>
            <Route exact="true" path="settings" render={signedIn} element={<Settings/>}/>
            <Route exact="true" path="user-home" render={signedIn} element={<UserHome/>}/>

            <Route element={<NotFound/>}/>

          </Routes>
        </Box>
        <AppFooter/>
      </Router>
    </Box>
  </ThemeProvider>);

}

function AppFooter() {
  return (<Box component="footer"
               sx={{backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]), flexGrow: 1, position: "fixed", width: "100%", bottom: 0}}>
    <Grid container>
      <Grid item xs={12} md={12} lg={12}>
        <Typography width="100%" variant="body2" color="text.secondary" align="center">
          {"Copyright © "}
          <Link color="inherit" href={useHref("/")}>
            TradeX
          </Link>{" "}
          {new Date().getFullYear()}
          {"."}
        </Typography>
      </Grid>
    </Grid>
  </Box>);
}
