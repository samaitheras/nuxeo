##=============================================================================
## Nuxeo configuration file
##=============================================================================
## See https://doc.nuxeo.com/nxdoc/configuration-parameters-index-nuxeoconf/
## for detailed information about the settings below.

##-----------------------------------------------------------------------------
## Java
##-----------------------------------------------------------------------------
## You can control the JVM heap size with the following options: InitialRAMPercentage and MaxRAMPercentage.
## They are respectively equivalent to Xms and Xmx, using a percentage of the available memory (or cgroup memory limit
## when running inside a container).
## See https://doc.nuxeo.com/n/HZ3/#java-virtual-machine-settings
JAVA_OPTS=-XX:InitialRAMPercentage=3 -XX:MaxRAMPercentage=25

## File encoding and encoded MIME parameters support
JAVA_OPTS=$JAVA_OPTS -Dfile.encoding=UTF-8 -Dmail.mime.decodeparameters=true

## No ehcache update check
JAVA_OPTS=$JAVA_OPTS -Dnet.sf.ehcache.skipUpdateCheck=true

## Update sort behavior for Arrays and Collections may throw an IllegalArgumentException
JAVA_OPTS=$JAVA_OPTS -Djava.util.Arrays.useLegacyMergeSort=true

## Log Garbage Collector informations into a file
#JAVA_OPTS=$JAVA_OPTS -Xlog:gc*:file=${nuxeo.log.dir}/gc.log

## Prevent the JDK's HTTP client from automatically resending to the server an unsuccessful HTTP POST request
JAVA_OPTS=$JAVA_OPTS -Dsun.net.http.retryPost=false

##-----------------------------------------------------------------------------
## Nuxeo launcher
##-----------------------------------------------------------------------------
#launcher.start.max.wait=300
#launcher.stop.max.wait=60
#launcher.override.java.tmpdir=true

##-----------------------------------------------------------------------------
## Nuxeo filesystem paths
## ----------------------------------------------------------------------------
## Relative paths will be anchored at NUXEO_HOME; the following
##  are not default values but recommended values
#nuxeo.log.dir=/var/log/nuxeo
#nuxeo.pid.dir=/var/run
#nuxeo.data.dir=/var/lib/nuxeo
#nuxeo.tmp.dir=/tmp

# Clean up the temporary directory on Nuxeo startup
#nuxeo.startup.clean.tmp.dir=false

##-----------------------------------------------------------------------------
## General parameters
##-----------------------------------------------------------------------------
## Will regenerate config from these parameters each time the server
##  is restarted
nuxeo.force.generation=true
#nuxeo.templates=default
#nuxeo.bind.address=0.0.0.0
#nuxeo.url=http://18.224.81.168:8080
#org.nuxeo.ecm.contextPath=/nuxeo
#org.nuxeo.ecm.product.name=
#org.nuxeo.ecm.product.version=

##-----------------------------------------------------------------------------
## Database configuration
##-----------------------------------------------------------------------------


#nuxeo.db.type=postgresql
#nuxeo.db.name=mongonuxeo
#nuxeo.db.user=mongo
#nuxeo.db.password=
#nuxeo.db.host=
#nuxeo.db.port=5432
#nuxeo.db.jdbc.url=
#nuxeo.db.driver=org.postgresql.Driver
#nuxeo.db.xadatasource=org.postgresql.xa.PGXADataSource
# Startup checks configuration
#postgresql.check.classpath=nxserver/lib:${nuxeo.home}/nxserver/bundles/nuxeo-launcher-commons-*.jar
#postgresql.check.class=org.nuxeo.launcher.config.backingservices.DBCheck


mongodb.target=.
nuxeo.templates=default,mongodb,s3binaries,retention
nuxeo.mongodb.server=
nuxeo.db.type=mongodb
nuxeo.mongodb.dbname=nuxeodocker
mongodb.check.classpath=nxserver/lib:${nuxeo.home}/nxserver/bundles/nuxeo-{core-storage,runtime}-mongodb-*.jar
mongodb.check.class=org.nuxeo.ecm.core.storage.mongodb.MongoDBChecker
nuxeo.mongodb.check.timeout=5
nuxeo.db.indexes.create=false
nuxeo.keyvalue.provider=mongodb

## Cache Configuration ##
nuxeo.dbs.cache.enabled=true
nuxeo.dbs.cache.maxSize=1000
nuxeo.dbs.cache.concurrencyLevel=10
nuxeo.dbs.cache.ttl=10
## MongoDB directories activation
nuxeo.mongodb.directories.enabled=true
nuxeo.db.indexes.create=true

## Pools
#nuxeo.db.min-pool-size=
#nuxeo.db.max-pool-size=
#nuxeo.vcs.min-pool-size=
#nuxeo.vcs.max-pool-size=
## Database transaction timeout in seconds (tomcat only)
#nuxeo.db.transactiontimeout=300


##S3 config
#### Configuration for S3 bucket upload. Better is to use the IAM if the Nuxeo server is in AWS.

aws.target=.

#nuxeo.aws.accessKeyId=
#nuxeo.aws.secretKey=
#nuxeo.aws.region=us-east-2

