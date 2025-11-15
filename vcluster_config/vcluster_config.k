@export()
schema ClusterConfig:
    global?: any
    exportKubeConfig?: ExportKubeConfig
    sync?: Sync
    integrations?: Integrations
    deploy?: Deploy
    networking?: Networking
    policies?: Policies
    controlPlane?: ControlPlane
    privateNodes?: PrivateNodes
    rbac?: RBAC
    plugins?: {str:Plugins}
    experimental?: Experimental
    external?: {str:ExternalConfig}
    telemetry?: Telemetry
    serviceCIDR?: str
    pro?: bool
    plugin?: {str:Plugin}
    sleepMode?: SleepMode
    logging?: Logging

@export()
schema ExportKubeConfig:
    """ExportKubeConfig describes how vCluster should export the vCluster kubeconfig."""
    context?: str
    server?: str
    insecure?: bool
    serviceAccount?: ExportKubeConfigServiceAccount
    secret?: ExportKubeConfigSecretReference
    additionalSecrets?: [ExportKubeConfigAdditionalSecretReference]

@export()
schema ExportKubeConfigServiceAccount:
    """ServiceAccount configuration for kubeconfig generation"""
    name?: str
    namespace?: str
    clusterRole?: str

@export()
schema ExportKubeConfigSecretReference:
    """
    Declare in which host cluster secret vCluster should store the generated virtual cluster kubeconfig.
    If this is not defined, vCluster create it with `vc-NAME`. If you specify another name,
    vCluster creates the config in this other secret.
    """
    name?: str
    namespace?: str

@export()
schema ExportKubeConfigAdditionalSecretReference:
    """
    ExportKubeConfigAdditionalSecretReference defines the additional host cluster secret in which
    vCluster stores the generated virtual cluster kubeconfigs.
    """
    context?: str
    server?: str
    insecure?: bool
    serviceAccount?: ExportKubeConfigServiceAccount
    name?: str
    namespace?: str

@export()
schema Sync:
    toHost?: SyncToHost
    fromHost?: SyncFromHost

@export()
schema SyncToHost:
    pods?: SyncPods
    secrets?: SyncAllResource
    configMaps?: SyncAllResource
    ingresses?: EnableSwitchWithPatches
    services?: EnableSwitchWithPatches
    endpoints?: EnableSwitchWithPatches
    endpointSlices?: EnableSwitchWithPatches
    networkPolicies?: EnableSwitchWithPatches
    persistentVolumeClaims?: EnableSwitchWithPatches
    persistentVolumes?: EnableSwitchWithPatches
    volumeSnapshots?: EnableSwitchWithPatches
    volumeSnapshotContents?: EnableSwitchWithPatches
    storageClasses?: EnableSwitchWithPatches
    serviceAccounts?: EnableSwitchWithPatches
    podDisruptionBudgets?: EnableSwitchWithPatches
    priorityClasses?: EnableSwitchWithPatches
    customResources?: {str:SyncToHostCustomResource}
    namespaces?: SyncToHostNamespaces

@export()
schema SyncFromHost:
    nodes?: SyncNodes
    events?: EnableSwitchWithPatches
    ingressClasses?: EnableSwitchWithPatchesAndSelector
    runtimeClasses?: EnableSwitchWithPatchesAndSelector
    priorityClasses?: EnableSwitchWithPatchesAndSelector
    storageClasses?: EnableAutoSwitchWithPatchesAndSelector
    csiNodes?: EnableAutoSwitchWithPatches
    csiDrivers?: EnableAutoSwitchWithPatches
    csiStorageCapacities?: EnableAutoSwitchWithPatches
    customResources?: {str:SyncFromHostCustomResource}
    volumeSnapshotClasses?: EnableSwitchWithPatches
    configMaps?: EnableSwitchWithResourcesMappings
    secrets?: EnableSwitchWithResourcesMappings

@export()
schema SyncPods:
    enabled?: bool
    translateImage?: {str:str}
    enforceTolerations?: [str]
    useSecretsForSATokens?: bool
    runtimeClassName?: str
    priorityClassName?: str
    rewriteHosts?: SyncRewriteHosts
    patches?: [TranslatePatch]
    hybridScheduling?: HybridScheduling

