from flask import Flask, jsonify
from flask_socketio import SocketIO, emit, join_room, leave_room

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app)

# In-memory data store for chat messages
chat_history = []

# REST API endpoint to get chat history


@app.route('/api/chat', methods=['GET'])
def get_chat_history():
    return jsonify(chat_history)

# WebSocket event to handle incoming messages and broadcast them to all clients


@socketio.on('join')
def on_join(data):
    username = data['username']
    room = data['room']
    join_room(room)
    emit(username + ' has entered the room.', to=room)


@socketio.on('leave')
def on_leave(data):
    username = data['username']
    room = data['room']
    leave_room(room)
    emit(username + ' has left the room.', to=room)


@socketio.on('message')
def handle_message(message):
    chat_history.append(message)  # Store the message in the chat history
    # Broadcast the message to all connected clients
    print("chat history:", chat_history)
    emit('message', message, broadcast=True)


if __name__ == '__main__':
    socketio.run(app, debug=True, port=8080)
