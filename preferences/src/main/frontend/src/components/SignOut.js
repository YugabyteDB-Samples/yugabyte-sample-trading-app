import React, {useEffect} from 'react';
import PageLayout from "./PageLayout";
import {LockOutlined} from "@mui/icons-material";

export default function SignOut(props) {
  const onLogout = props.onLogout || function(){};
  useEffect(()=>{
    onLogout();
  })
  return (
    <PageLayout icon={<LockOutlined/>} title={"Sign Out"} minHeight={"300"} description="Sign Out Successful!"/>
  );
};
