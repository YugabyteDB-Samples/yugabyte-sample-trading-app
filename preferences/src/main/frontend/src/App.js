import {useState} from "react";
import {HashRouter as Router, Route, Routes} from "react-router-dom";
import {createTheme} from "@mui/material";
import Box from "@mui/material/Box";
import CssBaseline from "@mui/material/CssBaseline";
import ThemeProvider from '@mui/system/ThemeProvider';
import "fontsource-roboto";
import AppFooter from "./components/AppFooter";
import AppHeader from "./components/AppHeader";
import SignUp from "./components/SignUp";
import ForgotPassword from "./components/ForgotPassword";
import NotFound from "./components/NotFound";
import Home from "./components/Home";
import SignIn from "./components/SignIn";
import Settings from "./components/Settings";
import SignOut from "./components/SignOut";
import UserHome from "./components/UserHome";

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

  let [auth, setAuth] = useState({});

  function onLogin(event) {
    setAuth({loggedIn: true, token: event.token})
  }

  function onLogout() {
    setAuth({loggedIn: false, token: null})
  }

  return (
    <ThemeProvider theme={theme}>
      <Box sx={{display: "flex"}}>
        <CssBaseline/>
        <Router>
          <AppHeader auth={auth}/>
          <Box
            component="main"
            sx={{
              flexGrow: 1,
              height: "100vh",
              overflow: "auto",
              mt: 8,
              mb: 3,
              backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]),
            }}
          >
            <Routes>
              <Route exact="true" path="/" element={<Home/>}/>
              <Route exact="true" path="home" element={<Home/>}/>
              <Route exact="true" path="user-home" element={<UserHome/>}/>
              <Route exact="true" path="settings" element={<Settings/>}/>
              <Route exact="true" path="sign-in" element={<SignIn onLogin={onLogin}/>}/>
              <Route exact="true" path="sign-up" element={<SignUp/>}/>
              <Route exact="true" path="sign-out" element={<SignOut onLogout={onLogout}/>}/>
              <Route exact="true" path="forgot-password" element={<ForgotPassword/>}/>
              <Route exact="true" path="error" element={<NotFound/>}/>
              <Route component={NotFound}/>
            </Routes>
          </Box>
          <Box
            component="footer"
            sx={{
              backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]),
              flexGrow: 0,
              position: "absolute",
              width: "100%",
              bottom: 0
            }}
          >
            <AppFooter/>
          </Box>
        </Router>
      </Box>
    </ThemeProvider>
  );

}

