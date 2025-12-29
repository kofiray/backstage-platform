# Ultimate Production Backstage.io Platform on GKE

A complete GitOps-first mono-repo delivering production-ready Backstage.io on Google Kubernetes Engine with full DevOps integrations.

## 🎯 Overview

This platform provides:
- **Production GKE cluster** (3 nodes, europe-west2, docker-1210 project)
- **Backstage.io** with GitHub OAuth, Cloud SQL, TechDocs on GCS
- **GitOps via Argo CD** with app-of-apps pattern
- **Observability** via SigNoz + OpenTelemetry
- **Full integrations**: Kubernetes, GitHub Actions, Azure DevOps, Terraform
- **Golden path templates** for immediate team productivity

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Developers    │───▶│   Backstage.io   │───▶│   Argo CD       │
│                 │    │   (Frontend)     │    │   (GitOps)      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        ▼
                       ┌──────────────────┐    ┌─────────────────┐
                       │   Cloud SQL      │    │   GKE Cluster   │
                       │   (Postgres)     │    │   (3 nodes)     │
                       └──────────────────┘    └─────────────────┘
                                                        │
                                                        ▼
                                               ┌─────────────────┐
                                               │   SigNoz        │
                                               │   (Observability)│
                                               └─────────────────┘
```

## 🚀 Quick Start

1. **Prerequisites**: gcloud CLI authenticated to docker-1210 project
2. **Deploy Infrastructure**: `cd infra/terraform/envs/prod && terraform apply`
3. **Bootstrap Platform**: Follow `/docs/bootstrap.md`
4. **Access Backstage**: `https://backstage.<your-domain>`

## 📁 Repository Structure

```
├── infra/terraform/          # Infrastructure as Code
│   ├── modules/             # Reusable Terraform modules
│   └── envs/prod/          # Production environment
├── platform/               # Kubernetes platform components
│   ├── argocd/             # Argo CD bootstrap and apps
│   ├── manifests/          # K8s manifests for platform services
│   └── k8s-baseline/       # Base namespaces, RBAC, policies
├── backstage/              # Backstage application
│   ├── app/                # Backstage app source
│   ├── plugins/            # Custom plugins
│   └── templates/          # Scaffolder templates
├── ci/                     # CI/CD configurations
│   ├── cloudbuild.yaml     # Cloud Build for Backstage
│   └── github/workflows/   # GitHub Actions
└── docs/                   # Documentation
    ├── bootstrap.md        # Getting started guide
    ├── architecture.md     # System architecture
    └── runbook.md         # Operations guide
```

## 🔧 Core Components

- **GKE**: 3-node production cluster (e2-standard-4, europe-west2)
- **Backstage**: Production deployment with GitHub OAuth
- **Argo CD**: GitOps orchestration with app-of-apps
- **SigNoz**: Full-stack observability with OpenTelemetry
- **cert-manager**: Automated TLS via DNS-01 challenge
- **External Secrets**: GCP Secret Manager integration

## 📚 Documentation

- [Bootstrap Guide](docs/bootstrap.md) - Step-by-step deployment
- [Architecture](docs/architecture.md) - System design and decisions
- [Security](docs/security.md) - Security controls and compliance
- [Runbook](docs/runbook.md) - Operations and troubleshooting
- [Onboarding](docs/onboarding.md) - Team onboarding guide

## 🎯 Golden Paths

Ready-to-use Backstage templates:
1. **New Microservice** - Complete K8s service with GitOps
2. **Team Namespace** - Namespace with RBAC and policies
3. **Terraform Module** - Infrastructure module with tests

## 🔒 Security & Compliance

- Workload Identity for GCP service authentication
- Private GKE cluster with authorized networks
- Pod Security Admission (baseline/restricted)
- Network policies for traffic segmentation
- Secret Manager for sensitive data
- RBAC with least privilege principles

## 📊 Monitoring & Observability

- **SigNoz**: Traces, metrics, logs, and dashboards
- **OpenTelemetry**: Automatic instrumentation
- **Backstage Integration**: Direct links to observability data
- **Alerting**: Production-ready alert rules

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.
