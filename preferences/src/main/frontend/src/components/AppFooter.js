import React from "react";
import {Link, Typography} from "@mui/material";
import {useHref} from "react-router-dom";
import Grid from "@mui/material/Grid";
import Container from "@mui/material/Container";

function Copyright(props) {
  return (
    <Typography width="100%" variant="body2" color="text.secondary" align="center" {...props}>
      {"Copyright © "}
      <Link color="inherit" href={useHref("/")}>
        TradeX
      </Link>{" "}
      {new Date().getFullYear()}
      {"."}
    </Typography>
  );
}

export default function AppFooter() {
  return (
    <Container maxWidth="lg">

      <Grid container>
        <Grid item xs={12} md={12} lg={12}>
          <Copyright sx={{align: "center"}}/>
        </Grid>
      </Grid>
    </Container>
  );
}