@export()
schema SyncRewriteHosts:
    enabled?: bool
    initContainer?: SyncRewriteHostsInitContainer

@export()
schema SyncRewriteHostsInitContainer:
    image?: Image
    resources?: Resources

@export()
schema HybridScheduling:
    enabled?: bool
    hostSchedulers?: [str]

@export()
schema SyncAllResource:
    enabled?: bool
    all?: bool
    patches?: [TranslatePatch]

@export()
schema SyncNodes:
    enabled?: bool
    syncBackChanges?: bool
    clearImageStatus?: bool
    selector?: SyncNodeSelector
    patches?: [TranslatePatch]

@export()
schema SyncNodeSelector:
    all?: bool
    labels?: {str:str}

@export()
schema SyncToHostCustomResource:
    enabled: bool
    scope?: str
    patches?: [TranslatePatch]

@export()
schema SyncFromHostCustomResource:
    enabled: bool
    scope: str
    patches?: [TranslatePatch]
    mappings?: FromHostMappings

@export()
schema SyncToHostNamespaces:
    enabled: bool
    patches?: [TranslatePatch]
    mappings?: FromHostMappings
    mappingsOnly?: bool
    extraLabels?: {str:str}

@export()
schema FromHostMappings:
    byName?: {str:str}

@export()
schema TranslatePatch:
    path: str
    expression?: str
    reverseExpression?: str
    reference?: TranslatePatchReference
    labels?: TranslatePatchLabels

@export()
schema TranslatePatchLabels:
    """Empty schema for labels patch - placeholder for label transformation logic"""
    _placeholder?: bool

@export()
schema TranslatePatchReference:
    apiVersion: str
    apiVersionPath?: str
    kind: str
    kindPath?: str
    namePath?: str
    namespacePath?: str

@export()
schema EnableSwitch:
    enabled?: bool

@export()
schema EnableAutoSwitch:
    enabled?: str | bool

@export()
schema EnableSwitchWithPatches:
    enabled?: bool
    patches?: [TranslatePatch]

@export()
schema EnableAutoSwitchWithPatches:
    enabled?: str | bool
    patches?: [TranslatePatch]

@export()
schema EnableSwitchWithPatchesAndSelector:
    enabled?: bool
    patches?: [TranslatePatch]
    selector?: StandardLabelSelector

@export()
schema EnableAutoSwitchWithPatchesAndSelector:
    enabled?: str | bool
    patches?: [TranslatePatch]
    selector?: StandardLabelSelector

@export()
schema EnableSwitchWithResourcesMappings:
    enabled?: bool
    patches?: [TranslatePatch]
    mappings?: FromHostMappings

@export()
schema StandardLabelSelector:
    matchLabels?: {str:str}
    matchExpressions?: [any]

@export()
schema Integrations:
    metricsServer?: MetricsServer
    kubeVirt?: KubeVirt
    externalSecrets?: ExternalSecrets
    certManager?: CertManager
    istio?: Istio
    netris?: {str:any}

@export()
schema MetricsServer:
    enabled?: bool
    apiService?: APIService
    nodes?: bool
    pods?: bool

@export()
schema APIService:
    service?: APIServiceService

@export()
schema APIServiceService:
    name?: str
    namespace?: str
    port?: int

@export()
schema KubeVirt:
    enabled?: bool
    apiService?: APIService
    webhook?: EnableSwitch
    sync?: KubeVirtSync

@export()
schema KubeVirtSync:
    dataVolumes?: EnableSwitch
    virtualMachineInstanceMigrations?: EnableSwitch
    virtualMachineInstances?: EnableSwitch
    virtualMachines?: EnableSwitch
    virtualMachineClones?: EnableSwitch
    virtualMachinePools?: EnableSwitch

@export()
schema ExternalSecrets:
    enabled?: bool
    version?: str
    webhook?: EnableSwitch
    sync?: ExternalSecretsSync

@export()
schema ExternalSecretsSync:
    toHost?: ExternalSecretsSyncToHostConfig
    fromHost?: ExternalSecretsSyncFromHostConfig

