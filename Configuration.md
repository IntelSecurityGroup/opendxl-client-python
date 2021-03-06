# Configuration

## How to get repo working
1. Download Vagrant https://www.vagrantup.com/downloads.html
2. Run installer for Vagrant
3. Download Git https://git-scm.com/downloads
4. Run installer for Git
5. git clone https://github.com/IntelSecurityGroup/opendxl-client-python.git
6. cd into opendxl-client-python
7. Run vssh.sh

## Create certificates
```
cd /vagrant/certs
sudo openssl req -new -x509 -days 365 -extensions v3_ca -keyout ca.key -out ca.crt
sudo openssl genrsa -out client.key 2048
sudo openssl req -out client.csr -key client.key -new
sudo openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365
sudo openssl verify -verbose -CAfile ca.crt client.crt
```

## Edit dxlclient.config
Add Client certs.  Test certs are in /vagrant/certs/

## ePO Certificate Authority (CA) Import
```
1. Navigate to Server Settings and select the DXL Certificates setting on the left navigation bar.
2. Click the Edit button in the lower right corner (as shown in the image above)
3. Click the Import button in the Client Certificates section (as shown in the image above)
4. Select the Certificate (For example, ca.crt) for the Certificate Authority (CA) that was created previously.
5. Click the OK button in the lower right corner (as shown in the image above)
6. Click the Save button in the lower right corner (as shown in the image above)

The imported Certificate Authority (CA) information will propagate to the DXL brokers. This process can take several minutes to complete.
```

## ePO Broker Certificates Export
```
The certificate information for DXL Brokers must be available to DXL clients attempting to connect to the fabric. This certificate information allows clients to ensure the Brokers being connected to are valid (via mutual authentication).

The following steps walk through the process to export the DXL Broker certificate information:

1. Navigate to Server Settings and select the DXL Certificates setting on the left navigation bar.
2. Click the Edit button in the lower right corner (as shown in the image above)
3. Click the Export All button in the Broker Certificates section (as shown in the image above)
4. The exported file, brokercerts.crt, will be saved locally.
   
   This file is specified as the broker_ca_bundle parameter when constructing a dxlclient.client_config.DxlClientConfig instance.
   
   This file can also be specified via a configuration file used to instantiate a dxlclient.client_config.DxlClientConfig instance.

```

## ePO Broker List Export
```
1. Navigate to Server Settings and select the DXL Certificates setting on the left navigation bar.
2. Click the Edit button in the lower right corner (as shown in the image above)
3. Click the Export All button in the Broker Certificates section (as shown in the image above)
4. The exported file, brokercerts.crt, will be saved locally.
   
   This file is specified as the broker_ca_bundle parameter when constructing a dxlclient.client_config.DxlClientConfig instance.
   
   This file can also be specified via a configuration file used to instantiate a dxlclient.client_config.DxlClientConfig instance.
```