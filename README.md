# Multiplayer Tic Tac Toe

A modern, real-time **Multiplayer Tic Tac Toe** game built with Flutter and Node.js! This project demonstrates full-stack development with real-time multiplayer functionality, WebSocket communication, and responsive design.

![Multiplayer Tic Tac Toe](tic%20tac%20toe.png)

## 🎮 Features

### Multiplayer Functionality
- **Real-time gameplay** with WebSocket connections
- **Room-based system** - Create or join game rooms
- **Live player updates** - See opponent moves instantly
- **Score tracking** - Keep track of wins across multiple rounds
- **Waiting lobby** - Wait for opponents to join your room

### Game Features
- **Classic 3x3 grid** gameplay
- **Turn-based mechanics** with visual indicators
- **Win detection** for rows, columns, and diagonals
- **Draw detection** when no winner is possible
- **Game reset** functionality for new rounds
- **Responsive design** that works on all screen sizes

### Technical Features
- **Flutter frontend** with clean, modern UI
- **Node.js backend** with Express and Socket.io
- **MongoDB database** for persistent game state
- **Real-time communication** via WebSockets
- **Cross-platform** support (Android, iOS, Web, Desktop)

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (latest stable version)
- Node.js (v14 or higher)
- MongoDB Atlas account (or local MongoDB)

### Frontend Setup (Flutter)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/tic_tac_toe.git
   cd tic_tac_toe
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the Flutter app**:
   ```bash
   flutter run
   ```

### Backend Setup (Node.js)

1. **Navigate to server directory**:
   ```bash
   cd server
   ```

2. **Install Node.js dependencies**:
   ```bash
   npm install
   ```

3. **Set up MongoDB connection**:
   - Create a MongoDB Atlas cluster or use local MongoDB
   - Update the connection string in `server/main.js`
   - ### CHANGE THIS #### Replace the hardcoded connection string with environment variables

4. **Start the server**:
   ```bash
   npm run dev
   ```

## 🎯 How to Play

### Creating a Room
1. Launch the app and enter your nickname
2. Click "Create Room" to start a new game
3. Share the generated Room ID with your friend
4. Wait for your opponent to join

### Joining a Room
1. Enter your nickname
2. Enter the Room ID provided by your friend
3. Click "Join Room" to enter the game
4. Start playing when both players are ready

### Gameplay
- Players take turns placing X and O on the 3x3 grid
- First player to get 3 marks in a row (horizontal, vertical, or diagonal) wins
- If all squares are filled without a winner, the game is a draw
- After each round, scores are updated and a new round begins
- First player to win 6 rounds wins the entire game

## 🏗️ Project Structure

```
tic_tac_toe/
├── lib/                    # Flutter frontend code
│   ├── main.dart          # App entry point
│   ├── models/            # Data models
│   ├── providers/         # State management
│   ├── resources/         # Game logic and socket methods
│   ├── screens/           # UI screens
│   ├── utils/             # Utilities and constants
│   ├── views/             # Game board and UI components
│   └── widgets/           # Reusable UI components
├── server/                # Node.js backend
│   ├── main.js           # Server entry point
│   ├── models/           # MongoDB schemas
│   └── package.json      # Backend dependencies
├── android/              # Android-specific files
├── ios/                  # iOS-specific files
├── web/                  # Web-specific files
└── README.md            # This file
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the server directory:

```env
MONGODB_URI=your_mongodb_connection_string
PORT=3000
NODE_ENV=development
```

### Socket Configuration
The app uses Socket.io for real-time communication. Key events:

- `createRoom` - Create a new game room
- `joinRoom` - Join an existing room
- `tap` - Player makes a move
- `winner` - Game winner announcement
- `updatePlayers` - Player list updates
- `updateRoom` - Room state updates

## 🎨 Screenshots

### Main Menu
![Main Menu](screenshots/main_menu.png)

### Create Room
![Create Room](screenshots/create_room.png)

### Game Board
![Game Board](screenshots/game_board.png)

### Waiting Lobby
![Waiting Lobby](screenshots/waiting_lobby.png)

### Victory Screen
![Victory Screen](screenshots/victory_screen.png)

## 🛠️ Development

### Adding New Features
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

## 🐛 Troubleshooting

### Common Issues

**MongoDB Connection Error**
- Check your MongoDB Atlas credentials
- Ensure your IP is whitelisted
- Verify the connection string format

**Socket Connection Issues**
- Make sure the server is running on port 3000
- Check firewall settings
- Verify network connectivity

**Flutter Build Issues**
- Run `flutter clean` and `flutter pub get`
- Check Flutter version compatibility
- Verify all dependencies are installed

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Socket.io for real-time communication
- MongoDB for the database solution
- All contributors and testers

## 📞 Support

If you encounter any issues or have questions:

- Open an issue on GitHub
- Check the troubleshooting section above
- Review the documentation

---

**Happy Gaming! 🎮**