@export()
schema ExternalSecretsSyncToHostConfig:
    externalSecrets?: SelectorConfig
    stores?: EnableSwitchSelector

@export()
schema ExternalSecretsSyncFromHostConfig:
    clusterStores?: EnableSwitchSelector

@export()
schema SelectorConfig:
    selector?: StandardLabelSelector

@export()
schema EnableSwitchSelector:
    enabled?: bool
    selector?: StandardLabelSelector

@export()
schema CertManager:
    enabled?: bool
    sync?: CertManagerSync

@export()
schema CertManagerSync:
    toHost?: CertManagerSyncToHost
    fromHost?: CertManagerSyncFromHost

@export()
schema CertManagerSyncToHost:
    certificates?: EnableSwitch
    issuers?: EnableSwitch

@export()
schema CertManagerSyncFromHost:
    clusterIssuers?: ClusterIssuersSyncConfig

@export()
schema ClusterIssuersSyncConfig:
    enabled?: bool
    selector?: LabelSelector

@export()
schema LabelSelector:
    labels?: {str:str}

@export()
schema Istio:
    enabled?: bool
    sync?: IstioSync

@export()
schema IstioSync:
    toHost?: IstioSyncToHost

@export()
schema IstioSyncToHost:
    destinationRules?: EnableSwitch
    gateways?: EnableSwitch
    virtualServices?: EnableSwitch

@export()
schema Deploy:
    kubeProxy?: KubeProxy
    metallb?: Metallb
    cni?: CNI
    localPathProvisioner?: LocalPathProvisioner
    ingressNginx?: IngressNginx
    metricsServer?: DeployMetricsServer
    volumeSnapshotController?: VolumeSnapshotController

@export()
schema KubeProxy:
    enabled?: bool
    image?: str
    imagePullPolicy?: str
    nodeSelector?: {str:str}
    priorityClassName?: str
    tolerations?: [any]
    extraEnv?: [any]
    extraArgs?: [str]
    config?: {str:any}

@export()
schema Metallb:
    enabled?: bool
    controllerImage?: str
    speakerImage?: str
    ipAddressPool?: MetallbIPAddressPool

@export()
schema MetallbIPAddressPool:
    addresses?: [str]
    l2Advertisement?: bool

@export()
schema CNI:
    flannel?: CNIFlannel

@export()
schema CNIFlannel:
    enabled?: bool
    image?: str
    initImage?: str
    imagePullPolicy?: str

@export()
schema LocalPathProvisioner:
    enabled?: bool
    image?: str
    imagePullPolicy?: str
    nodePath?: str

@export()
schema IngressNginx:
    enabled?: bool
    defaultIngressClass?: bool

@export()
schema DeployMetricsServer:
    enabled?: bool

@export()
schema VolumeSnapshotController:
    enabled?: bool

@export()
schema Networking:
    serviceCIDR?: str
    podCIDR?: str
    replicateServices?: ReplicateServices
    resolveDNS?: [ResolveDNS]
    advanced?: NetworkingAdvanced

@export()
schema ReplicateServices:
    toHost?: [ServiceMapping]
    fromHost?: [ServiceMapping]

@export()
schema ServiceMapping:
    from?: str
    to?: str

@export()
schema ResolveDNS:
    hostname: str
    service: str
    namespace: str
    target?: ResolveDNSTarget

@export()
schema ResolveDNSTarget:
    hostname?: str
    ip?: str
    hostService?: str
    hostNamespace?: str
    vClusterService?: str

@export()
schema NetworkingAdvanced:
    clusterDomain?: str
    fallbackHostCluster?: bool
    proxyKubelets?: NetworkProxyKubelets

@export()
schema NetworkProxyKubelets:
    byHostname?: bool
    byIP?: bool

@export()
schema Policies:
    networkPolicy?: NetworkPolicy
    podSecurityStandard?: str
    resourceQuota?: ResourceQuota
    limitRange?: LimitRange
    centralAdmission?: CentralAdmission

@export()
schema NetworkPolicy:
    enabled?: bool
    annotations?: {str:str}
    labels?: {str:str}
    fallbackDns?: str
    controlPlane?: NetworkPolicyControlPlane
    workload?: NetworkPolicyWorkload

