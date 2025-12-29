const express = require('express');
const path = require('path');

const app = express();
const port = 7007;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'dist')));

// Backstage API endpoints
app.get('/api/catalog/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/api/catalog/entities', (req, res) => {
  res.json([{
    apiVersion: 'backstage.io/v1alpha1',
    kind: 'Component',
    metadata: {
      name: 'example-service',
      title: 'Example Service',
      description: 'An example microservice'
    },
    spec: {
      type: 'service',
      lifecycle: 'production',
      owner: 'platform-team'
    }
  }]);
});

app.get('/api/auth/providers', (req, res) => {
  res.json([{
    id: 'github',
    title: 'GitHub',
    message: 'Sign in using GitHub'
  }]);
});

app.post('/api/auth/github/start', (req, res) => {
  res.json({ url: 'https://github.com/login/oauth/authorize?client_id=test' });
});

app.get('/api/techdocs/static/docs', (req, res) => {
  res.json({ docs: [] });
});

app.get('/api/scaffolder/v2/templates', (req, res) => {
  res.json([]);
});

app.get('/api/kubernetes/clusters', (req, res) => {
  res.json([]);
});

// Serve index.html for all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

app.listen(port, () => {
  console.log(`Backstage server running on port ${port}`);
});
