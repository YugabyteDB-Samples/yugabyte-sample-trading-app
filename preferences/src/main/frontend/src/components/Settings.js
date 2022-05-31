import React, {useState} from 'react';
import {Chip, Divider, Stack, ToggleButtonGroup} from "@mui/material";
import Typography from "@mui/material/Typography";
import Grid from "@mui/material/Grid";
import EmailIcon from '@mui/icons-material/Email';
import MarkunreadMailboxIcon from '@mui/icons-material/MarkunreadMailbox';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import DoNotDisturbOnIcon from '@mui/icons-material/DoNotDisturbOn';
import ToggleButton from "@mui/material/ToggleButton";
import Button from "@mui/material/Button";
import mockData from './mock-data.json';
import {DisplaySettings} from "@mui/icons-material";
import PageLayout from "./PageLayout";

export default function Settings(props) {
  /**
   * @type ApiClient
   * */
  const api = props.api;

  // let [preference, setPreference] = useState(props.preference)
  let subscriptions = mockData.subscriptions;

  let subList = subscriptions.map((sub) =>
    <Subscription label={sub.name} subscription_id={sub.id} description={sub.description} value={sub.default_option}/>
  );

  function onSave() {
    console.log("save");

  }

  return (

    <PageLayout icon={<DisplaySettings/>} title={"Forgot Password"} maxWidth="lg" minHeight={"300"} description="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium ad aut culpa delectus doloribus eius est et excepturi exercitationem expedita facilis illo impedit inventore iure,
          maiores natus nemo neque nisi non odit officiis quam saepe sit tempore velit veritatis voluptate voluptatem. Doloribus ipsam laudantium, nihil nulla quia quibusdam tempora unde?">
      <Divider>
        <Chip label="Communication Preferences"/>
      </Divider>
      <CommunicationPreference label="Statement (M/Q)" value="US_MAIL"/>
      <CommunicationPreference label="Trade confirmation and related prospectuses" value="US_MAIL"/>
      <CommunicationPreference label="Tax forms and related disclosures" value="EDELIVERY"/>
      <CommunicationPreference label="Prospectuses, shareholder reports, and other documents" value="US_MAIL"/>
      <Divider>
        <Chip label="Subscriptions"/>
      </Divider>
      {subList}
      <Stack
        sx={{pt: 4}}
        direction="row"
        spacing={2}
        justifyContent="center"
      >
        <Button variant="contained" onClick={onSave}>Save</Button>
        <Button variant="outlined">Cancel</Button>
      </Stack>
    </PageLayout>
  );
};

function CommunicationPreference(props) {
  let label = props.label;
  const [value, setValue] = useState(props.value);

  return (
    <Grid container spacing={2} sx={{mt: 1, mb: 1}}>
      <Grid item xs={12} md={8}>
        <Typography variant="body1">{label}</Typography>
      </Grid>
      <Grid item xs={12} md={4}>
        <ToggleButtonGroup value={value} exclusive fullWidth onChange={(e, v) => setValue(v)}>
          <ToggleButton value="EDELIVERY" color={'primary'} selected={value === 'EDELIVERY'}>
            <EmailIcon/>
            {' '}
            <Typography variant="body2">eDelivery</Typography>
          </ToggleButton>
          <ToggleButton value="US_MAIL" color={'primary'} selected={value === 'US_MAIL'}>
            <MarkunreadMailboxIcon/>
            {' '}
            <Typography variant="body2">US Mail</Typography>
          </ToggleButton>
        </ToggleButtonGroup>
      </Grid>
    </Grid>
  );
}

function Subscription(props) {
  let label = props.label;
  let description = props.description;
  // let sub_id = props.sub_id;
  const [value, setValue] = useState(props.value);

  return (
    <Grid container sx={{mt: 1, mb: 1}}>
      <Grid item xs={12} md={8}>
        <Typography variant="h6">{label}</Typography>
        <Typography variant="body1">{description}</Typography>
      </Grid>
      <Grid item xs={12} md={4}>
        <ToggleButtonGroup value={value} exclusive fullWidth onChange={(e, v) => setValue(v)}>
          <ToggleButton value="OPT_IN" color={"primary"} selected={value === 'OPT_IN'}>
            <CheckCircleIcon/>
            {' '}
            <Typography variant="body2">Opt In</Typography>
          </ToggleButton>
          <ToggleButton value="OPT_OUT" color={"error"} selected={value === 'OPT_OUT'}>
            <DoNotDisturbOnIcon/>
            {' '}
            <Typography variant="body2">Opt Out</Typography>
          </ToggleButton>
        </ToggleButtonGroup>
      </Grid>
    </Grid>
  );
}