@export()
schema NetworkPolicyControlPlane:
    ingress?: [any]
    egress?: [any]

@export()
schema NetworkPolicyWorkload:
    publicEgress?: NetworkPolicyWorkloadPublicEgress
    ingress?: [any]
    egress?: [any]

@export()
schema NetworkPolicyWorkloadPublicEgress:
    enabled?: bool
    cidr?: str
    except?: [str]

@export()
schema ResourceQuota:
    enabled?: str | bool
    quota?: {str:any}
    scopeSelector?: {str:any}
    scopes?: [str]
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema LimitRange:
    enabled?: str | bool
    default?: {str:any}
    defaultRequest?: {str:any}
    max?: {str:any}
    min?: {str:any}
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema CentralAdmission:
    validatingWebhooks?: [ValidatingWebhookConfiguration]
    mutatingWebhooks?: [MutatingWebhookConfiguration]

@export()
schema ValidatingWebhookConfiguration:
    kind?: str
    apiVersion?: str
    metadata?: ObjectMeta
    webhooks?: [ValidatingWebhook]

@export()
schema MutatingWebhookConfiguration:
    kind?: str
    apiVersion?: str
    metadata?: ObjectMeta
    webhooks?: [MutatingWebhook]

@export()
schema ValidatingWebhook:
    name: str
    clientConfig: ValidatingWebhookClientConfig
    rules?: [any]
    failurePolicy?: str
    matchPolicy?: str
    namespaceSelector?: any
    objectSelector?: any
    sideEffects?: str
    timeoutSeconds?: int
    admissionReviewVersions: [str]
    matchConditions?: [any]

@export()
schema MutatingWebhook:
    name: str
    clientConfig: ValidatingWebhookClientConfig
    rules?: [any]
    failurePolicy?: str
    matchPolicy?: str
    namespaceSelector?: any
    objectSelector?: any
    sideEffects?: str
    timeoutSeconds?: int
    admissionReviewVersions: [str]
    matchConditions?: [any]
    reinvocationPolicy?: str

@export()
schema ValidatingWebhookClientConfig:
    url?: str
    service?: ValidatingWebhookServiceReference
    caBundle?: str

@export()
schema ValidatingWebhookServiceReference:
    namespace: str
    name: str
    path?: str
    port?: int

@export()
schema ObjectMeta:
    name?: str
    labels?: {str:str}
    annotations?: {str:str}

@export()
schema ControlPlane:
    endpoint?: str
    distro?: Distro
    standalone?: Standalone
    backingStore?: BackingStore
    coredns?: CoreDNS
    proxy?: ControlPlaneProxy
    hostPathMapper?: HostPathMapper
    ingress?: ControlPlaneIngress
    service?: ControlPlaneService
    statefulSet?: ControlPlaneStatefulSet
    serviceMonitor?: ServiceMonitor
    advanced?: ControlPlaneAdvanced

@export()
schema Distro:
    k8s?: DistroK8s
    k3s?: DistroK3s

@export()
schema DistroK8s:
    enabled?: bool
    version?: str
    apiServer?: DistroContainerEnabled
    controllerManager?: DistroContainerEnabled
    scheduler?: DistroContainerEnabled
    image?: Image
    imagePullPolicy?: str
    env?: [any]
    resources?: {str:any}
    securityContext?: {str:any}

@export()
schema DistroK3s:
    enabled?: bool
    token?: str
    image?: Image
    imagePullPolicy?: str
    env?: [any]
    resources?: {str:any}
    securityContext?: {str:any}
    command?: [str]
    extraArgs?: [str]

@export()
schema DistroContainerEnabled:
    enabled?: bool
    command?: [str]
    extraArgs?: [str]

@export()
schema Standalone:
    enabled?: bool
    dataDir?: str
    autoNodes?: StandaloneAutoNodes
    joinNode?: StandaloneJoinNode

@export()
schema StandaloneAutoNodes:
    provider?: str
    quantity?: int
    nodeTypeSelector?: [Requirement]

