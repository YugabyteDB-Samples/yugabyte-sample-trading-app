import {Navigate} from "react-router-dom";
import {useAuth} from "./AuthProvider";

export const ProtectedRoute = ({children}) => {
  const {authData} = useAuth();
  if (!authData) {
    // user is not authenticated
    return <Navigate to="/"/>;
  }
  return children;
};
