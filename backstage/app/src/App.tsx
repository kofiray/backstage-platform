import React from 'react';
import { createApp } from '@backstage/app-defaults';

const app = createApp({});

const App = () => {
  const AppProvider = app.getProvider();
  const AppRouter = app.getRouter();
  
  return (
    <AppProvider>
      <AppRouter />
    </AppProvider>
  );
};

export default App;