@export()
schema StandaloneJoinNode:
    enabled?: bool
    preInstallCommands?: [str]
    preJoinCommands?: [str]
    postJoinCommands?: [str]
    containerd?: ContainerdJoin
    caCertPath?: str
    skipPhases?: [str]
    nodeRegistration?: NodeRegistration

@export()
schema BackingStore:
    etcd?: Etcd
    database?: Database

@export()
schema Etcd:
    embedded?: EtcdEmbedded
    deploy?: EtcdDeploy
    external?: EtcdExternal

@export()
schema EtcdEmbedded:
    enabled?: bool
    migrateFromDeployedEtcd?: bool
    snapshotCount?: int
    extraArgs?: [str]

@export()
schema EtcdDeploy:
    enabled?: bool
    statefulSet?: EtcdDeployStatefulSet
    service?: EtcdDeployService
    headlessService?: EtcdDeployHeadlessService

@export()
schema EtcdDeployStatefulSet:
    enabled?: bool
    enableServiceLinks?: bool
    image?: Image
    imagePullPolicy?: str
    env?: [any]
    extraArgs?: [str]
    resources?: Resources
    pods?: LabelsAndAnnotations
    highAvailability?: ExternalEtcdHighAvailability
    scheduling?: ControlPlaneScheduling
    security?: ControlPlaneSecurity
    persistence?: ExternalEtcdPersistence
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema EtcdDeployService:
    enabled?: bool
    annotations?: {str:str}

@export()
schema EtcdDeployHeadlessService:
    annotations?: {str:str}

@export()
schema ExternalEtcdHighAvailability:
    replicas?: int

@export()
schema ExternalEtcdPersistence:
    volumeClaim?: ExternalEtcdPersistenceVolumeClaim
    volumeClaimTemplates?: [any]
    addVolumes?: [any]
    addVolumeMounts?: [VolumeMount]

@export()
schema ExternalEtcdPersistenceVolumeClaim:
    enabled?: bool
    accessModes?: [str]
    retentionPolicy?: str
    size?: str
    storageClass?: str

@export()
schema EtcdExternal:
    enabled?: bool
    endpoint?: str
    tls?: EtcdExternalTLS

@export()
schema EtcdExternalTLS:
    caFile?: str
    certFile?: str
    keyFile?: str

@export()
schema Database:
    embedded?: DatabaseKine
    external?: ExternalDatabaseKine

@export()
schema DatabaseKine:
    enabled?: bool
    dataSource?: str
    identityProvider?: str
    keyFile?: str
    certFile?: str
    caFile?: str
    extraArgs?: [str]

@export()
schema ExternalDatabaseKine:
    enabled?: bool
    dataSource?: str
    identityProvider?: str
    keyFile?: str
    certFile?: str
    caFile?: str
    extraArgs?: [str]
    connector?: str

@export()
schema CoreDNS:
    enabled?: bool
    embedded?: bool
    security?: ControlPlaneSecurity
    service?: CoreDNSService
    deployment?: CoreDNSDeployment
    overwriteConfig?: str
    overwriteManifests?: str
    priorityClassName?: str

@export()
schema CoreDNSService:
    spec?: {str:any}
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema CoreDNSDeployment:
    image?: str
    replicas?: int
    nodeSelector?: {str:str}
    affinity?: {str:any}
    tolerations?: [any]
    resources?: Resources
    pods?: LabelsAndAnnotations
    annotations?: {str:str}
    labels?: {str:str}
    topologySpreadConstraints?: [any]

@export()
schema ControlPlaneProxy:
    bindAddress?: str
    port?: int
    extraSANs?: [str]

@export()
schema HostPathMapper:
    enabled?: bool
    central?: bool

