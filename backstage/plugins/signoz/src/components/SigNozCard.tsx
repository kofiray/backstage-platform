import React from 'react';
import { Entity } from '@backstage/catalog-model';
import { useEntity } from '@backstage/plugin-catalog-react';
import { 
  InfoCard, 
  Link,
  MissingAnnotationEmptyState 
} from '@backstage/core-components';
import { Button, Grid } from '@material-ui/core';
import { TrendingUp as TrendingUpIcon } from '@material-ui/icons';

const SIGNOZ_SERVICE_NAME_ANNOTATION = 'signoz.io/service-name';
const SIGNOZ_DASHBOARD_URL_ANNOTATION = 'signoz.io/dashboard-url';

export const isSigNozAvailable = (entity: Entity) =>
  Boolean(entity.metadata.annotations?.[SIGNOZ_SERVICE_NAME_ANNOTATION]);

export const SigNozCard = () => {
  const { entity } = useEntity();
  
  const serviceName = entity.metadata.annotations?.[SIGNOZ_SERVICE_NAME_ANNOTATION];
  const dashboardUrl = entity.metadata.annotations?.[SIGNOZ_DASHBOARD_URL_ANNOTATION];
  
  if (!serviceName) {
    return (
      <MissingAnnotationEmptyState
        annotation={SIGNOZ_SERVICE_NAME_ANNOTATION}
      />
    );
  }

  const signozBaseUrl = 'http://signoz-frontend.observability.svc.cluster.local:3301';
  const fullDashboardUrl = dashboardUrl 
    ? `${signozBaseUrl}${dashboardUrl}`
    : `${signozBaseUrl}/dashboard?service=${serviceName}`;

  return (
    <InfoCard title="SigNoz Observability" variant="gridItem">
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <p>Service: <strong>{serviceName}</strong></p>
        </Grid>
        <Grid item xs={12}>
          <Button
            variant="contained"
            color="primary"
            startIcon={<TrendingUpIcon />}
            component={Link}
            to={fullDashboardUrl}
            target="_blank"
          >
            View in SigNoz
          </Button>
        </Grid>
        <Grid item xs={6}>
          <Button
            variant="outlined"
            component={Link}
            to={`${signozBaseUrl}/traces?service=${serviceName}`}
            target="_blank"
            fullWidth
          >
            Traces
          </Button>
        </Grid>
        <Grid item xs={6}>
          <Button
            variant="outlined"
            component={Link}
            to={`${signozBaseUrl}/logs?service=${serviceName}`}
            target="_blank"
            fullWidth
          >
            Logs
          </Button>
        </Grid>
      </Grid>
    </InfoCard>
  );
};
