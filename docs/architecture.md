# Architecture Overview

## System Architecture

The Backstage platform is built on Google Kubernetes Engine with a GitOps-first approach using Argo CD for deployment orchestration.

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Internet                                  │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                 Cloud DNS + Load Balancer                       │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  backstage.domain.com    │    argocd.domain.com            ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                    GKE Cluster (3 nodes)                        │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐   │
│  │   Backstage     │ │    Argo CD      │ │    SigNoz       │   │
│  │   Namespace     │ │   Namespace     │ │   Namespace     │   │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘   │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐   │
│  │  cert-manager   │ │ external-secrets│ │     Apps        │   │
│  │   Namespace     │ │   Namespace     │ │   Namespace     │   │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘   │
└─────────────────────┬───────────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────────┐
│                   GCP Services                                   │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐   │
│  │   Cloud SQL     │ │      GCS        │ │ Artifact Registry│   │
│  │   (Postgres)    │ │   (TechDocs)    │ │   (Images)      │   │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘   │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐   │
│  │ Secret Manager  │ │  Cloud Build    │ │   Cloud DNS     │   │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Infrastructure Components

### GKE Cluster Configuration

**Cluster Specifications:**
- **Type**: Regional cluster in `europe-west2`
- **Nodes**: Exactly 3 nodes (1 per zone: a, b, c)
- **Machine Type**: `e2-standard-4` (4 vCPU, 16GB RAM)
- **Networking**: Private cluster with Cloud NAT
- **Security**: Workload Identity, Network Policies, Shielded Nodes

**Resource Allocation:**
```
Total Cluster Resources: 12 vCPU, 48GB RAM
├── System Reserved: ~2 vCPU, 4GB RAM
├── Backstage: 2 vCPU, 4GB RAM
├── SigNoz Stack: 3 vCPU, 6GB RAM
├── Argo CD: 1 vCPU, 2GB RAM
├── Platform Services: 2 vCPU, 4GB RAM
└── Available for Apps: 2 vCPU, 28GB RAM
```

### Networking Architecture

**VPC Configuration:**
- **Primary CIDR**: `10.0.0.0/24` (nodes)
- **Pods CIDR**: `10.1.0.0/16` (pods)
- **Services CIDR**: `10.2.0.0/16` (services)

**Security:**
- Private GKE cluster (no public node IPs)
- Cloud NAT for egress traffic
- Network policies for traffic segmentation
- Authorized networks for API server access

### Data Layer

**Cloud SQL Postgres:**
- **Instance**: `db-f1-micro` (cost-optimized)
- **Networking**: Private IP only
- **Backup**: Automated daily backups, 7-day retention
- **Security**: Workload Identity authentication

**Storage:**
- **TechDocs**: GCS bucket with lifecycle policies
- **Container Images**: Artifact Registry
- **Secrets**: Google Secret Manager
- **Persistent Volumes**: GCE Persistent Disks (SSD)

## Application Architecture

### Backstage Application

**Components:**
- **Frontend**: React SPA served by backend
- **Backend**: Node.js API server
- **Database**: PostgreSQL via Cloud SQL
- **Plugins**: Kubernetes, Argo CD, GitHub Actions, Azure DevOps, SigNoz

**Security Features:**
- GitHub OAuth authentication
- RBAC with least privilege
- Secure headers (CSP, HSTS)
- Non-root containers
- Read-only root filesystem

### GitOps Workflow

**App-of-Apps Pattern:**
```
root-app (Argo CD)
├── k8s-baseline (namespaces, RBAC, policies)
├── cert-manager (TLS automation)
├── external-secrets (secret management)
├── signoz (observability)
└── backstage (main application)
```

**Deployment Flow:**
1. Code pushed to GitHub
2. Cloud Build triggers on changes
3. Image built and pushed to Artifact Registry
4. GitOps repo updated with new image tag
5. Argo CD detects changes and deploys
6. Backstage shows deployment status

### Observability Stack

**SigNoz Components:**
- **ClickHouse**: Time-series database (1 replica)
- **Query Service**: API backend for SigNoz
- **Frontend**: Web UI for dashboards
- **OTel Collector**: Metrics, traces, logs collection

**Resource Tuning for 3-Node Constraint:**
- Conservative memory limits
- Single replica deployments
- Efficient storage allocation
- Pod Disruption Budgets for availability

## Security Architecture

### Identity and Access Management

**Workload Identity:**
- Backstage → Cloud SQL, GCS, Secret Manager
- cert-manager → Cloud DNS
- External Secrets → Secret Manager

**RBAC:**
- Namespace-level isolation
- Least privilege service accounts
- Pod Security Admission (baseline/restricted)

### Network Security

**Network Policies:**
- Default deny-all ingress/egress
- Explicit allow rules for required traffic
- DNS resolution allowed for all pods
- Cross-namespace communication controlled

### Secret Management

**Google Secret Manager:**
- Centralized secret storage
- Automatic rotation capabilities
- External Secrets Operator sync
- Workload Identity authentication

## Scalability Considerations

### Current Limitations (3-Node Constraint)

**Bottlenecks:**
- CPU: 12 vCPU total (system overhead ~2 vCPU)
- Memory: 48GB total (system overhead ~4GB)
- Storage: Limited by node local storage

**Optimization Strategies:**
- Vertical Pod Autoscaling for efficiency
- Resource quotas prevent resource starvation
- Pod Disruption Budgets ensure availability
- Efficient container images (multi-stage builds)

### Future Scaling Options

**Horizontal Scaling:**
- Add node pools for specific workloads
- Implement cluster autoscaling
- Multi-zone deployment for HA

**Vertical Scaling:**
- Upgrade to larger machine types
- Add memory-optimized nodes for data workloads

## Disaster Recovery

### Backup Strategy

**Data Backups:**
- Cloud SQL: Automated daily backups
- Persistent Volumes: Snapshot schedules
- Configuration: GitOps repository

**Recovery Procedures:**
- Infrastructure: Terraform state restoration
- Applications: Argo CD re-sync
- Data: Point-in-time recovery from backups

### High Availability

**Current Setup:**
- Multi-zone node distribution
- Pod Disruption Budgets
- Health checks and auto-restart

**Limitations:**
- Single replica for cost optimization
- Regional (not global) deployment
- Manual failover procedures

## Cost Optimization

### Resource Efficiency

**Machine Type Selection:**
- `e2-standard-4`: Best price/performance ratio
- Sustained use discounts
- No preemptible nodes (production requirement)

**Storage Optimization:**
- SSD persistent disks for performance
- Lifecycle policies for GCS
- Minimal container image sizes

### Monitoring and Alerts

**Cost Controls:**
- Resource quotas prevent overprovisioning
- SigNoz monitoring for resource usage
- Automated cleanup policies

**Estimated Monthly Costs (europe-west2):**
- GKE Cluster: ~$200/month
- Cloud SQL: ~$25/month
- Storage & Networking: ~$50/month
- **Total**: ~$275/month