@export()
schema ControlPlaneIngress:
    enabled?: bool
    host?: str
    pathType?: str
    spec?: {str:any}
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema ControlPlaneService:
    enabled?: bool
    spec?: {str:any}
    kubeletNodePort?: int
    httpsNodePort?: int
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema ControlPlaneStatefulSet:
    highAvailability?: ControlPlaneHighAvailability
    resources?: Resources
    scheduling?: ControlPlaneScheduling
    security?: ControlPlaneSecurity
    probes?: ControlPlaneProbes
    persistence?: ControlPlanePersistence
    enableServiceLinks?: bool
    annotations?: {str:str}
    labels?: {str:str}
    pods?: LabelsAndAnnotations
    image?: Image
    imagePullPolicy?: str
    workingDir?: str
    command?: [str]
    args?: [str]
    env?: [any]
    dnsPolicy?: str
    dnsConfig?: PodDNSConfig
    initContainers?: [any]
    sidecarContainers?: [any]

@export()
schema ControlPlaneHighAvailability:
    replicas?: int
    leaseDuration?: int
    renewDeadline?: int
    retryPeriod?: int

@export()
schema ControlPlaneScheduling:
    nodeSelector?: {str:any}
    affinity?: {str:any}
    tolerations?: [any]
    priorityClassName?: str
    podManagementPolicy?: str
    topologySpreadConstraints?: [any]

@export()
schema ControlPlaneSecurity:
    podSecurityContext?: {str:any}
    containerSecurityContext?: {str:any}

@export()
schema ControlPlaneProbes:
    livenessProbe?: LivenessProbe
    readinessProbe?: ReadinessProbe
    startupProbe?: StartupProbe

@export()
schema LivenessProbe:
    enabled?: bool
    failureThreshold?: int
    initialDelaySeconds?: int
    timeoutSeconds?: int
    periodSeconds?: int

@export()
schema ReadinessProbe:
    enabled?: bool
    failureThreshold?: int
    timeoutSeconds?: int
    periodSeconds?: int

@export()
schema StartupProbe:
    enabled?: bool
    failureThreshold?: int
    timeoutSeconds?: int
    periodSeconds?: int

@export()
schema ControlPlanePersistence:
    volumeClaim?: VolumeClaim
    volumeClaimTemplates?: [any]
    dataVolume?: [any]
    binariesVolume?: [any]
    addVolumes?: [any]
    addVolumeMounts?: [VolumeMount]

@export()
schema VolumeClaim:
    enabled?: str | bool
    accessModes?: [str]
    retentionPolicy?: str
    size?: str
    storageClass?: str

@export()
schema VolumeMount:
    name: str
    readOnly?: bool
    mountPath: str
    subPath?: str
    mountPropagation?: str
    subPathExpr?: str

@export()
schema ControlPlaneAdvanced:
    defaultImageRegistry?: str
    virtualScheduler?: EnableSwitch
    serviceAccount?: ControlPlaneServiceAccount
    workloadServiceAccount?: ControlPlaneWorkloadServiceAccount
    headlessService?: ControlPlaneHeadlessService
    konnectivity?: Konnectivity
    registry?: Registry
    cloudControllerManager?: CloudControllerManager
    globalMetadata?: ControlPlaneGlobalMetadata
    kubeVip?: KubeVip
    podDisruptionBudget?: PodDisruptionBudget

@export()
schema Konnectivity:
    server?: KonnectivityServer
    agent?: KonnectivityAgent

@export()
schema KonnectivityServer:
    enabled?: bool
    extraArgs?: [str]

@export()
schema KonnectivityAgent:
    enabled?: bool
    replicas?: int
    image?: str
    imagePullPolicy?: str
    nodeSelector?: {str:str}
    priorityClassName?: str
    tolerations?: [any]
    extraEnv?: [any]
    extraArgs?: [str]

@export()
schema Registry:
    enabled?: bool
    anonymousPull?: bool
    config?: any

@export()
schema CloudControllerManager:
    enabled?: bool

@export()
schema ControlPlaneGlobalMetadata:
    annotations?: {str:str}

@export()
schema KubeVip:
    enabled?: bool
    interface?: str
    gateway?: str

@export()
schema PodDisruptionBudget:
    enabled?: bool
    minAvailable?: any
    maxUnavailable?: any
    unhealthyPodEvictionPolicy?: str

@export()
schema ControlPlaneServiceAccount:
    enabled?: bool
    name?: str
    imagePullSecrets?: [ImagePullSecretName]
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema ControlPlaneWorkloadServiceAccount:
    enabled?: bool
    name?: str
    imagePullSecrets?: [ImagePullSecretName]
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema ControlPlaneHeadlessService:
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema ServiceMonitor:
    enabled?: bool
    labels?: {str:str}
    annotations?: {str:str}

