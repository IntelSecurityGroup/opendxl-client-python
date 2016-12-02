from dxlclient.broker import Broker
from dxlclient.client import DxlClient
from dxlclient.client_config import DxlClientConfig

# Create the client configuration
config = DxlClientConfig(
        broker_ca_bundle="certs/ca.crt",
        cert_file="certs/client.crt",
        private_key="certs/client.key",
        brokers=[Broker.parse("ssl://192.168.183.20")])

# Create the DXL client
with DxlClient(config) as dxl_client:

    # Connect to the fabric
    dxl_client.connect()