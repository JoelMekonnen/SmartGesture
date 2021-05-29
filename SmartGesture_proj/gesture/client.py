import websocket
#websocket.enableTrace(True)
def on_message(ws, message):
    print(message)
ws = websocket.WebSocket()
ws.connect("ws://localhost:8000/accelerometer/")
# ws.run_forever()
while True:
    print("Insert * to stop the server")
    message = input("~:")
    if message == "*":
        ws.close()
        break
    else:
        #print(ws.recv())
        ws.send(message)
        
