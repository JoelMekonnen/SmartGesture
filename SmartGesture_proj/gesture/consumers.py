import json
from random import randint
from time import sleep
from channels.generic.websocket import WebsocketConsumer
from channels.generic.websocket import AsyncWebsocketConsumer

class DataConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.channel_layer.group_add('mainRoom', self.channel_name)
        await self.accept()
    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            "mainRoom",
            self.channel_name
        )
    
    async def receive(self, text_data):
        #data_json = json.loads(text_data)
        #print(text_data)
        #send messages to room group
        await self.channel_layer.group_send(
            'mainRoom', 
            {
                'type':'data_receive',
                'text_data': text_data
            }
        )
    #receive message from room group
    async def data_receive(self, event):
        text_data = event['text_data']
        #print(text_data)
        await self.send(text_data)
    
    
        
    