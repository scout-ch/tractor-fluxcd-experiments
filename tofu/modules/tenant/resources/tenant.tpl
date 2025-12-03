#
# RBAC
#
---
apiVersion: v1
kind: Namespace
metadata:
  labels:
    toolkit.fluxcd.io/tenant: mova-erinnerungsbuch
  name: mova-erinnerungsbuch
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    toolkit.fluxcd.io/tenant: mova-erinnerungsbuch
  name: mova-erinnerungsbuch
  namespace: mova-erinnerungsbuch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    toolkit.fluxcd.io/tenant: mova-erinnerungsbuch
  name: gotk-reconciler
  namespace: mova-erinnerungsbuch
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: mova-erinnerungsbuch
    namespace: mova-erinnerungsbuch

#
# Sync
#
---
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: mova-erinnerungsbuch
  namespace: mova-erinnerungsbuch
spec:
  interval: 1m0s
  ref:
    branch: main
  secretRef:
    name: mova-erinnerungsbuch
  url: ssh://git@github.com/scout-ch/mova-erinnerungsbuch.ch.git
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: mova-erinnerungsbuch
  namespace: mova-erinnerungsbuch
spec:
  serviceAccountName: mova-erinnerungsbuch
  interval: 10m0s
  path: .
  prune: true
  sourceRef:
    kind: GitRepository
    name: mova-erinnerungsbuch
