import * as React from 'react';
import {useState} from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import Tooltip from '@mui/material/Tooltip';
import MenuItem from '@mui/material/MenuItem';
import {Link} from 'react-router-dom';
import CurrencyExchangeIcon from '@mui/icons-material/CurrencyExchange';
import {useAuth} from "./AuthProvider";

const pages = [
  {"label": 'Home', "route": "/home"},
  {"label": 'Sign Up', "route": "/sign-up", requiredSignInStatus: false},
  {"label": 'Sign In', "route": "/sign-in", requiredSignInStatus: false},

];
const settings = [
  {"label": "Account", "route": "/user-home"},
  {"label": "Setting", "route": "/settings"},
  {"label": "Sign Out", "route": "/sign-out"}
];
export default function AppHeader() {
  let {authData} = useAuth();
  const [signedIn] = useState(authData != null);
  const [anchorElNav, setAnchorElNav] = useState(null);
  const [anchorElUser, setAnchorElUser] = useState(null);

  const handleOpenNavMenu = (event) => {
    setAnchorElNav(event.currentTarget);
  };
  const handleOpenUserMenu = (event) => {
    setAnchorElUser(event.currentTarget);
  };

  const handleCloseNavMenu = () => {
    setAnchorElNav(null);
  };

  const handleCloseUserMenu = () => {
    setAnchorElUser(null);
  };

  return (
    <AppBar position="fixed">
      <Container maxWidth="xl">
        <Toolbar disableGutters sx={{
          pr: '24px', // keep right padding when drawer closed
        }}>
          <CurrencyExchangeIcon sx={{display: {xs: 'none', md: 'flex'}, mr: 1}}/>
          <Typography
            variant="h6"
            noWrap
            component="a"
            href="/"
            sx={{
              mr: 2,
              display: {xs: 'none', md: 'flex'},
              fontWeight: 700,
              letterSpacing: '.3rem',
              color: 'inherit',
              textDecoration: 'none',
            }}
          >
            TradeX
          </Typography>

          <Box sx={{flexGrow: 1, display: {xs: 'flex', md: 'none'}}}>
            <IconButton
              size="large"
              aria-label="account of current user"
              aria-controls="menu-appbar"
              aria-haspopup="true"
              onClick={handleOpenNavMenu}
              color="inherit"
            >
              <MenuIcon/>
            </IconButton>
            <Menu
              id="menu-appbar"
              anchorEl={anchorElNav}
              anchorOrigin={{
                vertical: 'bottom',
                horizontal: 'left',
              }}
              keepMounted
              transformOrigin={{
                vertical: 'top',
                horizontal: 'left',
              }}
              open={Boolean(anchorElNav)}
              onClose={handleCloseNavMenu}
              sx={{
                display: {xs: 'block', md: 'none'},
              }}
            >
              {pages.map((page) => (
                page.hasOwnProperty("requiredSignInStatus") && page.requiredSignInStatus !== signedIn ? null : (
                  <MenuItem key={page.label} onClick={handleCloseNavMenu} component={Link} to={page.route}>
                    <Typography textAlign="center">{page.label}</Typography>
                  </MenuItem>
                )
              ))}
            </Menu>
          </Box>
          <CurrencyExchangeIcon sx={{display: {xs: 'flex', md: 'none'}, mr: 1}}/>
          <Typography
            variant="h5"
            noWrap
            component="a"
            href=""
            sx={{
              mr: 2,
              display: {xs: 'flex', md: 'none'},
              flexGrow: 1,
              fontWeight: 700,

              color: 'inherit',
              textDecoration: 'none',
            }}
          >
            TradeX
          </Typography>
          <Box sx={{flexGrow: 1, display: {xs: 'none', md: 'flex'}}}>
            {pages.map((page) => (
              page.hasOwnProperty("requiredSignInStatus") && page.requiredSignInStatus !== signedIn ? null : (
                <Button
                  key={page.label}
                  onClick={handleCloseNavMenu}
                  sx={{my: 2, color: 'white', display: 'block'}}
                  component={Link} to={page.route}
                >
                  {page.label}
                </Button>
              )
            ))}
          </Box>
          {
            signedIn ?
              (
                <Box sx={{flexGrow: 0}}>
                  <Tooltip title="Open settings">
                    <IconButton onClick={handleOpenUserMenu} sx={{p: 0}}>
                      <Avatar alt="Remy Sharp" src="/static/images/avatar/2.png"/>
                    </IconButton>
                  </Tooltip>
                  <Menu
                    sx={{mt: '45px'}}
                    id="menu-appbar"
                    anchorEl={anchorElUser}
                    anchorOrigin={{
                      vertical: 'top',
                      horizontal: 'right',
                    }}
                    keepMounted
                    transformOrigin={{
                      vertical: 'top',
                      horizontal: 'right',
                    }}
                    open={Boolean(anchorElUser)}
                    onClose={handleCloseUserMenu}
                  >
                    {settings.map((setting) => (
                      <MenuItem key={setting.label} onClick={handleCloseUserMenu} component={Link} to={setting.route}>
                        <Typography textAlign="center">{setting.label}</Typography>
                      </MenuItem>
                    ))}
                  </Menu>
                </Box>
              )
              : null
          }
        </Toolbar>
      </Container>
    </AppBar>
  );
};
