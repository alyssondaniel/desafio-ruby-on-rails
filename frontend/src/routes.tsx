import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import TransactionUpload from "./components/TransactionUpload"
import TransactionList from "./components/TransactionList"

const Routes: React.FC = () => (
  <BrowserRouter>
    <Switch>
      <Route exact path="/" component={() => <TransactionUpload />} />
      <Route path="/listar" component={() => <TransactionList />} />
      <Route path="*" component={() => <h1>Page not found</h1>} />
    </Switch>
  </BrowserRouter>
);

export default Routes;
