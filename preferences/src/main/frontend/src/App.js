import { Component } from "react";
import "./App.css";
import AppFooter from "./components/AppFooter";
import AppHeader from "./components/AppHeader";
import { HashRouter as Router, Routes, Route } from "react-router-dom";
import SignUp from "./components/SignUp";
import ForgotPassword from "./components/ForgotPassword";
import NotFound from "./components/NotFound";
import "fontsource-roboto";
import Home from "./components/Home";
import SignIn from "./components/SignIn";
import { Box, createTheme, CssBaseline } from "@mui/material";
import { ThemeProvider } from "@mui/system";
import Settings from "./components/Settings";
import SignOut from "./components/SignOut";

let theme = createTheme({
  palette: {
    primary: {
      main: '#0052cc',
    },
    secondary: {
      main: '#edf2ff',
    },
  },
});

theme = createTheme(theme, {
  palette: {
    info: {
      main: theme.palette.secondary.main,
    },
  },
});

export default class App extends Component {
  render() {
    return (
      <ThemeProvider theme={theme}>
        <Box sx={{ display: "flex" }}>
          <CssBaseline />
          <Router>
            <AppHeader />
            <Box
              component="main"
              sx={{
                backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]),
                flexGrow: 1,
                height: "100vh",
                overflow: "auto",
                mt: 8,
                mb: 3,
              }}
            >
              <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/home" element={<Home />} />
                <Route path="/settings" element={<Settings />} />
                <Route path="/sign-in" element={<SignIn />} />
                <Route path="/sign-up" element={<SignUp />} />
                <Route path="/sign-out" element={<SignOut />} />
                <Route path="/forgot-password" element={<ForgotPassword />} />
                <Route element={<NotFound />} />
              </Routes>
            </Box>
            <Box
              component="footer"
              sx={{
                backgroundColor: (theme) => (theme.palette.mode === "light" ? theme.palette.grey[100] : theme.palette.grey[900]),
                flexGrow: 1,
                position: "absolute",
                width: "100%",
                bottom: 0
              }}
            >
              <AppFooter />
            </Box>
          </Router>
        </Box>
      </ThemeProvider>
    );
  }
}
