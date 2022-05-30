import {Avatar, CssBaseline, Stack, Typography} from "@mui/material";
import {Container} from "@mui/system";

import React from "react";
import Paper from "@mui/material/Paper";
import {Money} from "@mui/icons-material";

export default function PageLayout(props) {
  console.log(props);
  return (
    <Container component="main" maxWidth={props.maxWidth}>
      <CssBaseline/>
      <Paper sx={{m: 2, mt: 8, p: 4, display: 'flex', flexDirection: 'column', alignItems: 'center', minHeight: props.minHeight}}>
        <Avatar sx={{m: 1, bgcolor: props.iconColor}}>
          {props.icon}
        </Avatar>
        <Typography component="h5" variant="h5">
          {props.title}
        </Typography>
        <Typography variant="body1" align="center" color="text.secondary" paragraph>
          {props.description}
        </Typography>
        <Stack direction="column" width="100%">
          {props.children}
        </Stack>
      </Paper>
    </Container>
  );
}

PageLayout.defaultProps = {
  maxWidth: "sm",
  minHeight: 500,
  icon: (<Money/>),
  iconColor: "secondary.main",
  title: "Page",
  description: "",
  children: (<></>)
}
