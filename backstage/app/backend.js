const express = require('express');
const path = require('path');

const app = express();
const port = 7007;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'dist')));

// Config endpoint - required by Backstage frontend
app.get('/api/config', (req, res) => {
  res.json({
    app: { title: 'Backstage Platform', baseUrl: 'http://backstage.kofiray.net' },
    backend: { baseUrl: 'http://backstage.kofiray.net' },
    organization: { name: 'Platform Team' },
    auth: { 
      environment: 'production',
      providers: { 
        github: {
          production: {
            clientId: process.env.GITHUB_CLIENT_ID || '',
            clientSecret: process.env.GITHUB_CLIENT_SECRET || ''
          }
        }
      }
    }
  });
});

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
      namespace: 'default',
      uid: 'example-service-uid',
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

app.get('/api/catalog/entities/by-name/:kind/:namespace/:name', (req, res) => {
  res.json({
    apiVersion: 'backstage.io/v1alpha1',
    kind: req.params.kind,
    metadata: {
      name: req.params.name,
      namespace: req.params.namespace,
      uid: `${req.params.name}-uid`,
      title: req.params.name,
      description: 'A catalog entity'
    },
    spec: {
      type: 'service',
      lifecycle: 'production',
      owner: 'platform-team'
    }
  });
});

app.get('/api/auth/providers', (req, res) => {
  res.json([{
    id: 'github',
    title: 'GitHub',
    message: 'Sign in using GitHub'
  }]);
});

// GitHub OAuth flow
app.get('/api/auth/github/start', (req, res) => {
  const clientId = process.env.GITHUB_CLIENT_ID;
  const redirectUri = encodeURIComponent('http://backstage.kofiray.net/api/auth/github/handler/frame');
  const scope = encodeURIComponent('read:user user:email');
  res.redirect(`https://github.com/login/oauth/authorize?client_id=${clientId}&redirect_uri=${redirectUri}&scope=${scope}`);
});

app.get('/api/auth/github/handler/frame', (req, res) => {
  // Handle OAuth callback - simplified for now
  res.send(`
    <html><body><script>
      window.opener.postMessage({type: 'authorization_response', response: {profile: {displayName: 'User'}}}, '*');
      window.close();
    </script></body></html>
  `);
});

app.get('/api/techdocs/static/docs', (req, res) => {
  res.json({ docs: [] });
});

app.get('/api/scaffolder/v2/templates', (req, res) => {
  res.json({ items: [] });
});

app.get('/api/scaffolder/v2/actions', (req, res) => {
  res.json([]);
});

app.get('/api/kubernetes/clusters', (req, res) => {
  res.json([]);
});

app.get('/api/search/query', (req, res) => {
  res.json({ results: [] });
});

// Serve index.html for all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

app.listen(port, () => {
  console.log(`Backstage server running on port ${port}`);
});
