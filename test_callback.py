from dxlclient.callbacks import EventCallback

class MyEventCallback(EventCallback):
    def on_event(self, event):
        print "Received event! " + event.source_client_id

dxl_client.add_event_callback("/testeventtopic", MyEventCallback())

from dxlclient.message import Event

# Create the event message
evt = Event("/testeventtopic")

# Populate the event payload
evt.payload = "testing".encode()

# Send the event
dxl_client.send_event(evt)