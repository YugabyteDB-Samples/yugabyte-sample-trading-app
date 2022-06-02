import {Navigate} from "react-router-dom";
import {useAuth} from "./AuthProvider";

export const AnonymousRoute = ({children}) => {
  const {authData} = useAuth();
  if (authData) {
    // user is authenticated
    return <Navigate to="/"/>;
  }
  return children;
};
