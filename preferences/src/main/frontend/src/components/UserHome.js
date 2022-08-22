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

let chartInitialLoad=0;
let chartData = [];

function Chart() {
  const theme = useTheme();
 
  const api = new ApiClient();
  const [chartData,getChartData]=useState(0);
 
  useEffect(() => {
    if (chartInitialLoad === 0) {
      api.getChart().then((chartDataCall) => {
	  chartInitialLoad=1;
     let chartData = [];

	chartDataCall.forEach((obj,i) => {
			chartData.push(createChart(obj.date,obj.price));});
	getChartData(chartData);
      });
    }
  });

  return (
    <React.Fragment>
      <Title>Recent Orders</Title>
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
          	domain={[0,'auto']}
            dataKey="time"
            stroke={theme.palette.text.secondary}
            style={theme.typography.body2}
          />
          <YAxis 
          	domain={[0,'auto']}
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
              purchase ($)
            </Label>
          </YAxis>
          <Line
            isAnimationActive={true}
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
function createOrderData(id,symbol,type,price,time) {
  return {id,symbol, type, price, time};
}

let orderRows = [
  //createOrderData('99','IBM','Stock Purchase','200.00','2022-08-15')
];

let recentTradeDataInitialLoad=0;

function Orders() {
	
	
	//get the data
	//
	const api = new ApiClient();
	const [recentTradeData,getRecentTradeData]=useState(0);
 
  useEffect(() => {
    if (recentTradeDataInitialLoad === 0) {
      api.getRecentTrades().then((recentDataCall) => {
	  recentTradeDataInitialLoad=1;


	recentDataCall.forEach((obj,i) => {
			let price=obj.price;
			orderRows.push(createOrderData(obj.id,obj.symbol,obj.type,price,obj.time));
			});
		getRecentTradeData(orderRows);
      });
    }
  });

	
  return (
    <React.Fragment>
      <Title>Recent Orders</Title>
      <Table size="small">
        <TableHead>
          <TableRow>
            <TableCell>Symbol</TableCell>
            <TableCell>Type</TableCell>
            <TableCell>Date</TableCell>
            
            <TableCell align="right">Sale Amount</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {orderRows.map((row) => (
            <TableRow key={row.id}>
               <TableCell>{row.symbol}</TableCell>
              <TableCell>{row.type}</TableCell>
              <TableCell>{row.time}</TableCell>
              <TableCell align="right">{`${row.price}`}</TableCell>
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