nuxeo.template.includes=aws
s3binaries.target=.
nuxeo.s3storage.useDirectUpload=false
nuxeo.s3storage.awsid=AKIATBC4RMINV2TP6R44
nuxeo.s3storage.awssecret=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
nuxeo.s3storage.region=us-east-2
nuxeo.s3storage.bucket=armsnuxeo01
nuxeo.s3storage.bucket_prefix=mongodb
nuxeo.core.binarymanager=org.nuxeo.ecm.blob.s3.S3BlobProvider
nuxeo.core.blobstore.digestAsync=false
#nuxeo.s3storage.directdownload=true
#nuxeo.s3storage.directdownload.expire=3600

#mandatory
nuxeo.s3storage.transient.bucket=armsnuxeo01/nuxeo-transient
nuxeo.s3storage.transient.roleArn=arn:aws:iam::208499991067:role/nuxeowebui-s3role
nuxeo.s3storage.transient.targetMaxSizeMB=100
nuxeo.s3storage.transient.ttl=120
nuxeo.s3storage.transient.ttl2=10

nuxeo.template.includes=retention
retention.target=.
nuxeo.retention.compliance.enabled=true
nuxeo.core.binarymanager=org.nuxeo.ecm.core.storage.sql.S3BinaryManager


######## Kafka Settings ######

kafka.enabled=true
kafka.bootstrap.server=localhost:9092






##-----------------------------------------------------------------------------
## Elasticsearch configuration
##-----------------------------------------------------------------------------
## Enable or disable Elasticsearch integration, default is true.
elasticsearch.enabled=true

## Choose the client protocol to access Elasticsearch, either RestClient
## or TransportClient
elasticsearch.client=RestClient

## Address of the Elasticsearch cluster, comma separated list of nodes,
## node format for RestClient is http://server:9200
## node format for TransportClient is server:9300
## if empty Nuxeo uses an embedded Elasticsarch server, Not for production !
elasticsearch.addressList=http://172.31.1.57:9200

## Name of the Elasticsearch index for the default document repository
elasticsearch.indexName=epanuxeo

## Number of replicas, default is 1
#elasticsearch.indexNumberOfReplicas=0

## Number of shards, default is 5
#elasticsearch.indexNumberOfShards=1

## Display Elasticsearch cluster and nodes information in admin center
## default is false (always true for embedded mode)
#elasticsearch.adminCenter.displayClusterInfo=true

## Embedded elasticsearch server accept HTTP request on port 9200.
## Only requests from local machine are accepted.
elasticsearch.httpEnabled=true

## Comma separated list of CorePageProvider to supersede by Elasticsearch.
## The default is defined by nuxeo.defaults in template common-base
#elasticsearch.override.pageproviders=...

## Enable or disable Elasticsearch as a backend for audit logs.
## Default is false in common-base template for upgrade purposes, to not break an existing instance.
## Set to true for activation on a new instance.
audit.elasticsearch.enabled=true

## Name of the Elasticsearch index for audit logs
#audit.elasticsearch.indexName=${elasticsearch.indexName}-audit
## Name of the Elasticsearch index for the uid sequencer
#seqgen.elasticsearch.indexName=${elasticsearch.indexName}-uidgen

## See templates/common-base/nuxeo.defaults for more elasticsearch options

##-----------------------------------------------------------------------------
## Mail settings (for notifications)
##-----------------------------------------------------------------------------
#nuxeo.notification.eMailSubjectPrefix="[Nuxeo]"
#mail.transport.host=
#mail.transport.port=
#mail.transport.auth=
#mail.transport.user=
#mail.transport.password=
#mail.from=
#mailservice.user=
#mailservice.password=
#mail.store.protocol=
#mail.transport.protocol=
#mail.user=
#mail.pop3.host=
#mail.debug=

## Encoding of the zip entries filename
#zip.entry.encoding=ascii

##-----------------------------------------------------------------------------
## Nuxeo Dev Mode
##-----------------------------------------------------------------------------
## Enable this mode if you'd like to benefit from hot reload features
##  useful for development. Setting this property to true will:
## - set the JSF facelets refresh period to 2s, enabling to check for
##   changes on JSF files
## - make it possible to hot-reload Studio jars from the admin center
## - reset different levels of caches when hot-reloading a Studio jar,
##   or when triggering the "Dev Mode > Force flush" action available
##   in user menu to administrators of the application
## The dev mode is disabled by default (not suitable for production)
##  and can also be activated from the Admin Center.
#org.nuxeo.dev=true
org.nuxeo.runtime.reload_strategy=standby

##-----------------------------------------------------------------------------
## Nuxeo REST API
## -----------------------------------------------------------------------------
## Enable StackTrace display in JSON payload response in case of
## exception. By default there is no stacktrace displayed, only simple
## exception details.
#org.nuxeo.rest.stack.enable=true

##-----------------------------------------------------------------------------
## Nuxeo Automation Trace
##-----------------------------------------------------------------------------
## Enable this mode if you'd like to display automation traces during
##  runtime.  You'll benefit from exhaustive logs to debug all
##  automation chain and/or operation execution.
## The automation trace mode is disabled by default (not suitable for
##  production) and can also be activated through JMX via
##  org.nuxeo.automation:TracerFactory MBean during runtime.
#org.nuxeo.automation.trace=true

