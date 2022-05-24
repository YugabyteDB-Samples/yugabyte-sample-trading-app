import React from 'react';

import Container from "@mui/material/Container";
import {Box, Stack, ToggleButtonGroup} from "@mui/material";
import Typography from "@mui/material/Typography";

import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import EmailIcon from '@mui/icons-material/Email';
import MarkunreadMailboxIcon from '@mui/icons-material/MarkunreadMailbox';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import DoNotDisturbOnIcon from '@mui/icons-material/DoNotDisturbOn';
import MuiToggleButton from "@mui/material/ToggleButton";
import {styled} from "@mui/material/styles";
import Button from "@mui/material/Button";
import mockData from './mock-data.json';
const ToggleButton = styled(MuiToggleButton)({
  "&.Mui-selected, &.Mui-selected:hover": {
    color: "green",
    backgroundColor: '#00ff00'
  }
});

export default function Settings() {
  let subscriptions = mockData.subscriptions;

  let subList = subscriptions.map((sub)=>
      <Subscription label={sub.name}  description={sub.description} value="OptIn" />
    );


  return (

    <Box
      sx={{
        bgcolor: 'background.paper',
        pt: 8,
        pb: 6,
      }}
    >
      <Container maxWidth="lg">
        <Typography
          component="h5"
          variant="h5"
          align="center"
          color="text.primary"
          gutterBottom
        >
          Account Preferences
        </Typography>
        <Typography variant="body1" align="center" color="text.secondary" paragraph>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium ad aut culpa delectus doloribus eius est et excepturi exercitationem expedita facilis illo impedit inventore iure,
          maiores natus nemo neque nisi non odit officiis quam saepe sit tempore velit veritatis voluptate voluptatem. Doloribus ipsam laudantium, nihil nulla quia quibusdam tempora unde?
        </Typography>
        <Paper variant="outlined" sx={{my: {xs: 3, md: 6}, p: {xs: 2, md: 3}}}>
          <Typography
            component="h6"
            variant="h4"
            align="left"
            color="text.primary"
            gutterBottom
          >
            Communication Preferences
          </Typography>
          <hr/>
          <CommunicationPreference label="Statement (M/Q)" value="US_MAIL"/>
          <CommunicationPreference label="Trade confirmation and related prospectuses" value="US_MAIL"/>
          <CommunicationPreference label="Tax forms and related disclosures" value="US_MAIL"/>
          <CommunicationPreference label="Prospectuses, shareholder reports, and other documents" value="US_MAIL"/>
          <Typography
            component="h6"
            variant="h4"
            align="left"
            color="text.primary"
            gutterBottom
          >
            Subscriptions
          </Typography>
          <hr/>
          {subList}
        </Paper>
        <Stack
          sx={{ pt: 4 }}
          direction="row"
          spacing={2}
          justifyContent="center"
        >
          <Button variant="contained">Save</Button>
          <Button variant="outlined">Cancel</Button>
        </Stack>
      </Container>
    </Box>

  );
};

function CommunicationPreference(props) {
  let label = props.label;
  let value = props.value;

  return (
    <Grid container spacing={2}>
      <Grid item md={8}>
        <Typography variant="body1">{label}</Typography>
      </Grid>
      <Grid item md={4}>
        <ToggleButtonGroup value={value} exclusive>
          <ToggleButton value="left" aria-label="left aligned">
            <MarkunreadMailboxIcon/>
            {' '}
            <Typography variant="body2">US Mail</Typography>
          </ToggleButton>
          <ToggleButton value="center" aria-label="centered">
            <EmailIcon/>
            {' '}
            <Typography variant="body2">eDelivery</Typography>
          </ToggleButton>
        </ToggleButtonGroup>
      </Grid>
    </Grid>
  );
}

function Subscription(props) {
  let label = props.label;
  let value = props.value;
  let description = props.description;

  return (
    <Grid container>
      <Grid item xs={12} md={8}>
        <Typography variant="h6">{label}</Typography>
        <Typography variant="body1">{description}</Typography>
      </Grid>
      <Grid item xs={12} md={4}>
        <ToggleButtonGroup value={value} exclusive>
          <ToggleButton value="left" aria-label="left aligned" color="primary">
            <CheckCircleIcon/>

            {' '}
            <Typography variant="body2" color="blue">Opt In</Typography>
          </ToggleButton>
          <ToggleButton value="center" aria-label="centered" color={'error'} >
            <DoNotDisturbOnIcon />
            {' '}
            <Typography variant="body2" color={'error'}>Opt Out</Typography>
          </ToggleButton>
        </ToggleButtonGroup>
      </Grid>
    </Grid>
  );
}
