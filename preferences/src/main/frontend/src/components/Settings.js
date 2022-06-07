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
  let [status, setStatus] = useState({status: "init", message: ""});

  let navigate = useNavigate();
  if (profile == null) {
    api.getProfile()
      .then((data) => {
        let {accountStatementDelivery, taxFormsDelivery, tradeConfirmation, subscribeBlog, subscribeWebinar, subscribeNewsletter} = data;
        let profile = {
          accountStatementDelivery, taxFormsDelivery, tradeConfirmation, subscribeBlog, subscribeWebinar, subscribeNewsletter
        };

        setProfile(profile);
      });
  }

  function updateProfile(key, value) {
    let update = {};
    update[key] = value;
    let newProfile = {
      ...profile, ...update
    };
    return setProfile(newProfile);
  }

  function onSave() {
    setStatus({status: "processing", message: "Processing"});

    api.updateProfile(profile).then((e) => {
      setStatus({status: "success", message: "Update successful"});
    })
      .catch((e) => {
        setStatus({status: "error", message: e.message});
      });
  }

  function onCancel() {
    navigate(-1);
  }

  return (

    <PageLayout icon={<DisplaySettings/>} title={"User Settings"} maxWidth="lg" minHeight={"300"}>
      {
        status.message !== "" &&
        <Grid item xs={12} md={8}>
        <Typography variant="body1" sx={{m: 5, bgcolor: status.status + ".main"}}> Status: {status.message}</Typography>
      </Grid>
      }
      {!!profile && <>
      <Divider>
        <Chip label="Communication Preferences"/>
      </Divider>
        <CommunicationPreference label="Statement (M/Q)" value={profile.accountStatementDelivery} onChange={(event, value) => {
          updateProfile('accountStatementDelivery', value)
        }}/>
        <CommunicationPreference label="Trade confirmation and related prospectuses" value={profile.tradeConfirmation} onChange={(event, value) => {
          updateProfile('tradeConfirmation', value)
        }}/>
        <CommunicationPreference label="Tax forms and related disclosures" value={profile.taxFormsDelivery} onChange={(event, value) => {
          updateProfile('taxFormsDelivery', value)
        }}/>
        <Divider>
          <Chip label="Subscriptions"/>
        </Divider>
        <Subscription label="Trading Blog"
                      description="Subscribe to our Trading blog for latest news, insights and tips"
                      value={profile.subscribeBlog}
                      onChange={(e,v) => updateProfile('subscribeBlog', v)}/>
        <Subscription label="Trading Newsletter"
                      description="Our weekly Newsletter covering trends and weekly roundup"
                      value={profile.subscribeNewsletter}
                      onChange={(e,v) => updateProfile('subscribeNewsletter', v)}/>
        <Subscription label="Webinar"
                      description="Opt to hear from us about our regular webinars and events"
                      value={profile.subscribeWebinar}
                      onChange={(e,v) => updateProfile('subscribeWebinar', v)}/>

        <Stack sx={{pt: 4}} direction="row" spacing={2} justifyContent="center">
          <Button variant="contained" onClick={onSave}>Save</Button>
          <Button variant="outlined" onClick={onCancel}>Cancel</Button>
        </Stack>
      </>}
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

