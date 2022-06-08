import React, {useEffect, useState} from 'react';
import {Person} from "@mui/icons-material";
import PageLayout from "./PageLayout";
import Link from '@mui/material/Link';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import PropTypes from 'prop-types';
import Typography from '@mui/material/Typography';
import {useTheme} from '@mui/material/styles';
import {Label, Line, LineChart, ResponsiveContainer, XAxis, YAxis} from 'recharts';
import ApiClient from "./ApiClient";
import {Divider} from "@mui/material";

export default function UserHome() {
  const api = new ApiClient();
  let [profile, setProfile] = useState(null);
  useEffect(() => {
    if (profile == null) {
      api.getProfile().then((customer) => {
        setProfile(customer)
      });
    }
  });

  return (
    <PageLayout icon={<Person/>} title={"User Home"} minHeight={"500"} maxWidth="lg">
      {profile != null &&
        <>
          <Typography variant="h6">Information</Typography>
          <Grid container spacing={3}>
            <Grid item xs={12} md={4} lg={3}>
              Full Name : {profile.fullName}
            </Grid>
            <Grid item xs={12} md={4} lg={3}>
              Account Number : {profile.id.accountNumber}
            </Grid>
            <Grid item xs={12} md={4} lg={3}>
              Email : {profile.email}
            </Grid>
            <Grid item xs={12} md={4} lg={3}>
              Region: {profile.id.region}
            </Grid>
          </Grid>
          <Divider sx={{mt: 4, mb: 4}}/>
          <Dashboard/>
        </>
      }
    </PageLayout>
  )
};

function Dashboard() {
  return <DashboardContent/>;
}

function DashboardContent() {
  return (

    <Grid container spacing={3}>
      {/* Chart */}
      <Grid item xs={12} md={8} lg={9}>

        <Paper
          sx={{
            p: 2,
            display: 'flex',
            flexDirection: 'column',
            height: 240,
          }}
        >
          <Chart/>
        </Paper>
      </Grid>
      {/* Recent Deposits */}
      <Grid item xs={12} md={4} lg={3}>
        <Paper
          sx={{
            p: 2,
            display: 'flex',
            flexDirection: 'column',
            height: 240,
          }}
        >
          <Deposits/>
        </Paper>
      </Grid>
      {/* Recent Orders */}
      <Grid item xs={12}>
        <Paper sx={{p: 2, display: 'flex', flexDirection: 'column'}}>
          <Orders/>
        </Paper>
      </Grid>
    </Grid>
  );
}

function Title(props) {
  return (
    <Typography component="h2" variant="h6" color="primary" gutterBottom>
      {props.children}
    </Typography>
  );
}

Title.propTypes = {
  children: PropTypes.node,
};

// Generate Sales Data
function createChart(time, amount) {
  return {time, amount};
}

const chartData = [
  createChart('00:00', 0),
  createChart('03:00', 300),
  createChart('06:00', 200),
  createChart('09:00', 100),
  createChart('12:00', 400),
  createChart('15:00', 900),
  createChart('18:00', 700),
  createChart('21:00', 400),
  createChart('22:00', 500),
  createChart('23:00', 600),
  createChart('24:00', 600),
];

function Chart() {
  const theme = useTheme();

  return (
    <React.Fragment>
      <Title>Today's NAV History</Title>
      <ResponsiveContainer>
        <LineChart
          data={chartData}
          margin={{
            top: 16,
            right: 16,
            bottom: 0,
            left: 24,
          }}
        >
          <XAxis
            dataKey="time"
            stroke={theme.palette.text.secondary}
            style={theme.typography.body2}
          />
          <YAxis
            stroke={theme.palette.text.secondary}
            style={theme.typography.body2}
          >
            <Label
              angle={270}
              position="left"
              style={{
                textAnchor: 'middle',
                fill: theme.palette.text.primary,
                ...theme.typography.body1,
              }}
            >
              NAV ($)
            </Label>
          </YAxis>
          <Line
            isAnimationActive={false}
            type="monotone"
            dataKey="amount"
            stroke={theme.palette.primary.main}
            dot={false}
          />
        </LineChart>
      </ResponsiveContainer>
    </React.Fragment>
  );
}

function preventDefault(event) {
  event.preventDefault();
}

function Deposits() {
  return (
    <React.Fragment>
      <Title>Recent Deposits</Title>
      <Typography component="p" variant="h4">
        $3,024.00
      </Typography>
      <Typography color="text.secondary" sx={{flex: 1}}>
        on 15 March, 2019
      </Typography>
      <div>
        <Link color="primary" href="#" onClick={preventDefault}>
          View balance
        </Link>
      </div>
    </React.Fragment>
  );
}

// Generate Order Data
function createOrderData(id, date, name, shipTo, paymentMethod, amount) {
  return {id, date, name, shipTo, paymentMethod, amount};
}

const orderRows = [
  createOrderData(0, '16 Mar, 2019', 'Elvis Presley', 'Tupelo, MS', 'VISA ⠀•••• 3719', 312.44,),
  createOrderData(1, '16 Mar, 2019', 'Paul McCartney', 'London, UK', 'VISA ⠀•••• 2574', 866.99,),
  createOrderData(2, '16 Mar, 2019', 'Tom Scholz', 'Boston, MA', 'MC ⠀•••• 1253', 100.81),
  createOrderData(3, '16 Mar, 2019', 'Michael Jackson', 'Gary, IN', 'AMEX ⠀•••• 2000', 654.39,),
  createOrderData(4, '15 Mar, 2019', 'Bruce Springsteen', 'Long Branch, NJ', 'VISA ⠀•••• 5919', 212.79,)
];

function Orders() {
  return (
    <React.Fragment>
      <Title>Recent Orders</Title>
      <Table size="small">
        <TableHead>
          <TableRow>
            <TableCell>Date</TableCell>
            <TableCell>Name</TableCell>
            <TableCell>Ship To</TableCell>
            <TableCell>Payment Method</TableCell>
            <TableCell align="right">Sale Amount</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {orderRows.map((row) => (
            <TableRow key={row.id}>
              <TableCell>{row.date}</TableCell>
              <TableCell>{row.name}</TableCell>
              <TableCell>{row.shipTo}</TableCell>
              <TableCell>{row.paymentMethod}</TableCell>
              <TableCell align="right">{`$${row.amount}`}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <Link color="primary" href="#" onClick={preventDefault} sx={{mt: 3}}>
        See more orders
      </Link>
    </React.Fragment>
  );
}

