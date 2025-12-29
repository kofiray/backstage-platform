# HashiCorp Vault Integration Guide

## 🔐 **How Developers Use Vault via Backstage**

### **1. Vault UI Integration**

**Vault Card on Entity Pages:**
- Every service shows a **Vault Card** on the Overview tab
- Click to view secrets associated with that service
- Direct links to Vault UI for the service's secret path

**Dedicated Secrets Tab:**
- Full **Secrets tab** on service entity pages
- Browse, create, and manage secrets
- View secret metadata and access policies

### **2. Self-Service Secret Creation**

**Backstage Scaffolder Template:**
```
Create Component → "Create Vault Secret"
```

**What developers can do:**
- ✅ **Create new secrets** for their services
- ✅ **Specify environment** (dev/staging/prod)
- ✅ **Define secret keys** and descriptions
- ✅ **Set access policies** automatically
- ✅ **Link secrets to services** via annotations

### **3. Developer Workflow**

**Step 1: Create Secret via Backstage**
1. Go to Backstage → Create Component
2. Select "Create Vault Secret" template
3. Fill in:
   - Secret path: `secret/data/production/my-service`
   - Secret name: `database-credentials`
   - Environment: `production`
   - Keys: `username`, `password`, `host`

**Step 2: Backstage Actions**
- Creates secret in Vault at specified path
- Registers secret as Backstage entity
- Links secret to service via annotations
- Sets up access policies

**Step 3: Use in Applications**
```yaml
# In your service deployment
annotations:
  vault.io/secrets-path: secret/data/production/my-service
  vault.io/secrets-engine: secret
```

### **4. What Developers See in Backstage UI**

**🏠 Service Overview Page:**
- **Vault Card** showing:
  - Number of secrets for this service
  - Last updated timestamp
  - "View in Vault" button
  - "Create Secret" button

**🔐 Secrets Tab:**
- **Full secret management interface:**
  - List all secrets for the service
  - View secret metadata (not values)
  - Create new secrets
  - Update existing secrets
  - Manage access policies
  - View audit logs

**🔗 Direct Integration:**
- Click any secret → Opens Vault UI
- Vault UI shows at: `https://vault.kofiray.net`
- Single sign-on via Backstage authentication

### **5. Security & Access Control**

**Automatic Policy Creation:**
```hcl
# Auto-generated policy for service
path "secret/data/production/my-service/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
```

**Service Account Integration:**
- Each service gets Vault service account
- Workload Identity integration
- No manual token management needed

### **6. Example Developer Experience**

**Creating Database Credentials:**
1. **Backstage**: Create Component → Vault Secret
2. **Form**: 
   - Path: `secret/data/production/user-service`
   - Name: `database`
   - Keys: `username`, `password`, `host`, `port`
3. **Result**: 
   - Secret created in Vault
   - Service annotation updated
   - Vault card shows on service page
   - Direct link to manage secret

**Using in Kubernetes:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    vault.hashicorp.com/agent-inject: "true"
    vault.hashicorp.com/role: "user-service"
    vault.hashicorp.com/agent-inject-secret-db: "secret/data/production/user-service/database"
```

### **7. Vault Platform Setup**

**Included in Platform:**
- ✅ **Vault cluster** (3 replicas, HA)
- ✅ **Vault UI** at `https://vault.kofiray.net`
- ✅ **Backstage integration** with full UI
- ✅ **Workload Identity** authentication
- ✅ **Automated policies** per service
- ✅ **Audit logging** enabled

**Developer Benefits:**
- 🎯 **Self-service** secret management
- 🔒 **Secure by default** with automatic policies
- 👀 **Full visibility** in Backstage UI
- 🚀 **No CLI required** - all via web UI
- 📊 **Audit trail** of all secret operations

**Your developers get enterprise-grade secret management with zero operational overhead!** 🎯
