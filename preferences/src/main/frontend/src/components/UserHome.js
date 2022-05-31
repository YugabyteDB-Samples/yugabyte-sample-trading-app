import React from 'react';
import {VerifiedUser} from "@mui/icons-material";
import PageLayout from "./PageLayout";

export default function UserHome() {
  return (
    <PageLayout icon={<VerifiedUser />} title={"User Home"} minHeight={"500"} maxWidth="lg">
    </PageLayout>
  )
};