@export()
schema PrivateNodes:
    enabled?: bool
    kubelet?: Kubelet
    autoUpgrade?: AutoUpgrade
    joinNode?: JoinConfiguration
    autoNodes?: [PrivateNodesAutoNodes]
    vpn?: PrivateNodesVPN

@export()
schema Kubelet:
    config?: {str:any}

@export()
schema AutoUpgrade:
    enabled?: bool
    image?: str
    imagePullPolicy?: str
    nodeSelector?: {str:str}
    binariesPath?: str
    cniBinariesPath?: str
    concurrency?: int

@export()
schema JoinConfiguration:
    preInstallCommands?: [str]
    preJoinCommands?: [str]
    postJoinCommands?: [str]
    containerd?: ContainerdJoin
    caCertPath?: str
    skipPhases?: [str]
    nodeRegistration?: NodeRegistration

@export()
schema ContainerdJoin:
    enabled?: bool
    registry?: ContainerdRegistry
    pauseImage?: str

@export()
schema ContainerdRegistry:
    configPath?: str
    mirrors?: {str:ContainerdMirror}
    auth?: {str:ContainerdRegistryAuth}

@export()
schema ContainerdMirror:
    server?: str
    caCert?: [str]
    skipVerify?: bool
    capabilities?: [str]
    overridePath?: bool
    hosts?: [ContainerdMirrorHost]

@export()
schema ContainerdMirrorHost:
    server?: str
    caCert?: [str]
    skipVerify?: bool
    capabilities?: [str]
    overridePath?: bool

@export()
schema ContainerdRegistryAuth:
    username?: str
    password?: str
    identityToken?: str
    auth?: str

@export()
schema NodeRegistration:
    criSocket?: str
    kubeletExtraArgs?: [KubeletExtraArg]
    taints?: [KubeletJoinTaint]
    ignorePreflightErrors?: [str]
    imagePullPolicy?: str

@export()
schema KubeletExtraArg:
    name: str
    value: str

@export()
schema KubeletJoinTaint:
    key: str
    value?: str
    effect: str

@export()
schema PrivateNodesAutoNodes:
    provider: str
    properties?: {str:str}
    static?: [StaticNodePool]
    dynamic?: [DynamicNodePool]

@export()
schema StaticNodePool:
    name: str
    nodeTypeSelector?: [Requirement]
    taints?: [KubeletJoinTaint]
    nodeLabels?: {str:str}
    terminationGracePeriod?: str
    quantity: int

@export()
schema DynamicNodePool:
    name: str
    nodeTypeSelector?: [Requirement]
    taints?: [KubeletJoinTaint]
    nodeLabels?: {str:str}
    limits?: {str:str}
    disruption?: DynamicNodePoolDisruption
    terminationGracePeriod?: str
    expireAfter?: str
    weight?: int

@export()
schema DynamicNodePoolDisruption:
    consolidateAfter?: str
    consolidationPolicy?: str
    budgets?: [DynamicNodePoolDisruptionBudget]

@export()
schema DynamicNodePoolDisruptionBudget:
    nodes?: str
    schedule?: str
    duration?: str

@export()
schema Requirement:
    property: str
    operator?: str
    values?: [str]
    value?: str

@export()
schema PrivateNodesVPN:
    enabled?: bool
    nodeToNode?: PrivateNodesVPNNodeToNode

@export()
schema PrivateNodesVPNNodeToNode:
    enabled?: bool

@export()
schema RBAC:
    role?: RBACRole
    clusterRole?: RBACClusterRole
    enableVolumeSnapshotRules?: EnableAutoSwitch

@export()
schema RBACRole:
    enabled?: bool
    extraRules?: [any]
    overwriteRules?: [any]

@export()
schema RBACClusterRole:
    enabled?: str | bool
    extraRules?: [any]
    overwriteRules?: [any]

