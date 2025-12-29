import { createApiFactory, discoveryApiRef, fetchApiRef } from '@backstage/core-plugin-api';
import { scmIntegrationsApiRef, ScmIntegrationsApi } from '@backstage/integration-react';
import { catalogApiRef, CatalogClient } from '@backstage/plugin-catalog-react';
import { scaffolderApiRef, ScaffolderApi } from '@backstage/plugin-scaffolder';
import { techDocsApiRef, TechDocsApi } from '@backstage/plugin-techdocs-react';
import { kubernetesApiRef, KubernetesApi } from '@backstage/plugin-kubernetes';

export const apis = [
  createApiFactory({
    api: catalogApiRef,
    deps: { discoveryApi: discoveryApiRef, fetchApi: fetchApiRef },
    factory: ({ discoveryApi, fetchApi }) =>
      new CatalogClient({ discoveryApi, fetchApi }),
  }),
  createApiFactory({
    api: scmIntegrationsApiRef,
    deps: { discoveryApi: discoveryApiRef, fetchApi: fetchApiRef },
    factory: ({ discoveryApi, fetchApi }) =>
      ScmIntegrationsApi.fromConfig(
        new ConfigReader({
          integrations: {
            github: [
              {
                host: 'github.com',
                token: process.env.GITHUB_TOKEN,
              },
            ],
          },
        }),
      ),
  }),
  createApiFactory({
    api: scaffolderApiRef,
    deps: { discoveryApi: discoveryApiRef, fetchApi: fetchApiRef },
    factory: ({ discoveryApi, fetchApi }) =>
      new ScaffolderApi({ discoveryApi, fetchApi }),
  }),
  createApiFactory({
    api: techDocsApiRef,
    deps: { discoveryApi: discoveryApiRef, fetchApi: fetchApiRef },
    factory: ({ discoveryApi, fetchApi }) =>
      new TechDocsApi({ discoveryApi, fetchApi }),
  }),
  createApiFactory({
    api: kubernetesApiRef,
    deps: { discoveryApi: discoveryApiRef, fetchApi: fetchApiRef },
    factory: ({ discoveryApi, fetchApi }) =>
      new KubernetesApi({ discoveryApi, fetchApi }),
  }),
];
