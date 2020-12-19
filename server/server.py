from flask import Flask, render_template
from flask_socketio import SocketIO, emit

app = Flask(__name__)
socketio = SocketIO(app)

@app.route('/')
def index():
    return 'hello'

@socketio.on('sensor')
def sensor(data):
    print(data)
    emit('from_chopstick', data,broadcast=True)

if __name__=='__main__':
    socketio.run(app, host='0.0.0.0', debug=True)