## By default, all automation executions are 'printable' (appear in
##  logs). You can filter chain and/or operation execution trace
##  printing by setting this property to chain name and/or operation
##  separated by comma. Comment it to get all back.
#org.nuxeo.automation.trace.printable=chainIdA,ChainIdB

##-----------------------------------------------------------------------------
## Nuxeo Routing - Clean up 'done' and 'canceled' workflow instances
##-----------------------------------------------------------------------------
## By default, completed workflow instances are removed. The clean-up
##  is triggered daily at midnight. (by a scheduler with the id
##  'workflowInstancesCleanup') If you want to keep these workflows
##  enable the following line:
#nuxeo.routing.disable.cleanup.workflow.instances=true

##-----------------------------------------------------------------------------
## LiveEdit auto-versioning will minor version if set to minor
##-----------------------------------------------------------------------------
#org.nuxeo.ecm.platform.liveedit.autoversioning=minor

##-----------------------------------------------------------------------------
## Clustering settings
##-----------------------------------------------------------------------------
#repository.clustering.enabled=false
#repository.clustering.delay=1000
#repository.clustering.invalidation=default
## If clustering is activated, set
#repository.binary.store=/path/to/some/shared/folder/for/binaries

##-----------------------------------------------------------------------------
## Debugging options
##-----------------------------------------------------------------------------

## Sample JPDA settings for remote socket debugging
#JAVA_OPTS=$JAVA_OPTS -Xdebug -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8787

## Sample JPDA settings for shared memory debugging
#JAVA_OPTS=$JAVA_OPTS -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_shmem,server=y,suspend=n,address=jboss

## Enable jconsole
#JAVA_OPTS=$JAVA_OPTS -Dcom.sun.management.jmxremote=true

## Enable JMX
#JAVA_OPTS=$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1089 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false

## Disable soft references
#JAVA_OPTS=$JAVA_OPTS -XX:SoftRefLRUPolicyMSPerMB=0

## Mission control flight recorder
#JAVA_OPTS=$JAVA_OPTS -Dcom.sun.management.jmxremote.autodiscovery=true -Dcom.sun.management.jdp.name=Nuxeo -XX:StartFlightRecording=settings=default

## ENTRYPOINT: Append required properties
nuxeo.data.dir=/var/lib/nuxeo
nuxeo.log.dir=/var/log/nuxeo
nuxeo.tmp.dir=/tmp
nuxeo.pid.dir=/var/pid/nuxeo
# Set java.io.tmpdir = ${nuxeo.tmp.dir}
launcher.override.java.tmpdir=true
### Configuration for S3 bucket upload. Better is to use the IAM if the Nuxeo server is in AWS.

aws.target=.

#nuxeo.aws.accessKeyId=AKIATBC4RMINV2TP6R44
#nuxeo.aws.secretKey=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
#nuxeo.aws.region=us-east-2

nuxeo.template.includes=aws
s3binaries.target=.
nuxeo.s3storage.useDirectUpload=false
nuxeo.s3storage.awsid=AKIATBC4RMINV2TP6R44
nuxeo.s3storage.awssecret=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
nuxeo.s3storage.region=us-east-2
nuxeo.s3storage.bucket=armsnuxeo01
nuxeo.s3storage.bucket_prefix=Docker
nuxeo.core.binarymanager=org.nuxeo.ecm.blob.s3.S3BlobProvider
nuxeo.core.blobstore.digestAsync=false
#nuxeo.s3storage.directdownload=true
#nuxeo.s3storage.directdownload.expire=3600

#mandatory
nuxeo.s3storage.transient.bucket=armsnuxeo01/nuxeo-transient
nuxeo.s3storage.transient.roleArn=arn:aws:iam::208499991067:role/nuxeowebui-s3role
nuxeo.s3storage.transient.targetMaxSizeMB=100
nuxeo.s3storage.transient.ttl=120
nuxeo.s3storage.transient.ttl2=10

nuxeo.template.includes=retention
retention.target=.
nuxeo.retention.compliance.enabled=false
nuxeo.core.binarymanager=org.nuxeo.ecm.core.storage.sql.S3BinaryManager

## ENTRYPOINT: Append properties from /etc/nuxeo/conf.d/00-docker.conf
## When running Nuxeo in a Linux container, the JVM will automatically detect the cgroup memory limit with the
## UseContainerSupport option, enabled by default.
## By default, we set the heap size to a fixed size equal to 50% of the cgroup memory limit.
## This is achieved by using the same percentage for InitialRAM as for MaxRAM, resulting in equal Xms and Xmx which is recommended in production.
JAVA_OPTS=$JAVA_OPTS -XX:InitialRAMPercentage=50 -XX:MaxRAMPercentage=50
nuxeo.templates=default,s3binaries,arender,retention,s3retention

### BEGIN - DO NOT EDIT BETWEEN BEGIN AND END ###
server.status.key=513e3dd8
### END - DO NOT EDIT BETWEEN BEGIN AND END ###

