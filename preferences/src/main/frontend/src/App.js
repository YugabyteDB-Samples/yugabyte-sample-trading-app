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
import Settings from "./components/Settings";
import SignOut from "./components/SignOut";
import UserHome from "./components/UserHome";
import Grid from "@mui/material/Grid";
import ApiClient from "./components/ApiClient";

let theme = createTheme({
  palette: {
    mode: "light"
  },
});

theme = createTheme(theme, {
  palette: {
    info: {
      main: theme.palette.secondary.main,
    },
  },
});

export default function Apps() {
  let [api, setApi] = useState(new ApiClient())

  function onLogin(loginResponse) {
    setApi(new ApiClient(loginResponse.token));
  }

  function onLogout() {
    setApi(new ApiClient());
  }

  return (
    <ThemeProvider theme={theme}>
      <Box sx={{display: "flex"}}>
        <CssBaseline/>
        <Router>
          <AppHeader api={api}/>
          <Box component="article"
               sx={{flexGrow: 1, height: "100vh", overflow: "auto", mt: 5, mb:5, backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]),}}>
            <Routes>
              <Route exact="true" path="/" element={<Home api={api}/>}/>
              <Route exact="true" path="home" element={<Home api={api} />}/>
              <Route exact="true" path="user-home" element={<UserHome api={api}/>}/>
              <Route exact="true" path="settings" element={<Settings api={api} />}/>
              <Route exact="true" path="sign-in" element={<SignIn api={api} onLogin={onLogin} />} />
              <Route exact="true" path="sign-up" element={<SignUp api={api}/>}/>
              <Route exact="true" path="sign-out" element={<SignOut api={api} onLogout={onLogout}/>}/>
              <Route exact="true" path="forgot-password" element={<ForgotPassword api={api}/>}/>
              <Route exact="true" path="error" element={<NotFound api={api}/>}/>
              <Route component={NotFound}/>
            </Routes>
          </Box>
          <AppFooter />
        </Router>
      </Box>
    </ThemeProvider>
  );

}


function AppFooter (){
  return (
    <Box component="footer" sx={{backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]), flexGrow: 1, position: "fixed",  width: "100%", bottom: 0}}>
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
    </Box>
  );
}