@export()
schema Plugin:
    name?: str
    image?: str
    imagePullPolicy?: str
    config?: {str:any}
    rbac?: PluginsRBAC
    command?: [str]
    args?: [str]
    securityContext?: {str:any}
    resources?: {str:any}
    volumeMounts?: [any]
    version?: str
    env?: [any]
    envFrom?: [any]
    lifecycle?: {str:any}
    livenessProbe?: {str:any}
    readinessProbe?: {str:any}
    startupProbe?: {str:any}
    workingDir?: str
    optional?: bool

@export()
schema Plugins:
    name?: str
    image?: str
    imagePullPolicy?: str
    config?: {str:any}
    rbac?: PluginsRBAC
    command?: [str]
    args?: [str]
    securityContext?: {str:any}
    resources?: {str:any}
    volumeMounts?: [any]

@export()
schema PluginsRBAC:
    role?: PluginsExtraRules
    clusterRole?: PluginsExtraRules

@export()
schema PluginsExtraRules:
    extraRules?: [RBACPolicyRule]

@export()
schema RBACPolicyRule:
    verbs: [str]
    apiGroups?: [str]
    resources?: [str]
    resourceNames?: [str]
    nonResourceURLs?: [str]

@export()
schema Experimental:
    deploy?: ExperimentalDeploy
    syncSettings?: ExperimentalSyncSettings
    virtualClusterKubeConfig?: VirtualClusterKubeConfig
    denyProxyRequests?: [DenyRule]

@export()
schema ExperimentalDeploy:
    host?: ExperimentalDeployHost
    vcluster?: ExperimentalDeployVCluster

@export()
schema ExperimentalDeployHost:
    manifests?: str
    manifestsTemplate?: str

@export()
schema ExperimentalDeployVCluster:
    manifests?: str
    manifestsTemplate?: str
    helm?: [ExperimentalDeployHelm]

@export()
schema ExperimentalDeployHelm:
    chart?: ExperimentalDeployHelmChart
    release?: ExperimentalDeployHelmRelease
    values?: str
    timeout?: str
    bundle?: str

@export()
schema ExperimentalDeployHelmChart:
    name?: str
    repo?: str
    insecure?: bool
    version?: str
    username?: str
    password?: str

@export()
schema ExperimentalDeployHelmRelease:
    name?: str
    namespace?: str

@export()
schema ExperimentalSyncSettings:
    setOwner?: bool
    hostMetricsBindAddress?: str
    virtualMetricsBindAddress?: str

@export()
schema VirtualClusterKubeConfig:
    kubeConfig?: str
    serverCAKey?: str
    serverCACert?: str
    clientCACert?: str
    requestHeaderCACert?: str

@export()
schema DenyRule:
    name?: str
    namespaces?: [str]
    rules?: [RuleWithVerbs]
    excludedUsers?: [str]

@export()
schema RuleWithVerbs:
    apiGroups?: [str]
    apiVersions?: [str]
    resources?: [str]
    scope?: str
    operations?: [str]

@export()
schema ExternalConfig:
    [str]: any

@export()
schema Telemetry:
    enabled?: bool
    instanceCreator?: str
    machineID?: str
    platformUserID?: str
    platformInstanceID?: str

@export()
schema SleepMode:
    enabled?: bool
    timeZone?: str
    autoSleep?: SleepModeAutoSleep
    autoWakeup?: AutoWakeup

@export()
schema SleepModeAutoSleep:
    afterInactivity?: str
    schedule?: str
    exclude?: AutoSleepExclusion

@export()
schema AutoWakeup:
    schedule?: str

@export()
schema AutoSleepExclusion:
    selector?: LabelSelector

@export()
schema Logging:
    encoding?: str

@export()
schema Image:
    registry?: str
    repository?: str
    tag?: str

@export()
schema ImagePullSecretName:
    name?: str

@export()
schema Resources:
    limits?: {str:any}
    requests?: {str:any}

@export()
schema LabelsAndAnnotations:
    annotations?: {str:str}
    labels?: {str:str}

@export()
schema PodDNSConfig:
    nameservers?: [str]
    searches?: [str]
    options?: [PodDNSConfigOption]

@export()
schema PodDNSConfigOption:
    name?: str
    value?: str

