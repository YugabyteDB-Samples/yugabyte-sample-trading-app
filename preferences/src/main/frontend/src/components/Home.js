import React from 'react';
import Container from "@mui/material/Container";
import Grid from "@mui/material/Grid";
import Paper from "@mui/material/Paper";
import Chart from './Chart';
import {CssBaseline, Typography} from "@mui/material";

export default function Home() {
  return (
    <Container maxWidth="lg" sx={{mt: 4, mb: 4}}>
      <CssBaseline/>
      <Grid container spacing={3}>
        <Grid item xs={12} md={12} lg={12}>
          <Paper sx={{m: 2, mt: 8, p: 4, display: 'flex', flexDirection: 'column', height: 240}}>
          <Typography variant={"h5"}>
            Market Trends
          </Typography>
            <Chart/>
          </Paper>
        </Grid>
      </Grid>
    </Container>
  )
};



