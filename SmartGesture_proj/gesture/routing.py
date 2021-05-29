from django.urls import path
from . import consumers

websocket_urlpatterns = [
    path('accelerometer/', consumers.DataConsumer().as_asgi()),
]