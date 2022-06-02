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
import {DisplaySettings} from "@mui/icons-material";
import PageLayout from "./PageLayout";
import ApiClient from "./ApiClient";
import {useNavigate} from "react-router-dom";

export default function Settings() {
  const api = new ApiClient();

  let [profile, setProfile] = useState(null);
  let navigate = useNavigate();

  api.getProfile()
  .then((profile) => {
    setProfile(profile);
  });

  function updateProfile(key, event) {
    let update = {};
    update[key] = event.target.value;
    let newProfile = {
      ...profile, ...update
    };
    return setProfile(newProfile);
  }

  function onSave() {
    console.log("save");
    navigate(-1);
  }

  function onCancel() {
    navigate(-1);
  }

  return (

    <PageLayout icon={<DisplaySettings/>} title={"Forgot Password"} maxWidth="lg" minHeight={"300"}>
      <Divider>
        <Chip label="Communication Preferences"/>
      </Divider>
      {!!profile && <>
        <CommunicationPreference label="Statement (M/Q)" value={profile.accountStatementDelivery} onChange={e => updateProfile('accountStatementDelivery', e)}/>
        <CommunicationPreference label="Trade confirmation and related prospectuses" value={profile.tradeConfirmation} onChange={e => updateProfile('tradeConfirmation', e)}/>
        <CommunicationPreference label="Tax forms and related disclosures" value={profile.taxFormDelivery} onChange={e => updateProfile('taxFormDelivery', e)}/>
        <Divider>
          <Chip label="Subscriptions"/>
        </Divider>
        <Subscription label="Trading Blog"
                      description="Subscribe to our Trading blog for latest news, insights and tips"
                      value={profile.subscribeBlog}
                      onChange={e => updateProfile('subscribeBlog', e)}/>
        <Subscription label="Trading Newsletter"
                      description="Our weekly Newsletter covering trends and weekly roundup"
                      value={profile.subscribeNewsletter}
                      onChange={e => updateProfile('subscribeNewsletter', e)}/>
        <Subscription label="Webinar"
                      description="Opt to hear from us about our regular webinars and events"
                      value={profile.subscribeWebinar}
                      onChange={e => updateProfile('subscribeWebinar', e)}/>

        <Stack sx={{pt: 4}} direction="row" spacing={2} justifyContent="center">
          <Button variant="contained" onClick={onSave}>Save</Button>
          <Button variant="outlined" onClick={onCancel}>Cancel</Button>
        </Stack>
      </>
      }
    </PageLayout>);
};

function CommunicationPreference({label, value, onChange}) {
  return (<Grid container spacing={2} sx={{mt: 1, mb: 1}}>
    <Grid item xs={12} md={8}>
      <Typography variant="body1">{label}</Typography>
    </Grid>
    <Grid item xs={12} md={4}>
      <ToggleButtonGroup value={value} exclusive fullWidth onChange={onChange}>
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
  </Grid>);
}

function Subscription({label, description, value, onChange}) {
  return (<Grid container sx={{mt: 1, mb: 1}}>
    <Grid item xs={12} md={8}>
      <Typography variant="h6">{label}</Typography>
      <Typography variant="body1">{description}</Typography>
    </Grid>
    <Grid item xs={12} md={4}>
      <ToggleButtonGroup value={value} exclusive fullWidth onChange={onChange}>
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
  </Grid>);
}

