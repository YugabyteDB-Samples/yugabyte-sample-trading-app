import React from 'react';
import {Typography} from "@mui/material";
import {Error} from "@mui/icons-material";
import PageLayout from "./PageLayout";

export default function NotFound() {
  return (
    <PageLayout icon={<Error/>} title={"O-Oh!"} minHeight={"300"}>

      <Typography component="h5" variant="h5">
        Looks like you are took a wrong turn!
      </Typography>
    </PageLayout>
  )
};

