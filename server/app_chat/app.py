from flask import Flask, jsonify
from flask_socketio import SocketIO, emit, join_room, leave_room
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

from models.Message import *
from config import *

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app)

# In-memory data store for chat messages
chat_history = []
"""extarct configs from file"""
db_name, db_username, db_password = config_db("config_local.yaml")
"""local postgres"""
engine = create_engine(
    f"postgresql://{db_username}:{db_password}@localhost:5432/{db_name}"
)

Session = sessionmaker(bind=engine)
Base.metadata.create_all(engine)
session = Session()

# REST API endpoint to get chat history


@app.route('/api/chat', methods=['GET'])
def get_chat_history():
    return jsonify(chat_history)

# WebSocket event to handle incoming messages and broadcast them to all clients


@socketio.on('join')
def on_join(data):
    u_name = data['username']
    room_id = data['room']
    join_room(room_id)
    messages = [{
        "id": message.id,
        "room_id": message.room_id,
        "messageType": "sender",
        "date": message.date,
        "messageContent": message.message,
    }
        if message.user_name == u_name else {
        "id": message.id,
            "room_id": message.room_id,
            "messageType": "receiver",
            "date": message.date,
            "messageContent": message.message,
    }
        for message in session.query(Message).filter(Message.room_id == room_id).all()]
    print(messages)
    emit(messages)


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
