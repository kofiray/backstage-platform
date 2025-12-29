import React from 'react';
import { Entity } from '@backstage/catalog-model';
import { EntitySwitch, EntityLayout } from '@backstage/plugin-catalog';
import { EntityAboutCard } from '@backstage/plugin-catalog';
import { EntityHasSystemsCard, EntityHasComponentsCard, EntityHasResourcesCard } from '@backstage/plugin-catalog';
import { EntityUserProfileCard, EntityGroupProfileCard, EntityMembersListCard, EntityOwnershipCard } from '@backstage/plugin-org';
import { EntityTechdocsContent } from '@backstage/plugin-techdocs';
import { EntityKubernetesContent } from '@backstage/plugin-kubernetes';
import { EntityArgoCDOverviewCard } from '@backstage/plugin-argocd';
import { EntityGithubActionsContent } from '@backstage/plugin-github-actions';
import { EntityAzureDevOpsContent } from '@backstage/plugin-azure-devops';
import { SigNozCard, isSigNozAvailable } from '@internal/plugin-signoz';
import { EntityGrafanaCard } from '@backstage/plugin-grafana';
import { EntityJenkinsContent } from '@backstage/plugin-jenkins';
import { EntityLighthouseContent } from '@backstage/plugin-lighthouse';
import { EntityPagerDutyCard } from '@backstage/plugin-pagerduty';
import { EntitySnykContent } from '@backstage/plugin-snyk';
import { EntitySonarQubeCard } from '@backstage/plugin-sonarqube';
import { EntityDatadogContent } from '@backstage/plugin-datadog';
import { EntityNewRelicDashboardCard } from '@backstage/plugin-newrelic';
import { EntityRollbarContent } from '@backstage/plugin-rollbar';
import { EntitySentryCard } from '@backstage/plugin-sentry';
import { EntitySlackCard } from '@backstage/plugin-slack';
import { EntityJiraOverviewCard } from '@backstage/plugin-jira';

import {
  Direction,
  EntityCatalogGraphCard,
} from '@backstage/plugin-catalog-graph';

import {
  RELATION_API_CONSUMED_BY,
  RELATION_API_PROVIDED_BY,
  RELATION_CONSUMES_API,
  RELATION_DEPENDENCY_OF,
  RELATION_DEPENDS_ON,
  RELATION_HAS_PART,
  RELATION_PART_OF,
  RELATION_PROVIDES_API,
} from '@backstage/catalog-model';

const entityWarningContent = <>
  <EntitySwitch>
    <EntitySwitch.Case if={e => Boolean(e.metadata.annotations?.['backstage.io/managed-by-location'])}>
      <EntitySwitch.Case if={e => Boolean(e.metadata.annotations?.['backstage.io/managed-by-origin-location'])}>
        <div>
          This entity is managed by an external system. Changes made here may be overwritten.
        </div>
      </EntitySwitch.Case>
    </EntitySwitch.Case>
  </EntitySwitch>
</>;

const overviewContent = (
  <Grid container spacing={3} alignItems="stretch">
    {entityWarningContent}
    <Grid item md={6}>
      <EntityAboutCard variant="gridItem" />
    </Grid>
    <Grid item md={6} xs={12}>
      <EntityCatalogGraphCard variant="gridItem" height={400} />
    </Grid>
    <Grid item md={4} xs={12}>
      <EntityLinksCard />
    </Grid>
    <EntitySwitch>
      <EntitySwitch.Case if={isSigNozAvailable}>
        <Grid item md={6}>
          <SigNozCard />
        </Grid>
      </EntitySwitch.Case>
    </EntitySwitch>
    <EntitySwitch>
      <EntitySwitch.Case if={isArgocdAvailable}>
        <Grid item md={6}>
          <EntityArgoCDOverviewCard />
        </Grid>
      </EntitySwitch.Case>
    </EntitySwitch>
    <Grid item md={6}>
      <EntityGrafanaCard />
    </Grid>
    <Grid item md={6}>
      <EntityPagerDutyCard />
    </Grid>
    <Grid item md={6}>
      <EntitySonarQubeCard />
    </Grid>
    <Grid item md={6}>
      <EntitySentryCard />
    </Grid>
    <Grid item md={6}>
      <EntityNewRelicDashboardCard />
    </Grid>
    <Grid item md={6}>
      <EntitySlackCard />
    </Grid>
    <Grid item md={6}>
      <EntityJiraOverviewCard />
    </Grid>
    <Grid item md={8} xs={12}>
      <EntityHasSubcomponentsCard variant="gridItem" />
    </Grid>
  </Grid>
);

const serviceEntityPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      {overviewContent}
    </EntityLayout.Route>

    <EntityLayout.Route path="/ci-cd" title="CI/CD">
      <EntitySwitch>
        <EntitySwitch.Case if={isGithubActionsAvailable}>
          <EntityGithubActionsContent />
        </EntitySwitch.Case>
        <EntitySwitch.Case if={isAzureDevOpsAvailable}>
          <EntityAzureDevOpsContent />
        </EntitySwitch.Case>
        <EntitySwitch.Case if={isJenkinsAvailable}>
          <EntityJenkinsContent />
        </EntitySwitch.Case>
        <EntitySwitch.Case>
          <EmptyState
            title="No CI/CD available for this entity"
            missing="info"
            description="You need to add an annotation to your component if you want to enable CI/CD for it."
          />
        </EntitySwitch.Case>
      </EntitySwitch>
    </EntityLayout.Route>

    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>

    <EntityLayout.Route path="/security" title="Security">
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntitySnykContent />
        </Grid>
        <Grid item xs={12}>
          <EntitySentryCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/monitoring" title="Monitoring">
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityDatadogContent />
        </Grid>
        <Grid item xs={12}>
          <EntityRollbarContent />
        </Grid>
        <Grid item xs={6}>
          <EntityGrafanaCard />
        </Grid>
        <Grid item xs={6}>
          <EntityNewRelicDashboardCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/quality" title="Quality">
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityLighthouseContent />
        </Grid>
        <Grid item xs={12}>
          <EntitySonarQubeCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/docs" title="Docs">
      <EntityTechdocsContent />
    </EntityLayout.Route>
  </EntityLayout>
);

const websiteEntityPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      {overviewContent}
    </EntityLayout.Route>

    <EntityLayout.Route path="/ci-cd" title="CI/CD">
      <EntitySwitch>
        <EntitySwitch.Case if={isGithubActionsAvailable}>
          <EntityGithubActionsContent />
        </EntitySwitch.Case>
        <EntitySwitch.Case>
          <EmptyState
            title="No CI/CD available for this entity"
            missing="info"
            description="You need to add an annotation to your component if you want to enable CI/CD for it."
          />
        </EntitySwitch.Case>
      </EntitySwitch>
    </EntityLayout.Route>

    <EntityLayout.Route path="/quality" title="Quality">
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityLighthouseContent />
        </Grid>
        <Grid item xs={12}>
          <EntitySonarQubeCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/docs" title="Docs">
      <EntityTechdocsContent />
    </EntityLayout.Route>
  </EntityLayout>
);

const defaultEntityPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      {overviewContent}
    </EntityLayout.Route>

    <EntityLayout.Route path="/docs" title="Docs">
      <EntityTechdocsContent />
    </EntityLayout.Route>
  </EntityLayout>
);

const componentPage = (
  <EntitySwitch>
    <EntitySwitch.Case if={isComponentType('service')}>
      {serviceEntityPage}
    </EntitySwitch.Case>

    <EntitySwitch.Case if={isComponentType('website')}>
      {websiteEntityPage}
    </EntitySwitch.Case>

    <EntitySwitch.Case>{defaultEntityPage}</EntitySwitch.Case>
  </EntitySwitch>
);

const apiPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      <Grid container spacing={3}>
        {entityWarningContent}
        <Grid item md={6}>
          <EntityAboutCard />
        </Grid>
        <Grid item md={6} xs={12}>
          <EntityCatalogGraphCard variant="gridItem" height={400} />
        </Grid>
        <Grid item md={4} xs={12}>
          <EntityLinksCard />
        </Grid>
        <Grid item md={8}>
          <EntityHasSystemsCard variant="gridItem" />
        </Grid>
      </Grid>
    </EntityLayout.Route>

    <EntityLayout.Route path="/definition" title="Definition">
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <EntityApiDefinitionCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>
  </EntityLayout>
);

const userPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      <Grid container spacing={3}>
        {entityWarningContent}
        <Grid item xs={12} md={6}>
          <EntityUserProfileCard variant="gridItem" />
        </Grid>
        <Grid item xs={12} md={6}>
          <EntityOwnershipCard variant="gridItem" />
        </Grid>
      </Grid>
    </EntityLayout.Route>
  </EntityLayout>
);

const groupPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      <Grid container spacing={3}>
        {entityWarningContent}
        <Grid item xs={12} md={6}>
          <EntityGroupProfileCard variant="gridItem" />
        </Grid>
        <Grid item xs={12} md={6}>
          <EntityOwnershipCard variant="gridItem" />
        </Grid>
        <Grid item xs={12}>
          <EntityMembersListCard />
        </Grid>
      </Grid>
    </EntityLayout.Route>
  </EntityLayout>
);

const systemPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      <Grid container spacing={3} alignItems="stretch">
        {entityWarningContent}
        <Grid item md={6}>
          <EntityAboutCard variant="gridItem" />
        </Grid>
        <Grid item md={6} xs={12}>
          <EntityCatalogGraphCard variant="gridItem" height={400} />
        </Grid>
        <Grid item md={6}>
          <EntityHasComponentsCard variant="gridItem" />
        </Grid>
        <Grid item md={6}>
          <EntityHasResourcesCard variant="gridItem" />
        </Grid>
      </Grid>
    </EntityLayout.Route>
    <EntityLayout.Route path="/diagram" title="Diagram">
      <EntityCatalogGraphCard
        variant="gridItem"
        direction={Direction.TOP_BOTTOM}
        title="System Diagram"
        height={700}
        relations={[
          RELATION_PART_OF,
          RELATION_HAS_PART,
          RELATION_API_CONSUMED_BY,
          RELATION_API_PROVIDED_BY,
          RELATION_CONSUMES_API,
          RELATION_PROVIDES_API,
          RELATION_DEPENDENCY_OF,
          RELATION_DEPENDS_ON,
        ]}
        unidirectional={false}
      />
    </EntityLayout.Route>
  </EntityLayout>
);

const domainPage = (
  <EntityLayout>
    <EntityLayout.Route path="/" title="Overview">
      <Grid container spacing={3} alignItems="stretch">
        {entityWarningContent}
        <Grid item md={6}>
          <EntityAboutCard variant="gridItem" />
        </Grid>
        <Grid item md={6} xs={12}>
          <EntityCatalogGraphCard variant="gridItem" height={400} />
        </Grid>
        <Grid item md={6}>
          <EntityHasSystemsCard variant="gridItem" />
        </Grid>
      </Grid>
    </EntityLayout.Route>
  </EntityLayout>
);

export const entityPage = (
  <EntitySwitch>
    <EntitySwitch.Case if={isKind('component')} children={componentPage} />
    <EntitySwitch.Case if={isKind('api')} children={apiPage} />
    <EntitySwitch.Case if={isKind('group')} children={groupPage} />
    <EntitySwitch.Case if={isKind('user')} children={userPage} />
    <EntitySwitch.Case if={isKind('system')} children={systemPage} />
    <EntitySwitch.Case if={isKind('domain')} children={domainPage} />

    <EntitySwitch.Case>{defaultEntityPage}</EntitySwitch.Case>
  </EntitySwitch>
);
