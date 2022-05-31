import React from 'react';
import Container from "@mui/material/Container";
import Grid from "@mui/material/Grid";
import Paper from "@mui/material/Paper";
import Chart from './Chart';

export default function Home(props) {
  /**
   * @type ApiClient
   * */
  const api = props.api;

  return (
    <Container maxWidth="lg" sx={{mt: 4, mb: 4}}>
      <Grid container spacing={3}>
        <Grid item xs={12} md={12} lg={12}>
          <Paper
            sx={{
              p: 2,
              display: 'flex',
              flexDirection: 'column',
              height: 240
            }}
          >
            <Chart/>
          </Paper>
        </Grid>
      </Grid>
    </Container>
  )
};

