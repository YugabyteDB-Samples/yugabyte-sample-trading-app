import React, {useEffect} from 'react';
import PageLayout from "./PageLayout";
import {LockOutlined} from "@mui/icons-material";
import ApiClient from "./ApiClient";
import {useAuth} from "./AuthProvider";
import {useNavigate} from "react-router-dom";

export default function SignOut() {
  const api = new ApiClient();
  const {authData, logout} = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    if (authData != null) {
      api.signOut();
    }
    navigate("/")
    logout();
  });
  if (authData == null) {
    navigate("/", {replace: true});
  } else {
    return (<PageLayout icon={<LockOutlined/>} title={"Sign Out"} minHeight={"300"} description="Sign Out Successful!"/>);
  }
};

