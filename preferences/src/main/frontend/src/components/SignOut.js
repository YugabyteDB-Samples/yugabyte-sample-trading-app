import React from 'react';
import PageLayout from "./PageLayout";
import {LockOutlined} from "@mui/icons-material";

export default function SignOut() {
  return (
    <PageLayout icon={<LockOutlined/>} title={"Sign Out"} minHeight={"300"} description="Sign Out Successful!"/>
  );
};
