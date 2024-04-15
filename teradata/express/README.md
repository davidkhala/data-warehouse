# Teradata Vantage Express
A free version of Teradata based on virtual box

[Download index](https://downloads.teradata.com/download/database/teradata-express/vmware)
- vbox port forward: 4422 -> 22, 1025 -> 1025
- The default DB user `dbc` with password `dbc`
## [For VirtualBox](https://quickstarts.teradata.com/getting.started.vbox.html)
- Default OS user `root` with password `root`
- The database is configured to autostart with the VM. You can connect to DB immediate after VM up.
- This OVA cannot be loaded into VMWare
- If the host is using Docker network interface, it will conflict with VBox interface, making Teradata VM not accessible.

## For Cloud Host
### AWS
AWS doesn't support nested virtualization, you have to use Bare Mental shape in AWS to run Vantage Express
- Minimum hardware requirement: 4 vCPUs and 8GB of RAM, 70GB disk
### GCP
[guide](https://quickstarts.teradata.com/vantage.express.gcp.html)

To setup an instance with teradata vantage express embedded
1. `./gcp.sh create-vm`
2. `./gcp.sh setup-vm`

To tear down related resource, run `./gcp.sh terminate`

### Azure
[guide](https://quickstarts.teradata.com/run-vantage-express-on-microsoft-azure.html)

